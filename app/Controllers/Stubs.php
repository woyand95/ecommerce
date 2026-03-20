<?php
// Stub-Controllers — verhindern Fatal Errors beim Boot
// Volle Implementierungen folgen in den jeweiligen Dateien.

namespace App\ Controllers;
use App\ Core\ Controller;

class AuthController extends Controller {
  public function loginForm( array $p = [] ): void {
    echo '<h2>Login</h2>';
  }
  public function login( array $p = [] ): void {}
  public function registerForm( array $p = [] ): void {
    echo '<h2>Register</h2>';
  }
  public function register( array $p = [] ): void {}
  public function logout( array $p = [] ): void {
    session_destroy();
    header( 'Location: /' );
    exit;
  }
}
class CartController extends Controller {
  public function index( array $p = [] ): void {
    echo '<h2>Warenkorb</h2><p>Noch nicht implementiert.</p>';
  }
  public function add( array $p = [] ): void {}
  public function update( array $p = [] ): void {}
  public function remove( array $p = [] ): void {}
}
class CheckoutController extends Controller {
  public function index( array $p = [] ): void {
    echo '<h2>Checkout</h2><p>Noch nicht implementiert.</p>';
  }
  public function placeOrder( array $p = [] ): void {}
  public function success( array $p = [] ): void {
    echo '<h2>Bestellung erfolgreich!</h2>';
  }
}
class AccountController extends Controller {
  public function orders( array $p = [] ): void {
    echo '<h2>Meine Bestellungen</h2>';
  }
  public function orderDetail( array $p = [] ): void {}
  public function profile( array $p = [] ): void {
    echo '<h2>Profil</h2>';
  }
  public function updateProfile( array $p = [] ): void {}
  public function addresses( array $p = [] ): void {
    echo '<h2>Adressen</h2>';
  }
  public function storeAddress( array $p = [] ): void {}
  public function deleteAddress( array $p = [] ): void {}
  public function documents( array $p = [] ): void {
    echo '<h2>Dokumente</h2>';
  }
  public function uploadDocument( array $p = [] ): void {}
}
class PageController extends Controller {
  public function show( array $p = [] ): void {
    echo '<h2>Seite</h2>';
  }
}
class ErrorController extends Controller {
  public function notFound( array $p = [] ): void {
    http_response_code( 404 );
    echo '<h1>404 – Seite nicht gefunden</h1>';
  }
}

namespace App\ Controllers\ Admin;
use App\ Core\ Controller;

