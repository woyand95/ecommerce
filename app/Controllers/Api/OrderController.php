<?php

namespace App\Controllers\Api;

use App\Core\Controller;

class OrderController extends Controller {
    
    public function store(array $p = []): void {
        // Ensure authenticated
        $customer = $this->apiCustomer();
        if (!$customer) {
            $this->json(['error' => 'Unauthorized'], 401);
            return;
        }
        
        try {
            $this->db->beginTransaction();
            
            $data = $this->request->all();
            $branchId = $_SESSION['branch_id'] ?? 1;
            
            // Validate required fields
            if (empty($data['address_id']) || empty($data['payment_method'])) {
                $this->json(['error' => 'Missing required fields'], 400);
                return;
            }
            
            // Verify address belongs to customer
            $address = $this->db->fetchOne(
                "SELECT * FROM addresses WHERE id = ? AND customer_id = ?",
                [$data['address_id'], $customer['id']]
            );
            
            if (!$address) {
                $this->json(['error' => 'Address not found'], 404);
                return;
            }
            
            // Get cart items
            $sessionId = session_id();
            $cart = $this->db->fetchOne("SELECT id FROM carts WHERE session_id = ?", [$sessionId]);
            
            if (!$cart) {
                $this->json(['error' => 'Cart not found'], 404);
                return;
            }
            
            $items = $this->db->fetchAll("
                SELECT ci.*, pbp.price, b.tax_rate as vat_rate
                FROM cart_items ci
                JOIN products p ON p.id = ci.product_id
                JOIN carts c ON c.id = ci.cart_id
                JOIN branches b ON b.id = c.branch_id
                LEFT JOIN product_branch_prices pbp ON pbp.product_id = p.id AND pbp.branch_id = ? AND pbp.price_group = 'standard' AND pbp.variant_id IS NULL
                WHERE ci.cart_id = ?
            ", [$branchId, $cart['id']]);
            
            if (empty($items)) {
                $this->json(['error' => 'Cart is empty'], 400);
                return;
            }
            
            // Calculate totals
            $subtotal = array_sum(array_map(fn($i) => $i['price'] * $i['quantity'], $items));
            $shippingCost = $subtotal > 50 ? 0 : 4.99;
            $discount = 0;
            
            // Apply coupon if provided
            if (!empty($data['coupon_code'])) {
                $campaignService = new \App\Services\CampaignService();
                [$discount] = $campaignService->applyCoupon(
                    $data['coupon_code'],
                    $branchId,
                    $customer['id'],
                    $customer['customer_type'] ?? 'B2C',
                    $subtotal
                );
            }
            
            $total = $subtotal + $shippingCost - $discount;
            
            // Create order
            $orderNumber = 'ORD-' . date('Ymd') . '-' . strtoupper(substr(uniqid(), -6));
            
            $this->db->execute("
                INSERT INTO orders (
                    order_number, branch_id, customer_id,
                    status, payment_status,
                    subtotal, shipping_cost, discount_amount, total,
                    currency_code, customer_note, billing_address, shipping_address, payment_method, created_at, updated_at
                ) VALUES (?, ?, ?, 'pending', 'pending', ?, ?, ?, ?, 'EUR', ?, ?, ?, ?, NOW(), NOW())
            ", [
                $orderNumber,
                $branchId,
                $customer['id'],
                $subtotal,
                $shippingCost,
                $discount,
                $total,
                $data['notes'] ?? null,
                json_encode($address),
                json_encode($address),
                $data['payment_method']
            ]);
            
            $orderId = $this->db->lastInsertId();
            
            // Create order items
            foreach ($items as $item) {
                $this->db->execute("
                    INSERT INTO order_items (
                        order_id, product_id, variant_id, quantity,
                        unit_price, tax_rate, line_total, product_name, sku
                    ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)
                ", [
                    $orderId,
                    $item['product_id'],
                    $item['variant_id'] ?? null,
                    $item['quantity'],
                    $item['price'],
                    $item['vat_rate'] ?? 19,
                    $item['line_total'],
                    $item['name'],
                    $item['sku']
                ]);
                
                // Update stock
                $this->db->execute("
                    UPDATE product_branch_stock SET quantity = quantity - ? WHERE product_id = ? AND branch_id = ? AND (variant_id = ? OR variant_id IS NULL)
                ", [$item['quantity'], $item['product_id'], $branchId, $item['variant_id'] ?? null]);
            }
            
            // Order address snapshot saved directly to json_encode(addresses) mapped already inside `billing_address` / `shipping_address` columns natively upon insert.
            
            // Clear cart
            $this->db->execute("DELETE FROM cart_items WHERE cart_id = ?", [$cart['id']]);
            
            $this->db->commit();
            
            // Return order data
            $order = $this->db->fetchOne("SELECT * FROM orders WHERE id = ?", [$orderId]);
            
            $this->json([
                'success' => true,
                'message' => 'Order created successfully',
                'order' => [
                    'id' => $order['id'],
                    'order_number' => $order['order_number'],
                    'total' => $order['total'],
                    'status' => $order['status']
                ]
            ], 201);
            
        } catch (\Throwable $e) {
            $this->db->rollBack();
            error_log("API order store error: " . $e->getMessage());
            $this->json(['error' => 'Internal server error: ' . $e->getMessage()], 500);
        }
    }

    public function index(array $p = []): void {
        $customer = $this->apiCustomer();
        if (!$customer) {
            $this->json(['error' => 'Unauthorized'], 401);
            return;
        }
        
        $page = max(1, (int) $this->request->query('page', 1));
        $perPage = min(50, (int) $this->request->query('per_page', 20));
        $offset = ($page - 1) * $perPage;
        
        $orders = $this->db->fetchAll("
            SELECT o.* FROM orders o
            WHERE o.customer_id = ?
            ORDER BY o.created_at DESC
            LIMIT $perPage OFFSET $offset
        ", [$customer['id']]);
        
        $total = (int) $this->db->fetchColumn("SELECT COUNT(*) FROM orders WHERE customer_id = ?", [$customer['id']]);
        
        $this->json([
            'data' => $orders,
            'meta' => [
                'current_page' => $page,
                'per_page' => $perPage,
                'total' => $total,
                'total_pages' => ceil($total / $perPage)
            ]
        ]);
    }

    public function show(array $p = []): void {
        $customer = $this->apiCustomer();
        if (!$customer) {
            $this->json(['error' => 'Unauthorized'], 401);
            return;
        }
        
        $orderId = (int) ($p['id'] ?? 0);
        
        $order = $this->db->fetchOne(
            "SELECT * FROM orders WHERE id = ? AND customer_id = ?",
            [$orderId, $customer['id']]
        );
        
        if (!$order) {
            $this->json(['error' => 'Order not found'], 404);
            return;
        }
        
        $items = $this->db->fetchAll(
            "SELECT oi.*, p.name FROM order_items oi JOIN products p ON p.id = oi.product_id WHERE oi.order_id = ?",
            [$orderId]
        );
        
        $address = $this->db->fetchOne(
            "SELECT * FROM order_addresses WHERE order_id = ? AND address_type = 'shipping'",
            [$orderId]
        );
        
        $this->json([
            'data' => [
                'order' => $order,
                'items' => $items,
                'address' => $address
            ]
        ]);
    }
}
