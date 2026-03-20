-- ============================================================
--  SEED DATA — PART 1
--  Branches · Admin Users · Customers · Categories
-- ============================================================
SET FOREIGN_KEY_CHECKS = 0;
SET NAMES utf8mb4;

-- ─────────────────────────────────────────────
--  LANGUAGES (already seeded in schema, refresh)
-- ─────────────────────────────────────────────
DELETE FROM languages;
INSERT INTO languages (id, code, name, locale, flag, is_default, is_active, sort_order) VALUES
(1, 'de', 'Deutsch',    'de_DE', '🇩🇪', 1, 1, 0),
(2, 'en', 'English',    'en_US', '🇬🇧', 0, 1, 1),
(3, 'fr', 'Français',   'fr_FR', '🇫🇷', 0, 1, 2),
(4, 'nl', 'Nederlands', 'nl_NL', '🇳🇱', 0, 0, 3);

-- ─────────────────────────────────────────────
--  BRANCHES
-- ─────────────────────────────────────────────
DELETE FROM branches;
INSERT INTO branches (id, name, slug, domain, subdomain, email, phone, address, city, postal_code, country_code, currency_code, tax_rate, timezone, is_active, settings) VALUES
(1, 'Hauptfiliale Köln',    'koeln',    'koeln.techstore.de',    'koeln',    'koeln@techstore.de',    '+49 221 987654',  'Schildergasse 12',          'Köln',      '50667', 'DE', 'EUR', 19.00, 'Europe/Berlin',    1, '{"theme":"default","show_pickup":true}'),
(2, 'Filiale Berlin',       'berlin',   'berlin.techstore.de',   'berlin',   'berlin@techstore.de',   '+49 30 112233',   'Kurfürstendamm 85',         'Berlin',    '10709', 'DE', 'EUR', 19.00, 'Europe/Berlin',    1, '{"theme":"default","show_pickup":true}'),
(3, 'Filiale München',      'muenchen', 'muenchen.techstore.de', 'muenchen', 'muenchen@techstore.de', '+49 89 445566',   'Kaufingerstraße 22',        'München',   '80331', 'DE', 'EUR', 19.00, 'Europe/Berlin',    1, '{"theme":"default","show_pickup":true}'),
(4, 'Filiale Hamburg',      'hamburg',  'hamburg.techstore.de',  'hamburg',  'hamburg@techstore.de',  '+49 40 334455',   'Mönckebergstraße 7',        'Hamburg',   '20095', 'DE', 'EUR', 19.00, 'Europe/Berlin',    1, '{"theme":"default","show_pickup":true}'),
(5, 'Online Shop (AT)',     'austria',  'at.techstore.de',       'austria',  'at@techstore.de',       '+43 1 5556677',   'Mariahilfer Straße 99',     'Wien',      '1060',  'AT', 'EUR', 20.00, 'Europe/Vienna',    1, '{"theme":"minimal","show_pickup":false}');

DELETE FROM branch_delivery_settings;
INSERT INTO branch_delivery_settings (branch_id, allows_pickup, allows_shipping, free_shipping_from, min_order_amount, shipping_cost, estimated_days_min, estimated_days_max, pickup_instructions) VALUES
(1, 1, 1, 49.00,  0.00, 4.90, 1, 3, 'Abholung Mo–Sa 9–20 Uhr. Bitte Bestellnummer und Ausweis mitbringen.'),
(2, 1, 1, 49.00,  0.00, 4.90, 1, 3, 'Abholung Mo–Sa 10–20 Uhr, So 12–18 Uhr.'),
(3, 1, 1, 59.00,  0.00, 5.90, 1, 3, 'Abholung Mo–Sa 9–20 Uhr.'),
(4, 1, 1, 49.00,  0.00, 4.90, 1, 2, 'Abholung Mo–Sa 10–20 Uhr.'),
(5, 0, 1, 69.00, 10.00, 6.90, 2, 5, NULL);

-- ─────────────────────────────────────────────
--  ROLES
-- ─────────────────────────────────────────────
DELETE FROM roles;
INSERT INTO roles (id, name, permissions) VALUES
(1, 'superadmin',     '{"all":true}'),
(2, 'admin',          '{"products":"rw","orders":"rw","customers":"rw","cms":"rw","campaigns":"rw","branches":"r"}'),
(3, 'branch_manager', '{"orders":"rw","stock":"rw","customers":"r","campaigns":"r"}'),
(4, 'editor',         '{"products":"rw","cms":"rw","categories":"rw"}');

