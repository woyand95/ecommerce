<?php

namespace App\Controllers;

use App\Core\Controller;

class CheckoutController extends Controller {

    public function __construct(\App\Core\Request $request = null, \App\Core\Response $response = null) {
        parent::__construct($request, $response);
    }
    
    public function index(array $p = []): void {
        $customer = $this->customer();
        if (!$customer) {
            $_SESSION['intended_url'] = '/checkout';
            session_flash('error', 'Bitte melden Sie sich an, um zur Kasse zu gehen.');
            $this->redirect('/auth/login');
            return;
        }
        
        $cart = $this->getCart();
        if (!$cart) {
            session_flash('error', 'Ihr Warenkorb ist leer.');
            $this->redirect('/cart');
            return;
        }
        
        $branchId = $_SESSION['branch_id'] ?? 1;
        
        // Get cart items with prices
        $items = $this->db->fetchAll("
            SELECT ci.*, COALESCE(pt.name, p.sku) as name, p.sku, pbp.price, b.tax_rate as vat_rate, (pbp.price * ci.quantity) as line_total
            FROM cart_items ci
            JOIN products p ON p.id = ci.product_id
            JOIN carts c ON c.id = ci.cart_id
            JOIN branches b ON b.id = c.branch_id
            LEFT JOIN product_translations pt ON pt.product_id = p.id AND pt.lang_code = 'de'
            LEFT JOIN product_branch_prices pbp ON pbp.product_id = p.id AND pbp.branch_id = ? AND pbp.price_group = 'standard' AND pbp.variant_id IS NULL
            WHERE ci.cart_id = ?
        ", [$branchId, $cart['id']]);
        
        if (empty($items)) {
            session_flash('error', 'Ihr Warenkorb ist leer.');
            $this->redirect('/cart');
            return;
        }
        
        $subtotal = array_sum(array_column($items, 'line_total'));
        $shippingCost = $subtotal > 50 ? 0 : 4.99;
        $total = $subtotal + $shippingCost;
        
        // Get customer addresses
        $addresses = $this->db->fetchAll(
            "SELECT * FROM addresses WHERE customer_id = ? ORDER BY type, is_default DESC, id DESC",
            [$customer['id']]
        );
        
        // Get payment methods
        $paymentMethods = [
            ['id' => 'credit_card', 'name' => 'Kreditkarte'],
            ['id' => 'paypal', 'name' => 'PayPal'],
            ['id' => 'bank_transfer', 'name' => 'Vorkasse']
        ];
        
        $this->view('checkout/index', [
            'title' => 'Kasse',
            'items' => $items,
            'subtotal' => $subtotal,
            'shipping_cost' => $shippingCost,
            'total' => $total,
            'addresses' => $addresses,
            'payment_methods' => $paymentMethods,
            'customer' => $customer,
            'csrf_token' => \App\Core\Csrf::token()
        ]);
    }

    public function placeOrder(array $p = []): void {
        $customer = $this->customer();
        if (!$customer) {
            session_flash('error', 'Bitte melden Sie sich an.');
            $this->redirect('/auth/login');
            return;
        }
        
        try {
            $this->db->beginTransaction();
            
            $cart = $this->getCart();
            if (!$cart) {
                throw new \Exception('Warenkorb nicht gefunden.');
            }
            
            $branchId = $_SESSION['branch_id'] ?? 1;
            
            // Get form data
            $data = $this->request->all();
            
            // Validate required fields
            $requiredFields = ['address_id', 'payment_method'];
            foreach ($requiredFields as $field) {
                if (empty($data[$field])) {
                    throw new \Exception("Bitte wählen Sie {$field} aus.");
                }
            }
            
            // Verify address belongs to customer
            $address = $this->db->fetchOne(
                "SELECT * FROM addresses WHERE id = ? AND customer_id = ?",
                [$data['address_id'], $customer['id']]
            );
            
            if (!$address) {
                throw new \Exception('Adresse nicht gefunden.');
            }
            
            // Get cart items
            $items = $this->db->fetchAll("
                SELECT ci.*, COALESCE(pt.name, p.sku) as name, p.sku, pbp.price, b.tax_rate as vat_rate, (pbp.price * ci.quantity) as line_total
                FROM cart_items ci
                JOIN products p ON p.id = ci.product_id
                JOIN carts c ON c.id = ci.cart_id
                JOIN branches b ON b.id = c.branch_id
                LEFT JOIN product_translations pt ON pt.product_id = p.id AND pt.lang_code = 'de'
                LEFT JOIN product_branch_prices pbp ON pbp.product_id = p.id AND pbp.branch_id = ? AND pbp.price_group = 'standard' AND pbp.variant_id IS NULL
                WHERE ci.cart_id = ?
            ", [$branchId, $cart['id']]);
            
            if (empty($items)) {
                throw new \Exception('Warenkorb ist leer.');
            }
            
            // Calculate totals
            $subtotal = array_sum(array_map(fn($i) => $i['price'] * $i['quantity'], $items));
            $shippingCost = $subtotal > 50 ? 0 : 4.99;
            
            // Apply coupons if any
            $discount = 0;
            if (!empty($data['coupon_code'])) {
                $campaignService = new \App\Services\CampaignService();
                [$discount, $coupon] = $campaignService->applyCoupon(
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
            
            // Send order confirmation email (stub - implement later)
            // MailService::sendOrderConfirmation($orderId);
            
            session_flash('success', 'Bestellung erfolgreich! Ihre Bestellnummer ist: ' . $orderNumber);
            $this->redirect('/checkout/success/' . $orderId);
            
        } catch (\Throwable $e) {
            $this->db->rollBack();
            error_log("Place order error: " . $e->getMessage());
            session_flash('error', 'Ein Fehler ist aufgetreten: ' . $e->getMessage());
            $this->redirect('/checkout');
        }
    }

    public function success(array $p = []): void {
        $orderId = (int) ($p['id'] ?? 0);
        
        if ($orderId <= 0) {
            $this->redirect('/');
            return;
        }
        
        $customer = $this->customer();
        if (!$customer) {
            $this->redirect('/');
            return;
        }
        
        $order = $this->db->fetchOne(
            "SELECT * FROM orders WHERE id = ? AND customer_id = ?",
            [$orderId, $customer['id']]
        );
        
        if (!$order) {
            session_flash('error', 'Bestellung nicht gefunden.');
            $this->redirect('/account/orders');
            return;
        }
        
        $items = $this->db->fetchAll(
            "SELECT oi.*, COALESCE(pt.url_slug, pt_fb.url_slug) as url_slug FROM order_items oi JOIN products p ON p.id = oi.product_id LEFT JOIN product_translations pt ON pt.product_id = p.id AND pt.lang_code = ? LEFT JOIN product_translations pt_fb ON pt_fb.product_id = p.id AND pt_fb.lang_code = 'de' WHERE oi.order_id = ?",
            [$this->lang(), $orderId]
        );
        
        $this->view('checkout/success', [
            'title' => 'Bestellung erfolgreich',
            'order' => $order,
            'items' => $items
        ]);
    }

    private function getCart(): ?array {
        $sessionId = session_id();
        return $this->db->fetchOne("SELECT id FROM carts WHERE session_id = ?", [$sessionId]);
    }
}
