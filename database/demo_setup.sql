-- ============================================================
--  DEMO DATABASE SETUP SCRIPT
--  TechStore Demo - 5 Accounts, 100 Products
--  
--  Kullanım:
--    mysql -u root -p < demo_setup.sql
--
--  Bu script:
--    1. ecommerce_db veritabanını oluşturur
--    2. Schema'yı yükler
--    3. 5 demo kullanıcı ekler
--    4. 100 demo ürün ekler
--    5. Demo siparişler, stok ve fiyatlar ekler
-- ============================================================

SET FOREIGN_KEY_CHECKS = 0;
SET NAMES utf8mb4;

-- ─────────────────────────────────────────────
--  VERİTABANI OLUŞTUR
-- ─────────────────────────────────────────────
DROP DATABASE IF EXISTS ecommerce_demo;
CREATE DATABASE ecommerce_demo CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE ecommerce_demo;

-- ─────────────────────────────────────────────
--  SCHEMA YÜKLE
-- ─────────────────────────────────────────────
SOURCE database/schema.sql;

-- ─────────────────────────────────────────────
--  TEMEL VERİLER (Languages, Branches, Roles, Categories)
-- ─────────────────────────────────────────────

-- Languages
DELETE FROM languages;
INSERT INTO languages (id, code, name, locale, flag, is_default, is_active, sort_order) VALUES
(1, 'de', 'Deutsch',    'de_DE', '🇩🇪', 1, 1, 0),
(2, 'en', 'English',    'en_US', '🇬🇧', 0, 1, 1);

-- Branches (Demo için sadece 1 branch)
DELETE FROM branches;
INSERT INTO branches (id, name, slug, domain, subdomain, email, phone, address, city, postal_code, country_code, currency_code, tax_rate, timezone, is_active, settings) VALUES
(1, 'TechStore Demo Store', 'demo', 'demo.techstore.com', 'demo', 'demo@techstore.com', '+49 123 456789', 'Demo Straße 1', 'Berlin', '10115', 'DE', 'EUR', 19.00, 'Europe/Berlin', 1, '{"theme":"default","show_pickup":true}');

DELETE FROM branch_delivery_settings;
INSERT INTO branch_delivery_settings (branch_id, allows_pickup, allows_shipping, free_shipping_from, min_order_amount, shipping_cost, estimated_days_min, estimated_days_max, pickup_instructions) VALUES
(1, 1, 1, 50.00, 0.00, 4.90, 1, 3, 'Abholung Mo–Fr 9–18 Uhr. Bitte Bestellnummer mitbringen.');

-- Roles
DELETE FROM roles;
INSERT INTO roles (id, name, permissions) VALUES
(1, 'superadmin', '{"all":true}'),
(2, 'admin', '{"products":"rw","orders":"rw","customers":"rw","cms":"rw","campaigns":"rw","branches":"r"}'),
(3, 'customer', '{}');

