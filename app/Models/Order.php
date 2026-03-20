<?php

namespace App\Models;

use App\Core\Database;
use App\Core\Model;
use App\Exceptions\BranchMismatchException;
use App\Exceptions\InsufficientStockException;
use App\Exceptions\ValidationException;

/**
 * Order Model — handles order creation with strict branch enforcement,
 * stock reservation, coupon application, and B2B payment conditions.
 */
class Order extends Model
{
    protected static string $table       = 'orders';
    protected static bool   $timestamps  = true;
    protected static bool   $branchScoped = true;

    public function __construct(
        private readonly Product  $productModel  = new Product(),
        private readonly Campaign $campaignModel = new Campaign(),
        private readonly Customer $customerModel = new Customer(),
    ) {
        parent::__construct();
    }

    // ── Order creation ────────────────────────────────────────

    /**
     * Place a new order. Enforces:
     *  - Customer → branch match
     *  - All cart items belong to the customer's branch
     *  - Stock availability
     *  - Coupon validity
     *
     * @param array $payload {
     *   customer_id, branch_id, items, delivery_type,
     *   billing_address, shipping_address, coupon_code,
     *   payment_method, customer_note, lang_code
     * }
     */
    public function placeOrder(array $payload): array
    {
        return $this->db->transaction(function (Database $db) use ($payload): array {

            // 1. Verify customer belongs to this branch
            $customer = $this->customerModel->findOrFail($payload['customer_id']);
            if ((int) $customer['branch_id'] !== (int) $payload['branch_id']) {
                throw new BranchMismatchException(
                    "Customer #{$customer['id']} is assigned to branch #{$customer['branch_id']}, " .
                    "cannot order from branch #{$payload['branch_id']}."
                );
            }

            // 2. B2B: require verified company
            if ($customer['type'] === 'company' && !$customer['company_verified']) {
                throw new ValidationException('Company account not yet verified.');
            }

            $priceGroup = $customer['price_group'] ?? 'standard';

            // 3. Build order lines + validate stock
            $lines    = [];
            $subtotal = 0.0;

            foreach ($payload['items'] as $item) {
                $product = $this->productModel->getDetail(
                    $item['product_id'],
                    $payload['branch_id'],
                    $payload['lang_code'] ?? 'de',
                    $priceGroup
                );

                if (!$product) {
                    throw new ValidationException("Product #{$item['product_id']} not available for this branch.");
                }

                // Stock check
                if (!$this->productModel->isAvailable(
                    $item['product_id'], $payload['branch_id'], $item['quantity'], $item['variant_id'] ?? null
                )) {
                    throw new InsufficientStockException(
                        "Insufficient stock for: {$product['name']} (qty: {$item['quantity']})"
                    );
                }

                $unitPrice  = (float) $product['price'];
                $taxRate    = $this->resolveTaxRate($customer['type'], $payload['branch_id']);
                $lineTotal  = round($unitPrice * $item['quantity'], 2);
                $subtotal  += $lineTotal;

                $lines[] = [
                    'product_id'    => $item['product_id'],
                    'variant_id'    => $item['variant_id'] ?? null,
                    'product_name'  => $product['name'],
                    'variant_label' => $item['variant_label'] ?? null,
                    'sku'           => $product['sku'],
                    'quantity'      => $item['quantity'],
                    'unit_price'    => $unitPrice,
                    'tax_rate'      => $taxRate,
                    'tax_amount'    => round($lineTotal * ($taxRate / 100), 4),
                    'discount_amount' => 0,
                    'line_total'    => $lineTotal,
                ];
            }

            // 4. Apply coupon / campaign
            $discount   = 0.0;
            $campaignId = null;

            if (!empty($payload['coupon_code'])) {
                [$discount, $campaignId] = $this->campaignModel->applyCoupon(
                    $payload['coupon_code'],
                    $payload['branch_id'],
                    $customer['id'],
                    $customer['type'],
                    $subtotal
                );
            }

            // 5. Shipping
            $shippingCost = $this->resolveShippingCost(
                $payload['delivery_type'],
                $payload['branch_id'],
                $subtotal - $discount
            );

            // 6. Tax
            $taxAmount = array_sum(array_column($lines, 'tax_amount'));

            // 7. Total
            $total = round($subtotal - $discount + $shippingCost, 2);

            // 8. B2B payment conditions
            $paymentDueDate = null;
            if ($customer['type'] === 'company') {
                $paymentDueDate = date('Y-m-d', strtotime('+30 days'));
            }

            // 9. Insert order
            $orderId = $db->insert('orders', [
                'order_number'    => $this->generateOrderNumber($payload['branch_id']),
                'branch_id'       => $payload['branch_id'],
                'customer_id'     => $customer['id'],
                'status'          => 'pending',
                'type'            => $payload['delivery_type'],
                'subtotal'        => $subtotal,
                'discount_amount' => $discount,
                'shipping_cost'   => $shippingCost,
                'tax_amount'      => $taxAmount,
                'total'           => $total,
                'campaign_id'     => $campaignId,
                'coupon_code'     => $payload['coupon_code'] ?? null,
                'billing_address' => json_encode($payload['billing_address']),
                'shipping_address'=> json_encode($payload['shipping_address'] ?? $payload['billing_address']),
                'payment_method'  => $payload['payment_method'] ?? null,
                'po_number'       => $payload['po_number'] ?? null,
                'payment_due_date'=> $paymentDueDate,
                'customer_note'   => $payload['customer_note'] ?? null,
                'lang_code'       => $payload['lang_code'] ?? 'de',
                'ip_address'      => $_SERVER['REMOTE_ADDR'] ?? null,
                'created_at'      => date('Y-m-d H:i:s'),
            ]);

            // 10. Insert items + reserve stock
            foreach ($lines as $line) {
                $db->insert('order_items', array_merge($line, ['order_id' => $orderId]));

                $this->productModel->reserveStock(
                    $line['product_id'],
                    $payload['branch_id'],
                    $line['quantity'],
                    $line['variant_id']
                );
            }

            // 11. Initial status history
            $db->insert('order_status_history', [
                'order_id'   => $orderId,
                'status'     => 'pending',
                'comment'    => 'Order placed.',
                'created_at' => date('Y-m-d H:i:s'),
            ]);

            // 12. Increment coupon usage
            if ($campaignId) {
                $this->campaignModel->incrementUsage($campaignId, $customer['id']);
            }

            return $this->find((int) $orderId);
        });
    }

