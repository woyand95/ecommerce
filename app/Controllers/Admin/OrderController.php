<?php

namespace App\Controllers\Admin;

use App\Core\Controller;

class OrderController extends Controller {
    
    public function __construct(string $scope = 'backend') {
        parent::__construct($scope);
        
        if (!$this->adminUser()) {
            session_flash('error', 'Bitte melden Sie sich als Administrator an.');
            $this->redirect('/admin/login');
        }
    }

    public function index(array $p = []): void {
        $branchId = $this->adminBranchId();
        $status = $this->request->query('status', 'all');
        $page = max(1, (int) $this->request->query('page', 1));
        $perPage = 20;
        $offset = ($page - 1) * $perPage;
        
        $where = "WHERE (o.branch_id = ? OR ? IS NULL)";
        $params = [$branchId, $branchId];
        
        if ($status !== 'all') {
            $where .= " AND o.status = ?";
            $params[] = $status;
        }
        
        $orders = $this->db->fetchAll("
            SELECT o.*, c.first_name, c.last_name, c.email,
                   CASE o.status 
                       WHEN 'pending' THEN 'Ausstehend'
                       WHEN 'confirmed' THEN 'Bestätigt'
                       WHEN 'processing' THEN 'In Bearbeitung'
                       WHEN 'shipped' THEN 'Versendet'
                       WHEN 'delivered' THEN 'Zugestellt'
                       WHEN 'cancelled' THEN 'Storniert'
                       ELSE o.status
                   END as status_label
            FROM orders o
            JOIN customers c ON c.id = o.customer_id
            $where
            ORDER BY o.created_at DESC
            LIMIT $perPage OFFSET $offset
        ", $params);
        
        $total = (int) $this->db->fetchColumn("SELECT COUNT(*) FROM orders o $where", $params);
        $totalPages = ceil($total / $perPage);
        
        $this->view('admin/orders/index', [
            'title' => 'Bestellungen',
            'orders' => $orders,
            'current_status' => $status,
            'pagination' => [
                'current_page' => $page,
                'total_pages' => $totalPages,
                'total' => $total
            ]
        ]);
    }

    public function show(array $p = []): void {
        $orderId = (int) ($p['id'] ?? 0);
        $branchId = $this->adminBranchId();
        
        $order = $this->db->fetchOne("
            SELECT o.*, c.first_name, c.last_name, c.email, c.phone, c.company_name
            FROM orders o
            JOIN customers c ON c.id = o.customer_id
            WHERE o.id = ? AND (o.branch_id = ? OR ? IS NULL)
        ", [$orderId, $branchId, $branchId]);
        
        if (!$order) {
            session_flash('error', 'Bestellung nicht gefunden.');
            $this->redirect('/admin/orders');
            return;
        }
        
        $items = $this->db->fetchAll(
            "SELECT oi.*, p.name, p.sku FROM order_items oi JOIN products p ON p.id = oi.product_id WHERE oi.order_id = ?",
            [$orderId]
        );
        
        $address = $this->db->fetchOne(
            "SELECT * FROM order_addresses WHERE order_id = ? AND address_type = 'shipping'",
            [$orderId]
        );
        
        $this->view('admin/orders/show', [
            'title' => 'Bestellung #' . $order['order_number'],
            'order' => $order,
            'items' => $items,
            'address' => $address
        ]);
    }

    public function updateStatus(array $p = []): void {
        $orderId = (int) ($p['id'] ?? 0);
        $branchId = $this->adminBranchId();
        $data = $this->request->all();
        
        try {
            // Verify order exists and belongs to admin's branch
            $order = $this->db->fetchOne(
                "SELECT id FROM orders WHERE id = ? AND (branch_id = ? OR ? IS NULL)",
                [$orderId, $branchId, $branchId]
            );
            
            if (!$order) {
                session_flash('error', 'Bestellung nicht gefunden.');
                $this->redirect('/admin/orders');
                return;
            }
            
            $newStatus = $data['status'] ?? 'pending';
            $validStatuses = ['pending', 'confirmed', 'processing', 'shipped', 'delivered', 'cancelled'];
            
            if (!in_array($newStatus, $validStatuses)) {
                throw new \Exception('Ungültiger Status.');
            }
            
            $this->db->execute("
                UPDATE orders SET status = ?, updated_at = NOW()
                WHERE id = ?
            ", [$newStatus, $orderId]);
            
            // Create order status history
            $this->db->execute("
                INSERT INTO order_status_history (order_id, status, notes, created_at)
                VALUES (?, ?, ?, NOW())
            ", [$orderId, $newStatus, $data['notes'] ?? null]);
            
            session_flash('success', 'Bestellstatus aktualisiert.');
            
        } catch (\Throwable $e) {
            error_log("Update order status error: " . $e->getMessage());
            session_flash('error', 'Ein Fehler ist aufgetreten: ' . $e->getMessage());
        }
        
        $this->redirect('/admin/orders/' . $orderId);
    }
}
