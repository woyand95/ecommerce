-- ============================================================
--  SEED DATA — PART 4
--  CMS Pages · Menus · Reviews · UI Translations · Themes
-- ============================================================

-- ─────────────────────────────────────────────
--  CARTS (active sessions)
-- ─────────────────────────────────────────────
DELETE FROM carts;
INSERT INTO carts (id, session_id, customer_id, branch_id, coupon_code, expires_at) VALUES
(1, 'sess_lena_active_cart',      1, 1, NULL,            DATE_ADD(NOW(), INTERVAL 7 DAY)),
(2, 'sess_felix_active_cart',     7, 2, 'FRUEHLING25',   DATE_ADD(NOW(), INTERVAL 7 DAY)),
(3, 'sess_guest_koeln_123',    NULL, 1, NULL,            DATE_ADD(NOW(), INTERVAL 1 DAY));

DELETE FROM cart_items;
INSERT INTO cart_items (cart_id, product_id, variant_id, quantity) VALUES
(1, 7,  15, 1),   -- MacBook Air M3 Midnight
(1, 30, 30, 2),   -- USB-C Kabel ×2
(2, 12, 18,  1),  -- Sony WH-1000XM6 Schwarz
(3, 15, 20,  1),  -- AirPods Pro 4
(3, 30, 30,  1);  -- USB-C Kabel

-- ─────────────────────────────────────────────
--  CMS PAGES
-- ─────────────────────────────────────────────
DELETE FROM pages;
INSERT INTO pages (id, branch_id, parent_id, template, status, sort_order, show_in_nav, created_by) VALUES
( 1, NULL, NULL, 'standard',   'published', 1, 1, 7),  -- Über uns
( 2, NULL, NULL, 'standard',   'published', 2, 1, 7),  -- Kontakt
( 3, NULL, NULL, 'landing',    'published', 0, 0, 7),  -- Homepage Hero
( 4, NULL, NULL, 'standard',   'published', 3, 1, 7),  -- Impressum
( 5, NULL, NULL, 'standard',   'published', 4, 1, 7),  -- Datenschutz
( 6, NULL, NULL, 'standard',   'published', 5, 1, 7),  -- AGB
( 7, NULL, NULL, 'standard',   'published', 6, 1, 7),  -- Garantie & Rücksendungen
( 8, NULL, NULL, 'standard',   'published', 7, 0, 7),  -- B2B / Geschäftskunden
( 9, 1,    NULL, 'standard',   'published', 1, 0, 3),  -- Filiale Köln Info
(10, 2,    NULL, 'standard',   'published', 1, 0, 4),  -- Filiale Berlin Info
(11, 3,    NULL, 'standard',   'published', 1, 0, 5),  -- Filiale München Info
(12, 4,    NULL, 'standard',   'published', 1, 0, 6),  -- Filiale Hamburg Info
(13, NULL, NULL, 'standard',   'draft',     8, 0, 7);  -- Angebote (Draft)

