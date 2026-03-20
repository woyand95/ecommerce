# 🛒 Enterprise E-Commerce System — PHP MVC + MySQL

A fully-featured, production-grade multi-branch e-commerce platform built with PHP (OOP/MVC), MySQL, and a custom template engine. Designed for scalability, B2B/B2C multi-branch operation, and clean architecture.

---

## 📁 Project Structure

```
ecommerce/
│
├── public/                          # Web root (point your vhost here)
│   ├── index.php                    # Front controller — all requests enter here
│   ├── .htaccess                    # URL rewriting rules
│   └── assets/
│       ├── css/                     # Compiled stylesheets
│       │   ├── app.css              # Frontend theme CSS
│       │   └── admin.css            # Admin panel CSS
│       ├── js/
│       │   ├── app.js               # Frontend JS bundle
│       │   ├── admin.js             # Admin JS bundle
│       │   └── product-detail.js    # Product page scripts
│       ├── icons/
│       │   ├── sprite.svg           # Frontend icon sprite
│       │   └── admin-sprite.svg     # Admin icon sprite
│       ├── images/                  # Static images
│       └── themes/                  # Per-branch theme overrides
│           └── {theme}/{branch}/    # Branch-specific asset overrides
│
├── app/                             # Application source
│   │
│   ├── Core/                        # Framework kernel
│   │   ├── Database.php             # PDO singleton, query builder
│   │   ├── Router.php               # RESTful router with middleware pipeline
│   │   ├── Request.php              # HTTP request wrapper + input sanitization
│   │   ├── Response.php             # HTTP response, redirects, JSON output
│   │   ├── Controller.php           # Base controller (view, redirect, auth helpers)
│   │   ├── Model.php                # Base model (CRUD, pagination, translations)
│   │   ├── TemplateEngine.php       # Twig-inspired PHP template engine
│   │   ├── Auth.php                 # Session + JWT authentication manager
│   │   ├── Lang.php                 # i18n translator with key fallback
│   │   ├── Csrf.php                 # CSRF token generation and validation
│   │   ├── Cache.php                # Cache interface (Redis / file-based)
│   │   └── Validator.php            # Input validation rules engine
│   │
│   ├── Models/
│   │   ├── Product.php              # Products with branch pricing + stock
│   │   ├── Category.php             # Category tree with translations
│   │   ├── Branch.php               # Branch management + domain detection
│   │   ├── Customer.php             # B2C & B2B customers with verification
│   │   ├── Order.php                # Order placement, branch enforcement
│   │   ├── Cart.php                 # Persistent cart (session + DB)
│   │   ├── Campaign.php             # Discounts, coupons, promotions
│   │   ├── Page.php                 # CMS pages + content blocks
│   │   └── AdminUser.php            # Admin users + role management
│   │
│   ├── Controllers/
│   │   ├── HomeController.php       # Homepage
│   │   ├── ProductController.php    # Storefront product listing + detail
│   │   ├── CartController.php       # Cart management
│   │   ├── CheckoutController.php   # Checkout flow
│   │   ├── AuthController.php       # Customer login/register
│   │   ├── AccountController.php    # Customer account area
│   │   ├── PageController.php       # CMS page rendering
│   │   │
│   │   ├── Admin/                   # Admin panel controllers
│   │   │   ├── DashboardController.php
│   │   │   ├── ProductController.php    # Product CRUD + branch pricing
│   │   │   ├── CategoryController.php
│   │   │   ├── OrderController.php      # Order management + status
│   │   │   ├── CustomerController.php   # Customer + B2B verification
│   │   │   ├── DocumentController.php   # Company document review
│   │   │   ├── BranchController.php     # Branch management
│   │   │   ├── PageController.php       # CMS / Page builder
│   │   │   ├── CampaignController.php
│   │   │   ├── LanguageController.php
│   │   │   ├── AdminUserController.php
│   │   │   └── AuthController.php       # Admin login
│   │   │
│   │   └── Api/                     # REST API controllers
│   │       ├── ProductController.php
│   │       ├── CategoryController.php
│   │       ├── CartController.php
│   │       ├── OrderController.php
│   │       └── AuthController.php       # JWT auth
│   │
│   ├── Middleware/
│   │   ├── BranchMiddleware.php         # ⭐ STRICT branch restriction
│   │   ├── AuthMiddleware.php           # Customer session check
│   │   ├── AdminMiddleware.php          # Admin session + role check
│   │   ├── ApiAuthMiddleware.php        # JWT Bearer token validation
│   │   ├── CsrfMiddleware.php           # CSRF token validation
│   │   ├── ThrottleMiddleware.php       # Rate limiting (Redis)
│   │   └── VerifiedCustomerMiddleware.php # B2B company verification check
│   │
│   ├── Services/
│   │   ├── BranchService.php            # Detect + cache current branch
│   │   ├── CartService.php              # Cart logic (add, update, totals)
│   │   ├── OrderService.php             # Order flow orchestration
│   │   ├── FileUploadService.php        # Secure file upload + validation
│   │   ├── CacheService.php             # Redis/file cache abstraction
│   │   ├── EmailService.php             # Transactional emails
│   │   ├── PricingService.php           # Price resolution (branch + group)
│   │   └── SeoService.php               # URL slugs, meta, sitemap
│   │
│   ├── Helpers/
│   │   └── functions.php                # Global helpers (format_money, __)
│   │
│   └── Exceptions/
│       ├── BranchMismatchException.php
│       ├── InsufficientStockException.php
│       ├── NotFoundException.php
│       └── ValidationException.php
│
├── config/
│   ├── app.php                      # App settings (name, env, debug, URL)
│   ├── database.php                 # DB credentials
│   ├── cache.php                    # Redis / file cache config
│   ├── mail.php                     # SMTP / Mailgun settings
│   └── bootstrap.php                # App bootstrap + route definitions
│
├── templates/                       # ⭐ Theme / template system
│   ├── frontend/
│   │   ├── default/                 # Default storefront theme
│   │   │   ├── layouts/
│   │   │   │   └── main.php         # Base HTML layout
│   │   │   ├── partials/
│   │   │   │   ├── header.php
│   │   │   │   ├── footer.php
│   │   │   │   ├── cart-drawer.php
│   │   │   │   ├── flash-messages.php
│   │   │   │   └── cards/
│   │   │   │       └── product-card.php
│   │   │   └── pages/
│   │   │       ├── home.php
│   │   │       ├── products.php
│   │   │       ├── product-detail.php
│   │   │       ├── cart.php
│   │   │       ├── checkout.php
│   │   │       ├── search.php
│   │   │       └── account/
│   │   │           ├── orders.php
│   │   │           ├── profile.php
│   │   │           └── documents.php
│   │   │
│   │   └── minimal/                 # Alternative thin theme (extends default)
│   │       └── layouts/
│   │           └── main.php         # Override layout only; reuse other partials
│   │
│   └── backend/                     # Admin panel theme
│       ├── layouts/
│       │   └── admin.php            # Admin base layout
│       ├── partials/
│       │   ├── flash-messages.php
│       │   └── pagination.php
│       └── pages/
│           ├── dashboard.php
│           ├── products/
│           │   ├── index.php
│           │   └── form.php         # Create + edit (same form)
│           ├── orders/
│           │   ├── index.php
│           │   └── detail.php
│           ├── customers/
│           │   ├── index.php
│           │   └── detail.php
│           └── cms/
│               ├── index.php
│               └── builder.php      # Page builder UI
│
├── lang/
│   ├── de/
│   │   ├── general.php
│   │   ├── shop.php
│   │   ├── cart.php
│   │   ├── account.php
│   │   └── admin.php
│   └── en/
│       ├── general.php
│       ├── shop.php
│       ├── cart.php
│       ├── account.php
│       └── admin.php
│
├── database/
│   ├── schema.sql                   # ⭐ Full database schema
│   └── migrations/                  # Versioned schema changes
│
├── storage/
│   ├── cache/                       # File-based cache (fallback)
│   ├── logs/                        # Application logs
│   ├── sessions/                    # PHP session files
│   └── uploads/
│       ├── products/                # Product images
│       └── documents/               # B2B company documents (private)
│
└── tests/                           # Unit + integration tests
```

