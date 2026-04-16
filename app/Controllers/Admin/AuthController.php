<?php

namespace App\Controllers\Admin;

use App\Core\Controller;

class AuthController extends Controller {
    
    public function __construct(string $scope = 'backend') {
        parent::__construct($scope);
    }

    public function loginForm(array $p = []): void {
        // If already logged in as admin, redirect to dashboard
        if ($this->adminUser()) {
            $this->redirect('/admin');
            return;
        }
        
        $this->view('admin/auth/login', [
            'title' => 'Admin Login',
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
            $this->redirect('/admin/login');
            return;
        }
        
        try {
            $adminUser = $this->db->fetchOne("
                SELECT au.*, b.id as branch_id, b.name as branch_name, b.slug as branch_slug,
                       r.name as role_name, r.permissions as role_permissions
                FROM admin_users au
                LEFT JOIN branches b ON b.id = au.branch_id
                LEFT JOIN roles r ON r.id = au.role_id
                WHERE au.email = ? AND au.is_active = 1
            ", [$email]);
            
            if (!$adminUser) {
                session_flash('error', 'Ungültige Anmeldeinformationen.');
                $this->redirect('/admin/login');
                return;
            }
            
            if (!password_verify($password, $adminUser['password_hash'])) {
                session_flash('error', 'Ungültige Anmeldeinformationen.');
                $this->redirect('/admin/login');
                return;
            }
            
            // Set session
            $_SESSION['admin_id'] = $adminUser['id'];
            $_SESSION['admin_user'] = [
                'id' => $adminUser['id'],
                'email' => $adminUser['email'],
                'first_name' => $adminUser['first_name'],
                'last_name' => $adminUser['last_name'],
                'branch_id' => $adminUser['branch_id'],
                'role_id' => $adminUser['role_id'],
                'role_name' => $adminUser['role_name']
            ];
            
            if ($adminUser['branch_id']) {
                $_SESSION['branch_id'] = $adminUser['branch_id'];
            }
            
            // Update last login
            $this->db->execute("UPDATE admin_users SET last_login_at = NOW() WHERE id = ?", [$adminUser['id']]);
            
            session_flash('success', 'Willkommen zurück, ' . htmlspecialchars($adminUser['first_name']) . '!');
            
            // Redirect to intended page or dashboard
            $intended = $_SESSION['intended_url'] ?? '/admin';
            unset($_SESSION['intended_url']);
            $this->redirect($intended);
            
        } catch (\Throwable $e) {
            error_log("Admin login error: " . $e->getMessage());
            session_flash('error', 'Ein Fehler ist aufgetreten. Bitte versuchen Sie es später erneut.');
            $this->redirect('/admin/login');
        }
    }

    public function logout(array $p = []): void {
        session_destroy();
        session_start(); // Start fresh session
        session_flash('success', 'Sie wurden erfolgreich abgemeldet.');
        $this->redirect('/admin/login');
    }
}
