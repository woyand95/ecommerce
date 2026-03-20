-- ============================================================
--  SEED DATA — PART 2
--  Products · Translations · Images · Attributes · Variants
-- ============================================================

-- ─────────────────────────────────────────────
--  PRODUCTS (30 items across all categories)
-- ─────────────────────────────────────────────
DELETE FROM products;
INSERT INTO products (id, sku, barcode, category_id, type, weight, width, height, depth, tax_class, is_active, is_featured, sort_order) VALUES
-- Smartphones
( 1, 'SPH-SAM-S25U-256',  '8806095302714', 9,  'variable', 0.228, 7.97, 16.27, 0.88, 'standard', 1, 1,  1),
( 2, 'SPH-SAM-S25-128',   '8806095310139', 9,  'variable', 0.162, 7.07, 15.58, 0.77, 'standard', 1, 0,  2),
( 3, 'SPH-APP-IP16P-256', '0194253438656', 10, 'variable', 0.227, 7.12, 16.01, 0.82, 'standard', 1, 1,  3),
( 4, 'SPH-APP-IP16-128',  '0194253438649', 10, 'variable', 0.170, 7.08, 14.73, 0.78, 'standard', 1, 0,  4),
( 5, 'SPH-GOO-P9P-256',   '0842776112218', 9,  'simple',   0.221, 7.68, 16.26, 0.87, 'standard', 1, 0,  5),
( 6, 'SPH-ONE-12R-256',   '6921815623947', 9,  'simple',   0.199, 7.38, 16.36, 0.81, 'standard', 1, 0,  6),
-- Laptops
( 7, 'LPT-APP-MBA-M3-8',  '0194253842736', 15, 'variable', 1.240, 30.41, 21.24, 1.13,'standard', 1, 1,  1),
( 8, 'LPT-APP-MBP-M4-16', '0194253998012', 15, 'variable', 1.550, 35.57, 24.81, 1.55,'standard', 1, 0,  2),
( 9, 'LPT-DEL-XPS-15-I7', 'DLX15I7512EU', 14, 'simple',   1.860, 34.42, 23.04, 1.84,'standard', 1, 1,  3),
(10, 'LPT-LEN-X1C-I5-16', 'LNX1CI516EU',  14, 'simple',   1.120, 31.65, 21.73, 1.49,'standard', 1, 0,  4),
(11, 'LPT-ASU-ZB-I7-32',  'ASZBI732EU',   14, 'simple',   1.390, 32.09, 22.41, 1.49,'standard', 1, 0,  5),
-- Audio - Headphones
(12, 'AUD-SNY-WH1000XM6', 'SNY1000XM6EU', 11, 'variable', 0.250, 18.00, 20.00, 8.10,'standard', 1, 1,  1),
(13, 'AUD-APL-APP-MAX-SL', '0194253086550',11, 'variable', 0.386, 19.30, 16.80, 8.40,'standard', 1, 0,  2),
(14, 'AUD-BOS-QC45-II',   'QC45IIBLKEU',  11, 'simple',   0.240, 18.60, 20.00, 8.00,'standard', 1, 0,  3),
-- Audio - Earbuds
(15, 'AUD-APL-APWP4-WH',  '0194253900993',13, 'variable', 0.054, 4.62,  5.47,  2.21,'standard', 1, 1,  1),
(16, 'AUD-SNY-WF1000XM5', 'SNYWF1000EU',  13, 'variable', 0.047, 5.10,  4.90,  2.30,'standard', 1, 0,  2),
(17, 'AUD-SAM-GBP3-BK',   'SAMGBP3BKEU',  13, 'simple',   0.053, 4.90,  5.20,  2.50,'standard', 1, 0,  3),
-- Audio - Speakers
(18, 'AUD-SON-SRS-XB100',  'SONXB100BLK',  12, 'variable', 0.386, 7.30,  7.30, 7.30,'standard', 1, 0,  1),
(19, 'AUD-BOS-SND-300',    'BOSSND300BLK', 12, 'simple',   1.000,22.00, 11.60, 9.80,'standard', 1, 1,  2),
-- Tablets
(20, 'TAB-APP-IPAP13-256', '0194253887096',4,  'variable', 0.617,28.17, 21.50, 0.62,'standard', 1, 1,  1),
(21, 'TAB-SAM-TAB-S9FE-6', '8806094854558',4,  'simple',   0.523,25.40, 16.56, 0.61,'standard', 1, 0,  2),
-- Gaming
(22, 'GAM-SHR-GSN-10X',    'SHRGSNBKEU',   16, 'variable', 0.320,18.00, 20.00, 8.00,'standard', 1, 1,  1),
(23, 'GAM-LGT-G-PRO-X2',   'LGTGPROX2EU',  17, 'simple',   0.106, 6.24,  5.00, 2.00,'standard', 1, 1,  1),
(24, 'GAM-RZR-HNT-V3',     'RZRHNTV3EU',   18, 'simple',   0.980,36.54, 13.93, 3.80,'standard', 1, 0,  2),
-- Smart Home
(25, 'SHM-PHI-HUE-STA-4',  'PHIHUESTA4EU', 6,  'simple',   0.450,10.00,  5.00,10.00,'standard', 1, 0,  1),
(26, 'SHM-AMZ-ECH-DOT5',   'ECHD5GRYEU',   6,  'variable', 0.304, 9.96,  9.96, 8.91,'standard', 1, 0,  2),
(27, 'SHM-NES-THER-4TH',   'NESTHR4EU',    6,  'simple',   0.239,10.10, 10.10, 2.90,'standard', 1, 1,  3),
-- Cameras
(28, 'CAM-SON-A7IV-BODY',   'SONYA7IVEU',   8,  'simple',   0.658,13.15,  9.63, 7.72,'standard', 1, 1,  1),
(29, 'CAM-CAN-R8-BODY',     'CANR8BODY',    8,  'simple',   0.461,13.23,  8.60, 5.92,'standard', 1, 0,  2),
-- Accessories
(30, 'ACC-APL-USBC-MFI-1M', '0194253901877',5,  'variable', 0.035,12.00,  1.50, 1.50,'standard', 1, 0,  1);

