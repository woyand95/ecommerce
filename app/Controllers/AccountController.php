<?php

namespace App\Controllers;

use App\Core\Controller;

class AccountController extends Controller {
    
    public function __construct(string $scope = 'frontend') {
        parent::__construct($scope);
        
        // Ensure customer is logged in for all account actions
        if (!$this->customer()) {
            $_SESSION['intended_url'] = $_SERVER['REQUEST_URI'];
            session_flash('error', 'Bitte melden Sie sich an, um auf Ihr Konto zuzugreifen.');
            $this->redirect('/auth/login');
        }
    }

    public function orders(array $p = []): void {
        $customer = $this->customer();
        
        $orders = $this->db->fetchAll("
            SELECT o.*, 
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
            WHERE o.customer_id = ?
            ORDER BY o.created_at DESC
            LIMIT 50
        ", [$customer['id']]);
        
        $this->view('account/orders', [
            'title' => 'Meine Bestellungen',
            'orders' => $orders
        ]);
    }

    public function orderDetail(array $p = []): void {
        $customer = $this->customer();
        $orderId = (int) ($p['id'] ?? 0);
        
        if ($orderId <= 0) {
            session_flash('error', 'Bestellung nicht gefunden.');
            $this->redirect('/account/orders');
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
            "SELECT oi.*, COALESCE(pt.url_slug, pt_fb.url_slug) as url_slug, pi.file_path as image_url
             FROM order_items oi
             JOIN products p ON p.id = oi.product_id
             LEFT JOIN product_translations pt ON pt.product_id = p.id AND pt.lang_code = ?
             LEFT JOIN product_translations pt_fb ON pt_fb.product_id = p.id AND pt_fb.lang_code = 'de'
             LEFT JOIN product_images pi ON pi.product_id = p.id AND pi.is_primary = 1
             WHERE oi.order_id = ?",
            [$this->lang(), $orderId]
        );
        
        $address = $this->db->fetchOne(
            "SELECT * FROM order_addresses WHERE order_id = ? AND address_type = 'shipping'",
            [$orderId]
        );
        
        $this->view('account/order-detail', [
            'title' => 'Bestellung #' . $order['order_number'],
            'order' => $order,
            'items' => $items,
            'address' => $address
        ]);
    }

    public function profile(array $p = []): void {
        $customer = $this->customer();
        
        $fullCustomer = $this->db->fetchOne(
            "SELECT * FROM customers WHERE id = ?",
            [$customer['id']]
        );
        
        $this->view('account/profile', [
            'title' => 'Mein Profil',
            'customer' => $fullCustomer,
            'csrf_token' => \App\Core\Csrf::token()
        ]);
    }

    public function updateProfile(array $p = []): void {
        $customer = $this->customer();
        $data = $this->request->all();
        
        try {
            $updateData = [
                'first_name' => $data['first_name'] ?? '',
                'last_name' => $data['last_name'] ?? '',
                'company_name' => $data['company_name'] ?? null,
                'phone' => $data['phone'] ?? null,
                'updated_at' => date('Y-m-d H:i:s')
            ];
            
            // Update password if provided
            if (!empty($data['new_password'])) {
                if (strlen($data['new_password']) < 8) {
                    session_flash('error', 'Das neue Passwort muss mindestens 8 Zeichen lang sein.');
                    $this->redirect('/account/profile');
                    return;
                }
                
                if ($data['new_password'] !== ($data['password_confirmation'] ?? '')) {
                    session_flash('error', 'Die Passwörter stimmen nicht überein.');
                    $this->redirect('/account/profile');
                    return;
                }
                
                $updateData['password_hash'] = password_hash($data['new_password'], PASSWORD_DEFAULT);
            }
            
            $this->db->execute("
                UPDATE customers SET
                    first_name = ?, last_name = ?, company_name = ?, phone = ?,
                    password_hash = COALESCE(?, password_hash),
                    updated_at = ?
                WHERE id = ?
            ", [
                $updateData['first_name'],
                $updateData['last_name'],
                $updateData['company_name'],
                $updateData['phone'],
                $updateData['password_hash'] ?? null,
                $updateData['updated_at'],
                $customer['id']
            ]);
            
            // Update session
            $_SESSION['customer'] = array_merge($_SESSION['customer'], [
                'first_name' => $updateData['first_name'],
                'last_name' => $updateData['last_name'],
                'company_name' => $updateData['company_name']
            ]);
            
            session_flash('success', 'Profil erfolgreich aktualisiert.');
            $this->redirect('/account/profile');
            
        } catch (\Throwable $e) {
            error_log("Update profile error: " . $e->getMessage());
            session_flash('error', 'Ein Fehler ist aufgetreten.');
            $this->redirect('/account/profile');
        }
    }

    public function addresses(array $p = []): void {
        $customer = $this->customer();
        
        $addresses = $this->db->fetchAll(
            "SELECT * FROM addresses WHERE customer_id = ? ORDER BY is_default DESC, id DESC",
            [$customer['id']]
        );
        
        $this->view('account/addresses', [
            'title' => 'Meine Adressen',
            'addresses' => $addresses,
            'csrf_token' => \App\Core\Csrf::token()
        ]);
    }

