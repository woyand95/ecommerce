<?php

use App\Core\{Router, Request, Response};
use App\Controllers;
use App\Controllers\Admin;
use App\Controllers\Api;

// ── Environment & debug ───────────────────────
$config = require CONFIG_PATH . '/app.php';
define('APP_ENV',   $config['env']);
define('APP_DEBUG', $config['debug']);

// ── Error handling ────────────────────────────
if (APP_DEBUG) {
    ini_set('display_errors', '1');
    error_reporting(E_ALL);
} else {
    ini_set('display_errors', '0');
    error_reporting(0);
    set_exception_handler(fn($e) => (new Response())->internalError($e));
}

// ── Session ───────────────────────────────────
ini_set('session.cookie_httponly', '1');
ini_set('session.cookie_samesite', 'Strict');
ini_set('session.use_strict_mode', '1');
if ($config['env'] === 'production') {
    ini_set('session.cookie_secure', '1');
}
session_start();

// ── Helpers ───────────────────────────────────
require APP_PATH . '/Helpers/functions.php';

// ── Request / Response ────────────────────────
$request  = new Request();
$response = new Response();
$router   = new Router($request, $response);

// ════════════════════════════════════════════════════════════
//  ROUTE DEFINITIONS
// ════════════════════════════════════════════════════════════

// ── Public storefront ─────────────────────────
$router->get('/',                     [Controllers\HomeController::class,    'index']);
$router->get('/products',             [Controllers\ProductController::class, 'index']);
$router->get('/products/{slug}',      [Controllers\ProductController::class, 'show']);
$router->get('/category/{slug}',      [Controllers\ProductController::class, 'index']);
$router->get('/search',               [Controllers\ProductController::class, 'search']);
$router->get('/page/{slug}',          [Controllers\PageController::class,    'show']);

// ── Auth ──────────────────────────────────────
$router->get( '/auth/login',          [Controllers\AuthController::class, 'loginForm']);
$router->post('/auth/login',          [Controllers\AuthController::class, 'login'],    ['csrf', 'branch']);
$router->get( '/auth/register',       [Controllers\AuthController::class, 'registerForm']);
$router->post('/auth/register',       [Controllers\AuthController::class, 'register'], ['csrf', 'branch']);
$router->get( '/auth/logout',         [Controllers\AuthController::class, 'logout'],   ['auth']);

// ── Cart ──────────────────────────────────────
$router->group('/cart', function($r) {
    $r->get( '/',      [Controllers\CartController::class, 'index']);
    $r->post('/add',   [Controllers\CartController::class, 'add'],    ['csrf', 'branch']);
    $r->patch('/{id}', [Controllers\CartController::class, 'update'], ['csrf', 'branch']);
    $r->delete('/{id}',[Controllers\CartController::class, 'remove'], ['csrf', 'branch']);
}, ['branch']);

// ── Checkout ──────────────────────────────────
$router->group('/checkout', function($r) {
    $r->get( '/',             [Controllers\CheckoutController::class, 'index']);
    $r->post('/place-order',  [Controllers\CheckoutController::class, 'placeOrder'], ['csrf']);
    $r->get( '/success/{id}', [Controllers\CheckoutController::class, 'success']);
}, ['auth', 'branch']);

// ── Customer account ──────────────────────────
$router->group('/account', function($r) {
    $r->get('/orders',          [Controllers\AccountController::class, 'orders']);
    $r->get('/orders/{id}',     [Controllers\AccountController::class, 'orderDetail']);
    $r->get('/profile',         [Controllers\AccountController::class, 'profile']);
    $r->post('/profile',        [Controllers\AccountController::class, 'updateProfile'],  ['csrf']);
    $r->get('/addresses',       [Controllers\AccountController::class, 'addresses']);
    $r->post('/addresses',      [Controllers\AccountController::class, 'storeAddress'],   ['csrf']);
    $r->delete('/addresses/{id}', [Controllers\AccountController::class, 'deleteAddress'],['csrf']);
    $r->get('/documents',       [Controllers\AccountController::class, 'documents']);
    $r->post('/documents',      [Controllers\AccountController::class, 'uploadDocument'], ['csrf', 'verified']);
}, ['auth', 'branch']);

