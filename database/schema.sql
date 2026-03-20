-- ============================================================
--  E-COMMERCE SYSTEM — FULL DATABASE SCHEMA
--  Engine: MySQL 8.0+  |  Charset: utf8mb4
-- ============================================================

SET FOREIGN_KEY_CHECKS = 0;
SET NAMES utf8mb4;

-- ─────────────────────────────────────────────
--  CORE: LANGUAGES
-- ─────────────────────────────────────────────
CREATE TABLE languages (
    id          TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    code        VARCHAR(10)  NOT NULL UNIQUE,   -- 'en', 'de', 'fr'
    name        VARCHAR(50)  NOT NULL,
    locale      VARCHAR(20)  NOT NULL,           -- 'en_US', 'de_DE'
    flag        VARCHAR(10),                     -- emoji or icon key
    is_default  TINYINT(1)   NOT NULL DEFAULT 0,
    is_active   TINYINT(1)   NOT NULL DEFAULT 1,
    sort_order  TINYINT UNSIGNED DEFAULT 0,
    created_at  DATETIME     DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ─────────────────────────────────────────────
--  CORE: BRANCHES (Filialen)
-- ─────────────────────────────────────────────
CREATE TABLE branches (
    id              INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name            VARCHAR(150) NOT NULL,
    slug            VARCHAR(150) NOT NULL UNIQUE,
    domain          VARCHAR(255) UNIQUE,             -- branch1.com
    subdomain       VARCHAR(100) UNIQUE,             -- branch1.yourdomain.com
    email           VARCHAR(150),
    phone           VARCHAR(50),
    address         TEXT,
    city            VARCHAR(100),
    postal_code     VARCHAR(20),
    country_code    CHAR(2)      DEFAULT 'DE',
    currency_code   CHAR(3)      DEFAULT 'EUR',
    tax_rate        DECIMAL(5,2) DEFAULT 19.00,
    timezone        VARCHAR(50)  DEFAULT 'Europe/Berlin',
    logo            VARCHAR(255),
    is_active       TINYINT(1)   NOT NULL DEFAULT 1,
    settings        JSON,                            -- branch-level feature flags
    created_at      DATETIME     DEFAULT CURRENT_TIMESTAMP,
    updated_at      DATETIME     ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Branch delivery settings
CREATE TABLE branch_delivery_settings (
    id                  INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    branch_id           INT UNSIGNED NOT NULL,
    allows_pickup       TINYINT(1)   DEFAULT 1,
    allows_shipping     TINYINT(1)   DEFAULT 1,
    free_shipping_from  DECIMAL(10,2),
    min_order_amount    DECIMAL(10,2) DEFAULT 0.00,
    shipping_cost       DECIMAL(10,2) DEFAULT 0.00,
    estimated_days_min  TINYINT UNSIGNED DEFAULT 1,
    estimated_days_max  TINYINT UNSIGNED DEFAULT 3,
    pickup_instructions TEXT,
    FOREIGN KEY (branch_id) REFERENCES branches(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ─────────────────────────────────────────────
--  USERS & ROLES (Admin Panel)
-- ─────────────────────────────────────────────
CREATE TABLE roles (
    id          TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name        VARCHAR(50) NOT NULL UNIQUE,   -- superadmin, admin, branch_manager, editor
    permissions JSON,
    created_at  DATETIME DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE admin_users (
    id              INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    branch_id       INT UNSIGNED,               -- NULL = superadmin (all branches)
    role_id         TINYINT UNSIGNED NOT NULL,
    first_name      VARCHAR(80)  NOT NULL,
    last_name       VARCHAR(80)  NOT NULL,
    email           VARCHAR(150) NOT NULL UNIQUE,
    password_hash   VARCHAR(255) NOT NULL,
    avatar          VARCHAR(255),
    last_login_at   DATETIME,
    last_login_ip   VARCHAR(45),
    is_active       TINYINT(1)   DEFAULT 1,
    created_at      DATETIME     DEFAULT CURRENT_TIMESTAMP,
    updated_at      DATETIME     ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (branch_id) REFERENCES branches(id) ON DELETE SET NULL,
    FOREIGN KEY (role_id)   REFERENCES roles(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ─────────────────────────────────────────────
--  CUSTOMERS
-- ─────────────────────────────────────────────
CREATE TABLE customers (
    id              INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    branch_id       INT UNSIGNED NOT NULL,          -- Strict: one branch per customer
    type            ENUM('private','company') NOT NULL DEFAULT 'private',
    first_name      VARCHAR(80),
    last_name       VARCHAR(80),
    email           VARCHAR(150) NOT NULL,
    password_hash   VARCHAR(255) NOT NULL,
    phone           VARCHAR(50),
    date_of_birth   DATE,
    preferred_lang  VARCHAR(10)  DEFAULT 'de',
    -- Company-specific fields
    company_name    VARCHAR(200),
    vat_number      VARCHAR(50),
    trade_register  VARCHAR(100),
    company_verified TINYINT(1)  DEFAULT 0,         -- Admin must verify
    verification_status ENUM('pending','approved','rejected') DEFAULT 'pending',
    verified_at     DATETIME,
    verified_by     INT UNSIGNED,                   -- admin_users.id
    -- Pricing
    price_group     VARCHAR(50)  DEFAULT 'standard',-- custom price group
    -- Status
    is_active       TINYINT(1)   DEFAULT 1,
    email_verified  TINYINT(1)   DEFAULT 0,
    newsletter      TINYINT(1)   DEFAULT 0,
    last_login_at   DATETIME,
    created_at      DATETIME     DEFAULT CURRENT_TIMESTAMP,
    updated_at      DATETIME     ON UPDATE CURRENT_TIMESTAMP,
    UNIQUE KEY uq_customer_branch_email (branch_id, email),
    FOREIGN KEY (branch_id)   REFERENCES branches(id),
    FOREIGN KEY (verified_by) REFERENCES admin_users(id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Company verification documents
CREATE TABLE company_documents (
    id              INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    customer_id     INT UNSIGNED NOT NULL,
    document_type   ENUM('business_license','vat_proof','trade_register','other') NOT NULL,
    file_name       VARCHAR(255) NOT NULL,
    file_path       VARCHAR(500) NOT NULL,
    file_size       INT UNSIGNED,
    mime_type       VARCHAR(100),
    notes           TEXT,
    reviewed_by     INT UNSIGNED,
    reviewed_at     DATETIME,
    status          ENUM('pending','accepted','rejected') DEFAULT 'pending',
    uploaded_at     DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (customer_id) REFERENCES customers(id) ON DELETE CASCADE,
    FOREIGN KEY (reviewed_by) REFERENCES admin_users(id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Customer addresses
CREATE TABLE addresses (
    id              INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    customer_id     INT UNSIGNED NOT NULL,
    type            ENUM('billing','shipping') NOT NULL DEFAULT 'shipping',
    label           VARCHAR(50),                    -- 'Home', 'Work', etc.
    first_name      VARCHAR(80),
    last_name       VARCHAR(80),
    company         VARCHAR(200),
    street          VARCHAR(255) NOT NULL,
    house_number    VARCHAR(20),
    address_line2   VARCHAR(255),
    city            VARCHAR(100) NOT NULL,
    postal_code     VARCHAR(20)  NOT NULL,
    state           VARCHAR(100),
    country_code    CHAR(2)      NOT NULL DEFAULT 'DE',
    is_default      TINYINT(1)   DEFAULT 0,
    created_at      DATETIME     DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (customer_id) REFERENCES customers(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ─────────────────────────────────────────────
--  CATEGORIES
-- ─────────────────────────────────────────────
CREATE TABLE categories (
    id              INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    parent_id       INT UNSIGNED,
    slug            VARCHAR(200) NOT NULL UNIQUE,
    image           VARCHAR(255),
    sort_order      SMALLINT    DEFAULT 0,
    is_active       TINYINT(1)  DEFAULT 1,
    meta_robots     VARCHAR(50) DEFAULT 'index,follow',
    created_at      DATETIME    DEFAULT CURRENT_TIMESTAMP,
    updated_at      DATETIME    ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (parent_id) REFERENCES categories(id) ON DELETE SET NULL,
    INDEX idx_parent (parent_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE category_translations (
    id              INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    category_id     INT UNSIGNED NOT NULL,
    lang_code       VARCHAR(10)  NOT NULL,
    name            VARCHAR(200) NOT NULL,
    description     TEXT,
    meta_title      VARCHAR(255),
    meta_description VARCHAR(500),
    url_slug        VARCHAR(200),
    UNIQUE KEY uq_cat_lang (category_id, lang_code),
    FOREIGN KEY (category_id) REFERENCES categories(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ─────────────────────────────────────────────
--  PRODUCTS
-- ─────────────────────────────────────────────
CREATE TABLE products (
    id              INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    sku             VARCHAR(100) NOT NULL UNIQUE,
    barcode         VARCHAR(100),
    category_id     INT UNSIGNED,
    type            ENUM('simple','variable','bundle') DEFAULT 'simple',
    weight          DECIMAL(8,3),
    width           DECIMAL(8,2),
    height          DECIMAL(8,2),
    depth           DECIMAL(8,2),
    tax_class       VARCHAR(50)  DEFAULT 'standard',
    is_active       TINYINT(1)   DEFAULT 1,
    is_featured     TINYINT(1)   DEFAULT 0,
    sort_order      SMALLINT     DEFAULT 0,
    created_at      DATETIME     DEFAULT CURRENT_TIMESTAMP,
    updated_at      DATETIME     ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (category_id) REFERENCES categories(id) ON DELETE SET NULL,
    INDEX idx_category (category_id),
    INDEX idx_sku (sku)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Translatable product content
CREATE TABLE product_translations (
    id              INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    product_id      INT UNSIGNED NOT NULL,
    lang_code       VARCHAR(10)  NOT NULL,
    name            VARCHAR(300) NOT NULL,
    short_description TEXT,
    description     LONGTEXT,
    meta_title      VARCHAR(255),
    meta_description VARCHAR(500),
    url_slug        VARCHAR(300),
    UNIQUE KEY uq_prod_lang (product_id, lang_code),
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE,
    INDEX idx_slug (url_slug(100))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Product images
CREATE TABLE product_images (
    id          INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    product_id  INT UNSIGNED NOT NULL,
    file_path   VARCHAR(500) NOT NULL,
    alt_text    VARCHAR(255),
    sort_order  TINYINT UNSIGNED DEFAULT 0,
    is_primary  TINYINT(1)   DEFAULT 0,
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Product variants (for variable products)
CREATE TABLE product_attributes (
    id      INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name    VARCHAR(100) NOT NULL,
    slug    VARCHAR(100) NOT NULL UNIQUE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE product_attribute_values (
    id              INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    attribute_id    INT UNSIGNED NOT NULL,
    value           VARCHAR(100) NOT NULL,
    sort_order      TINYINT DEFAULT 0,
    FOREIGN KEY (attribute_id) REFERENCES product_attributes(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE product_variants (
    id              INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    product_id      INT UNSIGNED NOT NULL,
    sku             VARCHAR(100) NOT NULL UNIQUE,
    attributes      JSON NOT NULL,               -- {"color":"red","size":"XL"}
    image           VARCHAR(255),
    is_active       TINYINT(1)   DEFAULT 1,
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ─────────────────────────────────────────────
--  BRANCH PRICING & STOCK
-- ─────────────────────────────────────────────
CREATE TABLE product_branch_prices (
    id              INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    product_id      INT UNSIGNED NOT NULL,
    variant_id      INT UNSIGNED,
    branch_id       INT UNSIGNED NOT NULL,
    price_group     VARCHAR(50)  NOT NULL DEFAULT 'standard',  -- b2c, b2b, vip, etc.
    price           DECIMAL(12,4) NOT NULL,
    sale_price      DECIMAL(12,4),
    sale_from       DATETIME,
    sale_until      DATETIME,
    min_qty         SMALLINT UNSIGNED DEFAULT 1,
    UNIQUE KEY uq_price (product_id, variant_id, branch_id, price_group),
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE,
    FOREIGN KEY (variant_id) REFERENCES product_variants(id) ON DELETE CASCADE,
    FOREIGN KEY (branch_id)  REFERENCES branches(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE product_branch_stock (
    id              INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    product_id      INT UNSIGNED NOT NULL,
    variant_id      INT UNSIGNED,
    branch_id       INT UNSIGNED NOT NULL,
    quantity        INT          NOT NULL DEFAULT 0,
    reserved_qty    INT          NOT NULL DEFAULT 0,
    low_stock_alert INT UNSIGNED DEFAULT 5,
    track_stock     TINYINT(1)   DEFAULT 1,
    allow_backorder TINYINT(1)   DEFAULT 0,
    UNIQUE KEY uq_stock (product_id, variant_id, branch_id),
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE,
    FOREIGN KEY (variant_id) REFERENCES product_variants(id) ON DELETE CASCADE,
    FOREIGN KEY (branch_id)  REFERENCES branches(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ─────────────────────────────────────────────
--  CAMPAIGNS & DISCOUNTS
-- ─────────────────────────────────────────────
CREATE TABLE campaigns (
    id              INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    branch_id       INT UNSIGNED,                -- NULL = all branches
    name            VARCHAR(200) NOT NULL,
    code            VARCHAR(50)  UNIQUE,         -- coupon code
    type            ENUM('percent','fixed','free_shipping','buy_x_get_y') NOT NULL,
    value           DECIMAL(10,4),
    min_order_amount DECIMAL(10,2),
    max_uses        INT UNSIGNED,
    uses_count      INT UNSIGNED DEFAULT 0,
    max_uses_per_customer TINYINT UNSIGNED DEFAULT 1,
    customer_type   ENUM('all','private','company') DEFAULT 'all',
    valid_from      DATETIME,
    valid_until     DATETIME,
    is_active       TINYINT(1)   DEFAULT 1,
    created_at      DATETIME     DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (branch_id) REFERENCES branches(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE campaign_products (
    campaign_id INT UNSIGNED NOT NULL,
    product_id  INT UNSIGNED NOT NULL,
    PRIMARY KEY (campaign_id, product_id),
    FOREIGN KEY (campaign_id) REFERENCES campaigns(id) ON DELETE CASCADE,
    FOREIGN KEY (product_id)  REFERENCES products(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ─────────────────────────────────────────────
--  ORDERS
-- ─────────────────────────────────────────────
CREATE TABLE orders (
    id                  INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    order_number        VARCHAR(30)  NOT NULL UNIQUE,  -- e.g. ORD-2024-00001
    branch_id           INT UNSIGNED NOT NULL,          -- Strict: one branch per order
    customer_id         INT UNSIGNED NOT NULL,
    status              ENUM('pending','confirmed','processing','shipped','delivered',
                             'cancelled','refunded') DEFAULT 'pending',
    type                ENUM('standard','pickup') NOT NULL DEFAULT 'standard',
    -- Pricing snapshot
    subtotal            DECIMAL(12,2) NOT NULL DEFAULT 0,
    discount_amount     DECIMAL(12,2) DEFAULT 0,
    shipping_cost       DECIMAL(12,2) DEFAULT 0,
    tax_amount          DECIMAL(12,2) DEFAULT 0,
    total               DECIMAL(12,2) NOT NULL DEFAULT 0,
    currency_code       CHAR(3)       DEFAULT 'EUR',
    -- Campaign
    campaign_id         INT UNSIGNED,
    coupon_code         VARCHAR(50),
    -- Addresses (snapshot at order time)
    billing_address     JSON NOT NULL,
    shipping_address    JSON,
    -- Payment
    payment_method      VARCHAR(50),
    payment_status      ENUM('pending','paid','failed','refunded') DEFAULT 'pending',
    payment_reference   VARCHAR(200),
    paid_at             DATETIME,
    -- B2B
    po_number           VARCHAR(100),               -- Purchase Order number
    payment_due_date    DATE,
    -- Meta
    customer_note       TEXT,
    admin_note          TEXT,
    ip_address          VARCHAR(45),
    user_agent          TEXT,
    lang_code           VARCHAR(10)  DEFAULT 'de',
    created_at          DATETIME     DEFAULT CURRENT_TIMESTAMP,
    updated_at          DATETIME     ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (branch_id)   REFERENCES branches(id),
    FOREIGN KEY (customer_id) REFERENCES customers(id),
    FOREIGN KEY (campaign_id) REFERENCES campaigns(id) ON DELETE SET NULL,
    INDEX idx_branch_status (branch_id, status),
    INDEX idx_customer (customer_id),
    INDEX idx_order_number (order_number)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE order_items (
    id              INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    order_id        INT UNSIGNED NOT NULL,
    product_id      INT UNSIGNED NOT NULL,
    variant_id      INT UNSIGNED,
    product_name    VARCHAR(300) NOT NULL,      -- snapshot
    variant_label   VARCHAR(200),
    sku             VARCHAR(100) NOT NULL,
    quantity        SMALLINT UNSIGNED NOT NULL,
    unit_price      DECIMAL(12,4) NOT NULL,
    discount_amount DECIMAL(12,4) DEFAULT 0,
    tax_rate        DECIMAL(5,2)  DEFAULT 0,
    tax_amount      DECIMAL(12,4) DEFAULT 0,
    line_total      DECIMAL(12,2) NOT NULL,
    FOREIGN KEY (order_id)   REFERENCES orders(id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(id),
    FOREIGN KEY (variant_id) REFERENCES product_variants(id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Order status history
CREATE TABLE order_status_history (
    id          INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    order_id    INT UNSIGNED NOT NULL,
    status      VARCHAR(50)  NOT NULL,
    comment     TEXT,
    notify_customer TINYINT(1) DEFAULT 0,
    changed_by  INT UNSIGNED,
    created_at  DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (order_id)   REFERENCES orders(id) ON DELETE CASCADE,
    FOREIGN KEY (changed_by) REFERENCES admin_users(id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ─────────────────────────────────────────────
--  CART
-- ─────────────────────────────────────────────
CREATE TABLE carts (
    id              INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    session_id      VARCHAR(128) NOT NULL UNIQUE,
    customer_id     INT UNSIGNED,
    branch_id       INT UNSIGNED NOT NULL,
    coupon_code     VARCHAR(50),
    created_at      DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at      DATETIME ON UPDATE CURRENT_TIMESTAMP,
    expires_at      DATETIME,
    FOREIGN KEY (customer_id) REFERENCES customers(id) ON DELETE CASCADE,
    FOREIGN KEY (branch_id)   REFERENCES branches(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE cart_items (
    id          INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    cart_id     INT UNSIGNED NOT NULL,
    product_id  INT UNSIGNED NOT NULL,
    variant_id  INT UNSIGNED,
    quantity    SMALLINT UNSIGNED NOT NULL DEFAULT 1,
    added_at    DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (cart_id)    REFERENCES carts(id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(id),
    FOREIGN KEY (variant_id) REFERENCES product_variants(id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ─────────────────────────────────────────────
--  CMS: PAGES & BLOCKS
-- ─────────────────────────────────────────────
CREATE TABLE pages (
    id              INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    branch_id       INT UNSIGNED,               -- NULL = global page
    parent_id       INT UNSIGNED,
    template        VARCHAR(100) DEFAULT 'standard',  -- standard, landing, full_width
    status          ENUM('draft','published','archived') DEFAULT 'draft',
    sort_order      SMALLINT    DEFAULT 0,
    show_in_nav     TINYINT(1)  DEFAULT 0,
    requires_auth   TINYINT(1)  DEFAULT 0,
    created_by      INT UNSIGNED,
    created_at      DATETIME    DEFAULT CURRENT_TIMESTAMP,
    updated_at      DATETIME    ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (branch_id)  REFERENCES branches(id) ON DELETE CASCADE,
    FOREIGN KEY (parent_id)  REFERENCES pages(id) ON DELETE SET NULL,
    FOREIGN KEY (created_by) REFERENCES admin_users(id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE page_translations (
    id              INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    page_id         INT UNSIGNED NOT NULL,
    lang_code       VARCHAR(10)  NOT NULL,
    title           VARCHAR(300) NOT NULL,
    url_slug        VARCHAR(300) NOT NULL,
    meta_title      VARCHAR(255),
    meta_description VARCHAR(500),
    og_image        VARCHAR(500),
    UNIQUE KEY uq_page_lang (page_id, lang_code),
    UNIQUE KEY uq_slug_lang (url_slug, lang_code),
    FOREIGN KEY (page_id) REFERENCES pages(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- CMS content blocks (the page builder)
CREATE TABLE page_blocks (
    id          INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    page_id     INT UNSIGNED NOT NULL,
    block_type  VARCHAR(50)  NOT NULL,          -- text, image, slider, html, cta, grid
    sort_order  SMALLINT     DEFAULT 0,
    css_class   VARCHAR(200),
    settings    JSON,                           -- block-level settings (bg color, width, etc.)
    is_active   TINYINT(1)   DEFAULT 1,
    FOREIGN KEY (page_id) REFERENCES pages(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE page_block_translations (
    id          INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    block_id    INT UNSIGNED NOT NULL,
    lang_code   VARCHAR(10)  NOT NULL,
    content     LONGTEXT,                       -- JSON or raw HTML per block type
    UNIQUE KEY uq_block_lang (block_id, lang_code),
    FOREIGN KEY (block_id) REFERENCES page_blocks(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ─────────────────────────────────────────────
--  NAVIGATION MENUS
-- ─────────────────────────────────────────────
CREATE TABLE menus (
    id          INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    branch_id   INT UNSIGNED,
    location    VARCHAR(50) NOT NULL,           -- header, footer, mobile
    name        VARCHAR(100) NOT NULL,
    FOREIGN KEY (branch_id) REFERENCES branches(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE menu_items (
    id          INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    menu_id     INT UNSIGNED NOT NULL,
    parent_id   INT UNSIGNED,
    type        ENUM('page','category','url','product') NOT NULL DEFAULT 'url',
    reference_id INT UNSIGNED,
    url         VARCHAR(500),
    target      VARCHAR(20)  DEFAULT '_self',
    sort_order  SMALLINT     DEFAULT 0,
    FOREIGN KEY (menu_id)   REFERENCES menus(id) ON DELETE CASCADE,
    FOREIGN KEY (parent_id) REFERENCES menu_items(id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE menu_item_translations (
    id          INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    item_id     INT UNSIGNED NOT NULL,
    lang_code   VARCHAR(10)  NOT NULL,
    label       VARCHAR(200) NOT NULL,
    UNIQUE KEY uq_item_lang (item_id, lang_code),
    FOREIGN KEY (item_id) REFERENCES menu_items(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ─────────────────────────────────────────────
--  GENERAL TRANSLATIONS (UI strings)
-- ─────────────────────────────────────────────
CREATE TABLE translations (
    id          INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    lang_code   VARCHAR(10)  NOT NULL,
    `key`       VARCHAR(200) NOT NULL,
    value       TEXT         NOT NULL,
    group_name  VARCHAR(100) DEFAULT 'general',
    UNIQUE KEY uq_translation (lang_code, `key`),
    INDEX idx_lang_group (lang_code, group_name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ─────────────────────────────────────────────
--  REVIEWS & RATINGS
-- ─────────────────────────────────────────────
CREATE TABLE product_reviews (
    id          INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    product_id  INT UNSIGNED NOT NULL,
    customer_id INT UNSIGNED NOT NULL,
    branch_id   INT UNSIGNED NOT NULL,
    rating      TINYINT UNSIGNED NOT NULL CHECK (rating BETWEEN 1 AND 5),
    title       VARCHAR(200),
    body        TEXT,
    status      ENUM('pending','approved','rejected') DEFAULT 'pending',
    created_at  DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (product_id)  REFERENCES products(id) ON DELETE CASCADE,
    FOREIGN KEY (customer_id) REFERENCES customers(id) ON DELETE CASCADE,
    FOREIGN KEY (branch_id)   REFERENCES branches(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ─────────────────────────────────────────────
--  THEME / TEMPLATE SETTINGS
-- ─────────────────────────────────────────────
CREATE TABLE theme_settings (
    id          INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    branch_id   INT UNSIGNED,
    scope       ENUM('frontend','backend') NOT NULL DEFAULT 'frontend',
    theme_name  VARCHAR(100) NOT NULL DEFAULT 'default',
    settings    JSON,                           -- colors, fonts, logo overrides
    UNIQUE KEY uq_branch_scope (branch_id, scope),
    FOREIGN KEY (branch_id) REFERENCES branches(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ─────────────────────────────────────────────
--  ACTIVITY LOG / AUDIT
-- ─────────────────────────────────────────────
CREATE TABLE activity_logs (
    id          BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    user_type   ENUM('admin','customer') NOT NULL,
    user_id     INT UNSIGNED NOT NULL,
    action      VARCHAR(100) NOT NULL,
    model       VARCHAR(100),
    model_id    INT UNSIGNED,
    payload     JSON,
    ip_address  VARCHAR(45),
    user_agent  TEXT,
    created_at  DATETIME DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_user (user_type, user_id),
    INDEX idx_model (model, model_id),
    INDEX idx_created (created_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ─────────────────────────────────────────────
--  SEED DATA
-- ─────────────────────────────────────────────
INSERT INTO languages (code, name, locale, flag, is_default, is_active, sort_order) VALUES
('de', 'Deutsch', 'de_DE', '🇩🇪', 1, 1, 0),
('en', 'English', 'en_US', '🇬🇧', 0, 1, 1);

INSERT INTO roles (name, permissions) VALUES
('superadmin', JSON_OBJECT('all', true)),
('admin',       JSON_OBJECT('products','rw','orders','rw','customers','rw','cms','rw')),
('branch_manager', JSON_OBJECT('orders','rw','stock','rw','customers','r')),
('editor',      JSON_OBJECT('products','rw','cms','rw'));

INSERT INTO branches (name, slug, domain, currency_code, tax_rate) VALUES
('Main Branch',  'main',    'main.example.com',    'EUR', 19.00),
('North Branch', 'north',   'north.example.com',   'EUR', 19.00);

INSERT INTO branch_delivery_settings (branch_id, allows_pickup, allows_shipping, free_shipping_from, shipping_cost)
VALUES (1, 1, 1, 50.00, 4.90), (2, 1, 1, 75.00, 5.90);

SET FOREIGN_KEY_CHECKS = 1;