    public function storeAddress(array $p = []): void {
        $customer = $this->customer();
        $data = $this->request->all();
        
        // Validation
        if (empty($data['first_name']) || empty($data['last_name']) || 
            empty($data['address_line1']) || empty($data['city']) || 
            empty($data['postal_code'])) {
            session_flash('error', 'Bitte füllen Sie alle erforderlichen Felder aus.');
            $this->redirect('/account/addresses');
            return;
        }
        
        try {
            // If this is set as default, unset other defaults first
            if (!empty($data['is_default'])) {
                $this->db->execute(
                    "UPDATE addresses SET is_default = 0 WHERE customer_id = ?",
                    [$customer['id']]
                );
            }
            
            $this->db->execute("
                INSERT INTO addresses (
                    customer_id, type, label, first_name, last_name, company,
                    street, address_line2, city, postal_code, country_code,
                    is_default, created_at
                ) VALUES (?, 'shipping', ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, NOW())
            ", [
                $customer['id'],
                $data['address_label'] ?? 'Neue Adresse',
                $data['first_name'],
                $data['last_name'],
                $data['company_name'] ?? null,
                $data['address_line1'],
                $data['address_line2'] ?? null,
                $data['city'],
                $data['postal_code'],
                $data['country_code'] ?? 'DE',
                !empty($data['is_default']) ? 1 : 0
            ]);
            
            session_flash('success', 'Adresse erfolgreich gespeichert.');
            $this->redirect('/account/addresses');
            
        } catch (\Throwable $e) {
            error_log("Store address error: " . $e->getMessage());
            session_flash('error', 'Ein Fehler ist aufgetreten.');
            $this->redirect('/account/addresses');
        }
    }

    public function deleteAddress(array $p = []): void {
        $customer = $this->customer();
        $addressId = (int) ($p['id'] ?? 0);
        
        if ($addressId <= 0) {
            session_flash('error', 'Ungültige Adresse.');
            $this->redirect('/account/addresses');
            return;
        }
        
        try {
            // Verify address belongs to customer
            $exists = $this->db->fetchColumn(
                "SELECT COUNT(*) FROM addresses WHERE id = ? AND customer_id = ?",
                [$addressId, $customer['id']]
            );
            
            if ($exists) {
                $this->db->execute("DELETE FROM addresses WHERE id = ?", [$addressId]);
                session_flash('success', 'Adresse gelöscht.');
            }
            
            // Return JSON for AJAX requests
            if ($this->request->header('X-Requested-With') === 'XMLHttpRequest') {
                $this->json(['success' => true, 'message' => 'Adresse gelöscht']);
                return;
            }
            
            $this->redirect('/account/addresses');
            
        } catch (\Throwable $e) {
            error_log("Delete address error: " . $e->getMessage());
            session_flash('error', 'Ein Fehler ist aufgetreten.');
            $this->redirect('/account/addresses');
        }
    }

    public function documents(array $p = []): void {
        $customer = $this->customer();
        
        $documents = $this->db->fetchAll(
            "SELECT * FROM customer_documents WHERE customer_id = ? ORDER BY created_at DESC",
            [$customer['id']]
        );
        
        $verificationStatus = $this->db->fetchColumn(
            "SELECT verification_status FROM customers WHERE id = ?",
            [$customer['id']]
        );
        
        $this->view('account/documents', [
            'title' => 'Meine Dokumente',
            'documents' => $documents,
            'verification_status' => $verificationStatus,
            'csrf_token' => \App\Core\Csrf::token()
        ]);
    }

    public function uploadDocument(array $p = []): void {
        $customer = $this->customer();
        
        if (!$this->request->hasFile('document')) {
            session_flash('error', 'Bitte wählen Sie eine Datei aus.');
            $this->redirect('/account/documents');
            return;
        }
        
        $file = $this->request->files('document');
        
        // Validate file
        $allowedTypes = ['application/pdf', 'image/jpeg', 'image/png'];
        $maxSize = 5 * 1024 * 1024; // 5MB
        
        if (!in_array($file['type'], $allowedTypes)) {
            session_flash('error', 'Nur PDF, JPG und PNG Dateien sind erlaubt.');
            $this->redirect('/account/documents');
            return;
        }
        
        if ($file['size'] > $maxSize) {
            session_flash('error', 'Die Datei darf maximal 5MB groß sein.');
            $this->redirect('/account/documents');
            return;
        }
        
        try {
            // Generate unique filename
            $extension = pathinfo($file['name'], PATHINFO_EXTENSION);
            $filename = 'doc_' . $customer['id'] . '_' . time() . '.' . $extension;
            $uploadPath = STORAGE_PATH . '/uploads/customer_documents/' . $filename;
            
            // Ensure directory exists
            $dir = dirname($uploadPath);
            if (!is_dir($dir)) {
                mkdir($dir, 0755, true);
            }
            
            // Move uploaded file
            if (!move_uploaded_file($file['tmp_name'], $uploadPath)) {
                throw new \Exception('Fehler beim Hochladen der Datei.');
            }
            
            // Save to database
            $this->db->execute("
                INSERT INTO customer_documents (
                    customer_id, document_type, file_path, original_filename,
                    file_size, mime_type, status, created_at
                ) VALUES (?, ?, ?, ?, ?, ?, 'pending', NOW())
            ", [
                $customer['id'],
                $this->request->input('document_type', 'other'),
                '/storage/uploads/customer_documents/' . $filename,
                $file['name'],
                $file['size'],
                $file['type']
            ]);
            
            session_flash('success', 'Dokument erfolgreich hochgeladen. Es wird nun überprüft.');
            $this->redirect('/account/documents');
            
        } catch (\Throwable $e) {
            error_log("Upload document error: " . $e->getMessage());
            session_flash('error', 'Ein Fehler ist aufgetreten: ' . $e->getMessage());
            $this->redirect('/account/documents');
        }
    }
}