-- ─────────────────────────────────────────────
--  PRODUCT TRANSLATIONS
-- ─────────────────────────────────────────────
DELETE FROM product_translations;
INSERT INTO product_translations (product_id, lang_code, name, short_description, description, meta_title, meta_description, url_slug) VALUES
-- Product 1: Samsung Galaxy S25 Ultra
(1,'de','Samsung Galaxy S25 Ultra','Das ultimative Android-Flagship mit Galaxy AI und integriertem S Pen.',
'<h2>Samsung Galaxy S25 Ultra</h2><p>Das <strong>Galaxy S25 Ultra</strong> setzt neue Maßstäbe im Smartphone-Bereich. Mit dem integrierten S Pen, der leistungsstarken Galaxy AI und dem brillanten 6,9-Zoll-Display ist es das perfekte Gerät für Power-User.</p><h3>Highlights</h3><ul><li>6,9" Dynamic LTPO AMOLED 2X, 120 Hz</li><li>Snapdragon 8 Elite Prozessor</li><li>200 MP Hauptkamera + dreifacher Telezoom</li><li>5.000 mAh Akku mit 45 W Schnellladen</li><li>S Pen integriert</li><li>Galaxy AI: Circle to Search, Note Assist, Chat Assist</li></ul><p>Erhältlich in Titanium Gray, Titanium Black und Titanium Silver Blue.</p>',
'Samsung Galaxy S25 Ultra kaufen','Samsung Galaxy S25 Ultra mit 200 MP Kamera und Galaxy AI. Jetzt kaufen & schnell liefern lassen.','samsung-galaxy-s25-ultra'),
(1,'en','Samsung Galaxy S25 Ultra','The ultimate Android flagship with Galaxy AI and built-in S Pen.',
'<h2>Samsung Galaxy S25 Ultra</h2><p>The <strong>Galaxy S25 Ultra</strong> sets new standards. With its built-in S Pen, powerful Galaxy AI and brilliant 6.9-inch display, it is the perfect device for power users.</p><h3>Highlights</h3><ul><li>6.9" Dynamic LTPO AMOLED 2X, 120 Hz</li><li>Snapdragon 8 Elite processor</li><li>200 MP main camera + triple telephoto zoom</li><li>5,000 mAh battery with 45W fast charging</li><li>Built-in S Pen</li><li>Galaxy AI: Circle to Search, Note Assist, Chat Assist</li></ul>',
'Buy Samsung Galaxy S25 Ultra','Samsung Galaxy S25 Ultra with 200MP camera & Galaxy AI. Order now with fast delivery.','samsung-galaxy-s25-ultra'),

-- Product 2: Samsung S25
(2,'de','Samsung Galaxy S25','Das Kompakt-Flagship – leistungsstark, dünn und vielseitig.',
'<h2>Samsung Galaxy S25</h2><p>Das <strong>Galaxy S25</strong> bietet Flagship-Power im kompakten Format. Snapdragon 8 Elite, 50-MP-Kamera und eine lange Akkulaufzeit – alles in einem eleganten Design.</p><ul><li>6,2" Dynamic AMOLED 2X, 120 Hz</li><li>Snapdragon 8 Elite</li><li>50 MP Hauptkamera</li><li>4.000 mAh Akku</li></ul>',
'Samsung Galaxy S25 kaufen','Samsung Galaxy S25 – kompaktes Flagship mit Snapdragon 8 Elite.','samsung-galaxy-s25'),
(2,'en','Samsung Galaxy S25','The compact flagship – powerful, thin and versatile.',
'<h2>Samsung Galaxy S25</h2><p>The <strong>Galaxy S25</strong> delivers flagship power in a compact form. Snapdragon 8 Elite, 50MP camera and long battery life.</p><ul><li>6.2" Dynamic AMOLED 2X, 120 Hz</li><li>Snapdragon 8 Elite</li><li>50 MP main camera</li><li>4,000 mAh battery</li></ul>',
'Buy Samsung Galaxy S25','Samsung Galaxy S25 – compact flagship with Snapdragon 8 Elite.','samsung-galaxy-s25'),