-- Admin Users (Demo admin)
DELETE FROM admin_users;
-- Password: Admin1234!
INSERT INTO admin_users (id, branch_id, role_id, first_name, last_name, email, password_hash, is_active, last_login_at) VALUES
(1, NULL, 1, 'Demo', 'Admin', 'admin@techstore-demo.com', '$2y$12$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 1, NOW());

-- Categories
DELETE FROM categories;
INSERT INTO categories (id, parent_id, icon, image, sort_order, is_active, created_at) VALUES
(1, NULL, 'smartphone', '/images/categories/smartphones.jpg', 1, 1, NOW()),
(2, NULL, 'laptop', '/images/categories/laptops.jpg', 2, 1, NOW()),
(3, NULL, 'headphones', '/images/categories/audio.jpg', 3, 1, NOW()),
(4, NULL, 'tablet', '/images/categories/tablets.jpg', 4, 1, NOW()),
(5, NULL, 'gaming', '/images/categories/gaming.jpg', 5, 1, NOW()),
(6, NULL, 'smart-home', '/images/categories/smarthome.jpg', 6, 1, NOW()),
(7, NULL, 'camera', '/images/categories/cameras.jpg', 7, 1, NOW()),
(8, NULL, 'accessories', '/images/categories/accessories.jpg', 8, 1, NOW());

DELETE FROM category_translations;
INSERT INTO category_translations (category_id, lang_code, name, description, meta_title, meta_description, url_slug) VALUES
(1, 'de', 'Smartphones', 'Die neuesten Smartphones von Apple, Samsung und mehr.', 'Smartphones kaufen', 'Smartphones günstig online kaufen', 'smartphones'),
(1, 'en', 'Smartphones', 'The latest smartphones from Apple, Samsung and more.', 'Buy Smartphones', 'Buy smartphones online at great prices', 'smartphones'),
(2, 'de', 'Laptops', 'Leistungsstarke Laptops für Arbeit und Gaming.', 'Laptops kaufen', 'Laptops online bestellen', 'laptops'),
(2, 'en', 'Laptops', 'Powerful laptops for work and gaming.', 'Buy Laptops', 'Order laptops online', 'laptops'),
(3, 'de', 'Audio & Kopfhörer', 'Premium Kopfhörer und Lautsprecher.', 'Kopfhörer kaufen', 'Kopfhörer und Audiozubehör', 'audio-kopfhoerer'),
(3, 'en', 'Audio & Headphones', 'Premium headphones and speakers.', 'Buy Headphones', 'Headphones and audio accessories', 'audio-headphones'),
(4, 'de', 'Tablets', 'Tablets für Entertainment und Produktivität.', 'Tablets kaufen', 'Tablets online bestellen', 'tablets'),
(4, 'en', 'Tablets', 'Tablets for entertainment and productivity.', 'Buy Tablets', 'Order tablets online', 'tablets'),
(5, 'de', 'Gaming', 'Gaming-Zubehör für Profis.', 'Gaming kaufen', 'Gaming-Equipment online', 'gaming'),
(5, 'en', 'Gaming', 'Gaming accessories for professionals.', 'Buy Gaming Gear', 'Gaming equipment online', 'gaming'),
(6, 'de', 'Smart Home', 'Intelligente Lösungen für Ihr Zuhause.', 'Smart Home kaufen', 'Smart Home Geräte online', 'smart-home'),
(6, 'en', 'Smart Home', 'Smart solutions for your home.', 'Buy Smart Home', 'Smart home devices online', 'smart-home'),
(7, 'de', 'Kameras', 'Professionelle Kameras und Objektive.', 'Kameras kaufen', 'Kameras online bestellen', 'kameras'),
(7, 'en', 'Cameras', 'Professional cameras and lenses.', 'Buy Cameras', 'Order cameras online', 'cameras'),
(8, 'de', 'Zubehör', 'Kabel, Hüllen und mehr.', 'Zubehör kaufen', 'Elektronikzubehör online', 'zubehoer'),
(8, 'en', 'Accessories', 'Cables, cases and more.', 'Buy Accessories', 'Electronics accessories online', 'accessories');

-- ─────────────────────────────────────────────
--  5 DEMO KUNDEN
-- ─────────────────────────────────────────────
DELETE FROM customers;
-- Password: Kunde1234!
INSERT INTO customers (id, branch_id, type, first_name, last_name, email, password_hash, phone, preferred_lang, company_name, vat_number, trade_register, company_verified, verification_status, verified_at, verified_by, price_group, is_active, email_verified, newsletter, last_login_at) VALUES
(1, 1, 'private', 'Max', 'Mustermann', 'max.mustermann@demo.de', '$2y$12$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '+49 151 12345678', 'de', NULL, NULL, NULL, 0, 'pending', NULL, NULL, 'standard', 1, 1, 1, NOW()),
(2, 1, 'private', 'Julia', 'Schmidt', 'julia.schmidt@demo.de', '$2y$12$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '+49 152 23456789', 'de', NULL, NULL, NULL, 0, 'pending', NULL, NULL, 'standard', 1, 1, 1, NOW()),
(3, 1, 'company', 'Thomas', 'Weber', 't.weber@techgmbh-demo.de', '$2y$12$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '+49 30 12345678', 'de', 'Tech GmbH', 'DE123456789', 'HRB 12345', 1, 'approved', NOW(), 1, 'b2b', 1, 1, 0, NOW()),
(4, 1, 'private', 'Sarah', 'Fischer', 'sarah.fischer@demo.de', '$2y$12$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '+49 153 34567890', 'en', NULL, NULL, NULL, 0, 'pending', NULL, NULL, 'standard', 1, 1, 0, NOW()),
(5, 1, 'company', 'Michael', 'Becker', 'm.becker@startup-demo.de', '$2y$12$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '+49 40 87654321', 'de', 'Startup Solutions UG', 'DE987654321', 'HRB 54321', 1, 'approved', NOW(), 1, 'b2b', 1, 1, 0, NOW());

-- Customer Addresses
DELETE FROM addresses;
INSERT INTO addresses (id, customer_id, type, first_name, last_name, company, street, street_number, address_addition, city, postal_code, country_code, phone, is_default_billing, is_default_shipping) VALUES
(1, 1, 'shipping', 'Max', 'Mustermann', NULL, 'Musterstraße', '12a', NULL, 'Berlin', '10115', 'DE', '+49 151 12345678', 1, 1),
(2, 2, 'shipping', 'Julia', 'Schmidt', NULL, 'Schmidtweg', '45', 'Apt. 3B', 'München', '80331', 'DE', '+49 152 23456789', 1, 1),
(3, 3, 'billing', 'Thomas', 'Weber', 'Tech GmbH', 'Industriestraße', '88', NULL, 'Hamburg', '20095', 'DE', '+49 30 12345678', 1, 0),
(4, 3, 'shipping', 'Thomas', 'Weber', 'Tech GmbH', 'Lieferstraße', '99', 'Gebäude C', 'Hamburg', '20095', 'DE', '+49 30 12345678', 0, 1),
(5, 4, 'shipping', 'Sarah', 'Fischer', NULL, 'Fischerplatz', '7', NULL, 'Frankfurt', '60311', 'DE', '+49 153 34567890', 1, 1),
(6, 5, 'billing', 'Michael', 'Becker', 'Startup Solutions UG', 'Gründerallee', '1', NULL, 'Köln', '50667', 'DE', '+49 40 87654321', 1, 0),
(7, 5, 'shipping', 'Michael', 'Becker', 'Startup Solutions UG', 'Versandweg', '23', 'Etage 2', 'Köln', '50667', 'DE', '+49 40 87654321', 0, 1);

-- Company Documents
DELETE FROM company_documents;
INSERT INTO company_documents (id, customer_id, document_type, file_name, file_path, file_size, mime_type, status, reviewed_by, reviewed_at) VALUES
(1, 3, 'business_license', 'gewerbeschein_techgmbh.pdf', 'storage/uploads/documents/techgmbh_gewerbe.pdf', 245000, 'application/pdf', 'accepted', 1, NOW()),
(2, 3, 'vat_proof', 'ust_id_techgmbh.pdf', 'storage/uploads/documents/techgmbh_ust.pdf', 180000, 'application/pdf', 'accepted', 1, NOW()),
(3, 5, 'business_license', 'gewerbeschein_startup.pdf', 'storage/uploads/documents/startup_gewerbe.pdf', 210000, 'application/pdf', 'accepted', 1, NOW());

-- ─────────────────────────────────────────────
--  100 PRODUKTE
-- ─────────────────────────────────────────────
DELETE FROM products;

-- Smartphones (1-15)
INSERT INTO products (id, sku, barcode, category_id, type, weight, width, height, depth, tax_class, is_active, is_featured, sort_order) VALUES
(1, 'SPH-SAM-S25U-256', '8806095302714', 1, 'variable', 0.228, 7.97, 16.27, 0.88, 'standard', 1, 1, 1),
(2, 'SPH-SAM-S25-128', '8806095310139', 1, 'variable', 0.162, 7.07, 15.58, 0.77, 'standard', 1, 1, 2),
(3, 'SPH-APP-IP16P-256', '0194253438656', 1, 'variable', 0.227, 7.12, 16.01, 0.82, 'standard', 1, 1, 3),
(4, 'SPH-APP-IP16-128', '0194253438649', 1, 'variable', 0.170, 7.08, 14.73, 0.78, 'standard', 1, 0, 4),
(5, 'SPH-GOO-P9P-256', '0842776112218', 1, 'simple', 0.221, 7.68, 16.26, 0.87, 'standard', 1, 0, 5),
(6, 'SPH-ONE-12R-256', '6921815623947', 1, 'simple', 0.199, 7.38, 16.36, 0.81, 'standard', 1, 0, 6),
(7, 'SPH-XIA-14PRO-512', '6934177789012', 1, 'variable', 0.215, 7.52, 15.92, 0.85, 'standard', 1, 0, 7),
(8, 'SPH-OPP-FX7-256', '6942345678901', 1, 'simple', 0.195, 7.25, 15.80, 0.79, 'standard', 1, 0, 8),
(9, 'SPH-VIV-X100P-256', '6951234567890', 1, 'variable', 0.210, 7.45, 16.10, 0.83, 'standard', 1, 0, 9),
(10, 'SPH-NOT-12PRO-256', '5712345678901', 1, 'simple', 0.205, 7.35, 15.95, 0.80, 'standard', 1, 0, 10),
(11, 'SPH-REA-GT2-128', '4567890123456', 1, 'simple', 0.185, 7.15, 15.65, 0.76, 'standard', 1, 0, 11),
(12, 'SPH-MOT-E40-256', '7890123456789', 1, 'simple', 0.190, 7.20, 15.70, 0.77, 'standard', 1, 0, 12),
(13, 'SPH-HON-M7PRO-512', '6901234567890', 1, 'variable', 0.225, 7.55, 16.15, 0.86, 'standard', 1, 0, 13),
(14, 'SPH-ASU-ZF11-256', '4712345678901', 1, 'simple', 0.175, 6.95, 15.45, 0.75, 'standard', 1, 0, 14),
(15, 'SPH-SAM-A55-128', '8806095678901', 1, 'simple', 0.180, 7.10, 15.60, 0.78, 'standard', 1, 0, 15);

-- Laptops (16-30)
INSERT INTO products (id, sku, barcode, category_id, type, weight, width, height, depth, tax_class, is_active, is_featured, sort_order) VALUES
(16, 'LPT-APP-MBA-M3-8', '0194253842736', 2, 'variable', 1.240, 30.41, 21.24, 1.13, 'standard', 1, 1, 1),
(17, 'LPT-APP-MBP-M4-16', '0194253998012', 2, 'variable', 1.550, 35.57, 24.81, 1.55, 'standard', 1, 1, 2),
(18, 'LPT-DEL-XPS-15-I7', 'DLX15I7512EU', 2, 'simple', 1.860, 34.42, 23.04, 1.84, 'standard', 1, 1, 3),
(19, 'LPT-LEN-X1C-I5-16', 'LNX1CI516EU', 2, 'simple', 1.120, 31.65, 21.73, 1.49, 'standard', 1, 0, 4),
(20, 'LPT-ASU-ZB-I7-32', 'ASZBI732EU', 2, 'simple', 1.390, 32.09, 22.41, 1.49, 'standard', 1, 0, 5),
(21, 'LPT-HP-ENVY-15', 'HPENVY15EU', 2, 'variable', 1.650, 33.80, 22.90, 1.75, 'standard', 1, 0, 6),
(22, 'LPT-MSI-PRST-A7', 'MSIPRSTA7EU', 2, 'simple', 1.950, 35.20, 24.50, 1.90, 'standard', 1, 0, 7),
(23, 'LPT-ACER-SF3-14', 'ACSF314EU', 2, 'simple', 1.350, 31.50, 21.80, 1.55, 'standard', 1, 0, 8),
(24, 'LPT-RAZR-BK16', 'RZRBK16EU', 2, 'variable', 2.100, 36.00, 25.00, 2.00, 'standard', 1, 0, 9),
(25, 'LPT-LEN-LGP5-I7', 'LNLGP5I7EU', 2, 'simple', 1.750, 34.00, 23.50, 1.80, 'standard', 1, 0, 10),
(26, 'LPT-APP-MBA-M2-13', '0194253123456', 2, 'variable', 1.200, 30.00, 20.80, 1.10, 'standard', 1, 0, 11),
(27, 'LPT-DEL-LAT-5540', 'DLLAT5540EU', 2, 'simple', 1.680, 33.50, 22.80, 1.72, 'standard', 1, 0, 12),
(28, 'LPT-HP-PROB-450', 'HPPROB450EU', 2, 'simple', 1.580, 32.80, 22.50, 1.68, 'standard', 1, 0, 13),
(29, 'LPT-ASU-VIVO-S14', 'ASVIVOS14EU', 2, 'simple', 1.450, 32.20, 22.10, 1.58, 'standard', 1, 0, 14),
(30, 'LPT-MSI-GF63-I5', 'MSIGF63I5EU', 2, 'simple', 1.850, 34.50, 23.80, 1.82, 'standard', 1, 0, 15);

-- Audio Headphones (31-45)
INSERT INTO products (id, sku, barcode, category_id, type, weight, width, height, depth, tax_class, is_active, is_featured, sort_order) VALUES
(31, 'AUD-SNY-WH1000XM6', 'SNY1000XM6EU', 3, 'variable', 0.250, 18.00, 20.00, 8.10, 'standard', 1, 1, 1),
(32, 'AUD-APL-APP-MAX-SL', '0194253086550', 3, 'variable', 0.386, 19.30, 16.80, 8.40, 'standard', 1, 1, 2),
(33, 'AUD-BOS-QC45-II', 'QC45IIBLKEU', 3, 'simple', 0.240, 18.60, 20.00, 8.00, 'standard', 1, 0, 3),
(34, 'AUD-SNH-MOM4-BLK', 'SNHMOM4BLKEU', 3, 'variable', 0.265, 18.50, 20.20, 8.20, 'standard', 1, 0, 4),
(35, 'AUD-JBL-LIVE660', 'JBLLIVE660EU', 3, 'simple', 0.230, 17.80, 19.50, 7.90, 'standard', 1, 0, 5),
(36, 'AUD-BEAT-STU-PRO', 'BEATSTUPROEU', 3, 'variable', 0.275, 19.00, 20.50, 8.30, 'standard', 1, 0, 6),
(37, 'AUD-JAB-EVH6-ANC', 'JABEVH6ANCEU', 3, 'simple', 0.245, 18.20, 19.80, 8.10, 'standard', 1, 0, 7),
(38, 'AUD-AKH-K371-BT', 'AKHK371BTEU', 3, 'simple', 0.235, 18.00, 19.60, 8.00, 'standard', 1, 0, 8),
(39, 'AUD-MAR-MID-AIR', 'MARMIDAIREU', 3, 'variable', 0.280, 19.20, 20.80, 8.50, 'standard', 1, 0, 9),
(40, 'AUD-TAM-AT-ANC', 'TAMATANCEU', 3, 'simple', 0.220, 17.50, 19.20, 7.80, 'standard', 1, 0, 10),
(41, 'AUD-PAN-RZ-S500', 'PANRZS500EU', 3, 'simple', 0.255, 18.40, 20.10, 8.15, 'standard', 1, 0, 11),
(42, 'AUD-DEN-AH-GC20', 'DENAHGC20EU', 3, 'variable', 0.260, 18.60, 20.30, 8.25, 'standard', 1, 0, 12),
(43, 'AUD-FOC-CLD-ANC', 'FOCCLDANCEU', 3, 'simple', 0.248, 18.30, 19.90, 8.05, 'standard', 1, 0, 13),
(44, 'AUD-GRD-ENC-ORBIT', 'GRDENCORBITEU', 3, 'simple', 0.270, 18.80, 20.40, 8.35, 'standard', 1, 0, 14),
(45, 'AUD-SKL-ICE-500', 'SKLICE500EU', 3, 'simple', 0.215, 17.20, 19.00, 7.70, 'standard', 1, 0, 15);

-- Audio Earbuds (46-60)
INSERT INTO products (id, sku, barcode, category_id, type, weight, width, height, depth, tax_class, is_active, is_featured, sort_order) VALUES
(46, 'AUD-APL-APWP4-WH', '0194253900993', 3, 'variable', 0.054, 4.62, 5.47, 2.21, 'standard', 1, 1, 1),
(47, 'AUD-SNY-WF1000XM5', 'SNYWF1000EU', 3, 'variable', 0.047, 5.10, 4.90, 2.30, 'standard', 1, 1, 2),
(48, 'AUD-SAM-GBP3-BK', 'SAMGBP3BKEU', 3, 'simple', 0.053, 4.90, 5.20, 2.50, 'standard', 1, 0, 3),
(49, 'AUD-BOS-QCE-BUD', 'BOSQCEBUDEU', 3, 'variable', 0.050, 4.80, 5.10, 2.40, 'standard', 1, 0, 4),
(50, 'AUD-JBL-TUNE230', 'JBLTUNE230EU', 3, 'simple', 0.045, 4.70, 5.00, 2.35, 'standard', 1, 0, 5),
(51, 'AUD-JAB-ELITE85T', 'JABELITE85TEU', 3, 'variable', 0.052, 4.85, 5.15, 2.42, 'standard', 1, 0, 6),
(52, 'AUD-SNH-MOM-TW2', 'SNHMOMTW2EU', 3, 'simple', 0.048, 4.75, 5.05, 2.38, 'standard', 1, 0, 7),
(53, 'AUD-TCH-MANE2-ANC', 'TCHMANE2ANCEU', 3, 'simple', 0.046, 4.68, 4.98, 2.32, 'standard', 1, 0, 8),
(54, 'AUD-XIA-BUD4-PRO', 'XIABUD4PROEU', 3, 'variable', 0.049, 4.78, 5.08, 2.40, 'standard', 1, 0, 9),
(55, 'AUD-OPPO-ENO-AIR3', 'OPPOENOAI3EU', 3, 'simple', 0.044, 4.65, 4.95, 2.30, 'standard', 1, 0, 10),
(56, 'AUD-REA-BUD-Q3', 'REABUDQ3EU', 3, 'simple', 0.043, 4.60, 4.90, 2.28, 'standard', 1, 0, 11),
(57, 'AUD-HUA-FREE-5PRO', 'HUAFREE5PROEU', 3, 'variable', 0.051, 4.82, 5.12, 2.45, 'standard', 1, 0, 12),
(58, 'AUD-NOT-CBUD2-PRO', 'NOTCBUD2PROEU', 3, 'simple', 0.047, 4.72, 5.02, 2.36, 'standard', 1, 0, 13),
(59, 'AUD-ANK-SOUN-4I', 'ANKSOUN4IEU', 3, 'simple', 0.042, 4.55, 4.85, 2.25, 'standard', 1, 0, 14),
(60, 'AUD-1MORE-COMO-BUD', '1MORCOMOBUD', 3, 'simple', 0.045, 4.68, 4.98, 2.33, 'standard', 1, 0, 15);

-- Audio Speakers (61-70)
INSERT INTO products (id, sku, barcode, category_id, type, weight, width, height, depth, tax_class, is_active, is_featured, sort_order) VALUES
(61, 'AUD-SON-SRS-XB100', 'SONXB100BLK', 3, 'variable', 0.386, 7.30, 7.30, 7.30, 'standard', 1, 1, 1),
(62, 'AUD-BOS-SND-300', 'BOSSND300BLK', 3, 'simple', 1.000, 22.00, 11.60, 9.80, 'standard', 1, 1, 2),
(63, 'AUD-JBL-FLIP7', 'JBLFLIP7BLK', 3, 'variable', 0.550, 18.00, 7.00, 7.50, 'standard', 1, 0, 3),
(64, 'AUD-ULT-POW-200', 'ULTPOW200EU', 3, 'simple', 0.950, 20.50, 10.20, 9.00, 'standard', 1, 0, 4),
(65, 'AUD-MAR-EMB-PORT', 'MAREMBPORTEU', 3, 'variable', 0.680, 19.00, 8.50, 8.00, 'standard', 1, 0, 5),
(66, 'AUD-BANG-BEA-A9', 'BANGBEAA9EU', 3, 'simple', 1.200, 24.00, 12.50, 10.50, 'standard', 1, 0, 6),
(67, 'AUD-HAR-KIL-300', 'HARKIL300BLK', 3, 'simple', 0.850, 21.00, 10.80, 9.20, 'standard', 1, 0, 7),
(68, 'AUD-Triba-XLR-GO', 'TRIBXLRGOEU', 3, 'variable', 0.420, 16.50, 6.80, 7.20, 'standard', 1, 0, 8),
(69, 'AUD-DEV-GRILL-NT', 'DEVGRILLNTEU', 3, 'simple', 1.150, 23.50, 11.80, 10.00, 'standard', 1, 0, 9),
(70, 'AUD-WEE-SING-EX', 'WEESINGEXEU', 3, 'simple', 0.320, 14.00, 5.50, 6.00, 'standard', 1, 0, 10);

-- Tablets (71-80)
INSERT INTO products (id, sku, barcode, category_id, type, weight, width, height, depth, tax_class, is_active, is_featured, sort_order) VALUES
(71, 'TAB-APP-IPAP13-256', '0194253887096', 4, 'variable', 0.617, 28.17, 21.50, 0.62, 'standard', 1, 1, 1),
(72, 'TAB-SAM-TAB-S9FE-6', '8806094854558', 4, 'simple', 0.523, 25.40, 16.56, 0.61, 'standard', 1, 1, 2),
(73, 'TAB-MIC-SURF-PRO11', 'MICSURFPRO11', 4, 'variable', 0.880, 27.80, 20.10, 0.95, 'standard', 1, 0, 3),
(74, 'TAB-LEN-TAB-P12', 'LENTABP12EU', 4, 'simple', 0.560, 26.50, 17.20, 0.65, 'standard', 1, 0, 4),
(75, 'TAB-XIA-PAD6-PRO', 'XIAPAD6PROEU', 4, 'variable', 0.590, 27.00, 17.80, 0.68, 'standard', 1, 0, 5),
(76, 'TAB-OPP-PAD-AIR', 'OPPPADAIREU', 4, 'simple', 0.510, 25.80, 16.80, 0.60, 'standard', 1, 0, 6),
(77, 'TAB-HUA-MAT-11.5', 'HUAMAT115EU', 4, 'simple', 0.545, 26.20, 17.00, 0.63, 'standard', 1, 0, 7),
(78, 'TAB-GOO-PIX-TAB-PRO', 'GOOPIXTABPRO', 4, 'variable', 0.625, 27.50, 18.00, 0.70, 'standard', 1, 0, 8),
(79, 'TAB-ASU-ZEN-PAD', 'ASUZENPADEU', 4, 'simple', 0.535, 26.00, 16.90, 0.62, 'standard', 1, 0, 9),
(80, 'TAB-ONE-PLUS-PAD2', 'ONEPLPAD2EU', 4, 'simple', 0.555, 26.40, 17.10, 0.64, 'standard', 1, 0, 10);

-- Gaming (81-90)
INSERT INTO products (id, sku, barcode, category_id, type, weight, width, height, depth, tax_class, is_active, is_featured, sort_order) VALUES
(81, 'GAM-SHR-GSN-10X', 'SHRGSNBKEU', 5, 'variable', 0.320, 18.00, 20.00, 8.00, 'standard', 1, 1, 1),
(82, 'GAM-LGT-G-PRO-X2', 'LGTGPROX2EU', 5, 'simple', 0.106, 6.24, 5.00, 2.00, 'standard', 1, 1, 2),
(83, 'GAM-RZR-HNT-V3', 'RZRHNTV3EU', 5, 'simple', 0.980, 36.54, 13.93, 3.80, 'standard', 1, 0, 3),
(84, 'GAM-XBX-SER-X-1TB', 'XBXSX1TBEU', 5, 'variable', 4.400, 30.00, 15.00, 27.00, 'standard', 1, 1, 4),
(85, 'GAM-PS5-SLIM-DISC', 'PS5SLIMDISC', 5, 'simple', 3.900, 35.00, 12.00, 26.00, 'standard', 1, 1, 5),
(86, 'GAM-NIN-SWI-OLED', 'NINSWIOLEDEU', 5, 'variable', 0.420, 24.50, 10.50, 14.00, 'standard', 1, 0, 6),
(87, 'GAM-STE-DEC-512', 'STEDEC512EU', 5, 'simple', 0.670, 29.80, 11.70, 13.00, 'standard', 1, 0, 7),
(88, 'GAM-LOG-G502-X', 'LOGG502XEU', 5, 'simple', 0.120, 13.50, 7.50, 4.00, 'standard', 1, 0, 8),
(89, 'GAM-COR-K70-RGB', 'CORK70RGBEU', 5, 'variable', 1.150, 44.00, 16.50, 3.80, 'standard', 1, 0, 9),
(90, 'GAM-HYP-CLOUD-ALP', 'HYPCLOUDALPEU', 5, 'simple', 0.310, 19.00, 17.50, 9.00, 'standard', 1, 0, 10);

-- Smart Home (91-95)
INSERT INTO products (id, sku, barcode, category_id, type, weight, width, height, depth, tax_class, is_active, is_featured, sort_order) VALUES
(91, 'SHM-PHI-HUE-STA-4', 'PHIHUESTA4EU', 6, 'simple', 0.450, 10.00, 5.00, 10.00, 'standard', 1, 1, 1),
(92, 'SHM-AMZ-ECH-DOT5', 'ECHD5GRYEU', 6, 'variable', 0.304, 9.96, 9.96, 8.91, 'standard', 1, 0, 2),
(93, 'SHM-NES-THER-4TH', 'NESTHR4EU', 6, 'simple', 0.239, 10.10, 10.10, 2.90, 'standard', 1, 1, 3),
(94, 'SHM-TPK-TAPO-C200', 'TPKTAPC200EU', 6, 'simple', 0.180, 8.50, 8.50, 11.50, 'standard', 1, 0, 4),
(95, 'SHM-ARI-AIR-QUAL', 'ARIAIRQUALEU', 6, 'variable', 0.220, 9.00, 9.00, 3.50, 'standard', 1, 0, 5);

-- Cameras (96-100)
INSERT INTO products (id, sku, barcode, category_id, type, weight, width, height, depth, tax_class, is_active, is_featured, sort_order) VALUES
(96, 'CAM-SON-A7IV-BODY', 'SONYA7IVEU', 7, 'simple', 0.658, 13.15, 9.63, 7.72, 'standard', 1, 1, 1),
(97, 'CAM-CAN-R8-BODY', 'CANR8BODY', 7, 'simple', 0.461, 13.23, 8.60, 5.92, 'standard', 1, 0, 2),
(98, 'CAM-NIK-Z6III-BDY', 'NIKZ6IIIBDY', 7, 'variable', 0.725, 14.00, 10.20, 8.10, 'standard', 1, 0, 3),
(99, 'CAM-FUJ-XS20-BODY', 'FUJXS20BODY', 7, 'simple', 0.495, 12.80, 9.20, 6.50, 'standard', 1, 0, 4),
(100, 'CAM-PAN-LUM-S5II', 'PANLUMS5II', 7, 'simple', 0.680, 13.40, 9.80, 7.90, 'standard', 1, 0, 5);

-- Product Translations (nur deutsche Namen für Demo)
DELETE FROM product_translations;

-- Smartphone translations
INSERT INTO product_translations (product_id, lang_code, name, short_description, description, meta_title, meta_description, url_slug) VALUES
(1, 'de', 'Samsung Galaxy S25 Ultra', 'Das ultimative Android-Flagship mit Galaxy AI und S Pen.', '<p>Das Galaxy S25 Ultra mit 200MP Kamera, Snapdragon 8 Elite und integriertem S Pen.</p>', 'Samsung Galaxy S25 Ultra kaufen', 'Samsung Galaxy S25 Ultra mit 200MP Kamera', 'samsung-galaxy-s25-ultra'),
(2, 'de', 'Samsung Galaxy S25', 'Kompaktes Flagship mit Top-Leistung.', '<p>Galaxy S25 im kompakten Format mit 50MP Kamera.</p>', 'Samsung Galaxy S25 kaufen', 'Samsung Galaxy S25 günstig', 'samsung-galaxy-s25'),
(3, 'de', 'Apple iPhone 16 Pro', 'Profi-iPhone mit A18 Pro und 5x Zoom.', '<p>iPhone 16 Pro mit Titanium-Design und Camera Control.</p>', 'iPhone 16 Pro kaufen', 'Apple iPhone 16 Pro bestellen', 'apple-iphone-16-pro'),
(4, 'de', 'Apple iPhone 16', 'Das meistverkaufte iPhone mit A18.', '<p>iPhone 16 mit Camera Control und langer Akkulaufzeit.</p>', 'iPhone 16 kaufen', 'Apple iPhone 16 günstig', 'apple-iphone-16'),
(5, 'de', 'Google Pixel 9 Pro', 'Bestes Kamera-Smartphone von Google.', '<p>Pixel 9 Pro mit Tensor G4 und 7 Jahren Updates.</p>', 'Google Pixel 9 Pro kaufen', 'Pixel 9 Pro mit KI-Kamera', 'google-pixel-9-pro'),
(6, 'de', 'OnePlus 12R', 'Preis-Leistungs-Sieger mit 256GB.', '<p>OnePlus 12R mit Snapdragon 8 Gen 2 und 100W Laden.</p>', 'OnePlus 12R kaufen', 'OnePlus 12R günstig', 'oneplus-12r'),
(7, 'de', 'Xiaomi 14 Pro', 'Flagship mit Leica-Kamera.', '<p>Xiaomi 14 Pro mit Snapdragon 8 Gen 3 und Leica-Optik.</p>', 'Xiaomi 14 Pro kaufen', 'Xiaomi 14 Pro Leica', 'xiaomi-14-pro'),
(8, 'de', 'Oppo Find X7', 'Premium-Smartphone mit Hasselblad.', '<p>Oppo Find X7 mit Hasselblad-Kamera und ColorOS.</p>', 'Oppo Find X7 kaufen', 'Oppo Find X7 Hasselblad', 'oppo-find-x7'),
(9, 'de', 'Vivo X100 Pro', 'Kamera-Flagship mit Zeiss.', '<p>Vivo X100 Pro mit Zeiss-Optik und V3-Chip.</p>', 'Vivo X100 Pro kaufen', 'Vivo X100 Pro Zeiss', 'vivo-x100-pro'),
(10, 'de', 'Nothing Phone (2)', 'Einzigartiges Design mit Glyph.', '<p>Nothing Phone (2) mit transparentem Design und Glyph Interface.</p>', 'Nothing Phone 2 kaufen', 'Nothing Phone 2 Glyph', 'nothing-phone-2'),
(11, 'de', 'Realme GT 2', 'Speed-Flagship zu fairem Preis.', '<p>Realme GT 2 mit Snapdragon 888 und 65W Laden.</p>', 'Realme GT 2 kaufen', 'Realme GT 2 günstig', 'realme-gt-2'),
(12, 'de', 'Motorola Edge 40', 'Stylisches Mittelklasse-Smartphone.', '<p>Moto Edge 40 mit curved Display und 68W Laden.</p>', 'Motorola Edge 40 kaufen', 'Moto Edge 40 günstig', 'motorola-edge-40'),
(13, 'de', 'Honor Magic 6 Pro', 'KI-Powerhouse mit Falkenaugen-Kamera.', '<p>Honor Magic 6 Pro mit Snapdragon 8 Gen 3 und Falcon Camera.</p>', 'Honor Magic 6 Pro kaufen', 'Honor Magic 6 Pro Kamera', 'honor-magic-6-pro'),
(14, 'de', 'Asus Zenfone 11', 'Kompakt-Powerhouse.', '<p>Asus Zenfone 11 im kompakten Format mit Top-Leistung.</p>', 'Asus Zenfone 11 kaufen', 'Asus Zenfone 11 kompakt', 'asus-zenfone-11'),
(15, 'de', 'Samsung Galaxy A55', 'Mittelklasse-Bestseller.', '<p>Galaxy A55 mit Super AMOLED und langer Update-Garantie.</p>', 'Samsung Galaxy A55 kaufen', 'Galaxy A55 Mittelklasse', 'samsung-galaxy-a55');

-- Laptop translations (16-30)
INSERT INTO product_translations (product_id, lang_code, name, short_description, description, meta_title, meta_description, url_slug) VALUES
(16, 'de', 'MacBook Air M3', 'Ultradünnes Powerbook mit M3-Chip.', '<p>MacBook Air mit M3, 8GB RAM und 256GB SSD.</p>', 'MacBook Air M3 kaufen', 'Apple MacBook Air M3', 'macbook-air-m3'),
(17, 'de', 'MacBook Pro M4', 'Profi-Laptop mit M4 Max.', '<p>MacBook Pro 16" mit M4 Max, 36GB RAM und 1TB SSD.</p>', 'MacBook Pro M4 kaufen', 'Apple MacBook Pro M4', 'macbook-pro-m4'),
(18, 'de', 'Dell XPS 15', 'Premium-Windows-Laptop.', '<p>Dell XPS 15 mit i7, 32GB RAM und RTX 4060.</p>', 'Dell XPS 15 kaufen', 'Dell XPS 15 i7', 'dell-xps-15'),
(19, 'de', 'Lenovo ThinkPad X1', 'Business-Ultrabook.', '<p>ThinkPad X1 Carbon mit i5, 16GB RAM und 512GB SSD.</p>', 'ThinkPad X1 kaufen', 'Lenovo ThinkPad X1 Carbon', 'thinkpad-x1-carbon'),
(20, 'de', 'Asus ZenBook 14', 'Elegantes Ultrabook.', '<p>ZenBook 14 mit i7, 32GB RAM und OLED-Display.</p>', 'Asus ZenBook 14 kaufen', 'Asus ZenBook 14 OLED', 'asus-zenbook-14'),
(21, 'de', 'HP Envy 15', 'Multimedia-Laptop.', '<p>HP Envy 15 mit Ryzen 7, 16GB RAM und RTX 4050.</p>', 'HP Envy 15 kaufen', 'HP Envy 15 Ryzen', 'hp-envy-15'),
(22, 'de', 'MSI Prestige 16', 'Creator-Laptop.', '<p>MSI Prestige 16 mit i9, 64GB RAM und RTX 4070.</p>', 'MSI Prestige 16 kaufen', 'MSI Prestige Creator', 'msi-prestige-16'),
(23, 'de', 'Acer Swift 3', 'Leichtgewicht für unterwegs.', '<p>Acer Swift 3 mit i5, 16GB RAM und 14" Display.</p>', 'Acer Swift 3 kaufen', 'Acer Swift 3 leicht', 'acer-swift-3'),
(24, 'de', 'Razer Blade 16', 'Gaming-Laptop Premium.', '<p>Razer Blade 16 mit i9, 32GB RAM und RTX 4080.</p>', 'Razer Blade 16 kaufen', 'Razer Blade Gaming', 'razer-blade-16'),
(25, 'de', 'Lenovo Legion Pro 5', 'Gaming-Powerhouse.', '<p>Legion Pro 5 mit Ryzen 7, 16GB RAM und RTX 4060.</p>', 'Lenovo Legion Pro 5 kaufen', 'Lenovo Legion Gaming', 'lenovo-legion-pro-5'),
(26, 'de', 'MacBook Air M2 13"', 'Beliebtes Einsteiger-MacBook.', '<p>MacBook Air M2 mit 8GB RAM und 256GB SSD.</p>', 'MacBook Air M2 kaufen', 'Apple MacBook Air M2', 'macbook-air-m2'),
(27, 'de', 'Dell Latitude 5540', 'Business-Klassiker.', '<p>Dell Latitude mit i7, 16GB RAM und Docking-Optionen.</p>', 'Dell Latitude 5540 kaufen', 'Dell Business Laptop', 'dell-latitude-5540'),
(28, 'de', 'HP ProBook 450', 'Solider Business-Laptop.', '<p>HP ProBook mit i5, 8GB RAM und 256GB SSD.</p>', 'HP ProBook 450 kaufen', 'HP Business Laptop', 'hp-probook-450'),
(29, 'de', 'Asus VivoBook S14', 'Stylischer Allrounder.', '<p>VivoBook S14 mit i7, 16GB RAM und OLED.</p>', 'Asus VivoBook S14 kaufen', 'Asus VivoBook OLED', 'asus-vivobook-s14'),
(30, 'de', 'MSI GF63 Thin', 'Einstiegs-Gaming-Laptop.', '<p>MSI GF63 mit i5, 8GB RAM und GTX 1650.</p>', 'MSI GF63 kaufen', 'MSI Gaming Einsteiger', 'msi-gf63-thin');

-- Audio translations (31-70) - nur einige Beispiele
INSERT INTO product_translations (product_id, lang_code, name, short_description, description, meta_title, meta_description, url_slug) VALUES
(31, 'de', 'Sony WH-1000XM6', 'Beste Noise-Cancelling-Kopfhörer.', '<p>Sony XM6 mit branchenführendem ANC und 30h Akku.</p>', 'Sony WH-1000XM6 kaufen', 'Sony Noise Cancelling', 'sony-wh-1000xm6'),
(32, 'de', 'Apple AirPods Max', 'Premium Over-Ear von Apple.', '<p>AirPods Max mit Spatial Audio und Transparency Mode.</p>', 'AirPods Max kaufen', 'Apple Over-Ear Kopfhörer', 'airpods-max'),
(33, 'de', 'Bose QuietComfort 45 II', 'Komfort-Champion.', '<p>Bose QC45 II mit legendärem Komfort und ANC.</p>', 'Bose QC45 II kaufen', 'Bose Quiet Comfort', 'bose-qc45-ii'),
(46, 'de', 'Apple AirPods Pro 4', 'Premium In-Ears mit ANC.', '<p>AirPods Pro 4 mit adaptivem ANC und MagSafe.</p>', 'AirPods Pro 4 kaufen', 'Apple In-Ear ANC', 'airpods-pro-4'),
(47, 'de', 'Sony WF-1000XM5', 'Beste True Wireless.', '<p>Sony XM5 Earbuds mit top ANC und LDAC.</p>', 'Sony WF-1000XM5 kaufen', 'Sony True Wireless', 'sony-wf-1000xm5'),
(61, 'de', 'Sonos Roam XL', 'Premium Bluetooth-Lautsprecher.', '<p>Sonos Roam XL mit WiFi, Bluetooth und Alexa.</p>', 'Sonos Roam XL kaufen', 'Sonos Bluetooth Speaker', 'sonos-roam-xl'),
(62, 'de', 'Bose SoundLink 300', 'Kraftvoller Begleiter.', '<p>Bose SoundLink 300 mit 360° Sound und 15h Akku.</p>', 'Bose SoundLink 300 kaufen', 'Bose Portable Speaker', 'bose-soundlink-300');

-- Tablet translations (71-80)
INSERT INTO product_translations (product_id, lang_code, name, short_description, description, meta_title, meta_description, url_slug) VALUES
(71, 'de', 'iPad Pro 13" M4', 'Ultimatives Tablet mit M4.', '<p>iPad Pro 13" mit M4-Chip, OLED und 256GB.</p>', 'iPad Pro 13 M4 kaufen', 'Apple iPad Pro M4', 'ipad-pro-13-m4'),
(72, 'de', 'Samsung Tab S9 FE', 'Android-Tablet mit S Pen.', '<p>Tab S9 FE mit 128GB, S Pen inklusive.</p>', 'Samsung Tab S9 FE kaufen', 'Samsung Tablet S Pen', 'samsung-tab-s9-fe'),
(73, 'de', 'Microsoft Surface Pro 11', '2-in-1 für Profis.', '<p>Surface Pro 11 mit Snapdragon X Elite und Keyboard.</p>', 'Surface Pro 11 kaufen', 'Microsoft 2-in-1 Tablet', 'surface-pro-11'),
(74, 'de', 'Lenovo Tab P12', 'Großes Display für wenig Geld.', '<p>Lenovo Tab P12 mit 12,7" und Precision Pen.</p>', 'Lenovo Tab P12 kaufen', 'Lenovo Großes Tablet', 'lenovo-tab-p12'),
(75, 'de', 'Xiaomi Pad 6 Pro', 'Preis-Leistungs-Tipp.', '<p>Xiaomi Pad 6 Pro mit Snapdragon 8+ und 144Hz.</p>', 'Xiaomi Pad 6 Pro kaufen', 'Xiaomi Tablet günstig', 'xiaomi-pad-6-pro');

-- Gaming translations (81-90)
INSERT INTO product_translations (product_id, lang_code, name, short_description, description, meta_title, meta_description, url_slug) VALUES
(81, 'de', 'Nintendo Switch OLED', 'Hybrid-Konsole mit OLED.', '<p>Switch OLED mit verbessertem Display und 64GB.</p>', 'Switch OLED kaufen', 'Nintendo Switch OLED', 'switch-oled'),
(82, 'de', 'Logitech G Pro X2', 'Profi-Gaming-Headset.', '<p>G Pro X2 mit Graphene Drivers und DTS:X.</p>', 'Logitech G Pro X2 kaufen', 'Logitech Gaming Headset', 'logitech-g-pro-x2'),
(83, 'de', 'Razer Huntsman V3', 'Mechanische Tastatur.', '<p>Huntsman V3 mit Optical Switches und RGB.</p>', 'Razer Huntsman V3 kaufen', 'Razer Mechanische Tastatur', 'razer-huntsman-v3'),
(84, 'de', 'Xbox Series X', 'Next-Gen Gaming.', '<p>Xbox Series X mit 1TB SSD und 4K Gaming.</p>', 'Xbox Series X kaufen', 'Microsoft Xbox Konsole', 'xbox-series-x'),
(85, 'de', 'PlayStation 5 Slim', 'Sony Next-Gen.', '<p>PS5 Slim mit Disc-Laufwerk und 1TB SSD.</p>', 'PS5 Slim kaufen', 'Sony PlayStation 5', 'ps5-slim'),
(86, 'de', 'Steam Deck 512GB', 'PC-Gaming unterwegs.', '<p>Steam Deck mit 512GB NVMe und Anti-Glare.</p>', 'Steam Deck kaufen', 'Valve Handheld Konsole', 'steam-deck-512gb');

-- Smart Home translations (91-95)
INSERT INTO product_translations (product_id, lang_code, name, short_description, description, meta_title, meta_description, url_slug) VALUES
(91, 'de', 'Philips Hue Starter Kit', 'Smart Lighting Einstieg.', '<p>Hue Starter Kit mit 4 Lampen und Bridge.</p>', 'Philips Hue kaufen', 'Philips Hue Starter Set', 'philips-hue-starter'),
(92, 'de', 'Amazon Echo Dot 5', 'Smarter Lautsprecher.', '<p>Echo Dot 5 mit Alexa und verbessertem Sound.</p>', 'Echo Dot 5 kaufen', 'Amazon Alexa Lautsprecher', 'echo-dot-5'),
(93, 'de', 'Google Nest Thermostat', 'Intelligentes Heizen.', '<p>Nest Thermostat der 4. Generation mit Energiesparfunktionen.</p>', 'Nest Thermostat kaufen', 'Google Smart Thermostat', 'nest-thermostat-4'),
(94, 'de', 'TP-Link Tapo C200', 'Überwachungskamera.', '<p>Tapo C200 mit 360° Schwenkung und Nachtsicht.</p>', 'Tapo C200 kaufen', 'TP-Link WLAN Kamera', 'tapo-c200'),
(95, 'de', 'Aria Air Quality', 'Luftqualität messen.', '<p>Aria Sensor für Temperatur, Luftfeuchtigkeit und CO2.</p>', 'Aria Air Quality kaufen', 'Luftqualität Sensor', 'aria-air-quality');

-- Camera translations (96-100)
INSERT INTO product_translations (product_id, lang_code, name, short_description, description, meta_title, meta_description, url_slug) VALUES
(96, 'de', 'Sony Alpha 7 IV', 'Vollformat-Kamera für alle.', '<p>Sony A7 IV mit 33MP, 4K 60fps und Hybrid-AF.</p>', 'Sony A7 IV kaufen', 'Sony Vollformat Kamera', 'sony-alpha-7-iv'),
(97, 'de', 'Canon EOS R8', 'Leichte Vollformat-Kamera.', '<p>Canon R8 mit 24MP, 4K 60fps und Dual Pixel AF.</p>', 'Canon EOS R8 kaufen', 'Canon Vollformat spiegellos', 'canon-eos-r8'),
(98, 'de', 'Nikon Z6 III', 'Allround-Vollformat.', '<p>Nikon Z6 III mit 24MP, 6K Video und 5-Achsen-IBIS.</p>', 'Nikon Z6 III kaufen', 'Nikon Vollformat Kamera', 'nikon-z6-iii'),
(99, 'de', 'Fujifilm X-S20', 'APS-C mit Film-Simulation.', '<p>Fujifilm X-S20 mit 26MP, 6.2K Video und Classic Neg.</p>', 'Fujifilm X-S20 kaufen', 'Fuji APS-C Kamera', 'fujifilm-x-s20'),
(100, 'de', 'Panasonic Lumix S5 II', 'Video-Vollformat.', '<p>Panasonic S5 II mit 24MP, 6K Video und Phase-Hybrid-AF.</p>', 'Panasonic S5 II kaufen', 'Panasonic Vollformat Video', 'panasonic-lumix-s5-ii');

-- Fehlende Produkte ohne Translation füllen (generische Namen)
-- Für die restlichen Produkte (8-15, 21-30, 34-45, 48-60, 63-70, 76-80, 87-90, 94-95) generische Einträge
-- Dies wird durch einen Loop in echtem System gemacht, hier manuell vereinfacht

-- ─────────────────────────────────────────────
--  PRODUCT VARIANTS (für variable Produkte)
-- ─────────────────────────────────────────────
DELETE FROM product_variants;

-- Smartphone variants
INSERT INTO product_variants (id, product_id, sku, variant_type, variant_value, price, compare_price, cost, is_default, is_active, sort_order) VALUES
-- iPhone 16 Pro variants
(1, 3, 'SPH-APP-IP16P-256-BLK', 'color', 'black', 1149.00, 1249.00, 850.00, 1, 1, 1),
(2, 3, 'SPH-APP-IP16P-512-BLK', 'storage', '512gb', 1349.00, 1449.00, 980.00, 0, 1, 2),
(3, 3, 'SPH-APP-IP16P-1TB-BLK', 'storage', '1tb', 1549.00, 1649.00, 1120.00, 0, 1, 3),
-- Samsung S25 Ultra variants
(4, 1, 'SPH-SAM-S25U-256-GRY', 'color', 'gray', 1299.00, 1399.00, 920.00, 1, 1, 1),
(5, 1, 'SPH-SAM-S25U-512-GRY', 'storage', '512gb', 1449.00, 1549.00, 1050.00, 0, 1, 2),
-- MacBook Air M3 variants
(6, 16, 'LPT-APP-MBA-M3-8-256', 'storage', '256gb', 1199.00, 1299.00, 880.00, 1, 1, 1),
(7, 16, 'LPT-APP-MBA-M3-8-512', 'storage', '512gb', 1449.00, 1549.00, 1050.00, 0, 1, 2),
-- Sony Headphones variants
(8, 31, 'AUD-SNY-WH1000XM6-BLK', 'color', 'black', 349.00, 399.00, 220.00, 1, 1, 1),
(9, 31, 'AUD-SNY-WH1000XM6-SLV', 'color', 'silver', 349.00, 399.00, 220.00, 0, 1, 2);

-- ─────────────────────────────────────────────
--  PRODUCT PRICES & STOCK (Demo Branch)
-- ─────────────────────────────────────────────
DELETE FROM product_branch_prices;
DELETE FROM product_branch_stock;

-- Preise für alle 100 Produkte (Branch 1)
INSERT INTO product_branch_prices (product_id, branch_id, price, compare_price, cost, price_group, is_active, valid_from, valid_to)
SELECT id, 1, 
       CASE 
         WHEN id <= 15 THEN 699.00 + (id * 50)  -- Smartphones 749-1449
         WHEN id <= 30 THEN 899.00 + ((id-15) * 100)  -- Laptops 999-2399
         WHEN id <= 45 THEN 199.00 + ((id-30) * 20)  -- Headphones 219-499
         WHEN id <= 60 THEN 99.00 + ((id-45) * 15)  -- Earbuds 114-324
         WHEN id <= 70 THEN 49.00 + ((id-60) * 30)  -- Speakers 79-349
         WHEN id <= 80 THEN 399.00 + ((id-70) * 100)  -- Tablets 499-1399
         WHEN id <= 90 THEN 29.00 + ((id-80) * 50)  -- Gaming 79-529
         WHEN id <= 95 THEN 39.00 + ((id-90) * 40)  -- Smart Home 79-239
         ELSE 799.00 + ((id-95) * 200)  -- Cameras 999-1799
       END,
       CASE 
         WHEN id <= 15 THEN 799.00 + (id * 60)
         WHEN id <= 30 THEN 1099.00 + ((id-15) * 120)
         WHEN id <= 45 THEN 249.00 + ((id-30) * 25)
         WHEN id <= 60 THEN 129.00 + ((id-45) * 20)
         WHEN id <= 70 THEN 69.00 + ((id-60) * 40)
         WHEN id <= 80 THEN 499.00 + ((id-70) * 120)
         WHEN id <= 90 THEN 49.00 + ((id-80) * 60)
         WHEN id <= 95 THEN 59.00 + ((id-90) * 50)
         ELSE 999.00 + ((id-95) * 250)
       END,
       CASE 
         WHEN id <= 15 THEN 500.00 + (id * 35)
         WHEN id <= 30 THEN 650.00 + ((id-15) * 70)
         WHEN id <= 45 THEN 140.00 + ((id-30) * 15)
         WHEN id <= 60 THEN 70.00 + ((id-45) * 10)
         WHEN id <= 70 THEN 35.00 + ((id-60) * 20)
         WHEN id <= 80 THEN 280.00 + ((id-70) * 70)
         WHEN id <= 90 THEN 20.00 + ((id-80) * 35)
         WHEN id <= 95 THEN 28.00 + ((id-90) * 28)
         ELSE 560.00 + ((id-95) * 140)
       END,
       'standard', 1, CURDATE(), DATE_ADD(CURDATE(), INTERVAL 1 YEAR)
FROM products WHERE id BETWEEN 1 AND 100;

-- Stock für alle 100 Produkte (Branch 1)
INSERT INTO product_branch_stock (product_id, branch_id, stock_quantity, reserved_quantity, low_stock_threshold, track_inventory, allow_backorder)
SELECT id, 1, 
       FLOOR(50 + RAND() * 200),  -- 50-250 units random
       FLOOR(RAND() * 20),  -- 0-19 reserved
       10,  -- Low stock threshold
       1,   -- Track inventory
       0    -- No backorder
FROM products WHERE id BETWEEN 1 AND 100;

-- ─────────────────────────────────────────────
--  DEMO ORDERS
-- ─────────────────────────────────────────────
DELETE FROM orders;
DELETE FROM order_items;
DELETE FROM order_status_history;

-- 5 Demo-Bestellungen (eine pro Kunde)
INSERT INTO orders (id, branch_id, customer_id, order_number, status, subtotal, discount_total, shipping_cost, tax_total, total, currency, payment_method, payment_status, shipping_method, billing_first_name, billing_last_name, billing_company, billing_street, billing_city, billing_postal_code, billing_country, shipping_first_name, shipping_last_name, shipping_company, shipping_street, shipping_city, shipping_postal_code, shipping_country, notes, created_at) VALUES
(1, 1, 1, 'DEMO-2025-0001', 'completed', 1149.00, 0.00, 4.90, 219.24, 1373.14, 'EUR', 'credit_card', 'paid', 'standard', 'Max', 'Mustermann', NULL, 'Musterstraße 12a', 'Berlin', '10115', 'DE', 'Max', 'Mustermann', NULL, 'Musterstraße 12a', 'Berlin', '10115', 'DE', 'Erste Demo-Bestellung', DATE_SUB(NOW(), INTERVAL 5 DAY)),
(2, 1, 2, 'DEMO-2025-0002', 'processing', 349.00, 20.00, 0.00, 62.43, 391.43, 'EUR', 'paypal', 'paid', 'pickup', 'Julia', 'Schmidt', NULL, 'Schmidtweg 45', 'München', '80331', 'DE', 'Julia', 'Schmidt', NULL, 'Schmidtweg 45', 'München', '80331', 'DE', 'Abholung geplant', DATE_SUB(NOW(), INTERVAL 2 DAY)),
(3, 1, 3, 'DEMO-2025-0003', 'shipped', 2398.00, 100.00, 0.00, 437.52, 2735.52, 'EUR', 'invoice', 'pending', 'express', 'Thomas', 'Weber', 'Tech GmbH', 'Industriestraße 88', 'Hamburg', '20095', 'DE', 'Thomas', 'Weber', 'Tech GmbH', 'Lieferstraße 99', 'Hamburg', '20095', 'DE', 'Firmenbestellung mit Rechnung', DATE_SUB(NOW(), INTERVAL 3 DAY)),
(4, 1, 4, 'DEMO-2025-0004', 'pending', 799.00, 0.00, 4.90, 152.76, 956.66, 'EUR', 'credit_card', 'pending', 'standard', 'Sarah', 'Fischer', NULL, 'Fischerplatz 7', 'Frankfurt', '60311', 'DE', 'Sarah', 'Fischer', NULL, 'Fischerplatz 7', 'Frankfurt', '60311', 'DE', NULL, NOW()),
(5, 1, 5, 'DEMO-2025-0005', 'completed', 1899.00, 50.00, 0.00, 351.62, 2200.62, 'EUR', 'bank_transfer', 'paid', 'express', 'Michael', 'Becker', 'Startup Solutions UG', 'Gründerallee 1', 'Köln', '50667', 'DE', 'Michael', 'Becker', 'Startup Solutions UG', 'Versandweg 23', 'Köln', '50667', 'DE', 'Startup Equipment', DATE_SUB(NOW(), INTERVAL 7 DAY));

-- Order Items
INSERT INTO order_items (id, order_id, product_id, product_name, variant_id, quantity, unit_price, discount, tax_rate, tax_amount, total) VALUES
(1, 1, 3, 'Apple iPhone 16 Pro', 1, 1, 1149.00, 0.00, 19.00, 218.31, 1149.00),
(2, 2, 31, 'Sony WH-1000XM6', 8, 1, 349.00, 20.00, 19.00, 62.43, 329.00),
(3, 3, 17, 'MacBook Pro M4', 6, 1, 2398.00, 100.00, 19.00, 437.52, 2298.00),
(4, 4, 96, 'Sony Alpha 7 IV', NULL, 1, 799.00, 0.00, 19.00, 151.81, 799.00),
(5, 5, 18, 'Dell XPS 15', NULL, 1, 1899.00, 50.00, 19.00, 351.62, 1849.00);

-- Order Status History
INSERT INTO order_status_history (order_id, status, notes, changed_by, created_at) VALUES
(1, 'pending', 'Bestellung eingegangen', NULL, DATE_SUB(NOW(), INTERVAL 5 DAY)),
(1, 'processing', 'Zahlung bestätigt', NULL, DATE_SUB(NOW(), INTERVAL 5 DAY, HOUR 2)),
(1, 'shipped', 'Versendet mit DHL', NULL, DATE_SUB(NOW(), INTERVAL 4 DAY)),
(1, 'completed', 'Zugestellt', NULL, DATE_SUB(NOW(), INTERVAL 3 DAY)),
(2, 'pending', 'Bestellung eingegangen', NULL, DATE_SUB(NOW(), INTERVAL 2 DAY)),
(2, 'processing', 'Zahlung bestätigt - Abholung vorbereitet', NULL, DATE_SUB(NOW(), INTERVAL 1 DAY)),
(3, 'pending', 'Bestellung eingegangen', NULL, DATE_SUB(NOW(), INTERVAL 3 DAY)),
(3, 'processing', 'Rechnung erstellt', NULL, DATE_SUB(NOW(), INTERVAL 3 DAY, HOUR 4)),
(3, 'shipped', 'Mit UPS versendet', NULL, DATE_SUB(NOW(), INTERVAL 2 DAY)),
(4, 'pending', 'Bestellung eingegangen - Zahlung ausstehend', NULL, NOW()),
(5, 'pending', 'Bestellung eingegangen', NULL, DATE_SUB(NOW(), INTERVAL 7 DAY)),
(5, 'processing', 'Banküberweisung erhalten', NULL, DATE_SUB(NOW(), INTERVAL 6 DAY)),
(5, 'shipped', 'Mit FedEx versendet', NULL, DATE_SUB(NOW(), INTERVAL 5 DAY)),
(5, 'completed', 'Zugestellt', NULL, DATE_SUB(NOW(), INTERVAL 4 DAY));

-- ─────────────────────────────────────────────
--  CARTS (Demo Warenkörbe)
-- ─────────────────────────────────────────────
DELETE FROM carts;

INSERT INTO carts (id, branch_id, customer_id, session_id, status, subtotal, discount_total, tax_total, total, currency, expires_at, created_at, updated_at) VALUES
(1, 1, 1, NULL, 'active', 349.00, 0.00, 66.31, 415.31, 'EUR', DATE_ADD(NOW(), INTERVAL 7 DAY), DATE_SUB(NOW(), INTERVAL 1 DAY), NOW()),
(2, 1, 4, NULL, 'active', 1299.00, 50.00, 237.31, 1486.31, 'EUR', DATE_ADD(NOW(), INTERVAL 7 DAY), NOW(), NOW());

-- Cart items würden normalerweise über Cart-Modell verwaltet werden

-- ─────────────────────────────────────────────
--  CMS PAGES (Demo)
-- ─────────────────────────────────────────────
DELETE FROM pages;
DELETE FROM page_blocks;

INSERT INTO pages (id, template, is_active, meta_title, meta_description, created_at, updated_at) VALUES
(1, 'home', 1, 'TechStore Demo - Elektronik Online Shop', 'Entdecken Sie die neuesten Smartphones, Laptops und mehr!', NOW(), NOW()),
(2, 'about', 1, 'Über TechStore', 'Ihr vertrauenswürdiger Partner für Elektronik.', NOW(), NOW()),
(3, 'contact', 1, 'Kontakt', 'So erreichen Sie uns.', NOW(), NOW()),
(4, 'impressum', 1, 'Impressum', 'Rechtliche Angaben.', NOW(), NOW()),
(5, 'datenschutz', 1, 'Datenschutz', 'Unsere Datenschutzrichtlinien.', NOW(), NOW());

INSERT INTO page_blocks (id, page_id, block_type, title, content, sort_order, settings) VALUES
(1, 1, 'hero', 'Willkommen bei TechStore Demo', '<h1>Die besten Elektronik-Produkte</h1><p>Entdecken Sie unser Sortiment!</p>', 1, '{"background_image":"/images/hero-bg.jpg"}'),
(2, 1, 'featured_products', 'Unsere Bestseller', '', 2, '{"limit":8}'),
(3, 1, 'categories', 'Kategorien', '', 3, '{"show_all":true}'),
(4, 2, 'content', 'Über uns', '<p>TechStore ist Ihr Partner für hochwertige Elektronik.</p>', 1, NULL),
(5, 3, 'contact_form', 'Kontaktformular', '', 1, '{"email":"demo@techstore.com"}'),
(6, 4, 'content', 'Impressum', '<p>TechStore Demo GmbH<br>Demo Straße 1<br>10115 Berlin</p>', 1, NULL),
(7, 5, 'content', 'Datenschutz', '<p>Ihre Daten sind bei uns sicher.</p>', 1, NULL);

-- ─────────────────────────────────────────────
--  MENUS
-- ─────────────────────────────────────────────
DELETE FROM menus;
DELETE FROM menu_items;

INSERT INTO menus (id, name, location, is_active) VALUES
(1, 'Main Menu', 'header', 1),
(2, 'Footer Menu', 'footer', 1);

INSERT INTO menu_items (id, menu_id, parent_id, type, link, label, sort_order, is_active, icon, target) VALUES
(1, 1, NULL, 'category', '/category/smartphones', 'Smartphones', 1, 1, 'smartphone', '_self'),
(2, 1, NULL, 'category', '/category/laptops', 'Laptops', 2, 1, 'laptop', '_self'),
(3, 1, NULL, 'category', '/category/audio', 'Audio', 3, 1, 'headphones', '_self'),
(4, 1, NULL, 'category', '/category/tablets', 'Tablets', 4, 1, 'tablet', '_self'),
(5, 1, NULL, 'category', '/category/gaming', 'Gaming', 5, 1, 'gamepad', '_self'),
(6, 1, NULL, 'page', '/about', 'Über uns', 6, 1, 'info', '_self'),
(7, 1, NULL, 'page', '/contact', 'Kontakt', 7, 1, 'mail', '_self'),
(8, 2, NULL, 'page', '/impressum', 'Impressum', 1, 1, NULL, '_self'),
(9, 2, NULL, 'page', '/datenschutz', 'Datenschutz', 2, 1, NULL, '_self');

-- ─────────────────────────────────────────────
--  REVIEWS (Demo)
-- ─────────────────────────────────────────────
DELETE FROM product_reviews;

INSERT INTO product_reviews (id, product_id, customer_id, rating, title, comment, is_verified_purchase, is_approved, approved_at, helpful_count, created_at) VALUES
(1, 1, 1, 5, 'Bestes Smartphone ever!', 'Das S25 Ultra ist einfach fantastisch. Kamera ist der Wahnsinn!', 1, 1, NOW(), 12, DATE_SUB(NOW(), INTERVAL 10 DAY)),
(2, 3, 2, 5, 'Perfektes iPhone', 'Upgrade von iPhone 14 - lohnt sich! Kamera ist deutlich besser.', 1, 1, NOW(), 8, DATE_SUB(NOW(), INTERVAL 8 DAY)),
(3, 16, 3, 4, 'Sehr gut, aber teuer', 'MBA M3 ist super schnell, aber der Preis ist hoch.', 1, 1, NOW(), 5, DATE_SUB(NOW(), INTERVAL 12 DAY)),
(4, 31, 4, 5, 'Beste Noise Cancelling', 'Sony XM6 overear ist ungeschlagen im ANC.', 1, 1, NOW(), 15, DATE_SUB(NOW(), INTERVAL 6 DAY)),
(5, 46, 5, 4, 'Gute Earbuds', 'AirPods Pro 4 sind sehr gut, aber nicht perfekt.', 1, 1, NOW(), 3, DATE_SUB(NOW(), INTERVAL 4 DAY)),
(6, 85, 1, 5, 'Endlich PS5!', 'Nach langer Wartezeit endlich bekommen. Läuft super!', 1, 1, NOW(), 20, DATE_SUB(NOW(), INTERVAL 15 DAY)),
(7, 96, 2, 5, 'Traumkamera', 'Sony A7 IV erfüllt alle meine Erwartungen.', 0, 1, NOW(), 7, DATE_SUB(NOW(), INTERVAL 20 DAY));

-- ─────────────────────────────────────────────
--  ACTIVITY LOGS (Demo)
-- ─────────────────────────────────────────────
DELETE FROM activity_logs;

INSERT INTO activity_logs (id, user_type, user_id, action, entity_type, entity_id, description, ip_address, user_agent, created_at) VALUES
(1, 'customer', 1, 'login', 'customer', 1, 'Max Mustermann logged in', '192.168.1.100', 'Mozilla/5.0...', DATE_SUB(NOW(), INTERVAL 1 DAY)),
(2, 'customer', 1, 'order_created', 'order', 1, 'Order DEMO-2025-0001 created', '192.168.1.100', 'Mozilla/5.0...', DATE_SUB(NOW(), INTERVAL 5 DAY)),
(3, 'customer', 3, 'login', 'customer', 3, 'Thomas Weber logged in', '192.168.1.105', 'Mozilla/5.0...', DATE_SUB(NOW(), INTERVAL 3 DAY)),
(4, 'customer', 3, 'order_created', 'order', 3, 'Order DEMO-2025-0003 created', '192.168.1.105', 'Mozilla/5.0...', DATE_SUB(NOW(), INTERVAL 3 DAY)),
(5, 'admin', 1, 'login', 'admin_user', 1, 'Admin logged in', '192.168.1.1', 'Mozilla/5.0...', NOW()),
(6, 'customer', 5, 'order_created', 'order', 5, 'Order DEMO-2025-0005 created', '192.168.1.110', 'Mozilla/5.0...', DATE_SUB(NOW(), INTERVAL 7 DAY));

-- ─────────────────────────────────────────────
--  THEME SETTINGS
-- ─────────────────────────────────────────────
DELETE FROM theme_settings;

INSERT INTO theme_settings (id, theme_name, setting_key, setting_value, type, is_active) VALUES
(1, 'default', 'site_name', 'TechStore Demo', 'text', 1),
(2, 'default', 'primary_color', '#3B82F6', 'color', 1),
(3, 'default', 'secondary_color', '#10B981', 'color', 1),
(4, 'default', 'logo_url', '/images/logo.png', 'image', 1),
(5, 'default', 'favicon_url', '/images/favicon.ico', 'image', 1),
(6, 'default', 'show_newsletter', '1', 'boolean', 1),
(7, 'default', 'currency_symbol', '€', 'text', 1),
(8, 'default', 'tax_included', '1', 'boolean', 1);

-- ─────────────────────────────────────────────
--  CAMPAIGNS (Demo Aktionen)
-- ─────────────────────────────────────────────
DELETE FROM campaigns;

INSERT INTO campaigns (id, name, type, discount_type, discount_value, min_order_amount, max_discount, start_date, end_date, is_active, applicable_categories, applicable_products) VALUES
(1, 'Frühjahrs-Sale', 'percentage', 'percent', 15, 50.00, 100.00, CURDATE(), DATE_ADD(CURDATE(), INTERVAL 30 DAY), 1, '[1,2,3]', NULL),
(2, 'Neukunden-Rabatt', 'fixed', 'fixed', 20, 100.00, 20.00, CURDATE(), DATE_ADD(CURDATE(), INTERVAL 60 DAY), 1, NULL, NULL),
(3, 'Gaming Week', 'percentage', 'percent', 10, 0.00, 50.00, CURDATE(), DATE_ADD(CURDATE(), INTERVAL 14 DAY), 1, '[5]', NULL);

-- ─────────────────────────────────────────────
--  TRANSLATIONS (UI Texts)
-- ─────────────────────────────────────────────
DELETE FROM translations;

INSERT INTO translations (id, lang_code, translation_key, translation_value, context, created_at) VALUES
(1, 'de', 'add_to_cart', 'In den Warenkorb', 'button', NOW()),
(2, 'de', 'buy_now', 'Jetzt kaufen', 'button', NOW()),
(3, 'de', 'checkout', 'Zur Kasse', 'button', NOW()),
(4, 'de', 'login', 'Anmelden', 'button', NOW()),
(5, 'de', 'register', 'Registrieren', 'button', NOW()),
(6, 'de', 'welcome', 'Willkommen bei TechStore', 'heading', NOW()),
(7, 'de', 'featured_products', 'Empfohlene Produkte', 'heading', NOW()),
(8, 'de', 'new_arrivals', 'Neuheiten', 'heading', NOW()),
(9, 'en', 'add_to_cart', 'Add to Cart', 'button', NOW()),
(10, 'en', 'buy_now', 'Buy Now', 'button', NOW()),
(11, 'en', 'checkout', 'Checkout', 'button', NOW()),
(12, 'en', 'login', 'Login', 'button', NOW()),
(13, 'en', 'register', 'Register', 'button', NOW()),
(14, 'en', 'welcome', 'Welcome to TechStore', 'heading', NOW()),
(15, 'en', 'featured_products', 'Featured Products', 'heading', NOW()),
(16, 'en', 'new_arrivals', 'New Arrivals', 'heading', NOW());

SET FOREIGN_KEY_CHECKS = 1;

-- ─────────────────────────────────────────────
--  ZUSAMMENFASSUNG ANZEIGEN
-- ─────────────────────────────────────────────
SELECT '========================================' AS '';
SELECT 'DEMO DATABASE SUCCESSFULLY CREATED!' AS '';
SELECT '========================================' AS '';
SELECT '' AS '';
SELECT 'Tables populated:' AS 'Summary';
SELECT 'languages' AS table_name, COUNT(*) AS records FROM languages UNION ALL
SELECT 'branches', COUNT(*) FROM branches UNION ALL
SELECT 'roles', COUNT(*) FROM roles UNION ALL
SELECT 'admin_users', COUNT(*) FROM admin_users UNION ALL
SELECT 'customers', COUNT(*) FROM customers UNION ALL
SELECT 'addresses', COUNT(*) FROM addresses UNION ALL
SELECT 'company_documents', COUNT(*) FROM company_documents UNION ALL
SELECT 'categories', COUNT(*) FROM categories UNION ALL
SELECT 'products', COUNT(*) FROM products UNION ALL
SELECT 'product_translations', COUNT(*) FROM product_translations UNION ALL
SELECT 'product_variants', COUNT(*) FROM product_variants UNION ALL
SELECT 'product_branch_prices', COUNT(*) FROM product_branch_prices UNION ALL
SELECT 'product_branch_stock', COUNT(*) FROM product_branch_stock UNION ALL
SELECT 'orders', COUNT(*) FROM orders UNION ALL
SELECT 'order_items', COUNT(*) FROM order_items UNION ALL
SELECT 'carts', COUNT(*) FROM carts UNION ALL
SELECT 'pages', COUNT(*) FROM pages UNION ALL
SELECT 'menus', COUNT(*) FROM menus UNION ALL
SELECT 'product_reviews', COUNT(*) FROM product_reviews UNION ALL
SELECT 'campaigns', COUNT(*) FROM campaigns;

SELECT '' AS '';
SELECT 'Demo Credentials:' AS '';
SELECT '----------------------------------------' AS '';
SELECT 'ADMIN LOGIN:' AS '';
SELECT 'Email: admin@techstore-demo.com' AS '';
SELECT 'Password: Admin1234!' AS '';
SELECT '' AS '';
SELECT 'CUSTOMER LOGINS:' AS '';
SELECT '1. max.mustermann@demo.de / Kunde1234!' AS '';
SELECT '2. julia.schmidt@demo.de / Kunde1234!' AS '';
SELECT '3. t.weber@techgmbh-demo.de / Kunde1234!' AS '';
SELECT '4. sarah.fischer@demo.de / Kunde1234!' AS '';
SELECT '5. m.becker@startup-demo.de / Kunde1234!' AS '';
SELECT '----------------------------------------' AS '';
