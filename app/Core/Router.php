<?php

namespace App\Core;

/**
 * Router — RESTful, middleware-aware, language-prefixed.
 *
 * Usage:
 *   $router->get('/products',             [ProductController::class, 'index']);
 *   $router->post('/admin/products',      [Admin\ProductController::class, 'store'], ['auth', 'admin']);
 *   $router->group('/api/v1', function($r){ $r->get('/products', ...); }, ['throttle']);
 */
class Router
{
    private array  $routes      = [];
    private array  $middlewares = [];
    private array  $groupStack  = [];
    private string $basePath    = '';

    public function __construct(
        private readonly Request  $request,
        private readonly Response $response
    ) {}

    // ── Route registration ───────────────────────────────────
    public function get(string $uri, array|callable $action, array $middleware = []): void
    {
        $this->addRoute('GET', $uri, $action, $middleware);
    }
    public function post(string $uri, array|callable $action, array $middleware = []): void
    {
        $this->addRoute('POST', $uri, $action, $middleware);
    }
    public function put(string $uri, array|callable $action, array $middleware = []): void
    {
        $this->addRoute('PUT', $uri, $action, $middleware);
    }
    public function patch(string $uri, array|callable $action, array $middleware = []): void
    {
        $this->addRoute('PATCH', $uri, $action, $middleware);
    }
    public function delete(string $uri, array|callable $action, array $middleware = []): void
    {
        $this->addRoute('DELETE', $uri, $action, $middleware);
    }

    /** Register all RESTful routes for a resource at once. */
    public function resource(string $name, string $controller, array $middleware = []): void
    {
        $this->get("/$name",              [$controller, 'index'],   $middleware);
        $this->get("/$name/create",       [$controller, 'create'],  $middleware);
        $this->post("/$name",             [$controller, 'store'],   $middleware);
        $this->get("/$name/{id}",         [$controller, 'show'],    $middleware);
        $this->get("/$name/{id}/edit",    [$controller, 'edit'],    $middleware);
        $this->patch("/$name/{id}",       [$controller, 'update'],  $middleware);
        $this->delete("/$name/{id}",      [$controller, 'destroy'], $middleware);
    }

    /** Group routes under a prefix with shared middleware. */
    public function group(string $prefix, callable $callback, array $middleware = []): void
    {
        $previousGroup = $this->groupStack;
        $this->groupStack[] = ['prefix' => $prefix, 'middleware' => $middleware];
        $callback($this);
        $this->groupStack = $previousGroup;
    }

    // ── Dispatch ─────────────────────────────────────────────
    public function dispatch(): void
    {
        $method = $this->request->method();
        $uri    = $this->normalisedUri();

        foreach ($this->routes as $route) {
            if ($route['method'] !== $method) continue;

            $params = $this->matchRoute($route['pattern'], $uri);
            if ($params === null) continue;

            // Run middleware pipeline
            $this->runMiddlewarePipeline($route['middleware'], function () use ($route, $params) {
                $this->callAction($route['action'], $params);
            });
            return;
        }

        // 404
        $this->response->setStatusCode(404);
        $this->callAction([Controllers\ErrorController::class, 'notFound'], []);
    }

    // ── Private helpers ──────────────────────────────────────
    private function addRoute(string $method, string $uri, array|callable $action, array $middleware): void
    {
        // Merge group stack
        $prefix     = implode('', array_column($this->groupStack, 'prefix'));

        $allMw = [];
        foreach ($this->groupStack as $group) {
            $allMw = array_merge($allMw, $group['middleware']);
        }
        $allMw = array_merge($allMw, $middleware);

        $fullUri    = $prefix . $uri;
        $pattern    = $this->buildPattern($fullUri);

        $this->routes[] = compact('method', 'pattern', 'action') + ['middleware' => $allMw];
    }

    /**
     * Convert /products/{id:\d+} → named regex pattern.
     */
    private function buildPattern(string $uri): string
    {
        $pattern = preg_replace_callback(
            '/\{(\w+)(?::([^}]+))?\}/',
            fn($m) => '(?P<' . $m[1] . '>' . ($m[2] ?? '[^/]+') . ')',
            $uri
        );
        return '#^' . $pattern . '$#';
    }

    /**
     * Returns named captures on match, null otherwise.
     */
    private function matchRoute(string $pattern, string $uri): ?array
    {
        if (!preg_match($pattern, $uri, $matches)) return null;
        return array_filter($matches, 'is_string', ARRAY_FILTER_USE_KEY);
    }

    private function normalisedUri(): string
    {
        $uri = parse_url($_SERVER['REQUEST_URI'] ?? '/', PHP_URL_PATH) ?? '/';
        $scriptDir = dirname($_SERVER['SCRIPT_NAME'] ?? ''); // /ecommerce/public
        $rootDir = dirname($scriptDir); // /ecommerce

        if ($scriptDir !== '/' && $scriptDir !== '\\' && str_starts_with($uri, $scriptDir)) {
            $uri = substr($uri, strlen($scriptDir));
        } elseif ($rootDir !== '/' && $rootDir !== '\\' && str_starts_with($uri, $rootDir)) {
            $uri = substr($uri, strlen($rootDir));
        }

        // Strip language prefix: /en/, /de/ → store lang, continue without prefix
        if (preg_match('#^/([a-z]{2})(/.*)?$#', $uri, $m)) {
            $this->request->setLang($m[1]);
            $uri = $m[2] ?? '/';
        }

        return rtrim($uri, '/') ?: '/';
    }

    private function callAction(array|callable $action, array $params): void
    {
        if (is_callable($action)) {
            $action($this->request, $this->response, $params);
            return;
        }

        [$class, $method] = $action;
        $controller = new $class($this->request, $this->response);
        $controller->$method($params);
    }

    private function runMiddlewarePipeline(array $middlewares, callable $final): void
    {
        $pipeline = array_reduce(
            array_reverse($middlewares),
            function (callable $carry, string $mwAlias) {
                return function () use ($carry, $mwAlias) {
                    $mwClass = $this->resolveMiddleware($mwAlias);
                    (new $mwClass($this->request, $this->response))->handle($carry);
                };
            },
            $final
        );
        $pipeline();
    }

    private function resolveMiddleware(string $alias): string
    {
        return [
            'auth'       => \App\Middleware\AuthMiddleware::class,
            'admin'      => \App\Middleware\AdminMiddleware::class,
            'branch'     => \App\Middleware\BranchMiddleware::class,
            'throttle'   => \App\Middleware\ThrottleMiddleware::class,
            'csrf'       => \App\Middleware\CsrfMiddleware::class,
            'api'        => \App\Middleware\ApiAuthMiddleware::class,
            'verified'   => \App\Middleware\VerifiedCustomerMiddleware::class,
        ][$alias] ?? throw new \InvalidArgumentException("Unknown middleware: $alias");
    }
}