-- Page Translations
DELETE FROM page_translations;
INSERT INTO page_translations (page_id, lang_code, title, url_slug, meta_title, meta_description) VALUES
-- Über uns
( 1,'de','Über uns',                 'ueber-uns',           'Über TechStore – Ihr Elektronik-Fachhandel',         'TechStore: Ihr zuverlässiger Partner für Consumer Electronics. Erfahren Sie mehr über uns.'),
( 1,'en','About Us',                 'about-us',            'About TechStore – Your Electronics Specialist',      'TechStore: Your trusted partner for consumer electronics. Learn more about us.'),
-- Kontakt
( 2,'de','Kontakt',                  'kontakt',             'Kontakt – TechStore',                               'Kontaktieren Sie TechStore. Wir helfen Ihnen gerne weiter.'),
( 2,'en','Contact',                  'contact',             'Contact – TechStore',                               'Contact TechStore. We are happy to help.'),
-- Homepage Hero (no public URL)
( 3,'de','Startseite Hero',          'startseite',          'TechStore – Top Deals in Elektronik',               'Smartphones, Laptops, Audio & mehr. Günstig kaufen & schnell geliefert.'),
( 3,'en','Homepage Hero',            'home',                'TechStore – Top Electronics Deals',                 'Smartphones, laptops, audio & more. Buy cheap & get fast delivery.'),
-- Impressum
( 4,'de','Impressum',                'impressum',           'Impressum – TechStore GmbH',                        'Rechtliche Angaben gemäß § 5 TMG.'),
( 4,'en','Legal Notice',             'legal-notice',        'Legal Notice – TechStore GmbH',                     'Legal information pursuant to § 5 TMG.'),
-- Datenschutz
( 5,'de','Datenschutzerklärung',     'datenschutz',         'Datenschutz – TechStore GmbH',                      'Informationen zum Datenschutz und zur Verarbeitung personenbezogener Daten.'),
( 5,'en','Privacy Policy',           'privacy-policy',      'Privacy Policy – TechStore GmbH',                   'Information on data protection and the processing of personal data.'),
-- AGB
( 6,'de','Allgemeine Geschäftsbedingungen', 'agb',          'AGB – TechStore GmbH',                              'Allgemeine Geschäftsbedingungen der TechStore GmbH.'),
( 6,'en','Terms and Conditions',     'terms',               'Terms and Conditions – TechStore GmbH',             'General terms and conditions of TechStore GmbH.'),
-- Garantie
( 7,'de','Garantie & Rücksendungen', 'garantie-ruecksendungen','Garantie & Rücksendungen – TechStore',           '2 Jahre Garantie, 30 Tage Rückgaberecht. Alle Infos hier.'),
( 7,'en','Warranty & Returns',       'warranty-returns',    'Warranty & Returns – TechStore',                    '2 year warranty, 30 day return policy. All info here.'),
-- B2B
( 8,'de','Für Geschäftskunden',      'geschaeftskunden',    'B2B & Geschäftskunden – TechStore',                 'Exklusive Konditionen für Unternehmen. Jetzt B2B-Konto beantragen.'),
( 8,'en','For Business Customers',   'business',            'B2B & Business Customers – TechStore',              'Exclusive conditions for companies. Apply for a B2B account now.'),
-- Branch pages
( 9,'de','Filiale Köln',             'filiale-koeln',       'TechStore Filiale Köln – Öffnungszeiten & Adresse', 'TechStore in Köln auf der Schildergasse. Öffnungszeiten, Adresse, Anfahrt.'),
(10,'de','Filiale Berlin',           'filiale-berlin',      'TechStore Filiale Berlin – Öffnungszeiten & Adresse','TechStore am Kurfürstendamm Berlin.'),
(11,'de','Filiale München',          'filiale-muenchen',    'TechStore Filiale München – Öffnungszeiten & Adresse','TechStore in der Kaufingerstraße München.'),
(12,'de','Filiale Hamburg',          'filiale-hamburg',     'TechStore Filiale Hamburg – Öffnungszeiten & Adresse','TechStore an der Mönckebergstraße Hamburg.'),
(13,'de','Aktuelle Angebote',        'angebote',            'Top Angebote – TechStore',                          'Die besten Deals & Aktionen. Jetzt entdecken.');

-- ─────────────────────────────────────────────
--  PAGE CONTENT BLOCKS
-- ─────────────────────────────────────────────
DELETE FROM page_blocks;
DELETE FROM page_block_translations;