-- Product 3: iPhone 16 Pro
(3,'de','Apple iPhone 16 Pro','Professionelles iPhone mit A18 Pro Chip und 5-fach Teleobjektiv.',
'<h2>Apple iPhone 16 Pro</h2><p>Das <strong>iPhone 16 Pro</strong> hebt die iPhone-Erfahrung auf ein neues Niveau. Mit dem A18 Pro Chip, dem neuen Camera Control Button und bis zu 33 Stunden Videowiedergabe ist es das leistungsfähigste iPhone aller Zeiten.</p><h3>Kamera-System</h3><ul><li>48 MP Fusion-Kamera (Hauptkamera)</li><li>12 MP Ultraweitwinkel</li><li>12 MP 5-fach Teleobjektiv</li><li>Camera Control-Taste</li><li>4K 120fps ProRes Video</li></ul><h3>Design</h3><p>Titan-Gehäuse in Desert Titanium, Black Titanium, White Titanium und Natural Titanium. Display: 6,3" Super Retina XDR ProMotion, 120 Hz.</p>',
'Apple iPhone 16 Pro kaufen','iPhone 16 Pro – A18 Pro, 5-fach Zoom, Titan-Design. Jetzt bestellen.','apple-iphone-16-pro'),
(3,'en','Apple iPhone 16 Pro','Professional iPhone with A18 Pro chip and 5x telephoto.',
'<h2>Apple iPhone 16 Pro</h2><p>The iPhone 16 Pro takes the experience to a new level. A18 Pro chip, Camera Control button and up to 33 hours video playback.</p><ul><li>48 MP Fusion camera</li><li>12 MP ultrawide</li><li>12 MP 5x telephoto</li><li>Camera Control</li><li>4K 120fps ProRes video</li></ul>',
'Buy Apple iPhone 16 Pro','iPhone 16 Pro – A18 Pro, 5x zoom, titanium design.','apple-iphone-16-pro'),

-- Product 4: iPhone 16
(4,'de','Apple iPhone 16','Das meistverkaufte iPhone mit A18 Chip und Camera Control.',
'<h2>Apple iPhone 16</h2><p>Das <strong>iPhone 16</strong> bringt viele Pro-Features in ein zugänglicheres Paket. A18 Chip, Camera Control und das neue Action-Erlebnis mit Apple Intelligence.</p><ul><li>6,1" Super Retina XDR, 60 Hz</li><li>A18 Chip</li><li>48 MP Fusion-Kamera</li><li>3.561 mAh Akku</li></ul>',
'Apple iPhone 16 kaufen','iPhone 16 mit A18 Chip & Camera Control. Günstig & schnell liefern lassen.','apple-iphone-16'),
(4,'en','Apple iPhone 16','The best-selling iPhone with A18 chip and Camera Control.',
'<h2>Apple iPhone 16</h2><p>The iPhone 16 brings many Pro features into an accessible package. A18 Chip, Camera Control and Apple Intelligence.</p><ul><li>6.1" Super Retina XDR, 60 Hz</li><li>A18 Chip</li><li>48 MP Fusion camera</li></ul>',
'Buy Apple iPhone 16','iPhone 16 with A18 chip & Camera Control.','apple-iphone-16'),

-- Product 5: Google Pixel 9 Pro
(5,'de','Google Pixel 9 Pro','Googles bestes Kamera-Smartphone mit Tensor G4 und 7 Jahren Updates.',
'<h2>Google Pixel 9 Pro</h2><p>Das <strong>Pixel 9 Pro</strong> ist Googles ambitioniertestes Smartphone. Mit dem neuen Tensor G4 Chip, einem überarbeiteten Kamerasystem und sieben Jahren garantierter Updates ist es eine hervorragende Langzeitinvestition.</p><ul><li>6,3" LTPO OLED, 120 Hz</li><li>Google Tensor G4</li><li>50 MP + 48 MP Ultraweitwinkel + 48 MP Tele (5-fach)</li><li>Add Me, Magic Eraser, Best Take</li><li>7 Jahre OS-Updates</li></ul>',
'Google Pixel 9 Pro kaufen','Google Pixel 9 Pro – Tensor G4, 7 Jahre Updates, Top-Kamera.','google-pixel-9-pro'),
(5,'en','Google Pixel 9 Pro','Google''s best camera smartphone with Tensor G4 and 7 years of updates.',
'<h2>Google Pixel 9 Pro</h2><p>The Pixel 9 Pro is Google''s most ambitious smartphone. Tensor G4, redesigned camera system and seven years of guaranteed updates.</p>',
'Buy Google Pixel 9 Pro','Google Pixel 9 Pro – Tensor G4, 7 years updates, top camera.','google-pixel-9-pro'),

-- Product 7: MacBook Air M3
(7,'de','Apple MacBook Air 13" M3','Der leichteste MacBook Air mit M3 Chip – leistungsstark und fanlos.',
'<h2>Apple MacBook Air 13" M3</h2><p>Das <strong>MacBook Air mit M3</strong> ist der perfekte Allrounder. Leicht, leistungsstark und mit bis zu 18 Stunden Akkulaufzeit – ohne Lüfter, ohne Kompromisse.</p><ul><li>13,6" Liquid Retina Display</li><li>Apple M3 Chip (8-Core CPU, 10-Core GPU)</li><li>8 GB oder 16 GB Unified Memory</li><li>256 GB bis 2 TB SSD</li><li>Bis zu 18 Std. Akkulaufzeit</li><li>MagSafe 3, 2× Thunderbolt 4, 3,5-mm-Klinke</li></ul>',
'Apple MacBook Air M3 kaufen','MacBook Air M3 – leicht, leistungsstark, bis zu 18 Std. Akku.','apple-macbook-air-m3'),
(7,'en','Apple MacBook Air 13" M3','The lightest MacBook Air with M3 chip – powerful and fanless.',
'<h2>Apple MacBook Air 13" M3</h2><p>The MacBook Air with M3 is the perfect all-rounder. Light, powerful and up to 18 hours battery life – fanless, no compromises.</p><ul><li>13.6" Liquid Retina Display</li><li>Apple M3 (8-core CPU, 10-core GPU)</li><li>8 GB or 16 GB Unified Memory</li><li>Up to 18 hours battery</li></ul>',
'Buy Apple MacBook Air M3','MacBook Air M3 – light, powerful, up to 18h battery.','apple-macbook-air-m3'),

