<?php

namespace App\Controllers\Api;

use App\Core\Controller;

class AuthController extends Controller {
    
    public function login(array $p = []): void {
        $email = trim($this->request->input('email', ''));
        $password = $this->request->input('password', '');
        
        if (empty($email) || empty($password)) {
            $this->json(['error' => 'Email and password required'], 400);
            return;
        }
        
        try {
            $customer = $this->db->fetchOne("
                SELECT c.*, b.id as branch_id, b.name as branch_name
                FROM customers c
                JOIN branches b ON b.id = c.branch_id
                WHERE c.email = ? AND c.is_active = 1
            ", [$email]);
            
            if (!$customer || !password_verify($password, $customer['password_hash'])) {
                $this->json(['error' => 'Invalid credentials'], 401);
                return;
            }
            
            // Generate API token
            $token = bin2hex(random_bytes(32));
            $expiresAt = date('Y-m-d H:i:s', strtotime('+30 days'));
            
            $this->db->execute("
                INSERT INTO api_tokens (customer_id, token, expires_at)
                VALUES (?, ?, ?)
            ", [$customer['id'], $token, $expiresAt]);
            
            $this->json([
                'access_token' => $token,
                'token_type' => 'Bearer',
                'expires_in' => 30 * 24 * 60 * 60,
                'customer' => [
                    'id' => $customer['id'],
                    'email' => $customer['email'],
                    'first_name' => $customer['first_name'],
                    'last_name' => $customer['last_name']
                ]
            ]);
            
        } catch (\Throwable $e) {
            error_log("API login error: " . $e->getMessage());
            $this->json(['error' => 'Internal server error'], 500);
        }
    }

    public function register(array $p = []): void {
        $data = $this->request->all();
        
        // Validation
        if (empty($data['email']) || empty($data['password']) || 
            empty($data['first_name']) || empty($data['last_name'])) {
            $this->json(['error' => 'Missing required fields'], 400);
            return;
        }
        
        try {
            // Check if email exists
            $existing = $this->db->fetchOne("SELECT id FROM customers WHERE email = ?", [$data['email']]);
            if ($existing) {
                $this->json(['error' => 'Email already registered'], 409);
                return;
            }
            
            // Create customer
            $this->db->execute("
                INSERT INTO customers (
                    branch_id, email, password_hash, first_name, last_name,
                    customer_type, verification_status, created_at, updated_at
                ) VALUES (?, ?, ?, ?, ?, ?, 'pending', NOW(), NOW())
            ", [
                $data['branch_id'] ?? 1,
                $data['email'],
                password_hash($data['password'], PASSWORD_DEFAULT),
                $data['first_name'],
                $data['last_name'],
                $data['customer_type'] ?? 'B2C'
            ]);
            
            $customerId = $this->db->lastInsertId();
            
            // Generate API token
            $token = bin2hex(random_bytes(32));
            $expiresAt = date('Y-m-d H:i:s', strtotime('+30 days'));
            
            $this->db->execute("
                INSERT INTO api_tokens (customer_id, token, expires_at)
                VALUES (?, ?, ?)
            ", [$customerId, $token, $expiresAt]);
            
            $this->json([
                'access_token' => $token,
                'token_type' => 'Bearer',
                'expires_in' => 30 * 24 * 60 * 60,
                'customer' => [
                    'id' => $customerId,
                    'email' => $data['email'],
                    'first_name' => $data['first_name'],
                    'last_name' => $data['last_name']
                ]
            ], 201);
            
        } catch (\Throwable $e) {
            error_log("API register error: " . $e->getMessage());
            $this->json(['error' => 'Internal server error'], 500);
        }
    }

    public function refresh(array $p = []): void {
        // Get current authenticated customer from session or token
        $customer = $_SESSION['api_customer'] ?? null;
        
        if (!$customer) {
            $this->json(['error' => 'Unauthorized'], 401);
            return;
        }
        
        try {
            // Revoke old tokens
            $this->db->execute("UPDATE api_tokens SET is_revoked = 1 WHERE customer_id = ?", [$customer['id']]);
            
            // Generate new token
            $token = bin2hex(random_bytes(32));
            $expiresAt = date('Y-m-d H:i:s', strtotime('+30 days'));
            
            $this->db->execute("
                INSERT INTO api_tokens (customer_id, token, expires_at)
                VALUES (?, ?, ?)
            ", [$customer['id'], $token, $expiresAt]);
            
            $this->json([
                'access_token' => $token,
                'token_type' => 'Bearer',
                'expires_in' => 30 * 24 * 60 * 60
            ]);
            
        } catch (\Throwable $e) {
            error_log("API token refresh error: " . $e->getMessage());
            $this->json(['error' => 'Internal server error'], 500);
        }
    }
}