INSERT INTO page_blocks (id, page_id, block_type, sort_order, css_class, settings, is_active) VALUES
-- Über uns page
(1,  1, 'text',    0, 'intro-section', '{"width":"contained","bg":"white"}',  1),
(2,  1, 'image',   1, 'team-photo',    '{"align":"center"}',                   1),
(3,  1, 'grid',    2, 'values-grid',   '{"columns":3}',                        1),
(4,  1, 'cta',     3, 'contact-cta',   '{"style":"primary"}',                  1),
-- Kontakt page
(5,  2, 'grid',    0, 'locations-grid','{"columns":2}',                        1),
(6,  2, 'html',    1, 'contact-form',  '{}',                                   1),
-- B2B page
(7,  8, 'text',    0, 'b2b-hero',      '{"bg":"dark","text_color":"white"}',   1),
(8,  8, 'grid',    1, 'benefits-grid', '{"columns":4}',                        1),
(9,  8, 'text',    2, 'process-steps', '{}',                                   1),
(10, 8, 'cta',     3, 'b2b-cta',       '{"style":"primary"}',                  1),
-- Filiale Köln
(11, 9, 'text',    0, 'branch-info',   '{}',                                   1),
(12, 9, 'html',    1, 'branch-map',    '{}',                                   1);

INSERT INTO page_block_translations (block_id, lang_code, content) VALUES
-- Block 1: Über uns - intro text
(1,'de','{"heading":"Ihr zuverlässiger Partner für Consumer Electronics","body":"<p>TechStore wurde 2015 gegründet und hat sich zu einem der führenden Elektronik-Fachhändler in Deutschland und Österreich entwickelt. Mit fünf Filialen in Köln, Berlin, München und Hamburg sowie einem wachsenden Online-Shop beliefern wir täglich tausende von Kunden mit den neuesten Smartphones, Laptops, Audio-Geräten und Smart-Home-Produkten.</p><p>Unser Anspruch ist es, technisch anspruchsvolle Produkte mit erstklassigem Service zu verbinden. Kompetente Beratung, faire Preise und schnelle Lieferung – das ist unser Versprechen an Sie.</p>"}'),
(1,'en','{"heading":"Your Reliable Partner for Consumer Electronics","body":"<p>TechStore was founded in 2015 and has grown into one of the leading electronics retailers in Germany and Austria. With five branches in Cologne, Berlin, Munich and Hamburg, as well as a growing online store, we serve thousands of customers daily.</p>"}'),
-- Block 2: Team photo
(2,'de','{"src":"pages/about/team-foto-2024.webp","alt":"Das TechStore Team 2024","caption":"Das TechStore-Team – über 80 Mitarbeiter an 5 Standorten."}'),
(2,'en','{"src":"pages/about/team-foto-2024.webp","alt":"TechStore Team 2024","caption":"The TechStore team – over 80 employees at 5 locations."}'),
-- Block 3: Values
(3,'de','{"items":[{"icon":"shield","title":"Vertrauen","text":"Alle Produkte sind originale Markenware mit Hersteller-Garantie."},{"icon":"truck","title":"Schnell & Zuverlässig","text":"Bestellungen bis 14 Uhr werden noch am selben Tag versandt."},{"icon":"headset","title":"Exzellenter Support","text":"Unser Kundenservice ist Mo–Sa 8–20 Uhr für Sie erreichbar."}]}'),
(3,'en','{"items":[{"icon":"shield","title":"Trust","text":"All products are original branded goods with manufacturer warranty."},{"icon":"truck","title":"Fast & Reliable","text":"Orders placed before 2 PM are shipped the same day."},{"icon":"headset","title":"Excellent Support","text":"Our customer service is available Mon–Sat 8am–8pm."}]}'),
-- Block 4: CTA Über uns
(4,'de','{"heading":"Nehmen Sie Kontakt auf","text":"Haben Sie Fragen? Unser Team hilft gerne weiter.","button_text":"Zum Kontaktformular","button_url":"/de/kontakt"}'),
(4,'en','{"heading":"Get In Touch","text":"Have questions? Our team is happy to help.","button_text":"Go to Contact Form","button_url":"/en/contact"}'),
-- Block 7: B2B Hero
(7,'de','{"heading":"Maßgeschneiderte Lösungen für Ihr Unternehmen","text":"Als B2B-Kunde profitieren Sie von exklusiven Konditionen, persönlichem Ansprechpartner und flexiblen Zahlungskonditionen auf Rechnung."}'),
(7,'en','{"heading":"Tailored Solutions for Your Business","text":"As a B2B customer you benefit from exclusive pricing, a personal account manager and flexible payment terms."}'),
-- Block 8: B2B Benefits
(8,'de','{"items":[{"icon":"tag","title":"Sonderpreise","text":"Bis zu 20% unter UVP für verifizierte Geschäftskunden."},{"icon":"file-text","title":"Kauf auf Rechnung","text":"Zahlungsziel 30 Tage für bonitätsgeprüfte Unternehmen."},{"icon":"package","title":"Mengenrabatte","text":"Staffelpreise ab 3 Einheiten."},{"icon":"user","title":"Persönliche Betreuung","text":"Dedizierter Account-Manager für Ihren Betrieb."}]}'),
(8,'en','{"items":[{"icon":"tag","title":"Special Pricing","text":"Up to 20% below RRP for verified business customers."},{"icon":"file-text","title":"Invoice Purchase","text":"30-day payment terms for credit-checked companies."},{"icon":"package","title":"Volume Discounts","text":"Tiered pricing from 3 units."},{"icon":"user","title":"Personal Support","text":"Dedicated account manager for your business."}]}'),
-- Block 10: B2B CTA
(10,'de','{"heading":"Jetzt B2B-Konto beantragen","text":"Registrieren Sie sich und laden Sie Ihre Unternehmensdokumente hoch. Wir prüfen Ihren Antrag innerhalb von 24 Stunden.","button_text":"B2B-Konto erstellen","button_url":"/de/registrieren?typ=b2b"}'),
(10,'en','{"heading":"Apply for a B2B Account Now","text":"Register and upload your company documents. We review your application within 24 hours.","button_text":"Create B2B Account","button_url":"/en/register?type=b2b"}'),
-- Block 11: Filiale Köln info
(11,'de','{"heading":"TechStore Köln – Schildergasse 12","hours":"Mo–Sa: 9–20 Uhr, So: geschlossen","phone":"+49 221 987654","email":"koeln@techstore.de","parking":"Parkhaus Dom/Pfeifergasse in 200m Entfernung.","public_transport":"U-Bahn: Dom/Hbf (Linien 1, 7, 9)"}');