-- Product 9: Dell XPS 15
(9,'de','Dell XPS 15 (9530) Intel Core i7','Premium Windows-Laptop mit OLED-Display und InfinityEdge-Design.',
'<h2>Dell XPS 15</h2><p>Das <strong>Dell XPS 15</strong> ist der Goldstandard unter den Windows-Laptops. Mit einem 3,5K OLED-Touchscreen, Intel Core i7 und NVIDIA GeForce RTX 4060 ist es ideal für kreative Anwender und Profis.</p><ul><li>15,6" 3,5K OLED Touch (3456×2160)</li><li>Intel Core i7-13700H</li><li>16 GB DDR5-RAM</li><li>512 GB NVMe SSD</li><li>NVIDIA GeForce RTX 4060 (8 GB)</li></ul>',
'Dell XPS 15 kaufen','Dell XPS 15 mit OLED-Display und RTX 4060 – jetzt kaufen.','dell-xps-15-i7'),
(9,'en','Dell XPS 15 (9530) Intel Core i7','Premium Windows laptop with OLED display and InfinityEdge design.',
'<h2>Dell XPS 15</h2><p>The Dell XPS 15 is the gold standard in Windows laptops. 3.5K OLED touchscreen, Intel Core i7 and NVIDIA GeForce RTX 4060.</p>',
'Buy Dell XPS 15','Dell XPS 15 with OLED display and RTX 4060.','dell-xps-15-i7'),

-- Product 12: Sony WH-1000XM6
(12,'de','Sony WH-1000XM6','Der beste Noise-Cancelling-Kopfhörer der Welt – 6. Generation.',
'<h2>Sony WH-1000XM6</h2><p>Der <strong>WH-1000XM6</strong> setzt die Messlatte für Over-Ear-Kopfhörer erneut höher. Mit 8 Mikrofonen, dem neuen HD Noise Cancelling Processor QN3 und 30 Stunden Akkulaufzeit ist er unerreicht.</p><ul><li>Branchenführendes ANC mit Multi-Noise Sensor</li><li>30 Stunden Laufzeit (ANC ein), 3 Min = 3 Std</li><li>LDAC, DSEE Extreme Upscaling</li><li>Speak-to-Chat & Adaptive Sound Control</li><li>Multipoint-Verbindung (2 Geräte)</li><li>Faltbares Design, mitgeliefertes Etui</li></ul>',
'Sony WH-1000XM6 kaufen','Sony WH-1000XM6 – bester ANC-Kopfhörer, 30h Akku, LDAC.','sony-wh-1000xm6'),
(12,'en','Sony WH-1000XM6','The world''s best noise-cancelling headphones – 6th generation.',
'<h2>Sony WH-1000XM6</h2><p>The WH-1000XM6 raises the bar again. 8 microphones, HD Noise Cancelling Processor QN3 and 30-hour battery life.</p><ul><li>Industry-leading ANC</li><li>30h battery, 3 min = 3h</li><li>LDAC, DSEE Extreme</li><li>Multipoint (2 devices)</li></ul>',
'Buy Sony WH-1000XM6','Sony WH-1000XM6 – best ANC headphones, 30h battery.','sony-wh-1000xm6'),

-- Product 15: AirPods Pro 4
(15,'de','Apple AirPods Pro (4. Generation)','True Wireless Earbuds mit adaptivem ANC und H2 Chip.',
'<h2>Apple AirPods Pro (4. Generation)</h2><p>Die <strong>AirPods Pro der 4. Generation</strong> bringen das beste ANC aller Zeiten in einen kompakten Earbud. Mit dem H2 Chip, adaptiver Geräuschunterdrückung und Transparenzmodus erleben Sie Sound wie nie zuvor.</p><ul><li>Adaptives Audio (ANC + Transparenz automatisch)</li><li>H2 Chip</li><li>Bis zu 6h (ANC), 30h mit Case</li><li>MagSafe, USB-C und Qi2 Laden</li><li>IPX4 wasserdicht</li></ul>',
'Apple AirPods Pro 4 kaufen','AirPods Pro 4 – adaptives ANC, H2 Chip, 30h Gesamtlaufzeit.','apple-airpods-pro-4'),
(15,'en','Apple AirPods Pro (4th Generation)','True wireless earbuds with adaptive ANC and H2 chip.',
'<h2>Apple AirPods Pro (4th Generation)</h2><p>The AirPods Pro 4 bring the best ANC ever into a compact earbud. H2 Chip, Adaptive Audio and Transparency Mode.</p><ul><li>Adaptive Audio</li><li>H2 Chip</li><li>Up to 6h (ANC on), 30h with case</li><li>MagSafe, USB-C and Qi2 charging</li></ul>',
'Buy Apple AirPods Pro 4','AirPods Pro 4 – adaptive ANC, H2 chip, 30h total battery.','apple-airpods-pro-4'),