-- ─────────────────────────────────────────────
--  ADMIN USERS
-- ─────────────────────────────────────────────
DELETE FROM admin_users;
-- Passwords: all are 'Admin1234!' bcrypt-hashed
INSERT INTO admin_users (id, branch_id, role_id, first_name, last_name, email, password_hash, is_active, last_login_at) VALUES
(1, NULL, 1, 'System',    'Administrator', 'admin@techstore.de',           '$2y$12$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 1, '2025-03-19 09:00:00'),
(2, NULL, 2, 'Klaus',     'Bergmann',      'k.bergmann@techstore.de',      '$2y$12$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 1, '2025-03-18 14:22:00'),
(3, 1,    3, 'Sabine',    'Müller',        's.mueller.koeln@techstore.de', '$2y$12$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 1, '2025-03-19 08:15:00'),
(4, 2,    3, 'Thomas',    'Hoffmann',      't.hoffmann.berlin@techstore.de','$2y$12$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 1, '2025-03-17 11:30:00'),
(5, 3,    3, 'Maria',     'Schneider',     'm.schneider.muc@techstore.de', '$2y$12$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 1, '2025-03-18 09:45:00'),
(6, 4,    3, 'Jens',      'Krause',        'j.krause.hh@techstore.de',     '$2y$12$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 1, '2025-03-16 16:00:00'),
(7, NULL, 4, 'Anna',      'Weber',         'a.weber@techstore.de',         '$2y$12$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 1, '2025-03-19 10:00:00');

-- ─────────────────────────────────────────────
--  CUSTOMERS
-- ─────────────────────────────────────────────
DELETE FROM customers;
-- Passwords: all 'Kunde1234!' bcrypt-hashed
INSERT INTO customers (id, branch_id, type, first_name, last_name, email, password_hash, phone, preferred_lang, company_name, vat_number, trade_register, company_verified, verification_status, verified_at, verified_by, price_group, is_active, email_verified, newsletter, last_login_at) VALUES
-- ── Köln branch customers ──
( 1, 1, 'private', 'Lena',    'Fischer',     'lena.fischer@gmail.com',         '$2y$12$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '+49 157 11223344', 'de', NULL, NULL, NULL, 0, 'pending', NULL, NULL, 'standard', 1, 1, 1, '2025-03-18 20:11:00'),
( 2, 1, 'private', 'Markus',  'Wagner',      'markus.wagner@web.de',           '$2y$12$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '+49 172 9988776',  'de', NULL, NULL, NULL, 0, 'pending', NULL, NULL, 'standard', 1, 1, 0, '2025-03-17 12:35:00'),
( 3, 1, 'company', 'Stefan',  'Brandt',      's.brandt@brandtgmbh.de',         '$2y$12$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '+49 221 334455',   'de', 'Brandt GmbH', 'DE287654321', 'HRB 88421', 1, 'approved', '2025-02-10 10:00:00', 3, 'b2b', 1, 1, 0, '2025-03-19 09:00:00'),
( 4, 1, 'company', 'Nicole',  'Zimmermann',  'n.zimmermann@z-logistics.de',    '$2y$12$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '+49 221 667788',   'de', 'Z-Logistics KG', 'DE199887766', 'HRB 55320', 1, 'approved', '2025-01-15 14:00:00', 3, 'b2b', 1, 1, 0, '2025-03-16 14:20:00'),
( 5, 1, 'company', 'Peter',   'Schulz',      'p.schulz@schulz-it.de',          '$2y$12$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '+49 221 556677',   'de', 'Schulz IT Solutions', 'DE334455666', 'HRB 12984', 0, 'pending', NULL, NULL, 'standard', 1, 1, 0, '2025-03-10 11:00:00'),
( 6, 1, 'private', 'Julia',   'Koch',        'julia.koch@hotmail.de',          '$2y$12$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '+49 160 1234567',  'de', NULL, NULL, NULL, 0, 'pending', NULL, NULL, 'standard', 1, 1, 1, '2025-03-14 18:45:00'),
-- ── Berlin branch customers ──
( 7, 2, 'private', 'Felix',   'Bauer',       'felix.bauer@berlin.de',          '$2y$12$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '+49 179 8887766',  'de', NULL, NULL, NULL, 0, 'pending', NULL, NULL, 'standard', 1, 1, 1, '2025-03-19 07:30:00'),
( 8, 2, 'private', 'Sarah',   'Richter',     'sarah.richter@gmx.de',           '$2y$12$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '+49 152 4455667',  'de', NULL, NULL, NULL, 0, 'pending', NULL, NULL, 'standard', 1, 1, 0, '2025-03-12 15:20:00'),
( 9, 2, 'company', 'Andreas', 'Klein',       'a.klein@kleintec.de',            '$2y$12$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '+49 30 778899',    'de', 'KleinTec GmbH', 'DE412233445', 'HRB 33210', 1, 'approved', '2025-01-20 09:00:00', 4, 'b2b', 1, 1, 0, '2025-03-18 13:00:00'),
(10, 2, 'private', 'Emma',    'Wolf',        'emma.wolf@icloud.com',           '$2y$12$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '+49 176 3344556',  'en', NULL, NULL, NULL, 0, 'pending', NULL, NULL, 'standard', 1, 1, 1, '2025-03-15 21:00:00'),
-- ── München branch customers ──
(11, 3, 'private', 'Lukas',   'Braun',       'lukas.braun@yahoo.de',           '$2y$12$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '+49 171 6677889',  'de', NULL, NULL, NULL, 0, 'pending', NULL, NULL, 'standard', 1, 1, 0, '2025-03-19 11:10:00'),
(12, 3, 'company', 'Monika',  'Lange',       'm.lange@baysolutions.de',        '$2y$12$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '+49 89 998877',    'de', 'Bay Solutions AG', 'DE556677889', 'HRB 67890', 1, 'approved', '2025-02-05 11:30:00', 5, 'b2b', 1, 1, 0, '2025-03-17 10:00:00'),
-- ── Hamburg branch customers ──
(13, 4, 'private', 'Hannah',  'Schmitt',     'hannah.schmitt@t-online.de',     '$2y$12$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '+49 40 112244',    'de', NULL, NULL, NULL, 0, 'pending', NULL, NULL, 'standard', 1, 1, 1, '2025-03-18 19:05:00'),
(14, 4, 'company', 'Bernd',   'Neumann',     'b.neumann@nordseehandel.de',     '$2y$12$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '+49 40 335577',    'de', 'Nordsee Handel GmbH', 'DE778899001', 'HRB 54321', 1, 'approved', '2025-03-01 08:00:00', 6, 'b2b', 1, 1, 0, '2025-03-19 08:30:00'),
-- ── Austria branch customers ──
(15, 5, 'private', 'Sophie',  'Huber',       'sophie.huber@gmx.at',            '$2y$12$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '+43 676 1122334',  'de', NULL, NULL, NULL, 0, 'pending', NULL, NULL, 'standard', 1, 1, 1, '2025-03-16 17:00:00'),
(16, 5, 'company', 'Wolfgang','Gruber',      'w.gruber@alphatechnik.at',       '$2y$12$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '+43 1 889900',     'de', 'Alpha Technik GmbH', 'ATU55443322', 'FN 445566g', 1, 'approved', '2025-02-20 13:00:00', 2, 'b2b', 1, 1, 0, '2025-03-19 09:45:00');

-- ─────────────────────────────────────────────
--  COMPANY DOCUMENTS
-- ─────────────────────────────────────────────
DELETE FROM company_documents;
INSERT INTO company_documents (id, customer_id, document_type, file_name, file_path, file_size, mime_type, status, reviewed_by, reviewed_at) VALUES
( 1,  3, 'business_license', 'gewerbeschein_brandt.pdf',    'storage/uploads/documents/brandt_gewerbeschein.pdf',    245120, 'application/pdf', 'accepted', 3, '2025-02-10 10:05:00'),
( 2,  3, 'vat_proof',        'umsatzsteuer_brandt.pdf',     'storage/uploads/documents/brandt_vat.pdf',              180240, 'application/pdf', 'accepted', 3, '2025-02-10 10:05:00'),
( 3,  4, 'business_license', 'handelsregister_z_log.pdf',  'storage/uploads/documents/z_log_hr.pdf',                312000, 'application/pdf', 'accepted', 3, '2025-01-15 14:10:00'),
( 4,  9, 'business_license', 'kleintec_gewerbeschein.pdf', 'storage/uploads/documents/kleintec_gew.pdf',            198000, 'application/pdf', 'accepted', 4, '2025-01-20 09:10:00'),
( 5,  9, 'vat_proof',        'kleintec_ust.pdf',           'storage/uploads/documents/kleintec_vat.pdf',            145000, 'application/pdf', 'accepted', 4, '2025-01-20 09:10:00'),
( 6, 12, 'business_license', 'baysolutions_hr.pdf',        'storage/uploads/documents/baysol_hr.pdf',               267000, 'application/pdf', 'accepted', 5, '2025-02-05 11:35:00'),
( 7, 14, 'trade_register',   'nordsee_hr_auszug.pdf',      'storage/uploads/documents/nordsee_hr.pdf',              221000, 'application/pdf', 'accepted', 6, '2025-03-01 08:05:00'),
( 8, 16, 'business_license', 'alpha_technik_fb.pdf',       'storage/uploads/documents/alpha_fb.pdf',                190000, 'application/pdf', 'accepted', 2, '2025-02-20 13:10:00'),
( 9,  5, 'business_license', 'schulz_it_gew.pdf',          'storage/uploads/documents/schulz_gew.pdf',              173000, 'application/pdf', 'pending',  NULL, NULL);

-- ─────────────────────────────────────────────
--  ADDRESSES
-- ─────────────────────────────────────────────
DELETE FROM addresses;
INSERT INTO addresses (id, customer_id, type, label, first_name, last_name, company, street, house_number, city, postal_code, country_code, is_default) VALUES
( 1,  1, 'shipping', 'Zuhause',  'Lena',    'Fischer',    NULL,                 'Aachener Straße',   '45',  'Köln',   '50674', 'DE', 1),
( 2,  1, 'billing',  'Standard', 'Lena',    'Fischer',    NULL,                 'Aachener Straße',   '45',  'Köln',   '50674', 'DE', 1),
( 3,  2, 'shipping', 'Zuhause',  'Markus',  'Wagner',     NULL,                 'Ehrenfelder Gürtel','112', 'Köln',   '50823', 'DE', 1),
( 4,  3, 'billing',  'Büro',     'Stefan',  'Brandt',     'Brandt GmbH',        'Riehler Straße',    '8',   'Köln',   '50668', 'DE', 1),
( 5,  3, 'shipping', 'Lager',    'Stefan',  'Brandt',     'Brandt GmbH',        'Industriestraße',   '33',  'Bergheim','50126','DE', 0),
( 6,  4, 'billing',  'Büro',     'Nicole',  'Zimmermann', 'Z-Logistics KG',     'Bonner Straße',     '201', 'Köln',   '50969', 'DE', 1),
( 7,  6, 'shipping', 'Zuhause',  'Julia',   'Koch',       NULL,                 'Deutz-Mülheimer Str','14', 'Köln',   '51063', 'DE', 1),
( 8,  7, 'shipping', 'Zuhause',  'Felix',   'Bauer',      NULL,                 'Prenzlauer Allee',  '88',  'Berlin', '10405', 'DE', 1),
( 9,  8, 'shipping', 'Zuhause',  'Sarah',   'Richter',    NULL,                 'Kreuzbergstr.',     '7',   'Berlin', '10965', 'DE', 1),
(10,  9, 'billing',  'Büro',     'Andreas', 'Klein',      'KleinTec GmbH',      'Unter den Linden',  '42',  'Berlin', '10117', 'DE', 1),
(11, 10, 'shipping', 'Zuhause',  'Emma',    'Wolf',       NULL,                 'Schönhauser Allee', '55',  'Berlin', '10437', 'DE', 1),
(12, 11, 'shipping', 'Zuhause',  'Lukas',   'Braun',      NULL,                 'Maximilianstraße',  '19',  'München','80539', 'DE', 1),
(13, 12, 'billing',  'Büro',     'Monika',  'Lange',      'Bay Solutions AG',   'Rosenheimer Platz', '5',   'München','81669', 'DE', 1),
(14, 13, 'shipping', 'Zuhause',  'Hannah',  'Schmitt',    NULL,                 'Eppendorfer Baum',  '23',  'Hamburg','20249', 'DE', 1),
(15, 14, 'billing',  'Büro',     'Bernd',   'Neumann',    'Nordsee Handel GmbH','Speicherstadt',     '11',  'Hamburg','20457', 'DE', 1),
(16, 15, 'shipping', 'Zuhause',  'Sophie',  'Huber',      NULL,                 'Mariahilfer Straße','105', 'Wien',   '1060',  'AT', 1),
(17, 16, 'billing',  'Büro',     'Wolfgang','Gruber',      'Alpha Technik GmbH', 'Quellenstraße',    '33',  'Wien',   '1100',  'AT', 1);

-- ─────────────────────────────────────────────
--  CATEGORIES
-- ─────────────────────────────────────────────
DELETE FROM categories;
INSERT INTO categories (id, parent_id, slug, image, sort_order, is_active) VALUES
-- Top-level
( 1, NULL, 'smartphones',           'categories/smartphones.webp',        1, 1),
( 2, NULL, 'laptops-notebooks',     'categories/laptops.webp',            2, 1),
( 3, NULL, 'audio-hifi',            'categories/audio.webp',              3, 1),
( 4, NULL, 'tablets',               'categories/tablets.webp',            4, 1),
( 5, NULL, 'zubehoer',              'categories/accessories.webp',        5, 1),
( 6, NULL, 'smart-home',            'categories/smarthome.webp',          6, 1),
( 7, NULL, 'gaming',                'categories/gaming.webp',             7, 1),
( 8, NULL, 'kameras',               'categories/cameras.webp',            8, 1),
-- Subcategories of Smartphones
( 9,  1,   'android-smartphones',   'categories/android.webp',            1, 1),
(10,  1,   'apple-iphone',          'categories/iphone.webp',             2, 1),
-- Subcategories of Audio
(11,  3,   'kopfhoerer',            'categories/headphones.webp',         1, 1),
(12,  3,   'lautsprecher',          'categories/speakers.webp',           2, 1),
(13,  3,   'earbuds-in-ear',        'categories/earbuds.webp',            3, 1),
-- Subcategories of Laptops
(14,  2,   'windows-laptops',       'categories/win-laptops.webp',        1, 1),
(15,  2,   'apple-macbook',         'categories/macbook.webp',            2, 1),
-- Subcategories of Gaming
(16,  7,   'gaming-headsets',       'categories/gaming-headsets.webp',    1, 1),
(17,  7,   'gaming-maeuse',         'categories/gaming-mice.webp',        2, 1),
(18,  7,   'gaming-tastaturen',     'categories/gaming-keyboards.webp',   3, 1);

INSERT INTO category_translations (category_id, lang_code, name, description, meta_title, meta_description, url_slug) VALUES
-- DE
( 1,'de','Smartphones',             'Aktuelle Smartphones aller großen Hersteller.',                              'Smartphones kaufen',          'Große Auswahl an Smartphones. Top Preise & schneller Versand.',            'smartphones'),
( 2,'de','Laptops & Notebooks',     'Leistungsstarke Laptops für Arbeit, Studium und Freizeit.',                 'Laptops kaufen',              'Laptops & Notebooks günstig kaufen. Schnelle Lieferung.',                  'laptops-notebooks'),
( 3,'de','Audio & HiFi',            'Kopfhörer, Lautsprecher, Soundbars und HiFi-Anlagen.',                      'Audio-Geräte kaufen',         'Premium-Audio für zuhause und unterwegs.',                                 'audio-hifi'),
( 4,'de','Tablets',                 'iPad, Android-Tablets und E-Reader für jeden Einsatzbereich.',              'Tablets kaufen',              'Tablets aller Marken zum besten Preis.',                                   'tablets'),
( 5,'de','Zubehör',                 'Cases, Ladegeräte, Kabel und weiteres Zubehör.',                            'Smartphone Zubehör',          'Zubehör für Smartphones, Laptops und Tablets.',                            'zubehoer'),
( 6,'de','Smart Home',              'Intelligente Geräte für Ihr Zuhause: Leuchten, Thermostate, Kameras.',      'Smart Home Geräte',           'Smart-Home-Geräte für ein vernetztes Zuhause.',                            'smart-home'),
( 7,'de','Gaming',                  'Alles für Gamer: Headsets, Mäuse, Tastaturen und mehr.',                    'Gaming Equipment',            'Top Gaming-Zubehör zu unschlagbaren Preisen.',                             'gaming'),
( 8,'de','Kameras & Foto',          'Systemkameras, Kompaktkameras und Zubehör für Fotografen.',                 'Kameras kaufen',              'Kameras & Foto-Equipment für Einsteiger und Profis.',                       'kameras'),
( 9,'de','Android Smartphones',     'Samsung, Google Pixel, OnePlus und weitere Android-Geräte.',                'Android Smartphones',         'Android Smartphones aller Hersteller.',                                    'android-smartphones'),
(10,'de','Apple iPhone',            'Die neuesten iPhone-Modelle direkt verfügbar.',                              'iPhone kaufen',               'Alle iPhone-Modelle & Farben auf Lager.',                                  'apple-iphone'),
(11,'de','Kopfhörer',               'Over-Ear, On-Ear und In-Ear Kopfhörer top Marken.',                         'Kopfhörer kaufen',            'Premium-Kopfhörer von Sony, Bose, Apple & Co.',                            'kopfhoerer'),
(12,'de','Lautsprecher',            'Bluetooth-Lautsprecher, Soundbars und HiFi-Anlagen.',                       'Lautsprecher kaufen',         'Lautsprecher für drinnen und draußen.',                                    'lautsprecher'),
(13,'de','Earbuds & In-Ear',        'Kabellose In-Ear-Kopfhörer mit aktiver Geräuschunterdrückung.',             'Earbuds kaufen',              'True Wireless Earbuds für Sport und Alltag.',                               'earbuds-in-ear'),
(14,'de','Windows Laptops',         'Laptops mit Windows 11 von Dell, Lenovo, HP, ASUS und mehr.',               'Windows Laptops',             'Windows 11 Laptops für jeden Anspruch.',                                   'windows-laptops'),
(15,'de','Apple MacBook',           'MacBook Air und MacBook Pro mit Apple Silicon.',                             'MacBook kaufen',              'Alle MacBook-Modelle verfügbar.',                                          'apple-macbook'),
(16,'de','Gaming Headsets',         'Surround-Sound-Headsets für PS5, Xbox und PC.',                             'Gaming Headsets',             'Gaming Headsets für maximales Spielerlebnis.',                             'gaming-headsets'),
(17,'de','Gaming-Mäuse',            'Präzisions-Gaming-Mäuse mit RGB und hoher DPI.',                            'Gaming Mäuse',                'Gaming-Mäuse für Profis und Einsteiger.',                                  'gaming-maeuse'),
(18,'de','Gaming-Tastaturen',       'Mechanische und Membran-Tastaturen für Gamer.',                             'Gaming Tastaturen',           'Gaming-Tastaturen mit RGB-Beleuchtung.',                                   'gaming-tastaturen'),
-- EN
( 1,'en','Smartphones',             'Latest smartphones from all major manufacturers.',                           'Buy Smartphones',             'Wide selection of smartphones. Best prices & fast shipping.',              'smartphones'),
( 2,'en','Laptops & Notebooks',     'Powerful laptops for work, study and leisure.',                              'Buy Laptops',                 'Laptops & notebooks at great prices.',                                     'laptops-notebooks'),
( 3,'en','Audio & HiFi',            'Headphones, speakers, soundbars and HiFi systems.',                         'Buy Audio Equipment',         'Premium audio for home and on the go.',                                    'audio-hifi'),
( 4,'en','Tablets',                 'iPad, Android tablets and e-readers.',                                       'Buy Tablets',                 'Tablets from all brands at the best price.',                               'tablets'),
( 5,'en','Accessories',             'Cases, chargers, cables and other accessories.',                             'Smartphone Accessories',      'Accessories for smartphones, laptops and tablets.',                        'accessories'),
( 6,'en','Smart Home',              'Smart devices for your home.',                                               'Smart Home Devices',          'Smart home devices for a connected home.',                                 'smart-home'),
( 7,'en','Gaming',                  'Everything for gamers: headsets, mice, keyboards and more.',                 'Gaming Equipment',            'Top gaming accessories at unbeatable prices.',                             'gaming'),
( 8,'en','Cameras & Photo',         'System cameras, compact cameras and accessories.',                           'Buy Cameras',                 'Cameras & photo equipment for beginners and pros.',                        'cameras'),
(11,'en','Headphones',              'Over-ear, on-ear and in-ear headphones.',                                    'Buy Headphones',              'Premium headphones from Sony, Bose, Apple & more.',                        'headphones');