    // ── Status management ─────────────────────────────────────

    public function updateStatus(int $orderId, string $status, ?string $comment = null, ?int $adminId = null): void
    {
        $allowed = ['pending', 'confirmed', 'processing', 'shipped', 'delivered', 'cancelled', 'refunded'];
        if (!in_array($status, $allowed, true)) {
            throw new ValidationException("Invalid order status: $status");
        }

        $this->db->update('orders', ['status' => $status], ['id' => $orderId]);

        $this->db->insert('order_status_history', [
            'order_id'   => $orderId,
            'status'     => $status,
            'comment'    => $comment,
            'changed_by' => $adminId,
            'created_at' => date('Y-m-d H:i:s'),
        ]);
    }

    // ── Branch-scoped listing ─────────────────────────────────

    public function getForBranch(int $branchId, array $filters = [], int $page = 1, int $perPage = 25): array
    {
        $where  = ['o.branch_id = ?' => $branchId];
        $params = [$branchId];

        $statusFilter = '';
        if (!empty($filters['status'])) {
            $statusFilter = ' AND o.status = ?';
            $params[]     = $filters['status'];
        }

        $search = '';
        if (!empty($filters['search'])) {
            $search   = ' AND (o.order_number LIKE ? OR c.email LIKE ?)';
            $like     = '%' . $filters['search'] . '%';
            $params[] = $like;
            $params[] = $like;
        }

        $count = (int) $this->db->fetchColumn(
            "SELECT COUNT(*) FROM orders o JOIN customers c ON c.id=o.customer_id
             WHERE o.branch_id=? $statusFilter",
            array_slice($params, 0, count($params) - (substr_count($search, '?')))
        );

        $offset = ($page - 1) * $perPage;
        $params[] = $perPage;
        $params[] = $offset;

        $data = $this->db->fetchAll("
            SELECT o.*,
                   c.first_name, c.last_name, c.email, c.type AS customer_type,
                   c.company_name
            FROM orders o
            JOIN customers c ON c.id = o.customer_id
            WHERE o.branch_id = ? $statusFilter $search
            ORDER BY o.created_at DESC
            LIMIT ? OFFSET ?
        ", $params);

        return [
            'data'         => $data,
            'total'        => $count,
            'current_page' => $page,
            'last_page'    => (int) ceil($count / $perPage),
        ];
    }

    // ── Private helpers ──────────────────────────────────────

    private function generateOrderNumber(int $branchId): string
    {
        $year = date('Y');
        $seq  = $this->db->fetchColumn(
            "SELECT COUNT(*)+1 FROM orders WHERE branch_id = ? AND YEAR(created_at) = ?",
            [$branchId, $year]
        );
        // Format: ORD-2025-B1-00001  (globally unique, branch-readable)
        return sprintf('ORD-%s-B%d-%05d', $year, $branchId, $seq);
    }

    private function resolveTaxRate(string $customerType, int $branchId): float
    {
        if ($customerType === 'company') {
            // B2B customers with valid VAT may get 0% — simplified here
            return 0.0;
        }
        $branch = $this->db->fetchOne("SELECT tax_rate FROM branches WHERE id=?", [$branchId]);
        return (float) ($branch['tax_rate'] ?? 19.0);
    }

    private function resolveShippingCost(string $deliveryType, int $branchId, float $subtotal): float
    {
        if ($deliveryType === 'pickup') return 0.0;

        $settings = $this->db->fetchOne(
            "SELECT * FROM branch_delivery_settings WHERE branch_id = ?", [$branchId]
        );

        if (!$settings || !$settings['allows_shipping']) return 0.0;

        if ($settings['free_shipping_from'] && $subtotal >= (float) $settings['free_shipping_from']) {
            return 0.0;
        }

        return (float) ($settings['shipping_cost'] ?? 0.0);
    }
}