-- Product 19: Bose SoundLink Max
(19,'de','Bose SoundLink Max','Der kraftvollste Bluetooth-Lautsprecher von Bose für drinnen und draußen.',
'<h2>Bose SoundLink Max</h2><p>Der <strong>Bose SoundLink Max</strong> liefert Bose-typischen Premium-Sound in einem tragbaren Design. Ob am Pool, im Park oder zuhause – 20 Stunden Akkulaufzeit und IP67-Schutz machen ihn zum idealen Begleiter.</p><ul><li>360°-Klang mit kraftvollem Bass</li><li>20h Akkulaufzeit</li><li>IP67: staub- und wasserdicht</li><li>Zwei Lautsprecher koppelbar (Party Mode)</li><li>USB-C Ladeeingang + integriertes Netzkabel</li></ul>',
'Bose SoundLink Max kaufen','Bose SoundLink Max – 20h Akku, IP67, 360° Sound.','bose-soundlink-max'),
(19,'en','Bose SoundLink Max','The most powerful Bose Bluetooth speaker for indoors and outdoors.',
'<h2>Bose SoundLink Max</h2><p>The Bose SoundLink Max delivers premium sound in a portable design. 20 hours battery and IP67 protection.</p><ul><li>360° sound with powerful bass</li><li>20h battery</li><li>IP67 dustproof & waterproof</li><li>Party Mode (two speakers)</li></ul>',
'Buy Bose SoundLink Max','Bose SoundLink Max – 20h battery, IP67, 360° sound.','bose-soundlink-max'),

-- Product 20: iPad Pro M4
(20,'de','Apple iPad Pro 13" M4','Das leistungsfähigste iPad aller Zeiten mit Ultra Retina XDR Display.',
'<h2>Apple iPad Pro 13" M4</h2><p>Das <strong>iPad Pro 13" M4</strong> ist das dünnste Apple-Produkt aller Zeiten und das leistungsfähigste iPad. Mit dem M4 Chip, dem Ultra Retina XDR Display mit tandem OLED-Technologie und Apple Pencil Pro ist es das perfekte Gerät für Kreative.</p><ul><li>13" Ultra Retina XDR (Tandem OLED), 120 Hz</li><li>Apple M4 Chip</li><li>256 GB bis 2 TB</li><li>Apple Pencil Pro kompatibel</li><li>Magic Keyboard mit Trackpad kompatibel</li><li>Wi-Fi 6E + optionales 5G</li></ul>',
'Apple iPad Pro M4 kaufen','iPad Pro 13" M4 – Tandem OLED, ultra-dünn, professionell.','apple-ipad-pro-13-m4'),
(20,'en','Apple iPad Pro 13" M4','The most capable iPad ever with Ultra Retina XDR display.',
'<h2>Apple iPad Pro 13" M4</h2><p>The iPad Pro 13" M4 is Apple''s thinnest product ever and the most capable iPad. M4 chip, Ultra Retina XDR with tandem OLED and Apple Pencil Pro.</p>',
'Buy Apple iPad Pro M4','iPad Pro 13" M4 – tandem OLED, ultra-thin, professional.','apple-ipad-pro-13-m4'),

-- Product 23: Logitech G Pro X2
(23,'de','Logitech G PRO X 2 LIGHTSPEED','Professionelle Gaming-Maus – entwickelt mit Esport-Profis.',
'<h2>Logitech G PRO X 2 LIGHTSPEED</h2><p>Die <strong>G PRO X 2</strong> ist das Ergebnis jahrelanger Zusammenarbeit mit Esport-Profis. Mit dem HERO 25K Sensor, LIGHTSPEED Wireless und dem leichten Gehäuse (60 g) ist sie eine der präzisesten Mäuse auf dem Markt.</p><ul><li>HERO 25K Sensor (100–25.600 DPI)</li><li>LIGHTSPEED Wireless, bis zu 70h Akku</li><li>Über 5 Mio. Klicks garantiert</li><li>60 g Gewicht</li><li>Windows & Mac kompatibel</li></ul>',
'Logitech G Pro X 2 kaufen','Logitech G PRO X 2 – HERO 25K, LIGHTSPEED, 60g, 70h Akku.','logitech-g-pro-x2-lightspeed'),
(23,'en','Logitech G PRO X 2 LIGHTSPEED','Professional gaming mouse – developed with esport pros.',
'<h2>Logitech G PRO X 2 LIGHTSPEED</h2><p>The result of years of collaboration with esport pros. HERO 25K Sensor, LIGHTSPEED Wireless and 60g lightweight design.</p>',
'Buy Logitech G Pro X2','Logitech G PRO X 2 – HERO 25K, LIGHTSPEED, 60g, 70h battery.','logitech-g-pro-x2-lightspeed'),

-- Product 27: Nest Thermostat
(27,'de','Google Nest Thermostat (4. Generation)','Smarter Thermostat mit KI-Lernfunktion für mehr Komfort und Energiesparen.',
'<h2>Google Nest Thermostat</h2><p>Der <strong>Google Nest Thermostat</strong> lernt Ihre Gewohnheiten und passt die Temperatur automatisch an. Steuern Sie ihn per App, Stimme oder direkt am Gerät.</p><ul><li>Selbstlernende KI-Funktion</li><li>Google Home & Alexa kompatibel</li><li>Energiesparmodus spart bis zu 15% Heizkosten</li><li>Installierbar in unter 30 Minuten</li><li>OLED-Display</li></ul>',
'Google Nest Thermostat kaufen','Nest Thermostat 4 – smart, lernfähig, bis 15% Energie sparen.','google-nest-thermostat-4'),
(27,'en','Google Nest Thermostat (4th Generation)','Smart thermostat with AI learning for comfort and energy savings.',
'<h2>Google Nest Thermostat</h2><p>The Nest Thermostat learns your schedule and programs itself. Control it via app, voice or directly on the device.</p>',
'Buy Google Nest Thermostat','Nest Thermostat 4 – smart, self-learning, save up to 15% energy.','google-nest-thermostat-4'),