---

## 🏗️ Architecture Overview

### MVC Pattern
| Layer | Responsibility |
|---|---|
| **Model** | Data access, business rules, DB queries only |
| **View** | Templates (PHP), no logic except iteration/conditions |
| **Controller** | Thin orchestrators — validate input, call services/models, pass to view |
| **Service** | Complex business logic shared across controllers |
| **Middleware** | Cross-cutting concerns: auth, branch enforcement, CSRF, rate limit |

### Request Lifecycle
```
HTTP Request
    ↓
public/index.php  (Front Controller)
    ↓
Bootstrap (config, session, helpers)
    ↓
Router → matches URI + method
    ↓
Middleware Pipeline  [throttle → branch → auth → csrf]
    ↓
Controller::method()
    ↓
Service / Model
    ↓
TemplateEngine::render()  or  Response::json()
    ↓
HTTP Response
```

---

## 🔐 Security Implementation

| Threat | Defense |
|---|---|
| SQL Injection | 100% prepared statements via PDO (no raw concatenation) |
| XSS | `$v->e()` escapes all output; CSP headers |
| CSRF | Synchronizer token on every POST/PATCH/DELETE (CsrfMiddleware) |
| Session Hijacking | `session.cookie_httponly`, `session.cookie_secure`, `session.use_strict_mode` |
| File Upload | MIME-type validation, extension allowlist, stored outside webroot |
| Rate Limiting | ThrottleMiddleware (Redis-backed, per-IP + per-user) |
| Password Storage | `password_hash()` / `password_verify()` (bcrypt) |
| Sensitive Routes | `noindex, nofollow` on admin; Basic Auth optional additional layer |

