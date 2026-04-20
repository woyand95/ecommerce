<?php

namespace App\Controllers;

use App\Core\Controller;

class AuthController extends Controller {
    
    public function loginForm(array $p = []): void {
        // If already logged in, redirect to account
        if ($this->customer()) {
            $this->redirect('/account/profile');
            return;
        }
        
        $this->view('auth/login', [
            'title' => 'Anmelden',
            'csrf_token' => \App\Core\Csrf::token()
        ]);
    }

    public function login(array $p = []): void {
        $email = trim($this->request->input('email', ''));
        $password = $this->request->input('password', '');
        $remember = $this->request->input('remember', false);
        
        // Validation
        if (empty($email) || empty($password)) {
            session_flash('error', 'Bitte E-Mail und Passwort eingeben.');
            $this->redirect('/auth/login');
            return;
        }
        
        try {
            $customer = $this->db->fetchOne("
                SELECT c.*, b.id as branch_id, b.name as branch_name, b.slug as branch_slug
                FROM customers c
                JOIN branches b ON b.id = c.branch_id
                WHERE c.email = ? AND c.is_active = 1
            ", [$email]);
            
            if (!$customer) {
                session_flash('error', 'Ungültige Anmeldeinformationen.');
                $this->redirect('/auth/login');
                return;
            }
            
            if (!password_verify($password, $customer['password_hash'])) {
                session_flash('error', 'Ungültige Anmeldeinformationen.');
                $this->redirect('/auth/login');
                return;
            }
            
            // Check if account is banned
            if ($customer['verification_status'] === 'banned') {
                session_flash('error', 'Ihr Konto wurde gesperrt. Bitte kontaktieren Sie den Support.');
                $this->redirect('/auth/login');
                return;
            }
            
            // Set session
            $_SESSION['customer_id'] = $customer['id'];
            $_SESSION['customer'] = [
                'id' => $customer['id'],
                'email' => $customer['email'],
                'first_name' => $customer['first_name'],
                'last_name' => $customer['last_name'],
                'company_name' => $customer['company_name'],
                'branch_id' => $customer['branch_id'],
                'verification_status' => $customer['verification_status']
            ];
            $_SESSION['branch_id'] = $customer['branch_id'];
            
            // Remember me functionality
            if ($remember) {
                $token = bin2hex(random_bytes(32));
                $this->db->execute("
                    INSERT INTO customer_sessions (customer_id, token, expires_at)
                    VALUES (?, ?, DATE_ADD(NOW(), INTERVAL 30 DAY))
                ", [$customer['id'], $token]);
                
                setcookie('customer_session', $token, [
                    'expires' => time() + (30 * 24 * 60 * 60),
                    'path' => '/',
                    'httponly' => true,
                    'samesite' => 'Strict'
                ]);
            }
            
            // Update last login
            $this->db->execute("UPDATE customers SET last_login_at = NOW() WHERE id = ?", [$customer['id']]);
            
            session_flash('success', 'Willkommen zurück, ' . htmlspecialchars($customer['first_name']) . '!');
            
            // Redirect to intended page or account
            $intended = $_SESSION['intended_url'] ?? '/account/profile';
            unset($_SESSION['intended_url']);
            $this->redirect($intended);
            
        } catch (\Throwable $e) {
            error_log("Login error: " . $e->getMessage());
            session_flash('error', 'Ein Fehler ist aufgetreten. Bitte versuchen Sie es später erneut.');
            $this->redirect('/auth/login');
        }
    }

    public function registerForm(array $p = []): void {
        if ($this->customer()) {
            $this->redirect('/account/profile');
            return;
        }
        
        $branches = $this->db->fetchAll("SELECT id, name, slug FROM branches WHERE is_active = 1 ORDER BY name");
        
        $this->view('auth/register', [
            'title' => 'Registrieren',
            'branches' => $branches,
            'csrf_token' => \App\Core\Csrf::token()
        ]);
    }

    public function register(array $p = []): void {
        $data = $this->request->all();
        
        // Validation
        $errors = [];
        
        if (empty($data['first_name'])) {
            $errors[] = 'Vorname ist erforderlich.';
        }
        
        if (empty($data['last_name'])) {
            $errors[] = 'Nachname ist erforderlich.';
        }
        
        if (empty($data['email']) || !filter_var($data['email'], FILTER_VALIDATE_EMAIL)) {
            $errors[] = 'Eine gültige E-Mail-Adresse ist erforderlich.';
        }
        
        if (empty($data['password']) || strlen($data['password']) < 8) {
            $errors[] = 'Das Passwort muss mindestens 8 Zeichen lang sein.';
        }
        
        if (($data['password'] ?? '') !== ($data['password_confirmation'] ?? '')) {
            $errors[] = 'Die Passwörter stimmen nicht überein.';
        }
        
        if (empty($data['branch_id'])) {
            $errors[] = 'Bitte wählen Sie einen Standort aus.';
        }
        
        if (!empty($errors)) {
            foreach ($errors as $error) {
                session_flash('error', $error);
            }
            $this->redirect('/auth/register');
            return;
        }
        
        try {
            // Check if email already exists
            $existing = $this->db->fetchOne("SELECT id FROM customers WHERE email = ?", [$data['email']]);
            if ($existing) {
                session_flash('error', 'Diese E-Mail-Adresse ist bereits registriert.');
                $this->redirect('/auth/register');
                return;
            }
            
            // Create customer
            $this->db->execute("
                INSERT INTO customers (
                    branch_id, email, password_hash, first_name, last_name, 
                    company_name, customer_type, phone, verification_status,
                    created_at, updated_at
                ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, 'pending', NOW(), NOW())
            ", [
                $data['branch_id'],
                $data['email'],
                password_hash($data['password'], PASSWORD_DEFAULT),
                $data['first_name'],
                $data['last_name'],
                $data['company_name'] ?? null,
                $data['customer_type'] ?? 'B2C',
                $data['phone'] ?? null
            ]);
            
            $customerId = $this->db->lastInsertId();
            
            // Create default address if provided
            if (!empty($data['address_line1'])) {
                $this->db->execute("
                    INSERT INTO addresses (
                        customer_id, type, label, first_name, last_name, company,
                        street, address_line2, city, postal_code, country_code,
                        is_default, created_at
                    ) VALUES (?, 'shipping', 'Privatadresse', ?, ?, ?, ?, ?, ?, ?, ?, 1, NOW())
                ", [
                    $customerId,
                    $data['first_name'],
                    $data['last_name'],
                    $data['company_name'] ?? null,
                    $data['address_line1'] ?? 'Default Street',
                    $data['address_line2'] ?? null,
                    $data['city'] ?? 'Default City',
                    $data['postal_code'] ?? '00000',
                    $data['country_code'] ?? 'DE'
                ]);
            }
            
            session_flash('success', 'Registrierung erfolgreich! Bitte melden Sie sich an.');
            $this->redirect('/auth/login');
            
        } catch (\Throwable $e) {
            error_log("Registration error: " . $e->getMessage());
            session_flash('error', 'Ein Fehler ist aufgetreten. Bitte versuchen Sie es später erneut.');
            $this->redirect('/auth/register');
        }
    }

    public function logout(array $p = []): void {
        // Revoke remember me token if exists
        if (isset($_COOKIE['customer_session'])) {
            $token = $_COOKIE['customer_session'];
            $this->db->execute("DELETE FROM customer_sessions WHERE token = ?", [$token]);
            setcookie('customer_session', '', [
                'expires' => time() - 3600,
                'path' => '/'
            ]);
        }
        
        session_destroy();
        session_start(); // Start fresh session
        session_flash('success', 'Sie wurden erfolgreich abgemeldet.');
        $this->redirect('/');
    }
}
