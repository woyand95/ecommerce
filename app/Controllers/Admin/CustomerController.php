<?php

namespace App\Controllers\Admin;

use App\Core\Controller;

class CustomerController extends Controller {
    
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
        
        $where = "WHERE 1=1";
        $params = [];
        
        if ($branchId !== null) {
            $where .= " AND c.branch_id = ?";
            $params[] = $branchId;
        }
        
        if ($status !== 'all') {
            $where .= " AND c.verification_status = ?";
            $params[] = $status;
        }
        
        $customers = $this->db->fetchAll("
            SELECT c.*, b.name as branch_name,
                   COUNT(o.id) as order_count,
                   COALESCE(SUM(o.total), 0) as total_spent
            FROM customers c
            LEFT JOIN branches b ON b.id = c.branch_id
            LEFT JOIN orders o ON o.customer_id = c.id
            $where
            GROUP BY c.id
            ORDER BY c.created_at DESC
            LIMIT $perPage OFFSET $offset
        ", $params);
        
        $total = (int) $this->db->fetchColumn("SELECT COUNT(*) FROM customers c $where", $params);
        $totalPages = ceil($total / $perPage);
        
        $this->view('admin/customers/index', [
            'title' => 'Kunden',
            'customers' => $customers,
            'current_status' => $status,
            'pagination' => [
                'current_page' => $page,
                'total_pages' => $totalPages,
                'total' => $total
            ]
        ]);
    }

    public function show(array $p = []): void {
        $customerId = (int) ($p['id'] ?? 0);
        $branchId = $this->adminBranchId();
        
        $customer = $this->db->fetchOne("
            SELECT c.*, b.name as branch_name
            FROM customers c
            LEFT JOIN branches b ON b.id = c.branch_id
            WHERE c.id = ? AND (c.branch_id = ? OR ? IS NULL)
        ", [$customerId, $branchId, $branchId]);
        
        if (!$customer) {
            session_flash('error', 'Kunde nicht gefunden.');
            $this->redirect('/admin/customers');
            return;
        }
        
        // Get customer orders
        $orders = $this->db->fetchAll(
            "SELECT * FROM orders WHERE customer_id = ? ORDER BY created_at DESC LIMIT 20",
            [$customerId]
        );
        
        // Get customer addresses
        $addresses = $this->db->fetchAll(
            "SELECT * FROM customer_addresses WHERE customer_id = ? ORDER BY is_default DESC",
            [$customerId]
        );
        
        // Get customer documents
        $documents = $this->db->fetchAll(
            "SELECT * FROM customer_documents WHERE customer_id = ? ORDER BY created_at DESC",
            [$customerId]
        );
        
        $this->view('admin/customers/show', [
            'title' => 'Kunde: ' . $customer['first_name'] . ' ' . $customer['last_name'],
            'customer' => $customer,
            'orders' => $orders,
            'addresses' => $addresses,
            'documents' => $documents
        ]);
    }

    public function verify(array $p = []): void {
        $customerId = (int) ($p['id'] ?? 0);
        $branchId = $this->adminBranchId();
        $data = $this->request->all();
        
        try {
            // Verify customer exists and belongs to admin's branch
            $customer = $this->db->fetchOne(
                "SELECT id, verification_status FROM customers WHERE id = ? AND (branch_id = ? OR ? IS NULL)",
                [$customerId, $branchId, $branchId]
            );
            
            if (!$customer) {
                session_flash('error', 'Kunde nicht gefunden.');
                $this->redirect('/admin/customers');
                return;
            }
            
            $newStatus = $data['verification_status'] ?? 'verified';
            $validStatuses = ['pending', 'verified', 'rejected', 'banned'];
            
            if (!in_array($newStatus, $validStatuses)) {
                throw new \Exception('Ungültiger Verifizierungsstatus.');
            }
            
            $this->db->execute("
                UPDATE customers SET 
                    verification_status = ?, 
                    verified_at = CASE WHEN ? = 'verified' THEN NOW() ELSE verified_at END,
                    updated_at = NOW()
                WHERE id = ?
            ", [$newStatus, $newStatus, $customerId]);
            
            // If rejecting or banning, optionally send notification
            
            session_flash('success', 'Kundenstatus aktualisiert.');
            
        } catch (\Throwable $e) {
            error_log("Verify customer error: " . $e->getMessage());
            session_flash('error', 'Ein Fehler ist aufgetreten: ' . $e->getMessage());
        }
        
        $this->redirect('/admin/customers/' . $customerId);
    }
}
