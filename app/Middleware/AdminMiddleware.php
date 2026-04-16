<?php

namespace App\Middleware;

use App\Core\{Request, Response};

class AdminMiddleware {
    public function __construct(
        private Request $req,
        private Response $res
    ) {}

    public function handle(callable $next): void {
        if (!isset($_SESSION['admin_id'])) {
            session_flash('error', 'Zugriff verweigert. Bitte melden Sie sich als Administrator an.');
            $this->res->redirect('/admin/login');
            return;
        }
        $next();
    }
}
