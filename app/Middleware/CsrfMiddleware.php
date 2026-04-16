<?php

namespace App\Middleware;

use App\Core\{Request, Response, Csrf};

class CsrfMiddleware {
    public function __construct(
        private Request $req,
        private Response $res
    ) {}

    public function handle(callable $next): void {
        if (in_array($this->req->method(), ['POST', 'PUT', 'PATCH', 'DELETE'])) {
            $token = $this->req->input('_csrf_token') 
                     ?? $this->req->header('X-CSRF-TOKEN', '');
            
            if (!Csrf::validate($token)) {
                http_response_code(403);
                session_flash('error', 'CSRF-Token ungültig. Bitte laden Sie die Seite neu.');
                
                if ($this->req->isApi()) {
                    $this->res->json(['error' => 'Invalid CSRF token'], 403);
                    return;
                }
                
                $this->res->redirect($_SERVER['HTTP_REFERER'] ?? '/');
                return;
            }
        }
        $next();
    }
}