-- ─────────────────────────────────────────────
--  NAVIGATION MENUS
-- ─────────────────────────────────────────────
DELETE FROM menus;
INSERT INTO menus (id, branch_id, location, name) VALUES
(1, NULL, 'header',  'Hauptnavigation'),
(2, NULL, 'footer',  'Footer Navigation'),
(3, NULL, 'mobile',  'Mobile Navigation');

DELETE FROM menu_items;
INSERT INTO menu_items (id, menu_id, parent_id, type, reference_id, url, target, sort_order) VALUES
-- Header nav
( 1, 1, NULL, 'category', 1,  '/de/smartphones',        '_self', 1),
( 2, 1, NULL, 'category', 2,  '/de/laptops-notebooks',  '_self', 2),
( 3, 1, NULL, 'category', 3,  '/de/audio-hifi',         '_self', 3),
( 4, 1, NULL, 'category', 4,  '/de/tablets',            '_self', 4),
( 5, 1, NULL, 'category', 6,  '/de/smart-home',         '_self', 5),
( 6, 1, NULL, 'category', 7,  '/de/gaming',             '_self', 6),
( 7, 1, NULL, 'url',      NULL,'/de/angebote',           '_self', 7),
-- Submenu Smartphones
( 8, 1,  1,   'category', 10, '/de/apple-iphone',       '_self', 1),
( 9, 1,  1,   'category',  9, '/de/android-smartphones','_self', 2),
-- Submenu Audio
(10, 1,  3,   'category', 11, '/de/kopfhoerer',         '_self', 1),
(11, 1,  3,   'category', 13, '/de/earbuds-in-ear',     '_self', 2),
(12, 1,  3,   'category', 12, '/de/lautsprecher',       '_self', 3),
-- Submenu Laptops
(13, 1,  2,   'category', 15, '/de/apple-macbook',      '_self', 1),
(14, 1,  2,   'category', 14, '/de/windows-laptops',    '_self', 2),
-- Footer nav
(20, 2, NULL, 'page',   1,   '/de/ueber-uns',           '_self', 1),
(21, 2, NULL, 'page',   2,   '/de/kontakt',             '_self', 2),
(22, 2, NULL, 'page',   8,   '/de/geschaeftskunden',    '_self', 3),
(23, 2, NULL, 'page',   7,   '/de/garantie-ruecksendungen','_self',4),
(24, 2, NULL, 'page',   4,   '/de/impressum',           '_self', 5),
(25, 2, NULL, 'page',   5,   '/de/datenschutz',         '_self', 6),
(26, 2, NULL, 'page',   6,   '/de/agb',                 '_self', 7);

