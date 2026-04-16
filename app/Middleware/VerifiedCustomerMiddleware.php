<?php

namespace App\Middleware;

use App\Core\{Request, Response};

class VerifiedCustomerMiddleware {
    public function __construct(
        private Request $req,
        private Response $res
    ) {}

    public function handle(callable $next): void {
        if (!isset($_SESSION['customer_id'])) {
            session_flash('error', 'Bitte melden Sie sich an.');
            $this->res->redirect('/auth/login');
            return;
        }

        try {
            $db = \App\Core\Database::getInstance();
            $customer = $db->fetchOne(
                "SELECT verification_status FROM customers WHERE id = ?",
                [$_SESSION['customer_id']]
            );

            if ($customer && $customer['verification_status'] !== 'verified') {
                session_flash('warning', 'Ihr Konto muss noch verifiziert werden. Bitte laden Sie die erforderlichen Dokumente hoch.');
                
                if ($this->req->isApi()) {
                    $this->res->json([
                        'error' => 'Account not verified',
                        'status' => $customer['verification_status'],
                        'message' => 'Please upload required documents for verification'
                    ], 403);
                    return;
                }
                
                $this->res->redirect('/account/documents');
                return;
            }
        } catch (\Throwable $e) {
            // On error, allow access but log the issue
            error_log("VerifiedCustomerMiddleware error: " . $e->getMessage());
        }

        $next();
    }
}
