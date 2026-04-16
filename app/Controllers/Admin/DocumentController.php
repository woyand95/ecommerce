<?php

namespace App\Controllers\Admin;

use App\Core\Controller;

class DocumentController extends Controller {
    
    public function __construct(string $scope = 'backend') {
        parent::__construct($scope);
        
        if (!$this->adminUser()) {
            session_flash('error', 'Bitte melden Sie sich als Administrator an.');
            $this->redirect('/admin/login');
        }
    }

    public function index(array $p = []): void {
        $status = $this->request->query('status', 'pending');
        $page = max(1, (int) $this->request->query('page', 1));
        $perPage = 20;
        $offset = ($page - 1) * $perPage;
        
        $where = "WHERE 1=1";
        $params = [];
        
        if ($status !== 'all') {
            $where .= " AND cd.status = ?";
            $params[] = $status;
        }
        
        $documents = $this->db->fetchAll("
            SELECT cd.*, c.first_name, c.last_name, c.email, c.company_name
            FROM customer_documents cd
            JOIN customers c ON c.id = cd.customer_id
            $where
            ORDER BY cd.created_at DESC
            LIMIT $perPage OFFSET $offset
        ", $params);
        
        $total = (int) $this->db->fetchColumn("SELECT COUNT(*) FROM customer_documents cd $where", $params);
        $totalPages = ceil($total / $perPage);
        
        $this->view('admin/documents/index', [
            'title' => 'Dokumente',
            'documents' => $documents,
            'current_status' => $status,
            'pagination' => [
                'current_page' => $page,
                'total_pages' => $totalPages,
                'total' => $total
            ]
        ]);
    }

    public function review(array $p = []): void {
        $documentId = (int) ($p['id'] ?? 0);
        $data = $this->request->all();
        
        try {
            // Verify document exists
            $document = $this->db->fetchOne(
                "SELECT cd.*, c.verification_status FROM customer_documents cd JOIN customers c ON c.id = cd.customer_id WHERE cd.id = ?",
                [$documentId]
            );
            
            if (!$document) {
                session_flash('error', 'Dokument nicht gefunden.');
                $this->redirect('/admin/documents');
                return;
            }
            
            $newStatus = $data['status'] ?? 'approved';
            $validStatuses = ['pending', 'approved', 'rejected'];
            
            if (!in_array($newStatus, $validStatuses)) {
                throw new \Exception('Ungültiger Status.');
            }
            
            $this->db->execute("
                UPDATE customer_documents SET 
                    status = ?, 
                    reviewed_by = ?,
                    reviewed_at = NOW(),
                    review_notes = ?
                WHERE id = ?
            ", [$newStatus, $this->adminUser()['id'], $data['review_notes'] ?? null, $documentId]);
            
            // If approved, update customer verification status if all documents are approved
            if ($newStatus === 'approved') {
                // Check if customer has any pending or rejected documents
                $hasPending = $this->db->fetchColumn(
                    "SELECT COUNT(*) FROM customer_documents WHERE customer_id = ? AND status IN ('pending', 'rejected')",
                    [$document['customer_id']]
                );
                
                if ($hasPending === 0 && $document['verification_status'] === 'pending') {
                    $this->db->execute(
                        "UPDATE customers SET verification_status = 'verified', verified_at = NOW() WHERE id = ?",
                        [$document['customer_id']]
                    );
                }
            }
            
            session_flash('success', 'Dokument erfolgreich überprüft.');
            
        } catch (\Throwable $e) {
            error_log("Review document error: " . $e->getMessage());
            session_flash('error', 'Ein Fehler ist aufgetreten: ' . $e->getMessage());
        }
        
        $this->redirect('/admin/documents');
    }
}