DELETE FROM menu_item_translations;
INSERT INTO menu_item_translations (item_id, lang_code, label) VALUES
-- Header DE
( 1,'de','Smartphones'),( 2,'de','Laptops & Notebooks'),( 3,'de','Audio & HiFi'),
( 4,'de','Tablets'),    ( 5,'de','Smart Home'),         ( 6,'de','Gaming'),        ( 7,'de','Angebote'),
( 8,'de','Apple iPhone'),( 9,'de','Android'),
(10,'de','Kopfhörer'), (11,'de','Earbuds & In-Ear'),   (12,'de','Lautsprecher'),
(13,'de','Apple MacBook'),(14,'de','Windows Laptops'),
-- Header EN
( 1,'en','Smartphones'),( 2,'en','Laptops & Notebooks'),( 3,'en','Audio & HiFi'),
( 4,'en','Tablets'),    ( 5,'en','Smart Home'),          ( 6,'en','Gaming'),       ( 7,'en','Deals'),
( 8,'en','Apple iPhone'),( 9,'en','Android'),
(10,'en','Headphones'), (11,'en','Earbuds & In-Ear'),   (12,'en','Speakers'),
(13,'en','Apple MacBook'),(14,'en','Windows Laptops'),
-- Footer DE
(20,'de','Über uns'),(21,'de','Kontakt'),(22,'de','Für Geschäftskunden'),(23,'de','Garantie & Rücksendungen'),
(24,'de','Impressum'),(25,'de','Datenschutz'),(26,'de','AGB'),
-- Footer EN
(20,'en','About Us'),(21,'en','Contact'),(22,'en','Business Customers'),(23,'en','Warranty & Returns'),
(24,'en','Legal Notice'),(25,'en','Privacy Policy'),(26,'en','Terms & Conditions');

-- ─────────────────────────────────────────────
--  PRODUCT REVIEWS
-- ─────────────────────────────────────────────
DELETE FROM product_reviews;
INSERT INTO product_reviews (product_id, customer_id, branch_id, rating, title, body, status, created_at) VALUES
-- iPhone 16 Pro (product 3)
(3,  1, 1, 5, 'Absolut beeindruckend!',
    'Das iPhone 16 Pro ist das beste Smartphone, das ich je hatte. Die Kamera ist unglaublich – selbst bei Nacht entstehen brillante Fotos. Der A18 Pro Chip macht alles blitzschnell. Camera Control Button ist ein Gamechanger.',
    'approved', '2025-02-01 14:30:00'),
(3,  7, 2, 5, 'Top Kamera, super Performance',
    'Ich bin von Android zu Apple gewechselt und bereue es keinen Moment. Das ProRes-Video ist für meine YouTube-Produktion einfach perfekt.',
    'approved', '2025-02-10 11:00:00'),
(3, 11, 3, 4, 'Sehr gut, aber teuer',
    'Qualität ist erstklassig. 5x Telezoom ist fantastisch. Einziger Kritikpunkt: der Preis. Aber für professionelle Anwender absolut gerechtfertigt.',
    'approved', '2025-02-15 09:20:00'),

-- Samsung S25 Ultra (product 1)
(1,  2, 1, 5, 'S Pen macht den Unterschied',
    'Ich nutze das S25 Ultra täglich für Meetings und Notizen. Der S Pen ist reaktionsschnell und das Display einfach traumhaft. Galaxy AI ist überraschend nützlich.',
    'approved', '2025-03-05 10:45:00'),
