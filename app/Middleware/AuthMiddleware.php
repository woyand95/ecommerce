<?php

namespace App\Middleware;

use App\Core\{Request, Response};

class AuthMiddleware {
    public function __construct(
        private Request $req,
        private Response $res
    ) {}

    public function handle(callable $next): void {
        if (!isset($_SESSION['customer_id'])) {
            session_flash('error', 'Bitte melden Sie sich an, um fortzufahren.');
            $this->res->redirect('/auth/login');
            return;
        }
        $next();
    }
}