-- Product 28: Sony Alpha 7 IV
(28,'de','Sony Alpha 7 IV Gehäuse','Vollformat-Systemkamera für Fotos und Videos auf Profi-Niveau.',
'<h2>Sony Alpha 7 IV</h2><p>Die <strong>Alpha 7 IV</strong> ist die perfekte Hybridkamera für anspruchsvolle Fotografen und Videografen. 33 MP BSI-CMOS-Sensor, 759 Phasendetektions-AF-Punkte und 4K 60p Video machen sie zur vielseitigsten Kamera in ihrer Klasse.</p><ul><li>33 MP Vollformat BSI-CMOS Sensor</li><li>759 Phasen-AF + 425 Kontrast-AF Punkte</li><li>AI-basiertes Motiv-Tracking (Mensch, Tier, Vogel, Fahrzeug)</li><li>4K 60p (Super 35mm), 4K 30p (Vollformat)</li><li>In-Body Image Stabilization (5,5 Stufen)</li><li>Dual-Card-Slot (CFexpress Typ A + SD)</li></ul>',
'Sony Alpha 7 IV kaufen','Sony A7 IV – 33 MP, 4K 60p, IBIS, AI-AF. Profi-Hybridkamera.','sony-alpha-7-iv'),
(28,'en','Sony Alpha 7 IV Body','Full-frame mirrorless camera for professional photos and video.',
'<h2>Sony Alpha 7 IV</h2><p>The Alpha 7 IV is the perfect hybrid camera. 33 MP BSI-CMOS sensor, 759 phase-detection AF points and 4K 60p video.</p>',
'Buy Sony Alpha 7 IV','Sony A7 IV – 33 MP, 4K 60p, IBIS, AI-AF. Professional hybrid camera.','sony-alpha-7-iv'),

-- Product 30: Apple USB-C Cable
(30,'de','Apple USB-C Kabel (1 m)','Offizielles Apple USB-C auf USB-C Kabel – MFi-zertifiziert.',
'<h2>Apple USB-C Kabel 1 m</h2><p>Das originale <strong>Apple USB-C Kabel</strong> lädt Ihr iPhone 15, iPhone 16, iPad oder MacBook zuverlässig und schnell. MFi-zertifiziert, langlebig und flexibel.</p><ul><li>USB 2.0, bis zu 60 W Ladeleistung</li><li>MFi-zertifiziert</li><li>1 m Kabellänge</li><li>Kompatibel mit iPhone 15 / 16, iPad Pro, MacBook</li></ul>',
'Apple USB-C Kabel kaufen','Apple USB-C Kabel 1m – offiziell, MFi, 60W – günstig kaufen.','apple-usb-c-kabel-1m'),
(30,'en','Apple USB-C Cable (1 m)','Official Apple USB-C to USB-C cable – MFi-certified.',
'<h2>Apple USB-C Cable 1m</h2><p>The original Apple USB-C Cable charges your iPhone 15, iPhone 16, iPad or MacBook reliably and quickly.</p>',
'Buy Apple USB-C Cable','Apple USB-C Cable 1m – official, MFi, 60W.','apple-usb-c-cable-1m');