(1,  9, 2, 4, 'Sehr solides Flaggschiff',
    'Für unsere Außendienstmitarbeiter ist das S25 Ultra ideal. Langlebiger Akku, robustes Design, gute Business-Features. Circle to Search spart täglich Zeit.',
    'approved', '2025-03-10 15:00:00'),

-- Sony WH-1000XM6 (product 12)
(12, 1, 1, 5, 'Bester Kopfhörer auf dem Markt',
    'Ich habe die Vorgängerversion gehabt – XM6 ist nochmal ein Schritt besser. Das ANC ist phenomenal, der Klang warm und detailreich, Multipoint funktioniert endlich zuverlässig.',
    'approved', '2025-01-20 18:00:00'),
(12, 8, 2, 5, 'Kein Vergleich zu meinem alten Kopfhörer',
    'Pendeln zur Arbeit ist jetzt eine entspannte Erfahrung. 30 Stunden Akku – ich lade ihn noch seltener als gedacht. Sehr empfehlenswert!',
    'approved', '2025-02-28 08:30:00'),
(12,13, 4, 4, 'Super, aber leicht drückend nach 4h',
    'Klangqualität und ANC sind hervorragend. Nach sehr langen Sessionen (4+ Stunden) spüre ich leichten Druck. Insgesamt aber ein top Produkt.',
    'approved', '2025-03-12 21:00:00'),

-- MacBook Air M3 (product 7)
(7,  3, 1, 5, 'Perfekter Geschäftslaptop',
    'Wir haben 5 MacBook Air M3 für unser Team gekauft. Schnell, leise, langer Akku – kein einziges Problem nach 3 Monaten. Klare Kaufempfehlung.',
    'approved', '2025-02-20 11:00:00'),
(7, 11, 3, 5, 'Lautlos und schnell',
    'Kein Lüfter = kein Lärm. In der Bibliothek oder in Meetings perfekt. Der M3 ist schneller als alles, was ich bisher hatte.',
    'approved', '2025-03-15 16:30:00'),

-- AirPods Pro 4 (product 15)
(15, 6, 1, 5, 'Endlich perfektes ANC',
    'Adaptives Audio ist genialer als erwartet – wechselt automatisch zwischen ANC und Transparenz. Klang ist klar und räumlich. Der beste Kauf in diesem Jahr.',
    'approved', '2025-03-08 20:00:00'),
(15, 8, 2, 4, 'Sehr gut, aber teurer als früher',
    'Technisch top. ANC ist stark, Transparenzmodus klingt natürlich. Preis ist gestiegen, aber für Apple-Nutzer gibt es nichts Besseres.',
    'approved', '2025-03-14 09:00:00'),

-- Bose SoundLink Max (product 19)
(19,13, 4, 5, 'Kräftiger Sound, toll für draußen',
    '20 Stunden Akku und IP67 – nehme ihn mit an den See, in den Garten, überall. Der Sound ist erstaunlich voll für einen portablen Lautsprecher.',
    'approved', '2025-03-02 17:00:00'),

-- Google Pixel 9 Pro (product 5)
(5, 10, 2, 5, 'Beste Kamera in einem Android-Phone',
    'Add Me ist ein Lifesaver – endlich bin ich selbst auf Gruppenfotos drauf. Magic Eraser benutze ich täglich. 7 Jahre Updates geben Sicherheit.',
    'approved', '2025-03-16 12:00:00'),

-- Dell XPS 15 (product 9)
(9,  3, 1, 5, 'Unser neuer Office-Standard',
    'Für Grafikarbeiten und Video-Konferenzen einfach perfekt. OLED-Display ist Klasse A. RTX 4060 macht auch anspruchsvolle Aufgaben locker.',
    'approved', '2025-02-05 14:00:00'),

