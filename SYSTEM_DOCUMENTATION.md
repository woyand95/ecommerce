# TechStore Multi-Branch E-Commerce System

## 1. Project Overview
This project is a bespoke, highly-optimized E-Commerce framework built in pure PHP 8.2+. It follows the **MVC (Model-View-Controller)** pattern but integrates modern framework-like features:
- **Middleware Pipeline:** Includes `BranchMiddleware`, `CsrfMiddleware`, `AuthMiddleware`, `ThrottleMiddleware`.
- **ActiveRecord Models:** Database abstraction extending `App\Core\Model` via PDO prepared statements.
- **Service Layer:** `BranchService`, `CartService`, `PricingService`, etc. separating business logic from controllers.
- **Routing Engine:** RESTful routing mapping URIs to controllers (`App\Core\Router`).

The most distinct feature of this system is its strict **Multi-Branch Architecture**. Every user session belongs to a specific branch. Features like prices, product availability, stock, and UI themes are heavily scoped to the active branch.

## 2. System Requirements
To run this application, the following environment stack is required:
- **Operating System:** Ubuntu 22.04+ (or any modern Linux distribution)
- **Web Server:** Apache 2.4+ or Nginx 1.18+
- **PHP Version:** PHP 8.2 or higher
- **PHP Extensions:** `pdo`, `pdo_mysql`, `mbstring`, `json`, `intl`
- **Database:** MariaDB 10.11+ or MySQL 8.0+
- **Dependency Management:** Composer
- **Caching/Sessions (Optional):** Redis 7+

## 3. Installation Guide (Fresh Ubuntu Server)
Execute the following instructions step-by-step to deploy on a fresh Ubuntu 22.04 server.

### A. Install Web Server and PHP dependencies
```bash
sudo apt update && sudo apt upgrade -y
sudo apt install -y apache2 libapache2-mod-php php8.2 php8.2-cli php8.2-fpm \
php8.2-mysql php8.2-mbstring php8.2-xml php8.2-curl php8.2-intl unzip curl
```

### B. Install Composer
```bash
curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer
```

### C. Install Database Server
```bash
sudo apt install -y mariadb-server mariadb-client
sudo systemctl start mariadb
sudo systemctl enable mariadb
```

### D. Setup Project Files
```bash
git clone <repository_url> /var/www/ecommerce
cd /var/www/ecommerce
composer install --no-dev --optimize-autoloader
```

## 4. Configuration Guide
Copy the environment template and set proper values.

```bash
cp .env.example .env
# Edit .env using a text editor
```
Ensure you have the correct variables configured:
```env
APP_ENV=production
APP_DEBUG=false
APP_URL=https://yourdomain.com

DB_HOST=127.0.0.1
DB_PORT=3306
DB_DATABASE=ecommerce
DB_USERNAME=techstore
DB_PASSWORD=techstore123
```

Set the proper directory permissions for logs, cache, and uploads:
```bash
sudo chown -R www-data:www-data /var/www/ecommerce/storage
sudo chmod -R 775 /var/www/ecommerce/storage
```

## 5. Database Setup
Create the dedicated user and load the schema and demo data seeds:

```bash
sudo mysql -e "CREATE DATABASE ecommerce CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"
sudo mysql -e "CREATE USER 'techstore'@'localhost' IDENTIFIED BY 'techstore123';"
sudo mysql -e "GRANT ALL PRIVILEGES ON ecommerce.* TO 'techstore'@'localhost';"
sudo mysql -e "FLUSH PRIVILEGES;"

# Load core schema and seeds
sudo mysql -u techstore -ptechstore123 ecommerce < database/schema.sql
sudo mysql -u techstore -ptechstore123 ecommerce < database/seeds/01_base_data.sql
sudo mysql -u techstore -ptechstore123 ecommerce < database/seeds/02_products.sql
sudo mysql -u techstore -ptechstore123 ecommerce < database/seeds/03_prices_stock_orders.sql
sudo mysql -u techstore -ptechstore123 ecommerce < database/seeds/04_cms_menus_reviews.sql
```

## 6. Run Instructions
### Option A: Using Apache (Production)
Configure the Virtual Host:
```bash
# Create /etc/apache2/sites-available/ecommerce.conf
```
```apache
<VirtualHost *:80>
    ServerName yourdomain.com
    DocumentRoot /var/www/ecommerce/public

    <Directory /var/www/ecommerce/public>
        AllowOverride All
        Require all granted
    </Directory>

    ErrorLog ${APACHE_LOG_DIR}/ecommerce_error.log
    CustomLog ${APACHE_LOG_DIR}/ecommerce_access.log combined
</VirtualHost>
```
Enable the site and mod_rewrite:
```bash
sudo a2ensite ecommerce.conf
sudo a2enmod rewrite
sudo systemctl restart apache2
```

### Option B: Local PHP Development Server (Development)
For local testing or development purposes, you can start the built-in PHP server pointing to the `public/` directory:
```bash
cd /var/www/ecommerce
php -S 0.0.0.0:8080 -t public/
```

## 7. UI/UX & Frontend Architecture
The system uses a custom PHP-based template engine located in `templates/`.
- The main template is `templates/frontend/default/layouts/main.php`.
- Inline styles have been aggressively removed and replaced with modern CSS methodologies in `public/assets/css/app.css`.
- Global CSS custom variables (e.g. `--color-primary`, `--space-4`) ensure design consistency across desktop and mobile.
- Responsiveness: Designed mobile-first utilizing grids (`grid-template-columns: repeat(auto-fit, minmax(120px, 1fr))`) inside flexbox containers.

## 8. Security Highlights
1. **SQL Injection:** Strict usage of PDO Prepared Statements across `Database` and `Model` layer.
2. **XSS (Cross-Site Scripting):** All user output is securely escaped using the `__e()` or `$v->e()` helper.
3. **CSRF:** All mutable HTTP methods validate against a sync-token injected by `CsrfMiddleware`.
4. **Session Securing:** Cookies utilize `cookie_httponly`, `cookie_secure` and `use_strict_mode` configurations setup within `bootstrap.php`.

## 9. Troubleshooting
### Missing Dependencies / Classes Not Found
If you encounter `Uncaught Error: Class Not Found`, this indicates a mapping issue. Re-run Composer autoload:
```bash
composer dump-autoload
```

### Database Connection Refused (PDOException)
Ensure MariaDB is actively running and the `.env` file credentials map accurately to the SQL permissions. Run:
```bash
sudo systemctl status mariadb
```
Check if the user exists:
```bash
sudo mysql -e "SELECT User, Host FROM mysql.user;"
```

## 10. Admin Dashboard & Login
To access the backend administrator panel, navigate directly to `/admin/login`.

**Demo Credentials:**
- Email: `admin@techstore.de`
- Password: `Admin1234!`

Note: The admin panel is completely siloed behind the `AdminMiddleware`. Users accessing `/admin` routes who are not logged in as Administrators will be safely redirected to `/admin/login`.

### Broken Page Layout or Missing CSS
Ensure that the `APP_URL` in `.env` is correctly pointing to your local/production domain URL so `asset()` functions compute the fully-qualified paths effectively.

### Fatal Errors relating to Functions Loading
Ensure that `app/Helpers/functions.php` wraps every single function declaration with an `if (!function_exists('func_name'))` check to prevent multiple redeclarations when the script iterates multiple times in a single lifecycle.
