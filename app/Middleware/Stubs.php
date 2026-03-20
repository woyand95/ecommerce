<?php

namespace App\Middleware;

use App\Core\{Request, Response};

class AuthMiddleware {
    public function __construct(private Request $req, private Response $res) {}
    public function handle(callable $next): void { $next(); } // Stub: always pass
}

class AdminMiddleware {
    public function __construct(private Request $req, private Response $res) {}
    public function handle(callable $next): void { $next(); } // Stub: always pass
}

class CsrfMiddleware {
    public function __construct(private Request $req, private Response $res) {}
    public function handle(callable $next): void { $next(); } // Stub: always pass
}

class ThrottleMiddleware {
    public function __construct(private Request $req, private Response $res) {}
    public function handle(callable $next): void { $next(); }
}

class ApiAuthMiddleware {
    public function __construct(private Request $req, private Response $res) {}
    public function handle(callable $next): void { $next(); }
}

class VerifiedCustomerMiddleware {
    public function __construct(private Request $req, private Response $res) {}
    public function handle(callable $next): void { $next(); }
}