-- Sony Alpha 7 IV (product 28)
(28,12, 3, 5, 'Professionelle Qualität, zugänglicher Preis',
    'Für unsere Produktfotografie ist die A7 IV ein absoluter Gewinn. 33 MP sind reichlich für jedes Format, der IBIS ermöglicht auch Freihand-Aufnahmen in Innenräumen.',
    'approved', '2025-03-18 10:00:00'),

-- Nest Thermostat (product 27)
(27,15, 5, 5, 'Installation in 20 Minuten, spart wirklich Energie',
    'Einfach zu installieren, App ist intuitiv. Nach zwei Monaten merke ich ca. 12% weniger Gasverbrauch. Google Assistant Integration funktioniert reibungslos.',
    'approved', '2025-02-15 11:30:00'),

-- iPad Pro M4 (product 20)
(20, 4, 1, 5, 'Das beste iPad – und das dünnste Gerät aller Zeiten',
    'Das Tandem OLED-Display ist einfach spektakulär. Mit Apple Pencil Pro und Magic Keyboard ist es ein vollwertiger Laptop-Ersatz für meine Arbeit.',
    'approved', '2025-03-01 09:30:00');

-- ─────────────────────────────────────────────
--  THEME SETTINGS
-- ─────────────────────────────────────────────
DELETE FROM theme_settings;
INSERT INTO theme_settings (branch_id, scope, theme_name, settings) VALUES
(NULL,  'frontend', 'default',  '{"primary_color":"#1a56db","secondary_color":"#f59e0b","font":"Inter","logo":null}'),
(NULL,  'backend',  'default',  '{"sidebar_color":"#1e293b","accent":"#3b82f6"}'),
(1,     'frontend', 'default',  '{"primary_color":"#1a56db","branch_accent":"#2563eb","hero_image":"branches/koeln-hero.webp"}'),
(2,     'frontend', 'default',  '{"primary_color":"#1a56db","branch_accent":"#6d28d9","hero_image":"branches/berlin-hero.webp"}'),
(3,     'frontend', 'default',  '{"primary_color":"#1a56db","branch_accent":"#0891b2","hero_image":"branches/muenchen-hero.webp"}'),
(4,     'frontend', 'default',  '{"primary_color":"#1a56db","branch_accent":"#0f766e","hero_image":"branches/hamburg-hero.webp"}'),
(5,     'frontend', 'minimal',  '{"primary_color":"#dc2626","branch_accent":"#dc2626","hero_image":"branches/austria-hero.webp"}');