// ════════════════════════════════════════════════════════════
//  ADMIN PANEL
// ════════════════════════════════════════════════════════════

$router->group('/admin', function($r) {
    // Dashboard
    $r->get('/',                  [Admin\DashboardController::class, 'index']);

    // Products
    $r->resource('products',      Admin\ProductController::class);
    $r->resource('categories',    Admin\CategoryController::class);

    // Orders
    $r->get('/orders',            [Admin\OrderController::class, 'index']);
    $r->get('/orders/{id}',       [Admin\OrderController::class, 'show']);
    $r->patch('/orders/{id}/status', [Admin\OrderController::class, 'updateStatus'], ['csrf']);

    // Customers
    $r->get('/customers',         [Admin\CustomerController::class, 'index']);
    $r->get('/customers/{id}',    [Admin\CustomerController::class, 'show']);
    $r->patch('/customers/{id}/verify', [Admin\CustomerController::class, 'verify'], ['csrf']);

    // Company documents
    $r->get('/documents',         [Admin\DocumentController::class, 'index']);
    $r->patch('/documents/{id}',  [Admin\DocumentController::class, 'review'], ['csrf']);

    // CMS
    $r->resource('pages',         Admin\PageController::class);
    $r->resource('menus',         Admin\MenuController::class);

    // Campaigns
    $r->resource('campaigns',     Admin\CampaignController::class);

    // Branches (superadmin)
    $r->resource('branches',      Admin\BranchController::class);
    $r->resource('languages',     Admin\LanguageController::class);

    // Admin users & roles
    $r->resource('users',         Admin\AdminUserController::class);

    // Auth
    $r->get( '/login',            [Admin\AuthController::class, 'loginForm']);
    $r->post('/login',            [Admin\AuthController::class, 'login'],  ['csrf']);
    $r->get( '/logout',           [Admin\AuthController::class, 'logout']);

}, ['admin']); // 'admin' middleware requires admin session

// ════════════════════════════════════════════════════════════
//  REST API v1
// ════════════════════════════════════════════════════════════

$router->group('/api/v1', function($r) {
    $r->get('/products',          [Api\ProductController::class, 'index']);
    $r->get('/products/search',   [Api\ProductController::class, 'search']);
    $r->get('/products/{id:\d+}', [Api\ProductController::class, 'show']);

    $r->get('/categories',        [Api\CategoryController::class, 'index']);

    $r->get('/cart',              [Api\CartController::class, 'index'],  ['api']);
    $r->post('/cart/add',         [Api\CartController::class, 'add'],    ['api', 'branch', 'csrf']);
    $r->patch('/cart/{id}',       [Api\CartController::class, 'update'], ['api', 'branch', 'csrf']);
    $r->delete('/cart/{id}',      [Api\CartController::class, 'remove'], ['api', 'branch', 'csrf']);

    $r->post('/orders',           [Api\OrderController::class, 'store'], ['api', 'branch', 'csrf']);
    $r->get('/orders',            [Api\OrderController::class, 'index'], ['api']);
    $r->get('/orders/{id}',       [Api\OrderController::class, 'show'],  ['api']);

    $r->post('/auth/login',       [Api\AuthController::class, 'login']);
    $r->post('/auth/register',    [Api\AuthController::class, 'register']);
    $r->post('/auth/refresh',     [Api\AuthController::class, 'refresh'], ['api']);

}, ['throttle', 'branch']);

// ── Dispatch ─────────────────────────────────
return new class($router) {
    public function __construct(private Router $router) {}
    public function run(): void { $this->router->dispatch(); }
};