class DashboardController extends Controller {
  public function __construct() {
    parent::__construct( 'backend' );
  }
  public function index( array $p = [] ): void {
    echo '<h2>Admin Dashboard</h2><p>Willkommen im Admin-Panel.</p>';
  }
}
class CategoryController extends Controller {
  public function __construct() {
    parent::__construct( 'backend' );
  }
  public function index( array $p = [] ): void {}
  public function create( array $p = [] ): void {}
  public function store( array $p = [] ): void {}
  public function show( array $p = [] ): void {}
  public function edit( array $p = [] ): void {}
  public function update( array $p = [] ): void {}
  public function destroy( array $p = [] ): void {}
}
class OrderController extends Controller {
  public function __construct() {
    parent::__construct( 'backend' );
  }
  public function index( array $p = [] ): void {}
  public function show( array $p = [] ): void {}
  public function updateStatus( array $p = [] ): void {}
}
class CustomerController extends Controller {
  public function __construct() {
    parent::__construct( 'backend' );
  }
  public function index( array $p = [] ): void {}
  public function show( array $p = [] ): void {}
  public function verify( array $p = [] ): void {}
}
class DocumentController extends Controller {
  public function __construct() {
    parent::__construct( 'backend' );
  }
  public function index( array $p = [] ): void {}
  public function review( array $p = [] ): void {}
}
class MenuController extends Controller {
  public function __construct() {
    parent::__construct( 'backend' );
  }
  public function index( array $p = [] ): void {}
  public function create( array $p = [] ): void {}
  public function store( array $p = [] ): void {}
  public function show( array $p = [] ): void {}
  public function edit( array $p = [] ): void {}
  public function update( array $p = [] ): void {}
  public function destroy( array $p = [] ): void {}
}
class CampaignController extends Controller {
  public function __construct() {
    parent::__construct( 'backend' );
  }
  public function index( array $p = [] ): void {}
  public function create( array $p = [] ): void {}
  public function store( array $p = [] ): void {}
  public function show( array $p = [] ): void {}
  public function edit( array $p = [] ): void {}
  public function update( array $p = [] ): void {}
  public function destroy( array $p = [] ): void {}
}
class BranchController extends Controller {
  public function __construct() {
    parent::__construct( 'backend' );
  }
  public function index( array $p = [] ): void {}
  public function create( array $p = [] ): void {}
  public function store( array $p = [] ): void {}
  public function show( array $p = [] ): void {}
  public function edit( array $p = [] ): void {}
  public function update( array $p = [] ): void {}
  public function destroy( array $p = [] ): void {}
}
class LanguageController extends Controller {
  public function __construct() {
    parent::__construct( 'backend' );
  }
  public function index( array $p = [] ): void {}
  public function create( array $p = [] ): void {}
  public function store( array $p = [] ): void {}
  public function show( array $p = [] ): void {}
  public function edit( array $p = [] ): void {}
  public function update( array $p = [] ): void {}
  public function destroy( array $p = [] ): void {}
}
class AdminUserController extends Controller {
  public function __construct() {
    parent::__construct( 'backend' );
  }
  public function index( array $p = [] ): void {}
  public function create( array $p = [] ): void {}
  public function store( array $p = [] ): void {}
  public function show( array $p = [] ): void {}
  public function edit( array $p = [] ): void {}
  public function update( array $p = [] ): void {}
  public function destroy( array $p = [] ): void {}
}
class AuthController extends Controller {
  public function __construct() {
    parent::__construct( 'backend' );
  }
  public function loginForm( array $p = [] ): void {
    echo '<h2>Admin Login</h2>';
  }
  public function login( array $p = [] ): void {}
  public function logout( array $p = [] ): void {
    session_destroy();
    header( 'Location: /admin/login' );
    exit;
  }
}

namespace App\ Controllers\ Api;
use App\ Core\ Controller;

class CategoryController extends Controller {
  public function index( array $p = [] ): void {
    $this->json( [ 'data' => [] ] );
  }
}
class CartController extends Controller {
  public function index( array $p = [] ): void {
    $this->json( [ 'items' => [], 'total_formatted' => '0,00 €', 'cart_count' => 0 ] );
  }
  public function add( array $p = [] ): void {
    $this->json( [ 'cart_count' => 0, 'message' => 'Hinzugefügt' ] );
  }
  public function update( array $p = [] ): void {
    $this->json( [ 'cart_count' => 0 ] );
  }
  public function remove( array $p = [] ): void {
    $this->json( [ 'cart_count' => 0 ] );
  }
}
class OrderController extends Controller {
  public function store( array $p = [] ): void {
    $this->json( [ 'error' => 'Not implemented' ], 501 );
  }
  public function index( array $p = [] ): void {
    $this->json( [ 'data' => [] ] );
  }
  public function show( array $p = [] ): void {
    $this->json( [ 'data' => null ] );
  }
}
class AuthController extends Controller {
  public function login( array $p = [] ): void {
    $this->json( [ 'error' => 'Not implemented' ], 501 );
  }
  public function register( array $p = [] ): void {
    $this->json( [ 'error' => 'Not implemented' ], 501 );
  }
  public function refresh( array $p = [] ): void {
    $this->json( [ 'error' => 'Not implemented' ], 501 );
  }
}