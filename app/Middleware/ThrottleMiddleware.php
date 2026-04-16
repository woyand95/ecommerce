<?php

namespace App\Middleware;

use App\Core\{Request, Response};

class ThrottleMiddleware {
    private const LIMIT = 60; // requests per minute
    private const WINDOW = 60; // seconds

    public function __construct(
        private Request $req,
        private Response $res
    ) {}

    public function handle(callable $next): void {
        $key = 'throttle:' . md5($this->getClientIdentifier());
        $now = time();
        
        $cache = \App\Services\CacheService::getInstance();
        $data = $cache->get($key) ?? ['count' => 0, 'reset' => $now + self::WINDOW];
        
        if ($now >= $data['reset']) {
            $data = ['count' => 0, 'reset' => $now + self::WINDOW];
        }
        
        $data['count']++;
        $cache->set($key, $data, self::WINDOW);
        
        if ($data['count'] > self::LIMIT) {
            if ($this->req->isApi()) {
                $this->res->json([
                    'error' => 'Too many requests',
                    'retry_after' => $data['reset'] - $now
                ], 429);
                return;
            }
            
            http_response_code(429);
            session_flash('error', 'Zu viele Anfragen. Bitte warten Sie kurz.');
            $this->res->redirect($_SERVER['HTTP_REFERER'] ?? '/');
            return;
        }
        
        $next();
    }

    private function getClientIdentifier(): string {
        return $_SERVER['HTTP_X_FORWARDED_FOR'] 
               ?? $_SERVER['REMOTE_ADDR'] 
               : session_id();
    }
}