-- ─────────────────────────────────────────────
--  PRODUCT IMAGES (primary images per product)
-- ─────────────────────────────────────────────
DELETE FROM product_images;
INSERT INTO product_images (product_id, file_path, alt_text, sort_order, is_primary) VALUES
( 1, 'products/1/s25-ultra-titanium-gray.webp',   'Samsung Galaxy S25 Ultra Titanium Gray',      0, 1),
( 1, 'products/1/s25-ultra-titanium-black.webp',  'Samsung Galaxy S25 Ultra Titanium Black',     1, 0),
( 1, 'products/1/s25-ultra-spen-detail.webp',     'Samsung Galaxy S25 Ultra S Pen Detail',       2, 0),
( 2, 'products/2/s25-phantom-silver.webp',         'Samsung Galaxy S25 Phantom Silver',           0, 1),
( 2, 'products/2/s25-phantom-black.webp',          'Samsung Galaxy S25 Phantom Black',            1, 0),
( 3, 'products/3/iphone16pro-desert-titanium.webp','Apple iPhone 16 Pro Desert Titanium',         0, 1),
( 3, 'products/3/iphone16pro-black-titanium.webp', 'Apple iPhone 16 Pro Black Titanium',          1, 0),
( 3, 'products/3/iphone16pro-camera.webp',         'Apple iPhone 16 Pro Kamerasystem',            2, 0),
( 4, 'products/4/iphone16-black.webp',             'Apple iPhone 16 Schwarz',                     0, 1),
( 4, 'products/4/iphone16-ultramarine.webp',       'Apple iPhone 16 Ultramarine',                 1, 0),
( 5, 'products/5/pixel9pro-obsidian.webp',         'Google Pixel 9 Pro Obsidian',                 0, 1),
( 5, 'products/5/pixel9pro-porcelain.webp',        'Google Pixel 9 Pro Porcelain',                1, 0),
( 6, 'products/6/oneplus12r-iron-gray.webp',       'OnePlus 12R Iron Gray',                       0, 1),
( 7, 'products/7/mba-m3-midnight.webp',            'MacBook Air M3 Midnight',                     0, 1),
( 7, 'products/7/mba-m3-starlight.webp',           'MacBook Air M3 Starlight',                    1, 0),
( 7, 'products/7/mba-m3-silver.webp',              'MacBook Air M3 Silber',                       2, 0),
( 8, 'products/8/mbp-m4-spacegrau.webp',           'MacBook Pro M4 Space Grau',                   0, 1),
( 9, 'products/9/dell-xps15-oled.webp',            'Dell XPS 15 OLED Display',                    0, 1),
( 9, 'products/9/dell-xps15-tastatur.webp',        'Dell XPS 15 Tastatur Detail',                 1, 0),
(10, 'products/10/lenovo-x1-carbon.webp',          'Lenovo ThinkPad X1 Carbon',                   0, 1),
(11, 'products/11/asus-zenbook-pro.webp',           'ASUS ZenBook Pro',                            0, 1),
(12, 'products/12/wh1000xm6-schwarz.webp',         'Sony WH-1000XM6 Schwarz',                     0, 1),
(12, 'products/12/wh1000xm6-silber.webp',          'Sony WH-1000XM6 Silber',                      1, 0),
(12, 'products/12/wh1000xm6-case.webp',            'Sony WH-1000XM6 mit Etui',                    2, 0),
(13, 'products/13/app-max-midnightsky.webp',       'Apple AirPods Max Midnight Sky',              0, 1),
(13, 'products/13/app-max-starlight.webp',         'Apple AirPods Max Starlight',                 1, 0),
(14, 'products/14/bose-qc45-schwarz.webp',         'Bose QuietComfort 45 Schwarz',                0, 1),
(15, 'products/15/airpods-pro4-white.webp',        'Apple AirPods Pro 4 Weiß',                    0, 1),
(15, 'products/15/airpods-pro4-case.webp',         'Apple AirPods Pro 4 MagSafe Case',            1, 0),
(16, 'products/16/wf1000xm5-schwarz.webp',         'Sony WF-1000XM5 Schwarz',                     0, 1),
(17, 'products/17/galaxy-buds-pro3.webp',          'Samsung Galaxy Buds3 Pro',                    0, 1),
(18, 'products/18/sony-xb100-schwarz.webp',        'Sony SRS-XB100 Schwarz',                      0, 1),
(19, 'products/19/bose-soundlink-max.webp',        'Bose SoundLink Max',                          0, 1),
(19, 'products/19/bose-soundlink-max-side.webp',   'Bose SoundLink Max Seitenansicht',            1, 0),
(20, 'products/20/ipad-pro-m4-silber.webp',        'Apple iPad Pro 13 M4 Silber',                 0, 1),
(20, 'products/20/ipad-pro-m4-spacegrau.webp',     'Apple iPad Pro 13 M4 Space Grau',             1, 0),
(20, 'products/20/ipad-pro-m4-pencil.webp',        'Apple iPad Pro M4 mit Apple Pencil Pro',      2, 0),
(21, 'products/21/samsung-tab-s9fe-grau.webp',     'Samsung Galaxy Tab S9 FE Grau',               0, 1),
(22, 'products/22/shroud-gsn10-schwarz.webp',      'SteelSeries Arctis Nova Pro Schwarz',         0, 1),
(23, 'products/23/logitech-gpro-x2.webp',          'Logitech G PRO X 2 Weiß',                     0, 1),
(24, 'products/24/razer-huntsman-v3.webp',         'Razer Huntsman V3 Pro',                       0, 1),
(25, 'products/25/philips-hue-starter.webp',       'Philips Hue White & Color Starter Kit',       0, 1),
(26, 'products/26/amazon-echo-dot5.webp',          'Amazon Echo Dot 5. Generation',               0, 1),
(27, 'products/27/nest-thermostat-4.webp',         'Google Nest Thermostat 4. Gen.',              0, 1),
(28, 'products/28/sony-a7iv-kamera.webp',          'Sony Alpha 7 IV Gehäuse',                     0, 1),
(28, 'products/28/sony-a7iv-seite.webp',           'Sony Alpha 7 IV Seitenansicht',               1, 0),
(29, 'products/29/canon-eosr8-front.webp',         'Canon EOS R8 Gehäuse',                        0, 1),
(30, 'products/30/apple-usbc-kabel.webp',          'Apple USB-C Kabel 1 m',                       0, 1);

-- ─────────────────────────────────────────────
--  PRODUCT ATTRIBUTES & VALUES (Farbe, Speicher, Farbe)
-- ─────────────────────────────────────────────
DELETE FROM product_attributes;
DELETE FROM product_attribute_values;
INSERT INTO product_attributes (id, name, slug) VALUES
(1, 'Farbe',    'farbe'),
(2, 'Speicher', 'speicher'),
(3, 'RAM',      'ram'),
(4, 'Größe',    'groesse');

INSERT INTO product_attribute_values (id, attribute_id, value, sort_order) VALUES
-- Farben
( 1, 1, 'Titanium Black',    1),  ( 2, 1, 'Titanium Gray',     2),  ( 3, 1, 'Titanium Silver',   3),
( 4, 1, 'Phantom Black',     4),  ( 5, 1, 'Phantom Silver',    5),  ( 6, 1, 'Icy Blue',          6),
( 7, 1, 'Desert Titanium',   7),  ( 8, 1, 'Black Titanium',    8),  ( 9, 1, 'White Titanium',    9),
(10, 1, 'Natural Titanium',  10), (11, 1, 'Schwarz',           11), (12, 1, 'Weiß',              12),
(13, 1, 'Silber',            13), (14, 1, 'Midnight',          14), (15, 1, 'Starlight',         15),
(16, 1, 'Blau',              16), (17, 1, 'Obsidian',          17), (18, 1, 'Porcelain',         18),
(19, 1, 'Space Grau',        19),
-- Speicher
(20, 2, '128 GB',  1),  (21, 2, '256 GB', 2),  (22, 2, '512 GB', 3),  (23, 2, '1 TB', 4),
-- RAM
(24, 3, '8 GB',    1),  (25, 3, '16 GB',  2),  (26, 3, '32 GB',  3),  (27, 3, '48 GB',  4),
-- Größe
(28, 4, 'XS',      1),  (29, 4, 'S',      2),  (30, 4, 'M',      3),  (31, 4, 'L',      4);

