<?php

namespace App\Middleware;

use App\Core\{Request, Response};

class ApiAuthMiddleware {
    public function __construct(
        private Request $req,
        private Response $res
    ) {}

    public function handle(callable $next): void {
        // Check for Bearer token in Authorization header
        $authHeader = $this->req->header('Authorization', '');
        
        if (preg_match('/Bearer\s+(.+)/i', $authHeader, $matches)) {
            $token = $matches[1];
            
            try {
                $db = \App\Core\Database::getInstance();
                $apiToken = $db->fetchOne("
                    SELECT at.*, c.id as customer_id, c.email 
                    FROM api_tokens at
                    JOIN customers c ON c.id = at.customer_id
                    WHERE at.token = ? AND at.expires_at > NOW() AND at.is_revoked = 0
                ", [$token]);
                
                if ($apiToken) {
                    $_SESSION['api_customer'] = [
                        'id' => $apiToken['customer_id'],
                        'email' => $apiToken['email']
                    ];
                    $next();
                    return;
                }
            } catch (\Throwable $e) {
                // Token validation failed
            }
        }
        
        // Fallback: check session auth
        if (isset($_SESSION['customer_id'])) {
            $next();
            return;
        }
        
        $this->res->json([
            'error' => 'Unauthorized',
            'message' => 'Valid authentication required'
        ], 401);
    }
}
