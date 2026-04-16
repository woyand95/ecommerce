# TechStore Demo Database Setup

## Overview

This demo database setup script creates a complete e-commerce demonstration environment with:
- **5 Customer Accounts** (3 private, 2 company)
- **100 Products** across 8 categories
- **Demo Orders** with different statuses
- **Complete CMS content** (pages, menus, reviews)
- **Active campaigns** and promotions

## Quick Start

### Option A: Using Docker (Recommended)

```bash
# Start Docker containers
docker-compose up -d

# Wait for MySQL to be ready (about 30 seconds)
sleep 30

# Import demo database
docker exec -i techstore-mysql mysql -uroot -pTechStore123! ecommerce_demo < database/demo_setup.sql

# Access the application
echo "Application: http://localhost:8080"
echo "phpMyAdmin: http://localhost:8081"
```

### Option B: Manual MySQL Installation

```bash
# Create database and import demo
mysql -u root -p < database/demo_setup.sql
```

### Option C: Step-by-Step Manual

```bash
# 1. Create database
mysql -u root -p -e "CREATE DATABASE ecommerce_demo CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"

# 2. Import schema
mysql -u root -p ecommerce_demo < database/schema.sql

# 3. Import demo data
mysql -u root -p ecommerce_demo < database/demo_setup.sql
```

## Demo Credentials

### 🔐 Admin Login
```
Email:    admin@techstore-demo.com
Password: Admin1234!
```

### 👥 Customer Logins

| # | Email | Password | Type | Company |
|---|-------|----------|------|---------|
| 1 | max.mustermann@demo.de | Kunde1234! | Private | - |
| 2 | julia.schmidt@demo.de | Kunde1234! | Private | - |
| 3 | t.weber@techgmbh-demo.de | Kunde1234! | Company | Tech GmbH |
| 4 | sarah.fischer@demo.de | Kunde1234! | Private | - |
| 5 | m.becker@startup-demo.de | Kunde1234! | Company | Startup Solutions UG |

## Database Contents

### 📊 Statistics

| Table | Records | Description |
|-------|---------|-------------|
| `products` | 100 | All product types |
| `product_translations` | ~50 | German product names/descriptions |
| `product_variants` | 9 | Product variations (colors, storage) |
| `product_branch_prices` | 100 | Prices for demo branch |
| `product_branch_stock` | 100 | Stock levels (50-250 units each) |
| `customers` | 5 | Demo customer accounts |
| `addresses` | 7 | Customer addresses |
| `orders` | 5 | Sample orders with different statuses |
| `order_items` | 5 | Order line items |
| `order_status_history` | 14 | Order status changes |
| `categories` | 8 | Product categories |
| `pages` | 5 | CMS pages |
| `menus` | 2 | Navigation menus |
| `menu_items` | 9 | Menu links |
| `product_reviews` | 7 | Customer reviews |
| `campaigns` | 3 | Active promotions |
| `carts` | 2 | Active shopping carts |

### 📦 Product Categories

1. **Smartphones** (15 products) - Apple, Samsung, Google, OnePlus, Xiaomi, etc.
2. **Laptops** (15 products) - MacBook, Dell XPS, Lenovo, HP, Asus, MSI
3. **Audio - Headphones** (15 products) - Sony, Apple, Bose, Sennheiser
4. **Audio - Earbuds** (15 products) - AirPods, Sony WF, Samsung Galaxy Buds
5. **Audio - Speakers** (10 products) - Sonos, Bose, JBL, Marshall
6. **Tablets** (10 products) - iPad, Samsung Tab, Surface, Lenovo
7. **Gaming** (10 products) - Nintendo, PlayStation, Xbox, Steam Deck, Accessories
8. **Smart Home** (5 products) - Philips Hue, Echo, Nest, TP-Link
9. **Cameras** (5 products) - Sony Alpha, Canon, Nikon, Fujifilm, Panasonic

### 💰 Price Ranges

| Category | Min Price | Max Price |
|----------|-----------|-----------|
| Smartphones | €749 | €1,449 |
| Laptops | €999 | €2,399 |
| Headphones | €219 | €499 |
| Earbuds | €114 | €324 |
| Speakers | €79 | €349 |
| Tablets | €499 | €1,399 |
| Gaming | €79 | €529 |
| Smart Home | €79 | €239 |
| Cameras | €999 | €1,799 |

### 📋 Sample Orders

| Order # | Customer | Status | Total | Payment |
|---------|----------|--------|-------|---------|
| DEMO-2025-0001 | Max Mustermann | ✅ Completed | €1,373.14 | Credit Card |
| DEMO-2025-0002 | Julia Schmidt | 🔄 Processing | €391.43 | PayPal |
| DEMO-2025-0003 | Tech GmbH | 🚚 Shipped | €2,735.52 | Invoice |
| DEMO-2025-0004 | Sarah Fischer | ⏳ Pending | €956.66 | Credit Card |
| DEMO-2025-0005 | Startup Solutions | ✅ Completed | €2,200.62 | Bank Transfer |

### 🎯 Active Campaigns

1. **Frühjahrs-Sale** - 15% off on Smartphones, Laptops, Audio (min. €50)
2. **Neukunden-Rabatt** - €20 off first order (min. €100)
3. **Gaming Week** - 10% off Gaming products

## Features Demonstrated

✅ Multi-tenant architecture (branch-based)  
✅ Variable products with variants  
✅ Price groups and branch-specific pricing  
✅ Stock management with reservations  
✅ Order workflow with status history  
✅ Customer types (private/company)  
✅ Company verification workflow  
✅ CMS pages with blocks  
✅ Navigation menus  
✅ Product reviews  
✅ Shopping cart functionality  
✅ Campaign/discount system  
✅ Multi-language support (DE/EN)  
✅ Activity logging  

## Testing Scenarios

### Customer Journey
1. Browse products by category
2. View product details with variants
3. Add items to cart
4. Apply campaign discounts
5. Checkout with different payment methods
6. Track order status

### Admin Tasks
1. Login to admin panel
2. Manage products and inventory
3. Process orders (change status)
4. Verify company customers
5. Manage CMS content
6. View activity logs

### B2B Features
1. Company registration
2. Document upload
3. Verification workflow
4. B2B pricing
5. Invoice payment

## Troubleshooting

### MySQL Connection Issues
```bash
# Check if MySQL is running
docker ps | grep mysql

# View MySQL logs
docker logs techstore-mysql

# Test connection
docker exec -it techstore-mysql mysql -uroot -pTechStore123! -e "SHOW DATABASES;"
```

### Import Errors
```bash
# Drop and recreate database
mysql -u root -p -e "DROP DATABASE IF EXISTS ecommerce_demo; CREATE DATABASE ecommerce_demo CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"

# Re-import
mysql -u root -p ecommerce_demo < database/demo_setup.sql
```

### Reset Demo Data
```bash
# Simply re-run the script (it uses DELETE + INSERT)
mysql -u root -p ecommerce_demo < database/demo_setup.sql
```

## Next Steps

1. **Explore the Application**: Visit http://localhost:8080
2. **Login as Admin**: Test backend features
3. **Test Customer Flows**: Use customer credentials
4. **Customize Data**: Modify demo_setup.sql for your needs
5. **Production Setup**: Use proper seed files for production

## Support

For issues or questions:
- Check application logs in `storage/logs/`
- Review MySQL error logs
- Consult full documentation in `docs/`

---

**Note**: This is a demo database with test data. Do not use in production environments.
All passwords are intentionally weak for testing purposes only.