-- ─────────────────────────────────────────────
--  PRODUCT VARIANTS
-- ─────────────────────────────────────────────
DELETE FROM product_variants;
INSERT INTO product_variants (id, product_id, sku, attributes, is_active) VALUES
-- S25 Ultra variants
( 1,  1, 'SPH-SAM-S25U-256-BLK', '{"farbe":"Titanium Black","speicher":"256 GB"}',   1),
( 2,  1, 'SPH-SAM-S25U-256-GRY', '{"farbe":"Titanium Gray","speicher":"256 GB"}',    1),
( 3,  1, 'SPH-SAM-S25U-512-BLK', '{"farbe":"Titanium Black","speicher":"512 GB"}',   1),
( 4,  1, 'SPH-SAM-S25U-1TB-GRY', '{"farbe":"Titanium Gray","speicher":"1 TB"}',      1),
-- S25 variants
( 5,  2, 'SPH-SAM-S25-128-BLK',  '{"farbe":"Phantom Black","speicher":"128 GB"}',    1),
( 6,  2, 'SPH-SAM-S25-128-SLV',  '{"farbe":"Phantom Silver","speicher":"128 GB"}',   1),
( 7,  2, 'SPH-SAM-S25-256-BLK',  '{"farbe":"Phantom Black","speicher":"256 GB"}',    1),
-- iPhone 16 Pro variants
( 8,  3, 'SPH-APP-IP16P-256-DST', '{"farbe":"Desert Titanium","speicher":"256 GB"}', 1),
( 9,  3, 'SPH-APP-IP16P-256-BLK', '{"farbe":"Black Titanium","speicher":"256 GB"}',  1),
(10,  3, 'SPH-APP-IP16P-512-DST', '{"farbe":"Desert Titanium","speicher":"512 GB"}', 1),
(11,  3, 'SPH-APP-IP16P-1TB-BLK', '{"farbe":"Black Titanium","speicher":"1 TB"}',    1),
-- iPhone 16 variants
(12,  4, 'SPH-APP-IP16-128-BLK',  '{"farbe":"Schwarz","speicher":"128 GB"}',         1),
(13,  4, 'SPH-APP-IP16-128-WHT',  '{"farbe":"Weiß","speicher":"128 GB"}',            1),
(14,  4, 'SPH-APP-IP16-256-BLK',  '{"farbe":"Schwarz","speicher":"256 GB"}',         1),
-- MacBook Air M3 variants
(15,  7, 'LPT-APP-MBA-M3-8-256-MN',  '{"farbe":"Midnight","ram":"8 GB","speicher":"256 GB"}',   1),
(16,  7, 'LPT-APP-MBA-M3-8-512-SL',  '{"farbe":"Starlight","ram":"8 GB","speicher":"512 GB"}',  1),
(17,  7, 'LPT-APP-MBA-M3-16-512-SL', '{"farbe":"Silber","ram":"16 GB","speicher":"512 GB"}',    1),
-- Sony WH-1000XM6 variants
(18, 12, 'AUD-SNY-WH1000XM6-BLK',   '{"farbe":"Schwarz"}',  1),
(19, 12, 'AUD-SNY-WH1000XM6-SLV',   '{"farbe":"Silber"}',   1),
-- AirPods Pro 4 variants (just one, but for MagSafe differentiation)
(20, 15, 'AUD-APL-APP4-MAGSAFE',     '{"farbe":"Weiß"}',     1),
-- AirPods Max variants
(21, 13, 'AUD-APL-MAX-MN-BLK',       '{"farbe":"Midnight Sky"}', 1),
(22, 13, 'AUD-APL-MAX-MN-SL',        '{"farbe":"Starlight"}',    1),
-- Sony WF-1000XM5 variants
(23, 16, 'AUD-SNY-WF1000XM5-BLK',   '{"farbe":"Schwarz"}',  1),
(24, 16, 'AUD-SNY-WF1000XM5-SLV',   '{"farbe":"Silber"}',   1),
-- iPad Pro M4 variants
(25, 20, 'TAB-APP-IPAP13-256-SLV',  '{"farbe":"Silber","speicher":"256 GB"}',   1),
(26, 20, 'TAB-APP-IPAP13-256-SGR',  '{"farbe":"Space Grau","speicher":"256 GB"}',1),
(27, 20, 'TAB-APP-IPAP13-512-SLV',  '{"farbe":"Silber","speicher":"512 GB"}',   1),
-- Echo Dot variants
(28, 26, 'SHM-AMZ-ECHD5-CHAR',      '{"farbe":"Anthrazit"}', 1),
(29, 26, 'SHM-AMZ-ECHD5-BLAU',      '{"farbe":"Blau"}',      1),
-- USB-C Kabel variants (Farbe)
(30, 30, 'ACC-APL-USBC-1M-WHT',     '{"farbe":"Weiß"}',      1),
(31, 30, 'ACC-APL-USBC-1M-BLK',     '{"farbe":"Schwarz"}',   1),
(32, 30, 'ACC-APL-USBC-2M-WHT',     '{"farbe":"Weiß"}',      1);
