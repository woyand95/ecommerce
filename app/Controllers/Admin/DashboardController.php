<?php

namespace App\Controllers\Admin;

use App\Core\Controller;

class DashboardController extends Controller {
    
    public function __construct(string $scope = 'backend') {
        parent::__construct($scope);
        
        // Ensure admin is logged in
        if (!$this->adminUser()) {
            session_flash('error', 'Bitte melden Sie sich als Administrator an.');
            $this->redirect('/admin/login');
        }
    }

    public function index(array $p = []): void {
        $branchId = $this->adminBranchId();
        
        // Get statistics
        $stats = [];
        
        try {
            // Today's orders
            $stats['orders_today'] = (int) $this->db->fetchColumn("
                SELECT COUNT(*) FROM orders 
                WHERE DATE(created_at) = CURDATE() 
                AND (branch_id = ? OR ? IS NULL)
            ", [$branchId, $branchId]);
            
            // Pending orders
            $stats['orders_pending'] = (int) $this->db->fetchColumn("
                SELECT COUNT(*) FROM orders 
                WHERE status = 'pending' 
                AND (branch_id = ? OR ? IS NULL)
            ", [$branchId, $branchId]);
            
            // Revenue today
            $stats['revenue_today'] = (float) $this->db->fetchColumn("
                SELECT COALESCE(SUM(total), 0) FROM orders 
                WHERE DATE(created_at) = CURDATE() 
                AND (branch_id = ? OR ? IS NULL)
            ", [$branchId, $branchId]);
            
            // Low stock products
            $stats['low_stock'] = (int) $this->db->fetchColumn("
                SELECT COUNT(*) FROM products 
                WHERE stock_quantity < 10 AND is_active = 1
            ");
            
            // Pending customer verifications
            $stats['pending_verifications'] = (int) $this->db->fetchColumn("
                SELECT COUNT(*) FROM customers 
                WHERE verification_status = 'pending'
            ");
            
            // Recent orders
            $stats['recent_orders'] = $this->db->fetchAll("
                SELECT o.*, c.first_name, c.last_name, c.email
                FROM orders o
                JOIN customers c ON c.id = o.customer_id
                WHERE (o.branch_id = ? OR ? IS NULL)
                ORDER BY o.created_at DESC
                LIMIT 10
            ", [$branchId, $branchId]);
            
        } catch (\Throwable $e) {
            error_log("Dashboard stats error: " . $e->getMessage());
        }
        
        $this->view('admin/dashboard', [
            'title' => 'Dashboard',
            'stats' => $stats
        ]);
    }
}
