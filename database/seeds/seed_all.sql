-- ============================================================
--  MASTER SEED FILE — TechStore Beispieldaten
--  Führt alle Seed-Dateien in der richtigen Reihenfolge aus.
--
--  Verwendung:
--    mysql -u root -p ecommerce < database/seeds/seed_all.sql
--
--  WICHTIG: Erst das Schema laden:
--    mysql -u root -p ecommerce < database/schema.sql
-- ============================================================

SET FOREIGN_KEY_CHECKS = 0;
SET NAMES utf8mb4;

-- Reihenfolge: Basis → Produkte → Preise/Lager/Bestellungen → CMS/Menüs/Reviews

SOURCE database/seeds/01_base_data.sql;
SOURCE database/seeds/02_products.sql;
SOURCE database/seeds/03_prices_stock_orders.sql;
SOURCE database/seeds/04_cms_menus_reviews.sql;

SET FOREIGN_KEY_CHECKS = 1;

-- Zusammenfassung
SELECT 'languages'        AS Tabelle, COUNT(*) AS Datensätze FROM languages        UNION ALL
SELECT 'branches',                    COUNT(*)               FROM branches          UNION ALL
SELECT 'admin_users',                 COUNT(*)               FROM admin_users       UNION ALL
SELECT 'customers',                   COUNT(*)               FROM customers         UNION ALL
SELECT 'addresses',                   COUNT(*)               FROM addresses         UNION ALL
SELECT 'company_documents',           COUNT(*)               FROM company_documents UNION ALL
SELECT 'categories',                  COUNT(*)               FROM categories        UNION ALL
SELECT 'products',                    COUNT(*)               FROM products          UNION ALL
SELECT 'product_translations',        COUNT(*)               FROM product_translations UNION ALL
SELECT 'product_variants',            COUNT(*)               FROM product_variants  UNION ALL
SELECT 'product_images',              COUNT(*)               FROM product_images    UNION ALL
SELECT 'product_branch_prices',       COUNT(*)               FROM product_branch_prices UNION ALL
SELECT 'product_branch_stock',        COUNT(*)               FROM product_branch_stock  UNION ALL
SELECT 'campaigns',                   COUNT(*)               FROM campaigns         UNION ALL
SELECT 'orders',                      COUNT(*)               FROM orders            UNION ALL
SELECT 'order_items',                 COUNT(*)               FROM order_items       UNION ALL
SELECT 'order_status_history',        COUNT(*)               FROM order_status_history UNION ALL
SELECT 'carts',                       COUNT(*)               FROM carts             UNION ALL
SELECT 'pages',                       COUNT(*)               FROM pages             UNION ALL
SELECT 'page_blocks',                 COUNT(*)               FROM page_blocks       UNION ALL
SELECT 'menus',                       COUNT(*)               FROM menus             UNION ALL
SELECT 'menu_items',                  COUNT(*)               FROM menu_items        UNION ALL
SELECT 'product_reviews',             COUNT(*)               FROM product_reviews   UNION ALL
SELECT 'translations',                COUNT(*)               FROM translations      UNION ALL
SELECT 'theme_settings',              COUNT(*)               FROM theme_settings    UNION ALL
SELECT 'activity_logs',               COUNT(*)               FROM activity_logs;