---

## 🌿 Branch Enforcement — The Core Rule

Every customer is assigned `branch_id` at registration. The `BranchMiddleware` enforces this **at every layer**:

```
Customer login → session stores branch_id
    ↓
BranchMiddleware runs on every request
    ↓
Product listing → WHERE branch_id = customer.branch_id
    ↓
Cart add → validates product available in customer's branch
    ↓
Order::placeOrder() → throws BranchMismatchException if mismatch
    ↓
API endpoints → same enforcement via JWT claims
```

---

## 💰 Branch-Aware Pricing

Prices live in `product_branch_prices`, keyed by:
- `product_id` + `variant_id` (nullable)
- `branch_id`
- `price_group` — `'standard'` (B2C), `'b2b'`, `'vip'`, etc.

A product not having a price row for a branch simply **does not appear** there.

---

## 🌐 Multi-Language URLs

```
/de/products/rotes-t-shirt    → German product page
/en/products/red-t-shirt      → English product page
/de/kategorie/hemden          → German category
/en/category/shirts           → English category
```

Language is detected from URL prefix, stored in `Request`, and used for all DB translation queries with a fallback to the default language.

---

## 🎨 Template / Theme System

```
Priority chain for every template file:
1. templates/frontend/{theme}/branches/{branch-slug}/{type}/{name}.php  ← branch override
2. templates/frontend/{theme}/{type}/{name}.php                          ← active theme
3. templates/frontend/default/{type}/{name}.php                          ← fallback default
```

Switch themes per branch in `theme_settings` DB table. The `TemplateEngine` resolves paths automatically.

---

## 📦 CMS / Page Builder

Pages consist of ordered **blocks** (stored in `page_blocks`). Each block has:
- A `block_type` (`text`, `image`, `slider`, `cta`, `html`, `grid`, `products`, `faq`)
- Per-language content in `page_block_translations`
- Optional `settings` JSON (background color, column count, etc.)

The admin `builder.php` template renders a drag-and-drop-ready block list. Block data is submitted as a JSON array and stored atomically.

---

## 🚀 Installation

```bash
# 1. Clone and install dependencies
composer install

# 2. Configure
cp config/app.example.php config/app.php
# Fill in DB credentials, app URL, etc.

# 3. Create database + run schema
mysql -u root -p -e "CREATE DATABASE ecommerce CHARACTER SET utf8mb4;"
mysql -u root -p ecommerce < database/schema.sql

# 4. Set permissions
chmod -R 755 storage/
chmod -R 755 public/assets/

# 5. Web server
# Point document root to /public
# Enable mod_rewrite (Apache) or configure nginx try_files

# 6. Redis (optional, for caching + sessions)
# Set CACHE_DRIVER=redis in config/cache.php
```

### Nginx Config Example
```nginx
server {
    listen 80;
    server_name yourdomain.com branch1.yourdomain.com;
    root /var/www/ecommerce/public;
    index index.php;

    location / {
        try_files $uri $uri/ /index.php?$query_string;
    }

    location ~ \.php$ {
        fastcgi_pass unix:/var/run/php/php8.2-fpm.sock;
        fastcgi_param SCRIPT_FILENAME $realpath_root$fastcgi_script_name;
        include fastcgi_params;
    }

    location ~* \.(jpg|jpeg|png|webp|gif|svg|ico|css|js|woff2)$ {
        expires 1y;
        add_header Cache-Control "public, immutable";
    }
}
```

---

## 📋 Key Business Rules Summary

| Rule | Where Enforced |
|---|---|
| Customer → one branch only | `BranchMiddleware` + `Order::placeOrder()` |
| B2B customers need verification | `VerifiedCustomerMiddleware` + Admin panel |
| B2B gets 0% VAT (configurable) | `Order::resolveTaxRate()` |
| Stock check before order | `Order::placeOrder()` → `Product::isAvailable()` |
| Stock reserved on order | `Product::reserveStock()` (atomic UPDATE) |
| Each order belongs to one branch | `orders.branch_id` FK + model scoping |
| Admin branch_manager sees own branch only | `AdminMiddleware` → injects branch filter |
| Coupon per-customer usage limit | `Campaign::applyCoupon()` + usage tracking |
