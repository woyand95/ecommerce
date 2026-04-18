<?php

namespace App\Controllers;

use App\Core\Controller;

class CartController extends Controller {
    
    public function index(array $p = []): void {
        $cart = $this->getCart();
        $items = [];
        $subtotal = 0;
        
        if ($cart) {
            $branchId = $_SESSION['branch_id'] ?? 1;
            
            $items = $this->db->fetchAll("
                SELECT ci.*, p.name, p.slug, p.sku, 
                       COALESCE(pt.name, p.name) as translated_name,
                       pp.price, pp.old_price, pp.vat_rate,
                       (pp.price * ci.quantity) as line_total,
                       pi.image_url
                FROM cart_items ci
                JOIN products p ON p.id = ci.product_id
                LEFT JOIN product_translations pt ON pt.product_id = p.id AND pt.lang_code = ?
                LEFT JOIN product_prices pp ON pp.product_id = p.id AND pp.branch_id = ?
                LEFT JOIN (
                    SELECT pi.product_id, pi.image_url, 
                           ROW_NUMBER() OVER (PARTITION BY pi.product_id ORDER BY pi.is_primary DESC, pi.sort_order) as rn
                    FROM product_images pi WHERE pi.is_active = 1
                ) pi ON pi.product_id = p.id AND pi.rn = 1
                WHERE ci.cart_id = ?
                ORDER BY ci.created_at DESC
            ", [$this->lang(), $branchId, $cart['id']]);
            
            $subtotal = array_sum(array_column($items, 'line_total'));
        }
        
        $this->view('cart/index', [
            'title' => 'Warenkorb',
            'items' => $items,
            'subtotal' => $subtotal,
            'shipping_cost' => $subtotal > 50 ? 0 : 4.99,
            'csrf_token' => \App\Core\Csrf::token()
        ]);
    }

    public function addApi(array $p = []): void {
        $body = json_decode(file_get_contents('php://input'), true) ?? [];
        $productId = (int) ($body['product_id'] ?? $this->request->input('product_id', 0));
        $quantity = max(1, (int) ($body['quantity'] ?? $this->request->input('quantity', 1)));
        $variantId = isset($body['variant_id']) ? (int) $body['variant_id'] : ($this->request->input('variant_id') ? (int) $this->request->input('variant_id') : null);

        if ($productId <= 0) {
            $this->json(['error' => 'invalid_product', 'message' => 'Ungueltiges Produkt.'], 400);
            return;
        }

        try {
            $branchId = $_SESSION['branch_id'] ?? 1;
            $product = $this->db->fetchOne("SELECT p.id, COALESCE((SELECT SUM(quantity - reserved_qty) FROM product_branch_stock WHERE product_id = p.id AND branch_id = ?), 0) AS stock_quantity FROM products p WHERE p.id = ? AND p.is_active = 1", [$branchId, $productId]);
            if (!$product) {
                $this->json(['error' => 'not_found', 'message' => 'Produkt nicht gefunden.'], 404);
                return;
            }

            $sessionId = session_id();
            $branchId = $_SESSION['branch_id'] ?? 1;
            $customerId = $_SESSION['customer_id'] ?? null;
            $cart = $this->db->fetchOne("SELECT id FROM carts WHERE session_id = ?", [$sessionId]);
            if (!$cart) {
                $cartId = $this->db->insert('carts', [
                    'session_id' => $sessionId,
                    'branch_id' => $branchId,
                    'customer_id' => $customerId,
                    'created_at' => date('Y-m-d H:i:s')
                ]);
            } else {
                $cartId = $cart['id'];
            }

            $existingItem = null;
            if ($variantId) {
                $existingItem = $this->db->fetchOne(
                    "SELECT id, quantity FROM cart_items WHERE cart_id = ? AND product_id = ? AND variant_id = ?",
                    [$cartId, $productId, $variantId]
                );
            } else {
                $existingItem = $this->db->fetchOne(
                    "SELECT id, quantity FROM cart_items WHERE cart_id = ? AND product_id = ? AND variant_id IS NULL",
                    [$cartId, $productId]
                );
            }

            if ($existingItem) {
                $newQuantity = $existingItem['quantity'] + $quantity;
                if ($newQuantity > $product['stock_quantity']) {
                    $this->json(['error' => 'stock', 'message' => 'Nur noch ' . $product['stock_quantity'] . ' Stueck verfuegbar.'], 400);
                    return;
                }
                $this->db->execute("UPDATE cart_items SET quantity = ? WHERE id = ?", [$newQuantity, $existingItem['id']]);
            } else {
                if ($quantity > $product['stock_quantity']) {
                    $this->json(['error' => 'stock', 'message' => 'Nur noch ' . $product['stock_quantity'] . ' Stueck verfuegbar.'], 400);
                    return;
                }
                $this->db->execute(
                    "INSERT INTO cart_items (cart_id, product_id, variant_id, quantity) VALUES (?, ?, ?, ?)",
                    [$cartId, $productId, $variantId, $quantity]
                );
            }

            $count = \App\Services\CartService::count();
            $this->json(['success' => true, 'message' => 'Zum Warenkorb hinzugefuegt.', 'cart_count' => $count]);
        } catch (\Throwable $e) {
            $this->json(['error' => 'server_error', 'message' => 'Ein Fehler ist aufgetreten: ' . $e->getMessage()], 500);
        }
    }

    public function add(array $p = []): void {
        $productId = (int) $this->request->input('product_id', 0);
        $quantity = max(1, (int) $this->request->input('quantity', 1));
        $variantId = $this->request->input('variant_id') ? (int) $this->request->input('variant_id') : null;
        
        if ($productId <= 0) {
            session_flash('error', 'Ungültiges Produkt.');
            $this->redirect('/products');
            return;
        }
        
        try {
            // Check product exists and is active
            $branchId = $_SESSION['branch_id'] ?? 1;
            $product = $this->db->fetchOne("SELECT p.id, COALESCE((SELECT SUM(quantity - reserved_qty) FROM product_branch_stock WHERE product_id = p.id AND branch_id = ?), 0) AS stock_quantity FROM products p WHERE p.id = ? AND p.is_active = 1", [$branchId, $productId]);
            if (!$product) {
                session_flash('error', 'Produkt nicht gefunden.');
                $this->redirect('/products');
                return;
            }
            
            // Get or create cart
            $sessionId = session_id();
            $branchId = $_SESSION['branch_id'] ?? 1;
            $customerId = $_SESSION['customer_id'] ?? null;
            $cart = $this->db->fetchOne("SELECT id FROM carts WHERE session_id = ?", [$sessionId]);
            
            if (!$cart) {
                $this->db->execute("INSERT INTO carts (session_id, branch_id, customer_id, created_at) VALUES (?, ?, ?, NOW())", [$sessionId, $branchId, $customerId]);
                $cartId = $this->db->lastInsertId();
            } else {
                $cartId = $cart['id'];
            }
            
            // Check if item already in cart
            $existingItem = null;
            if ($variantId) {
                $existingItem = $this->db->fetchOne(
                    "SELECT id, quantity FROM cart_items WHERE cart_id = ? AND product_id = ? AND variant_id = ?",
                    [$cartId, $productId, $variantId]
                );
            } else {
                $existingItem = $this->db->fetchOne(
                    "SELECT id, quantity FROM cart_items WHERE cart_id = ? AND product_id = ? AND variant_id IS NULL",
                    [$cartId, $productId]
                );
            }
            
            if ($existingItem) {
                $newQuantity = $existingItem['quantity'] + $quantity;
                
                // Check stock
                if ($newQuantity > $product['stock_quantity']) {
                    session_flash('warning', 'Nur noch ' . $product['stock_quantity'] . ' Stück verfügbar.');
                    $newQuantity = $product['stock_quantity'];
                }
                
                $this->db->execute("UPDATE cart_items SET quantity = ?, updated_at = NOW() WHERE id = ?", [$newQuantity, $existingItem['id']]);
            } else {
                // Check stock
                if ($quantity > $product['stock_quantity']) {
                    session_flash('warning', 'Nur noch ' . $product['stock_quantity'] . ' Stück verfügbar.');
                    $quantity = $product['stock_quantity'];
                }
                
                $this->db->execute("
                    INSERT INTO cart_items (cart_id, product_id, variant_id, quantity, created_at)
                    VALUES (?, ?, ?, ?, NOW())
                ", [$cartId, $productId, $variantId, $quantity]);
            }
            
            session_flash('success', 'Produkt zum Warenkorb hinzugefügt.');
            
            // Return JSON for AJAX requests
            if ($this->request->header('X-Requested-With') === 'XMLHttpRequest') {
                $this->json([
                    'success' => true,
                    'message' => 'Produkt hinzugefügt',
                    'cart_count' => \App\Services\CartService::count()
                ]);
                return;
            }
            
            $this->redirect('/cart');
            
        } catch (\Throwable $e) {
            error_log("Add to cart error: " . $e->getMessage());
            session_flash('error', 'Ein Fehler ist aufgetreten.');
            $this->redirect('/products');
        }
    }

    public function update(array $p = []): void {
        $itemId = (int) ($p['id'] ?? 0);
        $quantity = (int) $this->request->input('quantity', 1);
        
        if ($itemId <= 0) {
            session_flash('error', 'Ungültiger Artikel.');
            $this->redirect('/cart');
            return;
        }
        
        try {
            $cart = $this->getCart();
            if (!$cart) {
                session_flash('error', 'Warenkorb nicht gefunden.');
                $this->redirect('/cart');
                return;
            }
            
            $branchId = $_SESSION['branch_id'] ?? 1;
            $item = $this->db->fetchOne("SELECT ci.*, COALESCE((SELECT SUM(quantity - reserved_qty) FROM product_branch_stock WHERE product_id = ci.product_id AND branch_id = ?), 0) AS stock_quantity FROM cart_items ci WHERE ci.id = ? AND ci.cart_id = ?", [$branchId, $itemId, $cart['id']]);
            
            if (!$item) {
                session_flash('error', 'Artikel nicht im Warenkorb.');
                $this->redirect('/cart');
                return;
            }
            
            if ($quantity <= 0) {
                $this->db->execute("DELETE FROM cart_items WHERE id = ?", [$itemId]);
                session_flash('success', 'Artikel entfernt.');
            } else {
                // Check stock
                if ($quantity > $item['stock_quantity']) {
                    session_flash('warning', 'Nur noch ' . $item['stock_quantity'] . ' Stück verfügbar.');
                    $quantity = $item['stock_quantity'];
                }
                
                $this->db->execute("UPDATE cart_items SET quantity = ?, updated_at = NOW() WHERE id = ?", [$quantity, $itemId]);
                session_flash('success', 'Warenkorb aktualisiert.');
            }
            
            $this->redirect('/cart');
            
        } catch (\Throwable $e) {
            error_log("Update cart error: " . $e->getMessage());
            session_flash('error', 'Ein Fehler ist aufgetreten.');
            $this->redirect('/cart');
        }
    }

    public function remove(array $p = []): void {
        $itemId = (int) ($p['id'] ?? 0);
        
        if ($itemId <= 0) {
            session_flash('error', 'Ungültiger Artikel.');
            $this->redirect('/cart');
            return;
        }
        
        try {
            $cart = $this->getCart();
            if (!$cart) {
                session_flash('error', 'Warenkorb nicht gefunden.');
                $this->redirect('/cart');
                return;
            }
            
            $exists = $this->db->fetchColumn("SELECT COUNT(*) FROM cart_items WHERE id = ? AND cart_id = ?", [$itemId, $cart['id']]);
            
            if ($exists) {
                $this->db->execute("DELETE FROM cart_items WHERE id = ?", [$itemId]);
                session_flash('success', 'Artikel entfernt.');
            }
            
            // Return JSON for AJAX requests
            if ($this->request->header('X-Requested-With') === 'XMLHttpRequest') {
                $this->json([
                    'success' => true,
                    'message' => 'Artikel entfernt',
                    'cart_count' => \App\Services\CartService::count()
                ]);
                return;
            }
            
            $this->redirect('/cart');
            
        } catch (\Throwable $e) {
            error_log("Remove cart error: " . $e->getMessage());
            session_flash('error', 'Ein Fehler ist aufgetreten.');
            $this->redirect('/cart');
        }
    }

    private function getCart(): ?array {
        $sessionId = session_id();
        return $this->db->fetchOne("SELECT id FROM carts WHERE session_id = ?", [$sessionId]);
    }
}