-- ─────────────────────────────────────────────
--  UI TRANSLATIONS (Datenbank-gestützte Strings)
-- ─────────────────────────────────────────────
DELETE FROM translations;
INSERT INTO translations (lang_code, `key`, value, group_name) VALUES
-- Allgemein DE
('de','app.name',                   'TechStore',                            'general'),
('de','layout.skip_to_content',     'Zum Inhalt springen',                  'general'),
('de','nav.home',                   'Startseite',                           'nav'),
('de','nav.back',                   'Zurück',                               'nav'),
('de','nav.search',                 'Suche',                                'nav'),
('de','nav.open_menu',              'Menü öffnen',                          'nav'),
('de','cart.title',                 'Warenkorb',                            'cart'),
('de','cart.empty',                 'Ihr Warenkorb ist leer.',              'cart'),
('de','cart.add_to_cart',           'In den Warenkorb',                     'cart'),
('de','cart.checkout',              'Zur Kasse',                            'cart'),
('de','cart.total',                 'Gesamtbetrag',                         'cart'),
('de','cart.subtotal',              'Zwischensumme',                        'cart'),
('de','cart.shipping',              'Versand',                              'cart'),
('de','cart.quantity',              'Menge',                                'cart'),
('de','product.in_stock',           'Auf Lager',                            'product'),
('de','product.out_of_stock',       'Ausverkauft',                          'product'),
('de','product.add_to_cart',        'In den Warenkorb',                     'product'),
('de','product.description',        'Beschreibung',                         'product'),
('de','product.related',            'Ähnliche Produkte',                    'product'),
('de','checkout.delivery_method',   'Liefermethode',                        'checkout'),
('de','checkout.shipping',          'Versand',                              'checkout'),
('de','checkout.pickup',            'Abholung',                             'checkout'),
('de','checkout.payment',           'Zahlung',                              'checkout'),
('de','checkout.place_order',       'Kostenpflichtig bestellen',            'checkout'),
('de','auth.login',                 'Anmelden',                             'auth'),
('de','auth.logout',                'Abmelden',                             'auth'),
('de','auth.register',              'Registrieren',                         'auth'),
('de','auth.email',                 'E-Mail-Adresse',                       'auth'),
('de','auth.password',              'Passwort',                             'auth'),
('de','account.orders',             'Meine Bestellungen',                   'account'),
('de','account.profile',            'Profil',                               'account'),
('de','account.addresses',          'Adressen',                             'account'),
('de','account.documents',          'Unternehmensdokumente',                'account'),
('de','errors.branch_mismatch',     'Sie können nur bei Ihrer zugewiesenen Filiale bestellen.', 'errors'),
('de','errors.not_found',           'Seite nicht gefunden.',                'errors'),
('de','errors.server_error',        'Ein Fehler ist aufgetreten.',          'errors'),
('de','delivery.free',              'Kostenlos',                            'delivery'),
('de','delivery.shipping_from',     'Versandkostenfrei ab :amount',         'delivery'),
('de','delivery.estimated_days',    'Lieferung in :min–:max Werktagen',     'delivery'),
-- English
('en','app.name',                   'TechStore',                            'general'),
('en','cart.title',                 'Cart',                                 'cart'),
('en','cart.empty',                 'Your cart is empty.',                  'cart'),
('en','cart.add_to_cart',           'Add to Cart',                          'cart'),
('en','cart.checkout',              'Checkout',                             'cart'),
('en','product.in_stock',           'In Stock',                             'product'),
('en','product.out_of_stock',       'Out of Stock',                         'product'),
('en','product.description',        'Description',                          'product'),
('en','checkout.place_order',       'Place Order',                          'checkout'),
('en','auth.login',                 'Sign In',                              'auth'),
('en','auth.logout',                'Sign Out',                             'auth'),
('en','auth.register',              'Register',                             'auth'),
('en','errors.branch_mismatch',     'You can only order from your assigned branch.', 'errors'),
('en','delivery.free',              'Free',                                 'delivery');

-- ─────────────────────────────────────────────
--  ACTIVITY LOGS (sample audit trail)
-- ─────────────────────────────────────────────
DELETE FROM activity_logs;
INSERT INTO activity_logs (user_type, user_id, action, model, model_id, payload, ip_address, created_at) VALUES
('admin',    1, 'login',          NULL,      NULL, '{"email":"admin@techstore.de"}',                          '127.0.0.1',      '2025-03-19 09:00:00'),
('admin',    3, 'order.status',   'orders',  5,    '{"from":"confirmed","to":"processing"}',                  '195.65.12.88',   '2025-03-13 09:00:00'),
('admin',    3, 'document.review','company_documents', 1,'{"status":"accepted"}',                             '195.65.12.88',   '2025-02-10 10:05:00'),
('admin',    2, 'product.create', 'products',1,    '{"sku":"SPH-SAM-S25U-256"}',                              '127.0.0.1',      '2024-12-10 09:00:00'),
('customer', 1, 'login',         NULL,       NULL, '{"email":"lena.fischer@gmail.com","branch_id":1}',        '91.12.34.56',    '2025-03-18 20:11:00'),
('customer', 3, 'order.place',   'orders',   7,    '{"total":"3598.00","type":"standard"}',                   '195.65.12.88',   '2025-03-19 10:00:00'),
('customer', 7, 'login',         NULL,       NULL, '{"email":"felix.bauer@berlin.de","branch_id":2}',         '87.123.45.67',   '2025-03-19 07:30:00'),
('admin',    4, 'order.status',  'orders',   9,    '{"from":"processing","to":"shipped"}',                    '194.55.88.11',   '2025-02-25 09:30:00');

SET FOREIGN_KEY_CHECKS = 1;
