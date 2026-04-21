# TechStore E-Commerce System Analysis & Documentation

## 1. Project Overview
This project is a highly-customized, multi-branch E-Commerce system built with pure **PHP 8.2+**.
- **Architecture**: It strictly adheres to an **MVC (Model-View-Controller)** pattern with custom routing (`App\Core\Router`) and an Active Record/Repository hybrid model (`App\Core\Model`).
- **Framework**: It is a bespoke (custom-built) framework without relying on Laravel or Symfony, though it adopts modern framework concepts such as Middlewares (`AuthMiddleware`, `CsrfMiddleware`, `BranchMiddleware`), Service Layers, and strict dependency structures.
- **Dependencies**: It uses Composer for autoloading (PSR-4) but has minimal external package dependencies natively outside of standard PHP extensions.
- **Core Feature**: The system is designed around a **Multi-Branch Architecture**, meaning inventory, pricing, delivery settings, and availability are branch-specific.

## 2. Database Analysis (MySQL/MariaDB)
The database is fully relational (InnoDB) with foreign key constraints.
**Core Tables & Relations:**
- `branches`: Core domain tenant table.
- `customers` & `admin_users`: Separation of concern between backend admins and frontend shoppers.
- `products`: Base product data.
- `product_variants`, `product_attributes`, `product_attribute_values`: Handles complex product variants (e.g., size, color).
- `product_branch_stock` & `product_branch_prices`: Allows individual branches to hold localized stock and pricing.
- `orders` & `order_items`: Order tracking linked to `branches` and `customers`.
- `translations` & `*_translations` tables: Implements comprehensive multi-language support (EAV-like pattern for localized strings).

**Improvements & Normalization Constraints:**
- *Current State*: The schema is well-normalized up to 3NF.
- *Performance Suggestion*: Introduce composite indexes on `product_branch_stock (product_id, branch_id)` and `product_branch_prices (product_id, branch_id)` to speed up frontend catalog queries since all queries filter by branch.

## 3. Environment Setup Guide
### System Requirements
- **OS**: Ubuntu 22.04 LTS (or similar Linux)
- **Web Server**: Apache 2.4+ or Nginx 1.18+
- **PHP**: 8.2+ (Extensions: `pdo_mysql`, `mbstring`, `json`, `intl`, `curl`, `xml`)
- **Database**: MariaDB 10.11+ or MySQL 8.0+

### Complete Fresh Server Setup (Ubuntu 22.04)
```bash
# 1. Update system and install software stack
sudo apt update && sudo apt upgrade -y
sudo apt install -y apache2 mariadb-server curl unzip \
    php8.2 libapache2-mod-php8.2 php8.2-mysql php8.2-mbstring \
    php8.2-intl php8.2-xml php8.2-curl php8.2-cli

# 2. Install Composer
curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer

# 3. Configure Database
sudo systemctl start mariadb
sudo systemctl enable mariadb
sudo mysql -e "CREATE DATABASE ecommerce CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"
sudo mysql -e "CREATE USER 'techstore'@'localhost' IDENTIFIED BY 'techstore123';"
sudo mysql -e "GRANT ALL PRIVILEGES ON ecommerce.* TO 'techstore'@'localhost';"
sudo mysql -e "FLUSH PRIVILEGES;"

# 4. Clone / Deploy Application
# git clone <repo> /var/www/ecommerce
cd /var/www/ecommerce
composer install --no-dev --optimize-autoloader

# 5. Populate Database
mysql -u techstore -ptechstore123 ecommerce < database/schema.sql
mysql -u techstore -ptechstore123 ecommerce < database/seeds/01_base_data.sql
mysql -u techstore -ptechstore123 ecommerce < database/seeds/02_products.sql
mysql -u techstore -ptechstore123 ecommerce < database/seeds/03_prices_stock_orders.sql
mysql -u techstore -ptechstore123 ecommerce < database/seeds/04_cms_menus_reviews.sql

# 6. Configure Environment
cp .env.example .env
# Edit .env with your specific DB credentials and APP_URL

# 7. Configure Apache Virtual Host
sudo cat <<EOT > /etc/apache2/sites-available/ecommerce.conf
<VirtualHost *:80>
    ServerName yourdomain.com
    DocumentRoot /var/www/ecommerce/public
    <Directory /var/www/ecommerce/public>
        AllowOverride All
        Require all granted
    </Directory>
</VirtualHost>
EOT

# 8. Set Permissions & Enable Site
sudo chown -R www-data:www-data /var/www/ecommerce
sudo a2ensite ecommerce.conf
sudo a2enmod rewrite
sudo systemctl restart apache2
```

## 4. Application Run & Test
### Local Development Run
To run the project locally without Apache:
```bash
cd /app
php -S 0.0.0.0:8080 -t public/
```
Navigate to `http://localhost:8080` to access the storefront.
Admin dashboard is at `http://localhost:8080/admin/login` (User: `admin@techstore.de`, Pass: `Admin1234!`).

### Testing & Troubleshooting
- Ensure `APP_URL` in `.env` accurately reflects the host to avoid broken asset links.
- Check database connection by browsing to the homepage; if categories load, PDO is successfully wired.

## 5. Frontend & UI/UX Analysis
- **Current State**: Uses a custom PHP view templating structure inside `templates/frontend/default`. Styles are defined centrally in `public/assets/css/app.css` using modern CSS variables (`--color-primary`, etc.) and CSS Grid/Flexbox.
- **Responsiveness**: The site embraces a mobile-first design philosophy. Product grids use `repeat(auto-fit, minmax(120px, 1fr))` to scale seamlessly.
- **UX Improvements Applied**:
  - Re-integrated missing templates (`profile.php`, `orders.php`) in the customer dashboard to prevent 404 errors.
  - Interactive elements feature clear `:focus` and `:hover` states.
  - The off-canvas drawer system for the cart keeps users engaged without full page redirects.

## 6. Security & Performance
- **SQL Injection**: The system is inherently protected against SQL Injection through rigid implementation of PDO Prepared Statements in the custom `App\Core\Model` layer.
- **XSS (Cross-Site Scripting)**: Secure escaping methodologies are employed (`$v->e()` helper functions) in templates to neutralize user-input injections.
- **CSRF**: A custom `CsrfMiddleware` binds tokens to sessions and injects them via hidden inputs in forms (`csrf_field()`).
- **Performance**:
  - The lack of a bloated ORM makes queries incredibly lightweight.
  - **Optimization**: We recommend implementing Redis for session handling and full-page/fragment caching if scaling to high traffic.

## 7. Debugging & Improvements (Fixed Issues)
During the analysis phase, several critical roadblocks were patched:
1. **Routing & Autoloader Constraints**: Fixed typehint errors across core controllers causing fatal crashes on PHP 8.2+.
2. **Missing Customer Account Dashboard Views**: Built out the entire `account/` subdirectory templates (`layout.php`, `orders.php`, `addresses.php`, `profile.php`) to fix fatal rendering errors.
3. **Database Column Mismatches**: Repaired queries where old column schemas (e.g., `address_line1`) were being called instead of updated ones (e.g., `street`), mitigating `PDOException` crashes.
4. **Checkout Controller**: Corrected cart extraction arrays that were improperly typed during the final order placement loop.

---
*Generated by Senior Full-Stack Engineer as per the Complete Project Analysis directive.*
