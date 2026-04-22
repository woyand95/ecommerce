/*M!999999\- enable the sandbox mode */

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

LOCK TABLES `activity_logs` WRITE;
/*!40000 ALTER TABLE `activity_logs` DISABLE KEYS */;
INSERT INTO `activity_logs` VALUES
(1,'admin',1,'login',NULL,NULL,'{\"email\":\"admin@techstore.de\"}','127.0.0.1',NULL,'2025-03-19 09:00:00'),
(2,'admin',3,'order.status','orders',5,'{\"from\":\"confirmed\",\"to\":\"processing\"}','195.65.12.88',NULL,'2025-03-13 09:00:00'),
(3,'admin',3,'document.review','company_documents',1,'{\"status\":\"accepted\"}','195.65.12.88',NULL,'2025-02-10 10:05:00'),
(4,'admin',2,'product.create','products',1,'{\"sku\":\"SPH-SAM-S25U-256\"}','127.0.0.1',NULL,'2024-12-10 09:00:00'),
(5,'customer',1,'login',NULL,NULL,'{\"email\":\"lena.fischer@gmail.com\",\"branch_id\":1}','91.12.34.56',NULL,'2025-03-18 20:11:00'),
(6,'customer',3,'order.place','orders',7,'{\"total\":\"3598.00\",\"type\":\"standard\"}','195.65.12.88',NULL,'2025-03-19 10:00:00'),
(7,'customer',7,'login',NULL,NULL,'{\"email\":\"felix.bauer@berlin.de\",\"branch_id\":2}','87.123.45.67',NULL,'2025-03-19 07:30:00'),
(8,'admin',4,'order.status','orders',9,'{\"from\":\"processing\",\"to\":\"shipped\"}','194.55.88.11',NULL,'2025-02-25 09:30:00');
/*!40000 ALTER TABLE `activity_logs` ENABLE KEYS */;
UNLOCK TABLES;

LOCK TABLES `addresses` WRITE;
/*!40000 ALTER TABLE `addresses` DISABLE KEYS */;
INSERT INTO `addresses` VALUES
(1,1,'shipping','Zuhause','Lena','Fischer',NULL,'Aachener Straße','45',NULL,'Köln','50674',NULL,'DE',1,'2026-04-17 08:58:36'),
(2,1,'billing','Standard','Lena','Fischer',NULL,'Aachener Straße','45',NULL,'Köln','50674',NULL,'DE',1,'2026-04-17 08:58:36'),
(3,2,'shipping','Zuhause','Markus','Wagner',NULL,'Ehrenfelder Gürtel','112',NULL,'Köln','50823',NULL,'DE',1,'2026-04-17 08:58:36'),
(4,3,'billing','Büro','Stefan','Brandt','Brandt GmbH','Riehler Straße','8',NULL,'Köln','50668',NULL,'DE',1,'2026-04-17 08:58:36'),
(5,3,'shipping','Lager','Stefan','Brandt','Brandt GmbH','Industriestraße','33',NULL,'Bergheim','50126',NULL,'DE',0,'2026-04-17 08:58:36'),
(6,4,'billing','Büro','Nicole','Zimmermann','Z-Logistics KG','Bonner Straße','201',NULL,'Köln','50969',NULL,'DE',1,'2026-04-17 08:58:36'),
(7,6,'shipping','Zuhause','Julia','Koch',NULL,'Deutz-Mülheimer Str','14',NULL,'Köln','51063',NULL,'DE',1,'2026-04-17 08:58:36'),
(8,7,'shipping','Zuhause','Felix','Bauer',NULL,'Prenzlauer Allee','88',NULL,'Berlin','10405',NULL,'DE',1,'2026-04-17 08:58:36'),
(9,8,'shipping','Zuhause','Sarah','Richter',NULL,'Kreuzbergstr.','7',NULL,'Berlin','10965',NULL,'DE',1,'2026-04-17 08:58:36'),
(10,9,'billing','Büro','Andreas','Klein','KleinTec GmbH','Unter den Linden','42',NULL,'Berlin','10117',NULL,'DE',1,'2026-04-17 08:58:36'),
(11,10,'shipping','Zuhause','Emma','Wolf',NULL,'Schönhauser Allee','55',NULL,'Berlin','10437',NULL,'DE',1,'2026-04-17 08:58:36'),
(12,11,'shipping','Zuhause','Lukas','Braun',NULL,'Maximilianstraße','19',NULL,'München','80539',NULL,'DE',1,'2026-04-17 08:58:36'),
(13,12,'billing','Büro','Monika','Lange','Bay Solutions AG','Rosenheimer Platz','5',NULL,'München','81669',NULL,'DE',1,'2026-04-17 08:58:36'),
(14,13,'shipping','Zuhause','Hannah','Schmitt',NULL,'Eppendorfer Baum','23',NULL,'Hamburg','20249',NULL,'DE',1,'2026-04-17 08:58:36'),
(15,14,'billing','Büro','Bernd','Neumann','Nordsee Handel GmbH','Speicherstadt','11',NULL,'Hamburg','20457',NULL,'DE',1,'2026-04-17 08:58:36'),
(16,15,'shipping','Zuhause','Sophie','Huber',NULL,'Mariahilfer Straße','105',NULL,'Wien','1060',NULL,'AT',1,'2026-04-17 08:58:36'),
(17,16,'billing','Büro','Wolfgang','Gruber','Alpha Technik GmbH','Quellenstraße','33',NULL,'Wien','1100',NULL,'AT',1,'2026-04-17 08:58:36');
/*!40000 ALTER TABLE `addresses` ENABLE KEYS */;
UNLOCK TABLES;

LOCK TABLES `admin_users` WRITE;
/*!40000 ALTER TABLE `admin_users` DISABLE KEYS */;
INSERT INTO `admin_users` VALUES
(1,NULL,1,'System','Administrator','admin@techstore.de','$2y$10$PEQ.OWveJRTjhvlYRqG6aOrJ4QwV1nNhzW.vWGBBQXiEBC42rjLEq',NULL,'2025-03-19 09:00:00',NULL,1,'2026-04-17 08:58:36',NULL),
(2,NULL,2,'Klaus','Bergmann','k.bergmann@techstore.de','$2y$10$PEQ.OWveJRTjhvlYRqG6aOrJ4QwV1nNhzW.vWGBBQXiEBC42rjLEq',NULL,'2025-03-18 14:22:00',NULL,1,'2026-04-17 08:58:36',NULL),
(3,1,3,'Sabine','Müller','s.mueller.koeln@techstore.de','$2y$10$PEQ.OWveJRTjhvlYRqG6aOrJ4QwV1nNhzW.vWGBBQXiEBC42rjLEq',NULL,'2025-03-19 08:15:00',NULL,1,'2026-04-17 08:58:36',NULL),
(4,2,3,'Thomas','Hoffmann','t.hoffmann.berlin@techstore.de','$2y$10$PEQ.OWveJRTjhvlYRqG6aOrJ4QwV1nNhzW.vWGBBQXiEBC42rjLEq',NULL,'2025-03-17 11:30:00',NULL,1,'2026-04-17 08:58:36',NULL),
(5,3,3,'Maria','Schneider','m.schneider.muc@techstore.de','$2y$10$PEQ.OWveJRTjhvlYRqG6aOrJ4QwV1nNhzW.vWGBBQXiEBC42rjLEq',NULL,'2025-03-18 09:45:00',NULL,1,'2026-04-17 08:58:36',NULL),
(6,4,3,'Jens','Krause','j.krause.hh@techstore.de','$2y$10$PEQ.OWveJRTjhvlYRqG6aOrJ4QwV1nNhzW.vWGBBQXiEBC42rjLEq',NULL,'2025-03-16 16:00:00',NULL,1,'2026-04-17 08:58:36',NULL),
(7,NULL,4,'Anna','Weber','a.weber@techstore.de','$2y$10$PEQ.OWveJRTjhvlYRqG6aOrJ4QwV1nNhzW.vWGBBQXiEBC42rjLEq',NULL,'2025-03-19 10:00:00',NULL,1,'2026-04-17 08:58:36',NULL);
/*!40000 ALTER TABLE `admin_users` ENABLE KEYS */;
UNLOCK TABLES;

LOCK TABLES `branch_delivery_settings` WRITE;
/*!40000 ALTER TABLE `branch_delivery_settings` DISABLE KEYS */;
INSERT INTO `branch_delivery_settings` VALUES
(3,1,1,1,49.00,0.00,4.90,1,3,'Abholung Mo–Sa 9–20 Uhr. Bitte Bestellnummer und Ausweis mitbringen.'),
(4,2,1,1,49.00,0.00,4.90,1,3,'Abholung Mo–Sa 10–20 Uhr, So 12–18 Uhr.'),
(5,3,1,1,59.00,0.00,5.90,1,3,'Abholung Mo–Sa 9–20 Uhr.'),
(6,4,1,1,49.00,0.00,4.90,1,2,'Abholung Mo–Sa 10–20 Uhr.'),
(7,5,0,1,69.00,10.00,6.90,2,5,NULL);
/*!40000 ALTER TABLE `branch_delivery_settings` ENABLE KEYS */;
UNLOCK TABLES;

LOCK TABLES `branches` WRITE;
/*!40000 ALTER TABLE `branches` DISABLE KEYS */;
INSERT INTO `branches` VALUES
(1,'Hauptfiliale Köln','koeln','koeln.techstore.de','koeln','koeln@techstore.de','+49 221 987654','Schildergasse 12','Köln','50667','DE','EUR',19.00,'Europe/Berlin',NULL,1,'{\"theme\":\"default\",\"show_pickup\":true}','2026-04-17 08:58:36',NULL),
(2,'Filiale Berlin','berlin','berlin.techstore.de','berlin','berlin@techstore.de','+49 30 112233','Kurfürstendamm 85','Berlin','10709','DE','EUR',19.00,'Europe/Berlin',NULL,1,'{\"theme\":\"default\",\"show_pickup\":true}','2026-04-17 08:58:36',NULL),
(3,'Filiale München','muenchen','muenchen.techstore.de','muenchen','muenchen@techstore.de','+49 89 445566','Kaufingerstraße 22','München','80331','DE','EUR',19.00,'Europe/Berlin',NULL,1,'{\"theme\":\"default\",\"show_pickup\":true}','2026-04-17 08:58:36',NULL),
(4,'Filiale Hamburg','hamburg','hamburg.techstore.de','hamburg','hamburg@techstore.de','+49 40 334455','Mönckebergstraße 7','Hamburg','20095','DE','EUR',19.00,'Europe/Berlin',NULL,1,'{\"theme\":\"default\",\"show_pickup\":true}','2026-04-17 08:58:36',NULL),
(5,'Online Shop (AT)','austria','at.techstore.de','austria','at@techstore.de','+43 1 5556677','Mariahilfer Straße 99','Wien','1060','AT','EUR',20.00,'Europe/Vienna',NULL,1,'{\"theme\":\"minimal\",\"show_pickup\":false}','2026-04-17 08:58:36',NULL);
/*!40000 ALTER TABLE `branches` ENABLE KEYS */;
UNLOCK TABLES;

LOCK TABLES `campaign_products` WRITE;
/*!40000 ALTER TABLE `campaign_products` DISABLE KEYS */;
INSERT INTO `campaign_products` VALUES
(8,7),
(8,8),
(8,9),
(8,10),
(8,11);
/*!40000 ALTER TABLE `campaign_products` ENABLE KEYS */;
UNLOCK TABLES;

LOCK TABLES `campaigns` WRITE;
/*!40000 ALTER TABLE `campaigns` DISABLE KEYS */;
INSERT INTO `campaigns` VALUES
(1,NULL,'Frühjahrsaktion 2025','FRUEHLING25','percent',10.0000,50.00,1000,234,1,'all','2025-03-01 00:00:00','2025-03-31 23:59:59',1,'2026-04-17 08:58:36'),
(2,NULL,'B2B Willkommensrabatt','B2BWILLKOMM','percent',5.0000,100.00,500,89,1,'company','2025-01-01 00:00:00','2025-12-31 23:59:59',1,'2026-04-17 08:58:36'),
(3,1,'Köln Eröffnungsfeier','KOELN10','fixed',10.0000,0.00,200,45,1,'all','2025-02-01 00:00:00','2025-04-30 23:59:59',1,'2026-04-17 08:58:36'),
(4,NULL,'Gratisversand ab 30€','GRATIS30','free_shipping',0.0000,30.00,5000,1203,3,'all','2025-01-01 00:00:00','2025-06-30 23:59:59',1,'2026-04-17 08:58:36'),
(5,2,'Berlin Special','BERLIN15','percent',15.0000,99.00,300,67,1,'all','2025-03-15 00:00:00','2025-04-15 23:59:59',1,'2026-04-17 08:58:36'),
(6,NULL,'Studenten-Rabatt','STUDENT10','percent',10.0000,20.00,2000,445,1,'private','2025-01-01 00:00:00','2025-12-31 23:59:59',1,'2026-04-17 08:58:36'),
(7,3,'München Oster-Aktion','OSTER20','percent',20.0000,150.00,500,0,1,'all','2025-04-01 00:00:00','2025-04-21 23:59:59',1,'2026-04-17 08:58:36'),
(8,NULL,'Tech-Deals März',NULL,'percent',12.0000,200.00,NULL,0,1,'all','2025-03-01 00:00:00','2025-03-31 23:59:59',0,'2026-04-17 08:58:36');
/*!40000 ALTER TABLE `campaigns` ENABLE KEYS */;
UNLOCK TABLES;

LOCK TABLES `cart_items` WRITE;
/*!40000 ALTER TABLE `cart_items` DISABLE KEYS */;
INSERT INTO `cart_items` VALUES
(1,1,7,15,1,'2026-04-17 08:58:36'),
(2,1,30,30,2,'2026-04-17 08:58:36'),
(3,2,12,18,1,'2026-04-17 08:58:36'),
(4,3,15,20,1,'2026-04-17 08:58:36'),
(5,3,30,30,1,'2026-04-17 08:58:36');
/*!40000 ALTER TABLE `cart_items` ENABLE KEYS */;
UNLOCK TABLES;

LOCK TABLES `carts` WRITE;
/*!40000 ALTER TABLE `carts` DISABLE KEYS */;
INSERT INTO `carts` VALUES
(1,'sess_lena_active_cart',1,1,NULL,'2026-04-17 08:58:36',NULL,'2026-04-24 08:58:36'),
(2,'sess_felix_active_cart',7,2,'FRUEHLING25','2026-04-17 08:58:36',NULL,'2026-04-24 08:58:36'),
(3,'sess_guest_koeln_123',NULL,1,NULL,'2026-04-17 08:58:36',NULL,'2026-04-18 08:58:36');
/*!40000 ALTER TABLE `carts` ENABLE KEYS */;
UNLOCK TABLES;

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES
(1,NULL,'smartphones','categories/smartphones.webp',1,1,'index,follow','2026-04-17 08:58:36',NULL),
(2,NULL,'laptops-notebooks','categories/laptops.webp',2,1,'index,follow','2026-04-17 08:58:36',NULL),
(3,NULL,'audio-hifi','categories/audio.webp',3,1,'index,follow','2026-04-17 08:58:36',NULL),
(4,NULL,'tablets','categories/tablets.webp',4,1,'index,follow','2026-04-17 08:58:36',NULL),
(5,NULL,'zubehoer','categories/accessories.webp',5,1,'index,follow','2026-04-17 08:58:36',NULL),
(6,NULL,'smart-home','categories/smarthome.webp',6,1,'index,follow','2026-04-17 08:58:36',NULL),
(7,NULL,'gaming','categories/gaming.webp',7,1,'index,follow','2026-04-17 08:58:36',NULL),
(8,NULL,'kameras','categories/cameras.webp',8,1,'index,follow','2026-04-17 08:58:36',NULL),
(9,1,'android-smartphones','categories/android.webp',1,1,'index,follow','2026-04-17 08:58:36',NULL),
(10,1,'apple-iphone','categories/iphone.webp',2,1,'index,follow','2026-04-17 08:58:36',NULL),
(11,3,'kopfhoerer','categories/headphones.webp',1,1,'index,follow','2026-04-17 08:58:36',NULL),
(12,3,'lautsprecher','categories/speakers.webp',2,1,'index,follow','2026-04-17 08:58:36',NULL),
(13,3,'earbuds-in-ear','categories/earbuds.webp',3,1,'index,follow','2026-04-17 08:58:36',NULL),
(14,2,'windows-laptops','categories/win-laptops.webp',1,1,'index,follow','2026-04-17 08:58:36',NULL),
(15,2,'apple-macbook','categories/macbook.webp',2,1,'index,follow','2026-04-17 08:58:36',NULL),
(16,7,'gaming-headsets','categories/gaming-headsets.webp',1,1,'index,follow','2026-04-17 08:58:36',NULL),
(17,7,'gaming-maeuse','categories/gaming-mice.webp',2,1,'index,follow','2026-04-17 08:58:36',NULL),
(18,7,'gaming-tastaturen','categories/gaming-keyboards.webp',3,1,'index,follow','2026-04-17 08:58:36',NULL);
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

LOCK TABLES `category_translations` WRITE;
/*!40000 ALTER TABLE `category_translations` DISABLE KEYS */;
INSERT INTO `category_translations` VALUES
(1,1,'de','Smartphones','Aktuelle Smartphones aller großen Hersteller.','Smartphones kaufen','Große Auswahl an Smartphones. Top Preise & schneller Versand.','smartphones'),
(2,2,'de','Laptops & Notebooks','Leistungsstarke Laptops für Arbeit, Studium und Freizeit.','Laptops kaufen','Laptops & Notebooks günstig kaufen. Schnelle Lieferung.','laptops-notebooks'),
(3,3,'de','Audio & HiFi','Kopfhörer, Lautsprecher, Soundbars und HiFi-Anlagen.','Audio-Geräte kaufen','Premium-Audio für zuhause und unterwegs.','audio-hifi'),
(4,4,'de','Tablets','iPad, Android-Tablets und E-Reader für jeden Einsatzbereich.','Tablets kaufen','Tablets aller Marken zum besten Preis.','tablets'),
(5,5,'de','Zubehör','Cases, Ladegeräte, Kabel und weiteres Zubehör.','Smartphone Zubehör','Zubehör für Smartphones, Laptops und Tablets.','zubehoer'),
(6,6,'de','Smart Home','Intelligente Geräte für Ihr Zuhause: Leuchten, Thermostate, Kameras.','Smart Home Geräte','Smart-Home-Geräte für ein vernetztes Zuhause.','smart-home'),
(7,7,'de','Gaming','Alles für Gamer: Headsets, Mäuse, Tastaturen und mehr.','Gaming Equipment','Top Gaming-Zubehör zu unschlagbaren Preisen.','gaming'),
(8,8,'de','Kameras & Foto','Systemkameras, Kompaktkameras und Zubehör für Fotografen.','Kameras kaufen','Kameras & Foto-Equipment für Einsteiger und Profis.','kameras'),
(9,9,'de','Android Smartphones','Samsung, Google Pixel, OnePlus und weitere Android-Geräte.','Android Smartphones','Android Smartphones aller Hersteller.','android-smartphones'),
(10,10,'de','Apple iPhone','Die neuesten iPhone-Modelle direkt verfügbar.','iPhone kaufen','Alle iPhone-Modelle & Farben auf Lager.','apple-iphone'),
(11,11,'de','Kopfhörer','Over-Ear, On-Ear und In-Ear Kopfhörer top Marken.','Kopfhörer kaufen','Premium-Kopfhörer von Sony, Bose, Apple & Co.','kopfhoerer'),
(12,12,'de','Lautsprecher','Bluetooth-Lautsprecher, Soundbars und HiFi-Anlagen.','Lautsprecher kaufen','Lautsprecher für drinnen und draußen.','lautsprecher'),
(13,13,'de','Earbuds & In-Ear','Kabellose In-Ear-Kopfhörer mit aktiver Geräuschunterdrückung.','Earbuds kaufen','True Wireless Earbuds für Sport und Alltag.','earbuds-in-ear'),
(14,14,'de','Windows Laptops','Laptops mit Windows 11 von Dell, Lenovo, HP, ASUS und mehr.','Windows Laptops','Windows 11 Laptops für jeden Anspruch.','windows-laptops'),
(15,15,'de','Apple MacBook','MacBook Air und MacBook Pro mit Apple Silicon.','MacBook kaufen','Alle MacBook-Modelle verfügbar.','apple-macbook'),
(16,16,'de','Gaming Headsets','Surround-Sound-Headsets für PS5, Xbox und PC.','Gaming Headsets','Gaming Headsets für maximales Spielerlebnis.','gaming-headsets'),
(17,17,'de','Gaming-Mäuse','Präzisions-Gaming-Mäuse mit RGB und hoher DPI.','Gaming Mäuse','Gaming-Mäuse für Profis und Einsteiger.','gaming-maeuse'),
(18,18,'de','Gaming-Tastaturen','Mechanische und Membran-Tastaturen für Gamer.','Gaming Tastaturen','Gaming-Tastaturen mit RGB-Beleuchtung.','gaming-tastaturen'),
(19,1,'en','Smartphones','Latest smartphones from all major manufacturers.','Buy Smartphones','Wide selection of smartphones. Best prices & fast shipping.','smartphones'),
(20,2,'en','Laptops & Notebooks','Powerful laptops for work, study and leisure.','Buy Laptops','Laptops & notebooks at great prices.','laptops-notebooks'),
(21,3,'en','Audio & HiFi','Headphones, speakers, soundbars and HiFi systems.','Buy Audio Equipment','Premium audio for home and on the go.','audio-hifi'),
(22,4,'en','Tablets','iPad, Android tablets and e-readers.','Buy Tablets','Tablets from all brands at the best price.','tablets'),
(23,5,'en','Accessories','Cases, chargers, cables and other accessories.','Smartphone Accessories','Accessories for smartphones, laptops and tablets.','accessories'),
(24,6,'en','Smart Home','Smart devices for your home.','Smart Home Devices','Smart home devices for a connected home.','smart-home'),
(25,7,'en','Gaming','Everything for gamers: headsets, mice, keyboards and more.','Gaming Equipment','Top gaming accessories at unbeatable prices.','gaming'),
(26,8,'en','Cameras & Photo','System cameras, compact cameras and accessories.','Buy Cameras','Cameras & photo equipment for beginners and pros.','cameras'),
(27,11,'en','Headphones','Over-ear, on-ear and in-ear headphones.','Buy Headphones','Premium headphones from Sony, Bose, Apple & more.','headphones');
/*!40000 ALTER TABLE `category_translations` ENABLE KEYS */;
UNLOCK TABLES;

LOCK TABLES `company_documents` WRITE;
/*!40000 ALTER TABLE `company_documents` DISABLE KEYS */;
INSERT INTO `company_documents` VALUES
(1,3,'business_license','gewerbeschein_brandt.pdf','storage/uploads/documents/brandt_gewerbeschein.pdf',245120,'application/pdf',NULL,3,'2025-02-10 10:05:00','accepted','2026-04-17 08:58:36'),
(2,3,'vat_proof','umsatzsteuer_brandt.pdf','storage/uploads/documents/brandt_vat.pdf',180240,'application/pdf',NULL,3,'2025-02-10 10:05:00','accepted','2026-04-17 08:58:36'),
(3,4,'business_license','handelsregister_z_log.pdf','storage/uploads/documents/z_log_hr.pdf',312000,'application/pdf',NULL,3,'2025-01-15 14:10:00','accepted','2026-04-17 08:58:36'),
(4,9,'business_license','kleintec_gewerbeschein.pdf','storage/uploads/documents/kleintec_gew.pdf',198000,'application/pdf',NULL,4,'2025-01-20 09:10:00','accepted','2026-04-17 08:58:36'),
(5,9,'vat_proof','kleintec_ust.pdf','storage/uploads/documents/kleintec_vat.pdf',145000,'application/pdf',NULL,4,'2025-01-20 09:10:00','accepted','2026-04-17 08:58:36'),
(6,12,'business_license','baysolutions_hr.pdf','storage/uploads/documents/baysol_hr.pdf',267000,'application/pdf',NULL,5,'2025-02-05 11:35:00','accepted','2026-04-17 08:58:36'),
(7,14,'trade_register','nordsee_hr_auszug.pdf','storage/uploads/documents/nordsee_hr.pdf',221000,'application/pdf',NULL,6,'2025-03-01 08:05:00','accepted','2026-04-17 08:58:36'),
(8,16,'business_license','alpha_technik_fb.pdf','storage/uploads/documents/alpha_fb.pdf',190000,'application/pdf',NULL,2,'2025-02-20 13:10:00','accepted','2026-04-17 08:58:36'),
(9,5,'business_license','schulz_it_gew.pdf','storage/uploads/documents/schulz_gew.pdf',173000,'application/pdf',NULL,NULL,NULL,'pending','2026-04-17 08:58:36');
/*!40000 ALTER TABLE `company_documents` ENABLE KEYS */;
UNLOCK TABLES;

LOCK TABLES `customers` WRITE;
/*!40000 ALTER TABLE `customers` DISABLE KEYS */;
INSERT INTO `customers` VALUES
(1,1,'private','Lena','Fischer','lena.fischer@gmail.com','$2y$10$PEQ.OWveJRTjhvlYRqG6aOrJ4QwV1nNhzW.vWGBBQXiEBC42rjLEq','+49 157 11223344',NULL,'de',NULL,NULL,NULL,0,'pending',NULL,NULL,'standard',1,1,1,'2025-03-18 20:11:00','2026-04-17 08:58:36',NULL),
(2,1,'private','Markus','Wagner','markus.wagner@web.de','$2y$10$PEQ.OWveJRTjhvlYRqG6aOrJ4QwV1nNhzW.vWGBBQXiEBC42rjLEq','+49 172 9988776',NULL,'de',NULL,NULL,NULL,0,'pending',NULL,NULL,'standard',1,1,0,'2025-03-17 12:35:00','2026-04-17 08:58:36',NULL),
(3,1,'company','Stefan','Brandt','s.brandt@brandtgmbh.de','$2y$10$PEQ.OWveJRTjhvlYRqG6aOrJ4QwV1nNhzW.vWGBBQXiEBC42rjLEq','+49 221 334455',NULL,'de','Brandt GmbH','DE287654321','HRB 88421',1,'approved','2025-02-10 10:00:00',3,'b2b',1,1,0,'2025-03-19 09:00:00','2026-04-17 08:58:36',NULL),
(4,1,'company','Nicole','Zimmermann','n.zimmermann@z-logistics.de','$2y$10$PEQ.OWveJRTjhvlYRqG6aOrJ4QwV1nNhzW.vWGBBQXiEBC42rjLEq','+49 221 667788',NULL,'de','Z-Logistics KG','DE199887766','HRB 55320',1,'approved','2025-01-15 14:00:00',3,'b2b',1,1,0,'2025-03-16 14:20:00','2026-04-17 08:58:36',NULL),
(5,1,'company','Peter','Schulz','p.schulz@schulz-it.de','$2y$10$PEQ.OWveJRTjhvlYRqG6aOrJ4QwV1nNhzW.vWGBBQXiEBC42rjLEq','+49 221 556677',NULL,'de','Schulz IT Solutions','DE334455666','HRB 12984',0,'pending',NULL,NULL,'standard',1,1,0,'2025-03-10 11:00:00','2026-04-17 08:58:36',NULL),
(6,1,'private','Julia','Koch','julia.koch@hotmail.de','$2y$10$PEQ.OWveJRTjhvlYRqG6aOrJ4QwV1nNhzW.vWGBBQXiEBC42rjLEq','+49 160 1234567',NULL,'de',NULL,NULL,NULL,0,'pending',NULL,NULL,'standard',1,1,1,'2025-03-14 18:45:00','2026-04-17 08:58:36',NULL),
(7,2,'private','Felix','Bauer','felix.bauer@berlin.de','$2y$10$PEQ.OWveJRTjhvlYRqG6aOrJ4QwV1nNhzW.vWGBBQXiEBC42rjLEq','+49 179 8887766',NULL,'de',NULL,NULL,NULL,0,'pending',NULL,NULL,'standard',1,1,1,'2025-03-19 07:30:00','2026-04-17 08:58:36',NULL),
(8,2,'private','Sarah','Richter','sarah.richter@gmx.de','$2y$10$PEQ.OWveJRTjhvlYRqG6aOrJ4QwV1nNhzW.vWGBBQXiEBC42rjLEq','+49 152 4455667',NULL,'de',NULL,NULL,NULL,0,'pending',NULL,NULL,'standard',1,1,0,'2025-03-12 15:20:00','2026-04-17 08:58:36',NULL),
(9,2,'company','Andreas','Klein','a.klein@kleintec.de','$2y$10$PEQ.OWveJRTjhvlYRqG6aOrJ4QwV1nNhzW.vWGBBQXiEBC42rjLEq','+49 30 778899',NULL,'de','KleinTec GmbH','DE412233445','HRB 33210',1,'approved','2025-01-20 09:00:00',4,'b2b',1,1,0,'2025-03-18 13:00:00','2026-04-17 08:58:36',NULL),
(10,2,'private','Emma','Wolf','emma.wolf@icloud.com','$2y$10$PEQ.OWveJRTjhvlYRqG6aOrJ4QwV1nNhzW.vWGBBQXiEBC42rjLEq','+49 176 3344556',NULL,'en',NULL,NULL,NULL,0,'pending',NULL,NULL,'standard',1,1,1,'2025-03-15 21:00:00','2026-04-17 08:58:36',NULL),
(11,3,'private','Lukas','Braun','lukas.braun@yahoo.de','$2y$10$PEQ.OWveJRTjhvlYRqG6aOrJ4QwV1nNhzW.vWGBBQXiEBC42rjLEq','+49 171 6677889',NULL,'de',NULL,NULL,NULL,0,'pending',NULL,NULL,'standard',1,1,0,'2025-03-19 11:10:00','2026-04-17 08:58:36',NULL),
(12,3,'company','Monika','Lange','m.lange@baysolutions.de','$2y$10$PEQ.OWveJRTjhvlYRqG6aOrJ4QwV1nNhzW.vWGBBQXiEBC42rjLEq','+49 89 998877',NULL,'de','Bay Solutions AG','DE556677889','HRB 67890',1,'approved','2025-02-05 11:30:00',5,'b2b',1,1,0,'2025-03-17 10:00:00','2026-04-17 08:58:36',NULL),
(13,4,'private','Hannah','Schmitt','hannah.schmitt@t-online.de','$2y$10$PEQ.OWveJRTjhvlYRqG6aOrJ4QwV1nNhzW.vWGBBQXiEBC42rjLEq','+49 40 112244',NULL,'de',NULL,NULL,NULL,0,'pending',NULL,NULL,'standard',1,1,1,'2025-03-18 19:05:00','2026-04-17 08:58:36',NULL),
(14,4,'company','Bernd','Neumann','b.neumann@nordseehandel.de','$2y$10$PEQ.OWveJRTjhvlYRqG6aOrJ4QwV1nNhzW.vWGBBQXiEBC42rjLEq','+49 40 335577',NULL,'de','Nordsee Handel GmbH','DE778899001','HRB 54321',1,'approved','2025-03-01 08:00:00',6,'b2b',1,1,0,'2025-03-19 08:30:00','2026-04-17 08:58:36',NULL),
(15,5,'private','Sophie','Huber','sophie.huber@gmx.at','$2y$10$PEQ.OWveJRTjhvlYRqG6aOrJ4QwV1nNhzW.vWGBBQXiEBC42rjLEq','+43 676 1122334',NULL,'de',NULL,NULL,NULL,0,'pending',NULL,NULL,'standard',1,1,1,'2025-03-16 17:00:00','2026-04-17 08:58:36',NULL),
(16,5,'company','Wolfgang','Gruber','w.gruber@alphatechnik.at','$2y$10$PEQ.OWveJRTjhvlYRqG6aOrJ4QwV1nNhzW.vWGBBQXiEBC42rjLEq','+43 1 889900',NULL,'de','Alpha Technik GmbH','ATU55443322','FN 445566g',1,'approved','2025-02-20 13:00:00',2,'b2b',1,1,0,'2025-03-19 09:45:00','2026-04-17 08:58:36',NULL);
/*!40000 ALTER TABLE `customers` ENABLE KEYS */;
UNLOCK TABLES;

LOCK TABLES `languages` WRITE;
/*!40000 ALTER TABLE `languages` DISABLE KEYS */;
INSERT INTO `languages` VALUES
(1,'de','Deutsch','de_DE','🇩🇪',1,1,0,'2026-04-17 08:58:36'),
(2,'en','English','en_US','🇬🇧',0,1,1,'2026-04-17 08:58:36'),
(3,'fr','Français','fr_FR','🇫🇷',0,1,2,'2026-04-17 08:58:36'),
(4,'nl','Nederlands','nl_NL','🇳🇱',0,0,3,'2026-04-17 08:58:36');
/*!40000 ALTER TABLE `languages` ENABLE KEYS */;
UNLOCK TABLES;

LOCK TABLES `menu_item_translations` WRITE;
/*!40000 ALTER TABLE `menu_item_translations` DISABLE KEYS */;
INSERT INTO `menu_item_translations` VALUES
(1,1,'de','Smartphones'),
(2,2,'de','Laptops & Notebooks'),
(3,3,'de','Audio & HiFi'),
(4,4,'de','Tablets'),
(5,5,'de','Smart Home'),
(6,6,'de','Gaming'),
(7,7,'de','Angebote'),
(8,8,'de','Apple iPhone'),
(9,9,'de','Android'),
(10,10,'de','Kopfhörer'),
(11,11,'de','Earbuds & In-Ear'),
(12,12,'de','Lautsprecher'),
(13,13,'de','Apple MacBook'),
(14,14,'de','Windows Laptops'),
(15,1,'en','Smartphones'),
(16,2,'en','Laptops & Notebooks'),
(17,3,'en','Audio & HiFi'),
(18,4,'en','Tablets'),
(19,5,'en','Smart Home'),
(20,6,'en','Gaming'),
(21,7,'en','Deals'),
(22,8,'en','Apple iPhone'),
(23,9,'en','Android'),
(24,10,'en','Headphones'),
(25,11,'en','Earbuds & In-Ear'),
(26,12,'en','Speakers'),
(27,13,'en','Apple MacBook'),
(28,14,'en','Windows Laptops'),
(29,20,'de','Über uns'),
(30,21,'de','Kontakt'),
(31,22,'de','Für Geschäftskunden'),
(32,23,'de','Garantie & Rücksendungen'),
(33,24,'de','Impressum'),
(34,25,'de','Datenschutz'),
(35,26,'de','AGB'),
(36,20,'en','About Us'),
(37,21,'en','Contact'),
(38,22,'en','Business Customers'),
(39,23,'en','Warranty & Returns'),
(40,24,'en','Legal Notice'),
(41,25,'en','Privacy Policy'),
(42,26,'en','Terms & Conditions');
/*!40000 ALTER TABLE `menu_item_translations` ENABLE KEYS */;
UNLOCK TABLES;

LOCK TABLES `menu_items` WRITE;
/*!40000 ALTER TABLE `menu_items` DISABLE KEYS */;
INSERT INTO `menu_items` VALUES
(1,1,NULL,'category',1,'/de/smartphones','_self',1),
(2,1,NULL,'category',2,'/de/laptops-notebooks','_self',2),
(3,1,NULL,'category',3,'/de/audio-hifi','_self',3),
(4,1,NULL,'category',4,'/de/tablets','_self',4),
(5,1,NULL,'category',6,'/de/smart-home','_self',5),
(6,1,NULL,'category',7,'/de/gaming','_self',6),
(7,1,NULL,'url',NULL,'/de/angebote','_self',7),
(8,1,1,'category',10,'/de/apple-iphone','_self',1),
(9,1,1,'category',9,'/de/android-smartphones','_self',2),
(10,1,3,'category',11,'/de/kopfhoerer','_self',1),
(11,1,3,'category',13,'/de/earbuds-in-ear','_self',2),
(12,1,3,'category',12,'/de/lautsprecher','_self',3),
(13,1,2,'category',15,'/de/apple-macbook','_self',1),
(14,1,2,'category',14,'/de/windows-laptops','_self',2),
(20,2,NULL,'page',1,'/de/ueber-uns','_self',1),
(21,2,NULL,'page',2,'/de/kontakt','_self',2),
(22,2,NULL,'page',8,'/de/geschaeftskunden','_self',3),
(23,2,NULL,'page',7,'/de/garantie-ruecksendungen','_self',4),
(24,2,NULL,'page',4,'/de/impressum','_self',5),
(25,2,NULL,'page',5,'/de/datenschutz','_self',6),
(26,2,NULL,'page',6,'/de/agb','_self',7);
/*!40000 ALTER TABLE `menu_items` ENABLE KEYS */;
UNLOCK TABLES;

LOCK TABLES `menus` WRITE;
/*!40000 ALTER TABLE `menus` DISABLE KEYS */;
INSERT INTO `menus` VALUES
(1,NULL,'header','Hauptnavigation'),
(2,NULL,'footer','Footer Navigation'),
(3,NULL,'mobile','Mobile Navigation');
/*!40000 ALTER TABLE `menus` ENABLE KEYS */;
UNLOCK TABLES;

LOCK TABLES `order_items` WRITE;
/*!40000 ALTER TABLE `order_items` DISABLE KEYS */;
INSERT INTO `order_items` VALUES
(1,1,3,8,'Apple iPhone 16 Pro','Desert Titanium, 256 GB','SPH-APP-IP16P-256-DST',1,1329.0000,0.0000,19.00,212.2500,1329.00),
(2,1,15,20,'Apple AirPods Pro (4. Gen.)','Weiß','AUD-APL-APP4-MAGSAFE',1,279.0000,0.0000,19.00,44.5400,279.00),
(3,2,9,NULL,'Dell XPS 15 (9530) i7',NULL,'LPT-DEL-XPS-15-I7',1,2299.0000,0.0000,0.00,0.0000,2299.00),
(4,3,15,20,'Apple AirPods Pro (4. Gen.)','Weiß','AUD-APL-APP4-MAGSAFE',1,279.0000,0.0000,19.00,44.5400,279.00),
(5,4,9,NULL,'Dell XPS 15 (9530) i7',NULL,'LPT-DEL-XPS-15-I7',3,2299.0000,0.0000,0.00,0.0000,6897.00),
(6,5,12,18,'Sony WH-1000XM6','Schwarz','AUD-SNY-WH1000XM6-BLK',1,399.0000,39.9000,19.00,57.5900,399.00),
(7,6,4,12,'Apple iPhone 16','Schwarz, 128 GB','SPH-APP-IP16-128-BLK',1,949.0000,0.0000,19.00,151.4700,949.00),
(8,7,7,17,'Apple MacBook Air 13\" M3','Silber, 16 GB, 512 GB','LPT-APP-MBA-M3-16-512-SL',2,1699.0000,0.0000,0.00,0.0000,3398.00),
(9,7,20,25,'Apple iPad Pro 13\" M4','Silber, 256 GB','TAB-APP-IPAP13-256-SLV',0,1299.0000,0.0000,0.00,0.0000,0.00),
(10,8,3,8,'Apple iPhone 16 Pro','Desert Titanium, 256 GB','SPH-APP-IP16P-256-DST',1,1329.0000,0.0000,19.00,212.2500,1329.00),
(11,9,8,NULL,'Apple MacBook Pro M4',NULL,'LPT-APP-MBP-M4-16',2,1999.0000,0.0000,0.00,0.0000,3998.00),
(12,9,9,NULL,'Dell XPS 15 (9530) i7',NULL,'LPT-DEL-XPS-15-I7',0,2299.0000,0.0000,0.00,0.0000,0.00),
(13,10,13,21,'Apple AirPods Max','Midnight Sky','AUD-APL-MAX-MN-BLK',1,279.0000,41.8500,19.00,37.7400,279.00),
(14,11,18,NULL,'Sony SRS-XB100',NULL,'AUD-SON-SRS-XB100',1,59.0000,0.0000,19.00,9.1400,59.00),
(15,12,4,14,'Apple iPhone 16','Schwarz, 256 GB','SPH-APP-IP16-256-BLK',1,949.0000,0.0000,19.00,151.4700,949.00),
(16,13,28,NULL,'Sony Alpha 7 IV Gehäuse',NULL,'CAM-SON-A7IV-BODY',2,3299.0000,0.0000,0.00,0.0000,6598.00),
(17,14,12,18,'Sony WH-1000XM6','Schwarz','AUD-SNY-WH1000XM6-BLK',1,399.0000,0.0000,19.00,63.7200,399.00),
(18,15,3,8,'Apple iPhone 16 Pro','Desert Titanium, 256 GB','SPH-APP-IP16P-256-DST',3,1329.0000,0.0000,0.00,0.0000,3987.00),
(19,15,7,15,'Apple MacBook Air 13\" M3','Midnight, 8 GB, 256 GB','LPT-APP-MBA-M3-8-256-MN',3,1299.0000,0.0000,0.00,0.0000,3897.00),
(20,16,27,NULL,'Google Nest Thermostat',NULL,'SHM-NES-THER-4TH',1,149.0000,0.0000,20.00,24.8300,149.00),
(21,16,26,28,'Amazon Echo Dot 5','Anthrazit','SHM-AMZ-ECHD5-CHAR',2,64.9900,0.0000,20.00,21.6600,129.98),
(22,17,28,NULL,'Sony Alpha 7 IV Gehäuse',NULL,'CAM-SON-A7IV-BODY',1,3499.0000,0.0000,0.00,0.0000,3499.00);
/*!40000 ALTER TABLE `order_items` ENABLE KEYS */;
UNLOCK TABLES;

LOCK TABLES `order_status_history` WRITE;
/*!40000 ALTER TABLE `order_status_history` DISABLE KEYS */;
INSERT INTO `order_status_history` VALUES
(1,1,'pending','Bestellung eingegangen.',0,NULL,'2025-01-15 09:58:00'),
(2,1,'confirmed','Zahlung bestätigt.',1,NULL,'2025-01-15 10:05:00'),
(3,1,'processing','Wird kommissioniert.',0,3,'2025-01-15 12:00:00'),
(4,1,'shipped','Versandt per DHL. Tracking: 1234567890.',1,3,'2025-01-16 09:30:00'),
(5,1,'delivered','Zugestellt laut DHL.',1,3,'2025-01-17 14:00:00'),
(6,2,'pending','Bestellung eingegangen.',0,NULL,'2025-01-18 14:20:00'),
(7,2,'confirmed','Rechnungskauf bestätigt.',1,3,'2025-01-19 09:00:00'),
(8,2,'processing','Wird vorbereitet.',0,3,'2025-01-19 11:00:00'),
(9,2,'shipped','Versandt per Spedition.',1,3,'2025-01-21 10:00:00'),
(10,2,'delivered','Zugestellt.',1,3,'2025-01-23 16:00:00'),
(11,3,'pending','Bestellung eingegangen.',0,NULL,'2025-02-05 13:10:00'),
(12,3,'confirmed','Zahlung bestätigt.',1,NULL,'2025-02-05 13:22:00'),
(13,3,'shipped','Versandt.',1,3,'2025-02-06 08:00:00'),
(14,3,'delivered','Zugestellt.',1,3,'2025-02-07 12:00:00'),
(15,4,'pending','Bestellung eingegangen.',0,NULL,'2025-02-18 09:30:00'),
(16,4,'confirmed','B2B-Auftrag bestätigt.',1,3,'2025-02-18 10:00:00'),
(17,4,'processing','In Bearbeitung.',0,3,'2025-02-19 09:00:00'),
(18,4,'shipped','Versandt per Spedition.',1,3,'2025-02-20 11:00:00'),
(19,5,'pending','Bestellung eingegangen.',0,NULL,'2025-03-12 15:20:00'),
(20,5,'confirmed','PayPal-Zahlung bestätigt.',1,NULL,'2025-03-12 15:30:00'),
(21,5,'processing','Wird kommissioniert.',0,3,'2025-03-13 09:00:00'),
(22,6,'pending','Bestellung zur Abholung eingegangen.',0,NULL,'2025-03-17 11:35:00'),
(23,6,'confirmed','Zahlung OK. Bereit zur Abholung.',1,3,'2025-03-17 11:45:00'),
(24,7,'pending','B2B-Bestellung eingegangen.',0,NULL,'2025-03-19 10:00:00'),
(25,7,'confirmed','Rechnungskauf genehmigt.',1,3,'2025-03-19 11:00:00'),
(26,7,'processing','Wird zusammengestellt.',0,3,'2025-03-19 14:00:00'),
(27,8,'pending','Bestellung eingegangen.',0,NULL,'2025-01-22 09:00:00'),
(28,8,'confirmed','Zahlung bestätigt.',1,NULL,'2025-01-22 09:15:00'),
(29,8,'shipped','Versandt.',1,4,'2025-01-23 08:30:00'),
(30,8,'delivered','Zugestellt.',1,4,'2025-01-24 14:00:00'),
(31,9,'pending','B2B-Auftrag eingegangen.',0,NULL,'2025-02-22 16:00:00'),
(32,9,'confirmed','Bestätigt.',1,4,'2025-02-23 09:00:00'),
(33,9,'processing','In Bearbeitung.',0,4,'2025-02-24 10:00:00'),
(34,9,'shipped','Versandt per Spedition.',1,4,'2025-02-25 09:30:00'),
(35,9,'delivered','Zugestellt.',1,4,'2025-02-27 16:00:00'),
(36,10,'pending','Bestellung eingegangen.',0,NULL,'2025-03-16 19:55:00'),
(37,10,'confirmed','PayPal-Zahlung bestätigt.',1,NULL,'2025-03-16 20:01:00'),
(38,11,'pending','Bestellung eingegangen.',0,NULL,'2025-03-19 08:40:00'),
(39,11,'confirmed','Zahlung bestätigt.',1,NULL,'2025-03-19 08:45:00'),
(40,12,'pending','Abholung angemeldet.',0,NULL,'2025-02-27 10:00:00'),
(41,12,'confirmed','Zahlung bestätigt. Zur Abholung bereit.',1,5,'2025-02-28 09:00:00'),
(42,12,'delivered','Abgeholt.',0,5,'2025-02-28 14:00:00'),
(43,13,'pending','B2B-Auftrag eingegangen.',0,NULL,'2025-03-18 09:00:00'),
(44,13,'confirmed','Bestätigt.',1,5,'2025-03-18 10:00:00'),
(45,13,'processing','In Bearbeitung.',0,5,'2025-03-18 13:00:00'),
(46,13,'shipped','Versandt.',1,5,'2025-03-19 10:00:00'),
(47,14,'pending','Bestellung eingegangen.',0,NULL,'2025-03-18 21:00:00'),
(48,14,'confirmed','PayPal-Zahlung bestätigt.',1,NULL,'2025-03-18 21:10:00'),
(49,15,'pending','Großauftrag B2B eingegangen.',0,NULL,'2025-03-19 08:00:00'),
(50,15,'confirmed','Rechnungskauf genehmigt.',1,6,'2025-03-19 09:00:00'),
(51,15,'processing','Wird vorbereitet.',0,6,'2025-03-19 13:00:00'),
(52,16,'pending','Bestellung eingegangen.',0,NULL,'2025-03-05 18:10:00'),
(53,16,'confirmed','Zahlung bestätigt.',1,NULL,'2025-03-05 18:20:00'),
(54,16,'shipped','Versandt nach Österreich.',1,2,'2025-03-06 09:00:00'),
(55,16,'delivered','Zugestellt.',1,2,'2025-03-08 14:00:00'),
(56,17,'pending','B2B-Auftrag Österreich eingegangen.',0,NULL,'2025-03-18 14:00:00'),
(57,17,'confirmed','Bestätigt.',1,2,'2025-03-18 15:00:00');
/*!40000 ALTER TABLE `order_status_history` ENABLE KEYS */;
UNLOCK TABLES;

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES
(1,'ORD-2025-B1-00001',1,1,'delivered','standard',1578.00,0.00,0.00,299.82,1578.00,'EUR',NULL,NULL,'{\"first_name\":\"Lena\",\"last_name\":\"Fischer\",\"street\":\"Aachener Straße\",\"house_number\":\"45\",\"city\":\"Köln\",\"postal_code\":\"50674\",\"country_code\":\"DE\"}','{\"first_name\":\"Lena\",\"last_name\":\"Fischer\",\"street\":\"Aachener Straße\",\"house_number\":\"45\",\"city\":\"Köln\",\"postal_code\":\"50674\",\"country_code\":\"DE\"}','paypal','paid',NULL,'2025-01-15 10:05:00',NULL,NULL,NULL,NULL,'91.12.34.56',NULL,'de','2025-01-15 09:58:00',NULL),
(2,'ORD-2025-B1-00002',1,3,'delivered','standard',2299.00,0.00,0.00,0.00,2299.00,'EUR',NULL,NULL,'{\"first_name\":\"Stefan\",\"last_name\":\"Brandt\",\"company\":\"Brandt GmbH\",\"street\":\"Riehler Straße\",\"house_number\":\"8\",\"city\":\"Köln\",\"postal_code\":\"50668\",\"country_code\":\"DE\"}','{\"first_name\":\"Stefan\",\"last_name\":\"Brandt\",\"company\":\"Brandt GmbH\",\"street\":\"Industriestraße\",\"house_number\":\"33\",\"city\":\"Bergheim\",\"postal_code\":\"50126\",\"country_code\":\"DE\"}','invoice','paid',NULL,'2025-01-20 11:00:00','PO-2025-0042','2025-02-20','Bitte mit Lieferschein und Rechnung senden.',NULL,'195.65.12.88',NULL,'de','2025-01-18 14:20:00',NULL),
(3,'ORD-2025-B1-00003',1,1,'delivered','standard',279.00,0.00,0.00,44.54,279.00,'EUR',NULL,NULL,'{\"first_name\":\"Lena\",\"last_name\":\"Fischer\",\"street\":\"Aachener Straße\",\"house_number\":\"45\",\"city\":\"Köln\",\"postal_code\":\"50674\",\"country_code\":\"DE\"}','{\"first_name\":\"Lena\",\"last_name\":\"Fischer\",\"street\":\"Aachener Straße\",\"house_number\":\"45\",\"city\":\"Köln\",\"postal_code\":\"50674\",\"country_code\":\"DE\"}','credit_card','paid',NULL,'2025-02-05 13:22:00',NULL,NULL,NULL,NULL,'91.12.34.56',NULL,'de','2025-02-05 13:10:00',NULL),
(4,'ORD-2025-B1-00004',1,4,'shipped','standard',6597.00,329.85,0.00,0.00,6267.15,'EUR',2,'B2BWILLKOMM','{\"first_name\":\"Nicole\",\"last_name\":\"Zimmermann\",\"company\":\"Z-Logistics KG\",\"street\":\"Bonner Straße\",\"house_number\":\"201\",\"city\":\"Köln\",\"postal_code\":\"50969\",\"country_code\":\"DE\"}','{\"first_name\":\"Nicole\",\"last_name\":\"Zimmermann\",\"company\":\"Z-Logistics KG\",\"street\":\"Bonner Straße\",\"house_number\":\"201\",\"city\":\"Köln\",\"postal_code\":\"50969\",\"country_code\":\"DE\"}','invoice','pending',NULL,NULL,'PO-ZL-2025-008','2025-03-20',NULL,NULL,'195.99.77.22',NULL,'de','2025-02-18 09:30:00',NULL),
(5,'ORD-2025-B1-00005',1,2,'processing','standard',399.00,39.90,0.00,57.59,359.10,'EUR',1,'FRUEHLING25','{\"first_name\":\"Markus\",\"last_name\":\"Wagner\",\"street\":\"Ehrenfelder Gürtel\",\"house_number\":\"112\",\"city\":\"Köln\",\"postal_code\":\"50823\",\"country_code\":\"DE\"}','{\"first_name\":\"Markus\",\"last_name\":\"Wagner\",\"street\":\"Ehrenfelder Gürtel\",\"house_number\":\"112\",\"city\":\"Köln\",\"postal_code\":\"50823\",\"country_code\":\"DE\"}','paypal','paid',NULL,'2025-03-12 15:30:00',NULL,NULL,'Bitte besonders sorgfältig verpacken.',NULL,'212.78.56.11',NULL,'de','2025-03-12 15:20:00',NULL),
(6,'ORD-2025-B1-00006',1,6,'confirmed','pickup',949.00,0.00,0.00,151.47,949.00,'EUR',NULL,NULL,'{\"first_name\":\"Julia\",\"last_name\":\"Koch\",\"street\":\"Deutz-Mülheimer Str\",\"house_number\":\"14\",\"city\":\"Köln\",\"postal_code\":\"51063\",\"country_code\":\"DE\"}',NULL,'credit_card','paid',NULL,'2025-03-17 11:45:00',NULL,NULL,NULL,NULL,'78.45.221.33',NULL,'de','2025-03-17 11:35:00',NULL),
(7,'ORD-2025-B1-00007',1,3,'processing','standard',3598.00,0.00,0.00,0.00,3598.00,'EUR',NULL,NULL,'{\"first_name\":\"Stefan\",\"last_name\":\"Brandt\",\"company\":\"Brandt GmbH\",\"street\":\"Riehler Straße\",\"house_number\":\"8\",\"city\":\"Köln\",\"postal_code\":\"50668\",\"country_code\":\"DE\"}','{\"first_name\":\"Stefan\",\"last_name\":\"Brandt\",\"company\":\"Brandt GmbH\",\"street\":\"Industriestraße\",\"house_number\":\"33\",\"city\":\"Bergheim\",\"postal_code\":\"50126\",\"country_code\":\"DE\"}','invoice','pending',NULL,NULL,'PO-2025-0078','2025-04-19',NULL,NULL,'195.65.12.88',NULL,'de','2025-03-19 10:00:00',NULL),
(8,'ORD-2025-B2-00001',2,7,'delivered','standard',1329.00,0.00,0.00,212.25,1329.00,'EUR',NULL,NULL,'{\"first_name\":\"Felix\",\"last_name\":\"Bauer\",\"street\":\"Prenzlauer Allee\",\"house_number\":\"88\",\"city\":\"Berlin\",\"postal_code\":\"10405\",\"country_code\":\"DE\"}','{\"first_name\":\"Felix\",\"last_name\":\"Bauer\",\"street\":\"Prenzlauer Allee\",\"house_number\":\"88\",\"city\":\"Berlin\",\"postal_code\":\"10405\",\"country_code\":\"DE\"}','credit_card','paid',NULL,'2025-01-22 09:15:00',NULL,NULL,NULL,NULL,'87.123.45.67',NULL,'de','2025-01-22 09:00:00',NULL),
(9,'ORD-2025-B2-00002',2,9,'delivered','standard',4798.00,239.90,0.00,0.00,4558.10,'EUR',2,'B2BWILLKOMM','{\"first_name\":\"Andreas\",\"last_name\":\"Klein\",\"company\":\"KleinTec GmbH\",\"street\":\"Unter den Linden\",\"house_number\":\"42\",\"city\":\"Berlin\",\"postal_code\":\"10117\",\"country_code\":\"DE\"}','{\"first_name\":\"Andreas\",\"last_name\":\"Klein\",\"company\":\"KleinTec GmbH\",\"street\":\"Unter den Linden\",\"house_number\":\"42\",\"city\":\"Berlin\",\"postal_code\":\"10117\",\"country_code\":\"DE\"}','invoice','paid',NULL,'2025-02-25 10:00:00','PO-KT-2025-015','2025-03-25',NULL,NULL,'194.55.88.11',NULL,'de','2025-02-22 16:00:00',NULL),
(10,'ORD-2025-B2-00003',2,8,'confirmed','standard',279.00,41.85,4.90,37.74,242.05,'EUR',5,'BERLIN15','{\"first_name\":\"Sarah\",\"last_name\":\"Richter\",\"street\":\"Kreuzbergstr.\",\"house_number\":\"7\",\"city\":\"Berlin\",\"postal_code\":\"10965\",\"country_code\":\"DE\"}','{\"first_name\":\"Sarah\",\"last_name\":\"Richter\",\"street\":\"Kreuzbergstr.\",\"house_number\":\"7\",\"city\":\"Berlin\",\"postal_code\":\"10965\",\"country_code\":\"DE\"}','paypal','paid',NULL,'2025-03-16 20:01:00',NULL,NULL,NULL,NULL,'78.99.112.55',NULL,'de','2025-03-16 19:55:00',NULL),
(11,'ORD-2025-B2-00004',2,10,'pending','standard',59.00,0.00,4.90,9.14,63.90,'EUR',NULL,NULL,'{\"first_name\":\"Emma\",\"last_name\":\"Wolf\",\"street\":\"Schönhauser Allee\",\"house_number\":\"55\",\"city\":\"Berlin\",\"postal_code\":\"10437\",\"country_code\":\"DE\"}','{\"first_name\":\"Emma\",\"last_name\":\"Wolf\",\"street\":\"Schönhauser Allee\",\"house_number\":\"55\",\"city\":\"Berlin\",\"postal_code\":\"10437\",\"country_code\":\"DE\"}','credit_card','paid',NULL,'2025-03-19 08:45:00',NULL,NULL,NULL,NULL,'99.12.34.77',NULL,'en','2025-03-19 08:40:00',NULL),
(12,'ORD-2025-B3-00001',3,11,'delivered','pickup',949.00,0.00,0.00,151.47,949.00,'EUR',NULL,NULL,'{\"first_name\":\"Lukas\",\"last_name\":\"Braun\",\"street\":\"Maximilianstraße\",\"house_number\":\"19\",\"city\":\"München\",\"postal_code\":\"80539\",\"country_code\":\"DE\"}',NULL,'credit_card','paid',NULL,'2025-02-28 14:00:00',NULL,NULL,'Abholung am Samstag bitte.',NULL,'89.12.56.78',NULL,'de','2025-02-27 10:00:00',NULL),
(13,'ORD-2025-B3-00002',3,12,'shipped','standard',5598.00,0.00,0.00,0.00,5598.00,'EUR',NULL,NULL,'{\"first_name\":\"Monika\",\"last_name\":\"Lange\",\"company\":\"Bay Solutions AG\",\"street\":\"Rosenheimer Platz\",\"house_number\":\"5\",\"city\":\"München\",\"postal_code\":\"81669\",\"country_code\":\"DE\"}','{\"first_name\":\"Monika\",\"last_name\":\"Lange\",\"company\":\"Bay Solutions AG\",\"street\":\"Rosenheimer Platz\",\"house_number\":\"5\",\"city\":\"München\",\"postal_code\":\"81669\",\"country_code\":\"DE\"}','invoice','pending',NULL,NULL,'PO-BAY-0091','2025-04-18',NULL,NULL,'195.22.33.44',NULL,'de','2025-03-18 09:00:00',NULL),
(14,'ORD-2025-B4-00001',4,13,'confirmed','standard',399.00,0.00,4.90,63.72,403.90,'EUR',NULL,NULL,'{\"first_name\":\"Hannah\",\"last_name\":\"Schmitt\",\"street\":\"Eppendorfer Baum\",\"house_number\":\"23\",\"city\":\"Hamburg\",\"postal_code\":\"20249\",\"country_code\":\"DE\"}','{\"first_name\":\"Hannah\",\"last_name\":\"Schmitt\",\"street\":\"Eppendorfer Baum\",\"house_number\":\"23\",\"city\":\"Hamburg\",\"postal_code\":\"20249\",\"country_code\":\"DE\"}','paypal','paid',NULL,'2025-03-18 21:10:00',NULL,NULL,NULL,NULL,'212.15.67.99',NULL,'de','2025-03-18 21:00:00',NULL),
(15,'ORD-2025-B4-00002',4,14,'processing','standard',9246.00,462.30,0.00,0.00,8783.70,'EUR',2,'B2BWILLKOMM','{\"first_name\":\"Bernd\",\"last_name\":\"Neumann\",\"company\":\"Nordsee Handel GmbH\",\"street\":\"Speicherstadt\",\"house_number\":\"11\",\"city\":\"Hamburg\",\"postal_code\":\"20457\",\"country_code\":\"DE\"}','{\"first_name\":\"Bernd\",\"last_name\":\"Neumann\",\"company\":\"Nordsee Handel GmbH\",\"street\":\"Speicherstadt\",\"house_number\":\"11\",\"city\":\"Hamburg\",\"postal_code\":\"20457\",\"country_code\":\"DE\"}','invoice','pending',NULL,NULL,'PO-NH-2025-022','2025-04-19',NULL,NULL,'195.45.33.21',NULL,'de','2025-03-19 08:00:00',NULL),
(16,'ORD-2025-B5-00001',5,15,'delivered','standard',429.00,0.00,6.90,71.50,435.90,'EUR',NULL,NULL,'{\"first_name\":\"Sophie\",\"last_name\":\"Huber\",\"street\":\"Mariahilfer Straße\",\"house_number\":\"105\",\"city\":\"Wien\",\"postal_code\":\"1060\",\"country_code\":\"AT\"}','{\"first_name\":\"Sophie\",\"last_name\":\"Huber\",\"street\":\"Mariahilfer Straße\",\"house_number\":\"105\",\"city\":\"Wien\",\"postal_code\":\"1060\",\"country_code\":\"AT\"}','credit_card','paid',NULL,'2025-03-05 18:20:00',NULL,NULL,NULL,NULL,'213.33.44.55',NULL,'de','2025-03-05 18:10:00',NULL),
(17,'ORD-2025-B5-00002',5,16,'confirmed','standard',3499.00,0.00,0.00,0.00,3499.00,'EUR',NULL,NULL,'{\"first_name\":\"Wolfgang\",\"last_name\":\"Gruber\",\"company\":\"Alpha Technik GmbH\",\"street\":\"Quellenstraße\",\"house_number\":\"33\",\"city\":\"Wien\",\"postal_code\":\"1100\",\"country_code\":\"AT\"}','{\"first_name\":\"Wolfgang\",\"last_name\":\"Gruber\",\"company\":\"Alpha Technik GmbH\",\"street\":\"Quellenstraße\",\"house_number\":\"33\",\"city\":\"Wien\",\"postal_code\":\"1100\",\"country_code\":\"AT\"}','invoice','pending',NULL,NULL,'PO-AT-2025-009','2025-04-18',NULL,NULL,'195.77.22.11',NULL,'de','2025-03-18 14:00:00',NULL);
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

LOCK TABLES `page_block_translations` WRITE;
/*!40000 ALTER TABLE `page_block_translations` DISABLE KEYS */;
INSERT INTO `page_block_translations` VALUES
(1,1,'de','{\"heading\":\"Ihr zuverlässiger Partner für Consumer Electronics\",\"body\":\"<p>TechStore wurde 2015 gegründet und hat sich zu einem der führenden Elektronik-Fachhändler in Deutschland und Österreich entwickelt. Mit fünf Filialen in Köln, Berlin, München und Hamburg sowie einem wachsenden Online-Shop beliefern wir täglich tausende von Kunden mit den neuesten Smartphones, Laptops, Audio-Geräten und Smart-Home-Produkten.</p><p>Unser Anspruch ist es, technisch anspruchsvolle Produkte mit erstklassigem Service zu verbinden. Kompetente Beratung, faire Preise und schnelle Lieferung – das ist unser Versprechen an Sie.</p>\"}'),
(2,1,'en','{\"heading\":\"Your Reliable Partner for Consumer Electronics\",\"body\":\"<p>TechStore was founded in 2015 and has grown into one of the leading electronics retailers in Germany and Austria. With five branches in Cologne, Berlin, Munich and Hamburg, as well as a growing online store, we serve thousands of customers daily.</p>\"}'),
(3,2,'de','{\"src\":\"pages/about/team-foto-2024.webp\",\"alt\":\"Das TechStore Team 2024\",\"caption\":\"Das TechStore-Team – über 80 Mitarbeiter an 5 Standorten.\"}'),
(4,2,'en','{\"src\":\"pages/about/team-foto-2024.webp\",\"alt\":\"TechStore Team 2024\",\"caption\":\"The TechStore team – over 80 employees at 5 locations.\"}'),
(5,3,'de','{\"items\":[{\"icon\":\"shield\",\"title\":\"Vertrauen\",\"text\":\"Alle Produkte sind originale Markenware mit Hersteller-Garantie.\"},{\"icon\":\"truck\",\"title\":\"Schnell & Zuverlässig\",\"text\":\"Bestellungen bis 14 Uhr werden noch am selben Tag versandt.\"},{\"icon\":\"headset\",\"title\":\"Exzellenter Support\",\"text\":\"Unser Kundenservice ist Mo–Sa 8–20 Uhr für Sie erreichbar.\"}]}'),
(6,3,'en','{\"items\":[{\"icon\":\"shield\",\"title\":\"Trust\",\"text\":\"All products are original branded goods with manufacturer warranty.\"},{\"icon\":\"truck\",\"title\":\"Fast & Reliable\",\"text\":\"Orders placed before 2 PM are shipped the same day.\"},{\"icon\":\"headset\",\"title\":\"Excellent Support\",\"text\":\"Our customer service is available Mon–Sat 8am–8pm.\"}]}'),
(7,4,'de','{\"heading\":\"Nehmen Sie Kontakt auf\",\"text\":\"Haben Sie Fragen? Unser Team hilft gerne weiter.\",\"button_text\":\"Zum Kontaktformular\",\"button_url\":\"/de/kontakt\"}'),
(8,4,'en','{\"heading\":\"Get In Touch\",\"text\":\"Have questions? Our team is happy to help.\",\"button_text\":\"Go to Contact Form\",\"button_url\":\"/en/contact\"}'),
(9,7,'de','{\"heading\":\"Maßgeschneiderte Lösungen für Ihr Unternehmen\",\"text\":\"Als B2B-Kunde profitieren Sie von exklusiven Konditionen, persönlichem Ansprechpartner und flexiblen Zahlungskonditionen auf Rechnung.\"}'),
(10,7,'en','{\"heading\":\"Tailored Solutions for Your Business\",\"text\":\"As a B2B customer you benefit from exclusive pricing, a personal account manager and flexible payment terms.\"}'),
(11,8,'de','{\"items\":[{\"icon\":\"tag\",\"title\":\"Sonderpreise\",\"text\":\"Bis zu 20% unter UVP für verifizierte Geschäftskunden.\"},{\"icon\":\"file-text\",\"title\":\"Kauf auf Rechnung\",\"text\":\"Zahlungsziel 30 Tage für bonitätsgeprüfte Unternehmen.\"},{\"icon\":\"package\",\"title\":\"Mengenrabatte\",\"text\":\"Staffelpreise ab 3 Einheiten.\"},{\"icon\":\"user\",\"title\":\"Persönliche Betreuung\",\"text\":\"Dedizierter Account-Manager für Ihren Betrieb.\"}]}'),
(12,8,'en','{\"items\":[{\"icon\":\"tag\",\"title\":\"Special Pricing\",\"text\":\"Up to 20% below RRP for verified business customers.\"},{\"icon\":\"file-text\",\"title\":\"Invoice Purchase\",\"text\":\"30-day payment terms for credit-checked companies.\"},{\"icon\":\"package\",\"title\":\"Volume Discounts\",\"text\":\"Tiered pricing from 3 units.\"},{\"icon\":\"user\",\"title\":\"Personal Support\",\"text\":\"Dedicated account manager for your business.\"}]}'),
(13,10,'de','{\"heading\":\"Jetzt B2B-Konto beantragen\",\"text\":\"Registrieren Sie sich und laden Sie Ihre Unternehmensdokumente hoch. Wir prüfen Ihren Antrag innerhalb von 24 Stunden.\",\"button_text\":\"B2B-Konto erstellen\",\"button_url\":\"/de/registrieren?typ=b2b\"}'),
(14,10,'en','{\"heading\":\"Apply for a B2B Account Now\",\"text\":\"Register and upload your company documents. We review your application within 24 hours.\",\"button_text\":\"Create B2B Account\",\"button_url\":\"/en/register?type=b2b\"}'),
(15,11,'de','{\"heading\":\"TechStore Köln – Schildergasse 12\",\"hours\":\"Mo–Sa: 9–20 Uhr, So: geschlossen\",\"phone\":\"+49 221 987654\",\"email\":\"koeln@techstore.de\",\"parking\":\"Parkhaus Dom/Pfeifergasse in 200m Entfernung.\",\"public_transport\":\"U-Bahn: Dom/Hbf (Linien 1, 7, 9)\"}');
/*!40000 ALTER TABLE `page_block_translations` ENABLE KEYS */;
UNLOCK TABLES;

LOCK TABLES `page_blocks` WRITE;
/*!40000 ALTER TABLE `page_blocks` DISABLE KEYS */;
INSERT INTO `page_blocks` VALUES
(1,1,'text',0,'intro-section','{\"width\":\"contained\",\"bg\":\"white\"}',1),
(2,1,'image',1,'team-photo','{\"align\":\"center\"}',1),
(3,1,'grid',2,'values-grid','{\"columns\":3}',1),
(4,1,'cta',3,'contact-cta','{\"style\":\"primary\"}',1),
(5,2,'grid',0,'locations-grid','{\"columns\":2}',1),
(6,2,'html',1,'contact-form','{}',1),
(7,8,'text',0,'b2b-hero','{\"bg\":\"dark\",\"text_color\":\"white\"}',1),
(8,8,'grid',1,'benefits-grid','{\"columns\":4}',1),
(9,8,'text',2,'process-steps','{}',1),
(10,8,'cta',3,'b2b-cta','{\"style\":\"primary\"}',1),
(11,9,'text',0,'branch-info','{}',1),
(12,9,'html',1,'branch-map','{}',1);
/*!40000 ALTER TABLE `page_blocks` ENABLE KEYS */;
UNLOCK TABLES;

LOCK TABLES `page_translations` WRITE;
/*!40000 ALTER TABLE `page_translations` DISABLE KEYS */;
INSERT INTO `page_translations` VALUES
(1,1,'de','Über uns','ueber-uns','Über TechStore – Ihr Elektronik-Fachhandel','TechStore: Ihr zuverlässiger Partner für Consumer Electronics. Erfahren Sie mehr über uns.',NULL),
(2,1,'en','About Us','about-us','About TechStore – Your Electronics Specialist','TechStore: Your trusted partner for consumer electronics. Learn more about us.',NULL),
(3,2,'de','Kontakt','kontakt','Kontakt – TechStore','Kontaktieren Sie TechStore. Wir helfen Ihnen gerne weiter.',NULL),
(4,2,'en','Contact','contact','Contact – TechStore','Contact TechStore. We are happy to help.',NULL),
(5,3,'de','Startseite Hero','startseite','TechStore – Top Deals in Elektronik','Smartphones, Laptops, Audio & mehr. Günstig kaufen & schnell geliefert.',NULL),
(6,3,'en','Homepage Hero','home','TechStore – Top Electronics Deals','Smartphones, laptops, audio & more. Buy cheap & get fast delivery.',NULL),
(7,4,'de','Impressum','impressum','Impressum – TechStore GmbH','Rechtliche Angaben gemäß § 5 TMG.',NULL),
(8,4,'en','Legal Notice','legal-notice','Legal Notice – TechStore GmbH','Legal information pursuant to § 5 TMG.',NULL),
(9,5,'de','Datenschutzerklärung','datenschutz','Datenschutz – TechStore GmbH','Informationen zum Datenschutz und zur Verarbeitung personenbezogener Daten.',NULL),
(10,5,'en','Privacy Policy','privacy-policy','Privacy Policy – TechStore GmbH','Information on data protection and the processing of personal data.',NULL),
(11,6,'de','Allgemeine Geschäftsbedingungen','agb','AGB – TechStore GmbH','Allgemeine Geschäftsbedingungen der TechStore GmbH.',NULL),
(12,6,'en','Terms and Conditions','terms','Terms and Conditions – TechStore GmbH','General terms and conditions of TechStore GmbH.',NULL),
(13,7,'de','Garantie & Rücksendungen','garantie-ruecksendungen','Garantie & Rücksendungen – TechStore','2 Jahre Garantie, 30 Tage Rückgaberecht. Alle Infos hier.',NULL),
(14,7,'en','Warranty & Returns','warranty-returns','Warranty & Returns – TechStore','2 year warranty, 30 day return policy. All info here.',NULL),
(15,8,'de','Für Geschäftskunden','geschaeftskunden','B2B & Geschäftskunden – TechStore','Exklusive Konditionen für Unternehmen. Jetzt B2B-Konto beantragen.',NULL),
(16,8,'en','For Business Customers','business','B2B & Business Customers – TechStore','Exclusive conditions for companies. Apply for a B2B account now.',NULL),
(17,9,'de','Filiale Köln','filiale-koeln','TechStore Filiale Köln – Öffnungszeiten & Adresse','TechStore in Köln auf der Schildergasse. Öffnungszeiten, Adresse, Anfahrt.',NULL),
(18,10,'de','Filiale Berlin','filiale-berlin','TechStore Filiale Berlin – Öffnungszeiten & Adresse','TechStore am Kurfürstendamm Berlin.',NULL),
(19,11,'de','Filiale München','filiale-muenchen','TechStore Filiale München – Öffnungszeiten & Adresse','TechStore in der Kaufingerstraße München.',NULL),
(20,12,'de','Filiale Hamburg','filiale-hamburg','TechStore Filiale Hamburg – Öffnungszeiten & Adresse','TechStore an der Mönckebergstraße Hamburg.',NULL),
(21,13,'de','Aktuelle Angebote','angebote','Top Angebote – TechStore','Die besten Deals & Aktionen. Jetzt entdecken.',NULL);
/*!40000 ALTER TABLE `page_translations` ENABLE KEYS */;
UNLOCK TABLES;

LOCK TABLES `pages` WRITE;
/*!40000 ALTER TABLE `pages` DISABLE KEYS */;
INSERT INTO `pages` VALUES
(1,NULL,NULL,'standard','published',1,1,0,7,'2026-04-17 08:58:36',NULL),
(2,NULL,NULL,'standard','published',2,1,0,7,'2026-04-17 08:58:36',NULL),
(3,NULL,NULL,'landing','published',0,0,0,7,'2026-04-17 08:58:36',NULL),
(4,NULL,NULL,'standard','published',3,1,0,7,'2026-04-17 08:58:36',NULL),
(5,NULL,NULL,'standard','published',4,1,0,7,'2026-04-17 08:58:36',NULL),
(6,NULL,NULL,'standard','published',5,1,0,7,'2026-04-17 08:58:36',NULL),
(7,NULL,NULL,'standard','published',6,1,0,7,'2026-04-17 08:58:36',NULL),
(8,NULL,NULL,'standard','published',7,0,0,7,'2026-04-17 08:58:36',NULL),
(9,1,NULL,'standard','published',1,0,0,3,'2026-04-17 08:58:36',NULL),
(10,2,NULL,'standard','published',1,0,0,4,'2026-04-17 08:58:36',NULL),
(11,3,NULL,'standard','published',1,0,0,5,'2026-04-17 08:58:36',NULL),
(12,4,NULL,'standard','published',1,0,0,6,'2026-04-17 08:58:36',NULL),
(13,NULL,NULL,'standard','draft',8,0,0,7,'2026-04-17 08:58:36',NULL);
/*!40000 ALTER TABLE `pages` ENABLE KEYS */;
UNLOCK TABLES;

LOCK TABLES `product_attribute_values` WRITE;
/*!40000 ALTER TABLE `product_attribute_values` DISABLE KEYS */;
INSERT INTO `product_attribute_values` VALUES
(1,1,'Titanium Black',1),
(2,1,'Titanium Gray',2),
(3,1,'Titanium Silver',3),
(4,1,'Phantom Black',4),
(5,1,'Phantom Silver',5),
(6,1,'Icy Blue',6),
(7,1,'Desert Titanium',7),
(8,1,'Black Titanium',8),
(9,1,'White Titanium',9),
(10,1,'Natural Titanium',10),
(11,1,'Schwarz',11),
(12,1,'Weiß',12),
(13,1,'Silber',13),
(14,1,'Midnight',14),
(15,1,'Starlight',15),
(16,1,'Blau',16),
(17,1,'Obsidian',17),
(18,1,'Porcelain',18),
(19,1,'Space Grau',19),
(20,2,'128 GB',1),
(21,2,'256 GB',2),
(22,2,'512 GB',3),
(23,2,'1 TB',4),
(24,3,'8 GB',1),
(25,3,'16 GB',2),
(26,3,'32 GB',3),
(27,3,'48 GB',4),
(28,4,'XS',1),
(29,4,'S',2),
(30,4,'M',3),
(31,4,'L',4);
/*!40000 ALTER TABLE `product_attribute_values` ENABLE KEYS */;
UNLOCK TABLES;

LOCK TABLES `product_attributes` WRITE;
/*!40000 ALTER TABLE `product_attributes` DISABLE KEYS */;
INSERT INTO `product_attributes` VALUES
(1,'Farbe','farbe'),
(2,'Speicher','speicher'),
(3,'RAM','ram'),
(4,'Größe','groesse');
/*!40000 ALTER TABLE `product_attributes` ENABLE KEYS */;
UNLOCK TABLES;

LOCK TABLES `product_branch_prices` WRITE;
/*!40000 ALTER TABLE `product_branch_prices` DISABLE KEYS */;
INSERT INTO `product_branch_prices` VALUES
(1,1,NULL,1,'standard',1249.0000,NULL,NULL,NULL,1),
(2,1,NULL,2,'standard',1249.0000,NULL,NULL,NULL,1),
(3,1,NULL,3,'standard',1249.0000,NULL,NULL,NULL,1),
(4,1,NULL,4,'standard',1249.0000,NULL,NULL,NULL,1),
(5,1,NULL,5,'standard',1299.0000,NULL,NULL,NULL,1),
(6,1,NULL,1,'b2b',1049.9900,NULL,NULL,NULL,1),
(7,1,NULL,2,'b2b',1049.9900,NULL,NULL,NULL,1),
(8,1,NULL,3,'b2b',1049.9900,NULL,NULL,NULL,1),
(9,1,NULL,4,'b2b',1049.9900,NULL,NULL,NULL,1),
(10,1,NULL,5,'b2b',1099.9900,NULL,NULL,NULL,1),
(11,1,1,1,'standard',1249.0000,NULL,NULL,NULL,1),
(12,1,1,2,'standard',1249.0000,NULL,NULL,NULL,1),
(13,1,1,3,'standard',1249.0000,NULL,NULL,NULL,1),
(14,1,1,4,'standard',1249.0000,NULL,NULL,NULL,1),
(15,1,1,5,'standard',1299.0000,NULL,NULL,NULL,1),
(16,1,2,1,'standard',1249.0000,NULL,NULL,NULL,1),
(17,1,2,2,'standard',1249.0000,NULL,NULL,NULL,1),
(18,1,2,3,'standard',1249.0000,NULL,NULL,NULL,1),
(19,1,2,4,'standard',1249.0000,NULL,NULL,NULL,1),
(20,1,2,5,'standard',1299.0000,NULL,NULL,NULL,1),
(21,1,3,1,'standard',1379.0000,NULL,NULL,NULL,1),
(22,1,3,2,'standard',1379.0000,NULL,NULL,NULL,1),
(23,1,3,3,'standard',1379.0000,NULL,NULL,NULL,1),
(24,1,3,4,'standard',1379.0000,NULL,NULL,NULL,1),
(25,1,3,5,'standard',1429.0000,NULL,NULL,NULL,1),
(26,1,4,1,'standard',1619.0000,NULL,NULL,NULL,1),
(27,1,4,2,'standard',1619.0000,NULL,NULL,NULL,1),
(28,1,4,3,'standard',1619.0000,NULL,NULL,NULL,1),
(29,1,4,4,'standard',1619.0000,NULL,NULL,NULL,1),
(30,1,4,5,'standard',1679.0000,NULL,NULL,NULL,1),
(31,1,1,1,'b2b',1049.9900,NULL,NULL,NULL,1),
(32,1,1,2,'b2b',1049.9900,NULL,NULL,NULL,1),
(33,1,1,3,'b2b',1049.9900,NULL,NULL,NULL,1),
(34,1,1,4,'b2b',1049.9900,NULL,NULL,NULL,1),
(35,1,3,1,'b2b',1169.0000,NULL,NULL,NULL,1),
(36,1,4,1,'b2b',1379.0000,NULL,NULL,NULL,1),
(37,2,NULL,1,'standard',849.0000,NULL,NULL,NULL,1),
(38,2,NULL,2,'standard',849.0000,NULL,NULL,NULL,1),
(39,2,NULL,3,'standard',849.0000,NULL,NULL,NULL,1),
(40,2,NULL,4,'standard',849.0000,NULL,NULL,NULL,1),
(41,2,NULL,5,'standard',899.0000,NULL,NULL,NULL,1),
(42,2,5,1,'standard',849.0000,NULL,NULL,NULL,1),
(43,2,5,2,'standard',849.0000,NULL,NULL,NULL,1),
(44,2,5,3,'standard',849.0000,NULL,NULL,NULL,1),
(45,2,5,4,'standard',849.0000,NULL,NULL,NULL,1),
(46,2,6,1,'standard',849.0000,NULL,NULL,NULL,1),
(47,2,6,2,'standard',849.0000,NULL,NULL,NULL,1),
(48,2,6,3,'standard',849.0000,NULL,NULL,NULL,1),
(49,2,6,4,'standard',849.0000,NULL,NULL,NULL,1),
(50,2,7,1,'standard',989.0000,NULL,NULL,NULL,1),
(51,2,7,2,'standard',989.0000,NULL,NULL,NULL,1),
(52,2,7,3,'standard',989.0000,NULL,NULL,NULL,1),
(53,2,7,4,'standard',989.0000,NULL,NULL,NULL,1),
(54,2,5,1,'b2b',721.0000,NULL,NULL,NULL,1),
(55,2,7,1,'b2b',840.0000,NULL,NULL,NULL,1),
(56,3,NULL,1,'standard',1329.0000,NULL,NULL,NULL,1),
(57,3,NULL,2,'standard',1329.0000,NULL,NULL,NULL,1),
(58,3,NULL,3,'standard',1329.0000,NULL,NULL,NULL,1),
(59,3,NULL,4,'standard',1329.0000,NULL,NULL,NULL,1),
(60,3,NULL,5,'standard',1379.0000,NULL,NULL,NULL,1),
(61,3,8,1,'standard',1329.0000,NULL,NULL,NULL,1),
(62,3,8,2,'standard',1329.0000,NULL,NULL,NULL,1),
(63,3,8,3,'standard',1329.0000,NULL,NULL,NULL,1),
(64,3,8,4,'standard',1329.0000,NULL,NULL,NULL,1),
(65,3,9,1,'standard',1329.0000,NULL,NULL,NULL,1),
(66,3,9,2,'standard',1329.0000,NULL,NULL,NULL,1),
(67,3,10,1,'standard',1549.0000,NULL,NULL,NULL,1),
(68,3,10,2,'standard',1549.0000,NULL,NULL,NULL,1),
(69,3,10,3,'standard',1549.0000,NULL,NULL,NULL,1),
(70,3,10,4,'standard',1549.0000,NULL,NULL,NULL,1),
(71,3,11,1,'standard',1779.0000,NULL,NULL,NULL,1),
(72,3,11,2,'standard',1779.0000,NULL,NULL,NULL,1),
(73,3,8,1,'b2b',1129.9900,NULL,NULL,NULL,1),
(74,3,10,1,'b2b',1319.0000,NULL,NULL,NULL,1),
(75,4,NULL,1,'standard',949.0000,NULL,NULL,NULL,1),
(76,4,NULL,2,'standard',949.0000,NULL,NULL,NULL,1),
(77,4,NULL,3,'standard',949.0000,NULL,NULL,NULL,1),
(78,4,NULL,4,'standard',949.0000,NULL,NULL,NULL,1),
(79,4,NULL,5,'standard',989.0000,NULL,NULL,NULL,1),
(80,4,12,1,'standard',949.0000,799.0000,'2025-03-01 00:00:00','2025-03-31 23:59:59',1),
(81,4,12,2,'standard',949.0000,799.0000,'2025-03-01 00:00:00','2025-03-31 23:59:59',1),
(82,4,12,3,'standard',949.0000,NULL,NULL,NULL,1),
(83,4,12,4,'standard',949.0000,NULL,NULL,NULL,1),
(84,4,13,1,'standard',949.0000,NULL,NULL,NULL,1),
(85,4,13,2,'standard',949.0000,NULL,NULL,NULL,1),
(86,4,14,1,'standard',1099.0000,NULL,NULL,NULL,1),
(87,4,14,2,'standard',1099.0000,NULL,NULL,NULL,1),
(88,4,12,1,'b2b',807.0000,NULL,NULL,NULL,1),
(89,4,14,1,'b2b',934.0000,NULL,NULL,NULL,1),
(90,5,NULL,1,'standard',1099.0000,NULL,NULL,NULL,1),
(91,5,NULL,2,'standard',1099.0000,NULL,NULL,NULL,1),
(92,5,NULL,3,'standard',1099.0000,NULL,NULL,NULL,1),
(93,5,NULL,4,'standard',1099.0000,NULL,NULL,NULL,1),
(94,5,NULL,5,'standard',1149.0000,NULL,NULL,NULL,1),
(95,5,NULL,1,'b2b',934.0000,NULL,NULL,NULL,1),
(96,6,NULL,1,'standard',499.0000,449.0000,'2025-03-15 00:00:00','2025-03-31 23:59:59',1),
(97,6,NULL,2,'standard',499.0000,449.0000,'2025-03-15 00:00:00','2025-03-31 23:59:59',1),
(98,6,NULL,3,'standard',499.0000,NULL,NULL,NULL,1),
(99,6,NULL,4,'standard',499.0000,NULL,NULL,NULL,1),
(100,6,NULL,1,'b2b',424.0000,NULL,NULL,NULL,1),
(101,7,NULL,1,'standard',1299.0000,NULL,NULL,NULL,1),
(102,7,NULL,2,'standard',1299.0000,NULL,NULL,NULL,1),
(103,7,NULL,3,'standard',1299.0000,NULL,NULL,NULL,1),
(104,7,NULL,4,'standard',1299.0000,NULL,NULL,NULL,1),
(105,7,NULL,5,'standard',1349.0000,NULL,NULL,NULL,1),
(106,7,15,1,'standard',1299.0000,NULL,NULL,NULL,1),
(107,7,15,2,'standard',1299.0000,NULL,NULL,NULL,1),
(108,7,15,3,'standard',1299.0000,NULL,NULL,NULL,1),
(109,7,15,4,'standard',1299.0000,NULL,NULL,NULL,1),
(110,7,16,1,'standard',1499.0000,NULL,NULL,NULL,1),
(111,7,16,2,'standard',1499.0000,NULL,NULL,NULL,1),
(112,7,16,3,'standard',1499.0000,NULL,NULL,NULL,1),
(113,7,16,4,'standard',1499.0000,NULL,NULL,NULL,1),
(114,7,17,1,'standard',1699.0000,NULL,NULL,NULL,1),
(115,7,17,2,'standard',1699.0000,NULL,NULL,NULL,1),
(116,7,15,1,'b2b',1104.0000,NULL,NULL,NULL,1),
(117,7,16,1,'b2b',1274.0000,NULL,NULL,NULL,1),
(118,7,17,1,'b2b',1444.0000,NULL,NULL,NULL,1),
(119,8,NULL,1,'standard',1999.0000,NULL,NULL,NULL,1),
(120,8,NULL,2,'standard',1999.0000,NULL,NULL,NULL,1),
(121,8,NULL,3,'standard',1999.0000,NULL,NULL,NULL,1),
(122,8,NULL,4,'standard',1999.0000,NULL,NULL,NULL,1),
(123,8,NULL,5,'standard',2099.0000,NULL,NULL,NULL,1),
(124,8,NULL,1,'b2b',1699.0000,NULL,NULL,NULL,1),
(125,9,NULL,1,'standard',2299.0000,1999.0000,'2025-03-10 00:00:00','2025-03-31 23:59:59',1),
(126,9,NULL,2,'standard',2299.0000,1999.0000,'2025-03-10 00:00:00','2025-03-31 23:59:59',1),
(127,9,NULL,3,'standard',2299.0000,NULL,NULL,NULL,1),
(128,9,NULL,4,'standard',2299.0000,NULL,NULL,NULL,1),
(129,9,NULL,5,'standard',2399.0000,NULL,NULL,NULL,1),
(130,9,NULL,1,'b2b',1954.0000,NULL,NULL,NULL,1),
(131,9,NULL,2,'b2b',1954.0000,NULL,NULL,NULL,1),
(132,10,NULL,1,'standard',1599.0000,NULL,NULL,NULL,1),
(133,10,NULL,2,'standard',1599.0000,NULL,NULL,NULL,1),
(134,10,NULL,3,'standard',1599.0000,NULL,NULL,NULL,1),
(135,10,NULL,4,'standard',1599.0000,NULL,NULL,NULL,1),
(136,10,NULL,1,'b2b',1359.0000,NULL,NULL,NULL,1),
(137,11,NULL,1,'standard',1899.0000,NULL,NULL,NULL,1),
(138,11,NULL,2,'standard',1899.0000,NULL,NULL,NULL,1),
(139,11,NULL,3,'standard',1899.0000,NULL,NULL,NULL,1),
(140,11,NULL,1,'b2b',1614.0000,NULL,NULL,NULL,1),
(141,12,NULL,1,'standard',399.0000,NULL,NULL,NULL,1),
(142,12,NULL,2,'standard',399.0000,NULL,NULL,NULL,1),
(143,12,NULL,3,'standard',399.0000,NULL,NULL,NULL,1),
(144,12,NULL,4,'standard',399.0000,NULL,NULL,NULL,1),
(145,12,NULL,5,'standard',419.0000,NULL,NULL,NULL,1),
(146,12,18,1,'standard',399.0000,NULL,NULL,NULL,1),
(147,12,18,2,'standard',399.0000,NULL,NULL,NULL,1),
(148,12,18,3,'standard',399.0000,NULL,NULL,NULL,1),
(149,12,18,4,'standard',399.0000,NULL,NULL,NULL,1),
(150,12,19,1,'standard',399.0000,NULL,NULL,NULL,1),
(151,12,19,2,'standard',399.0000,NULL,NULL,NULL,1),
(152,12,18,1,'b2b',339.0000,NULL,NULL,NULL,1),
(153,12,19,1,'b2b',339.0000,NULL,NULL,NULL,1),
(154,13,NULL,1,'standard',549.0000,NULL,NULL,NULL,1),
(155,13,NULL,2,'standard',549.0000,NULL,NULL,NULL,1),
(156,13,NULL,3,'standard',549.0000,NULL,NULL,NULL,1),
(157,13,NULL,4,'standard',549.0000,NULL,NULL,NULL,1),
(158,13,21,1,'standard',549.0000,NULL,NULL,NULL,1),
(159,13,21,2,'standard',549.0000,NULL,NULL,NULL,1),
(160,13,22,1,'standard',549.0000,NULL,NULL,NULL,1),
(161,13,22,2,'standard',549.0000,NULL,NULL,NULL,1),
(162,13,21,1,'b2b',466.0000,NULL,NULL,NULL,1),
(163,14,NULL,1,'standard',279.0000,229.0000,'2025-03-01 00:00:00','2025-04-30 23:59:59',1),
(164,14,NULL,2,'standard',279.0000,229.0000,'2025-03-01 00:00:00','2025-04-30 23:59:59',1),
(165,14,NULL,3,'standard',279.0000,NULL,NULL,NULL,1),
(166,14,NULL,4,'standard',279.0000,NULL,NULL,NULL,1),
(167,14,NULL,5,'standard',299.0000,NULL,NULL,NULL,1),
(168,14,NULL,1,'b2b',237.0000,NULL,NULL,NULL,1),
(169,15,NULL,1,'standard',279.0000,NULL,NULL,NULL,1),
(170,15,NULL,2,'standard',279.0000,NULL,NULL,NULL,1),
(171,15,NULL,3,'standard',279.0000,NULL,NULL,NULL,1),
(172,15,NULL,4,'standard',279.0000,NULL,NULL,NULL,1),
(173,15,NULL,5,'standard',299.0000,NULL,NULL,NULL,1),
(174,15,20,1,'standard',279.0000,NULL,NULL,NULL,1),
(175,15,20,2,'standard',279.0000,NULL,NULL,NULL,1),
(176,15,20,3,'standard',279.0000,NULL,NULL,NULL,1),
(177,15,20,4,'standard',279.0000,NULL,NULL,NULL,1),
(178,15,20,1,'b2b',237.0000,NULL,NULL,NULL,1),
(179,16,NULL,1,'standard',349.0000,NULL,NULL,NULL,1),
(180,16,NULL,2,'standard',349.0000,NULL,NULL,NULL,1),
(181,16,NULL,3,'standard',349.0000,NULL,NULL,NULL,1),
(182,16,NULL,4,'standard',349.0000,NULL,NULL,NULL,1),
(183,16,NULL,5,'standard',369.0000,NULL,NULL,NULL,1),
(184,16,23,1,'standard',349.0000,NULL,NULL,NULL,1),
(185,16,24,1,'standard',349.0000,NULL,NULL,NULL,1),
(186,16,23,1,'b2b',297.0000,NULL,NULL,NULL,1),
(187,17,NULL,1,'standard',219.0000,199.0000,'2025-03-01 00:00:00','2025-03-31 23:59:59',1),
(188,17,NULL,2,'standard',219.0000,199.0000,'2025-03-01 00:00:00','2025-03-31 23:59:59',1),
(189,17,NULL,3,'standard',219.0000,NULL,NULL,NULL,1),
(190,17,NULL,4,'standard',219.0000,NULL,NULL,NULL,1),
(191,17,NULL,1,'b2b',186.0000,NULL,NULL,NULL,1),
(192,18,NULL,1,'standard',59.0000,NULL,NULL,NULL,1),
(193,18,NULL,2,'standard',59.0000,NULL,NULL,NULL,1),
(194,18,NULL,3,'standard',59.0000,NULL,NULL,NULL,1),
(195,18,NULL,4,'standard',59.0000,NULL,NULL,NULL,1),
(196,18,NULL,5,'standard',65.0000,NULL,NULL,NULL,1),
(197,19,NULL,1,'standard',349.0000,NULL,NULL,NULL,1),
(198,19,NULL,2,'standard',349.0000,NULL,NULL,NULL,1),
(199,19,NULL,3,'standard',349.0000,NULL,NULL,NULL,1),
(200,19,NULL,4,'standard',349.0000,NULL,NULL,NULL,1),
(201,19,NULL,5,'standard',369.0000,NULL,NULL,NULL,1),
(202,19,NULL,1,'b2b',297.0000,NULL,NULL,NULL,1),
(203,20,NULL,1,'standard',1299.0000,NULL,NULL,NULL,1),
(204,20,NULL,2,'standard',1299.0000,NULL,NULL,NULL,1),
(205,20,NULL,3,'standard',1299.0000,NULL,NULL,NULL,1),
(206,20,NULL,4,'standard',1299.0000,NULL,NULL,NULL,1),
(207,20,NULL,5,'standard',1379.0000,NULL,NULL,NULL,1),
(208,20,25,1,'standard',1299.0000,NULL,NULL,NULL,1),
(209,20,25,2,'standard',1299.0000,NULL,NULL,NULL,1),
(210,20,26,1,'standard',1299.0000,NULL,NULL,NULL,1),
(211,20,27,1,'standard',1519.0000,NULL,NULL,NULL,1),
(212,20,25,1,'b2b',1104.0000,NULL,NULL,NULL,1),
(213,21,NULL,1,'standard',449.0000,379.0000,'2025-02-01 00:00:00','2025-03-31 23:59:59',1),
(214,21,NULL,2,'standard',449.0000,379.0000,'2025-02-01 00:00:00','2025-03-31 23:59:59',1),
(215,21,NULL,3,'standard',449.0000,NULL,NULL,NULL,1),
(216,21,NULL,4,'standard',449.0000,NULL,NULL,NULL,1),
(217,21,NULL,1,'b2b',382.0000,NULL,NULL,NULL,1),
(218,22,NULL,1,'standard',289.0000,NULL,NULL,NULL,1),
(219,22,NULL,2,'standard',289.0000,NULL,NULL,NULL,1),
(220,22,NULL,3,'standard',289.0000,NULL,NULL,NULL,1),
(221,22,NULL,4,'standard',289.0000,NULL,NULL,NULL,1),
(222,22,NULL,1,'b2b',246.0000,NULL,NULL,NULL,1),
(223,23,NULL,1,'standard',159.0000,NULL,NULL,NULL,1),
(224,23,NULL,2,'standard',159.0000,NULL,NULL,NULL,1),
(225,23,NULL,3,'standard',159.0000,NULL,NULL,NULL,1),
(226,23,NULL,4,'standard',159.0000,NULL,NULL,NULL,1),
(227,23,NULL,5,'standard',169.0000,NULL,NULL,NULL,1),
(228,23,NULL,1,'b2b',135.0000,NULL,NULL,NULL,1),
(229,24,NULL,1,'standard',229.0000,NULL,NULL,NULL,1),
(230,24,NULL,2,'standard',229.0000,NULL,NULL,NULL,1),
(231,24,NULL,3,'standard',229.0000,NULL,NULL,NULL,1),
(232,24,NULL,4,'standard',229.0000,NULL,NULL,NULL,1),
(233,24,NULL,1,'b2b',195.0000,NULL,NULL,NULL,1),
(234,25,NULL,1,'standard',199.0000,NULL,NULL,NULL,1),
(235,25,NULL,2,'standard',199.0000,NULL,NULL,NULL,1),
(236,25,NULL,3,'standard',199.0000,NULL,NULL,NULL,1),
(237,25,NULL,4,'standard',199.0000,NULL,NULL,NULL,1),
(238,25,NULL,5,'standard',209.0000,NULL,NULL,NULL,1),
(239,25,NULL,1,'b2b',169.0000,NULL,NULL,NULL,1),
(240,26,NULL,1,'standard',64.9900,NULL,NULL,NULL,1),
(241,26,NULL,2,'standard',64.9900,NULL,NULL,NULL,1),
(242,26,NULL,3,'standard',64.9900,NULL,NULL,NULL,1),
(243,26,NULL,4,'standard',64.9900,NULL,NULL,NULL,1),
(244,26,28,1,'standard',64.9900,NULL,NULL,NULL,1),
(245,26,29,1,'standard',64.9900,NULL,NULL,NULL,1),
(246,27,NULL,1,'standard',149.0000,NULL,NULL,NULL,1),
(247,27,NULL,2,'standard',149.0000,NULL,NULL,NULL,1),
(248,27,NULL,3,'standard',149.0000,NULL,NULL,NULL,1),
(249,27,NULL,4,'standard',149.0000,NULL,NULL,NULL,1),
(250,27,NULL,5,'standard',159.0000,NULL,NULL,NULL,1),
(251,27,NULL,1,'b2b',126.0000,NULL,NULL,NULL,1),
(252,28,NULL,1,'standard',3299.0000,NULL,NULL,NULL,1),
(253,28,NULL,2,'standard',3299.0000,NULL,NULL,NULL,1),
(254,28,NULL,3,'standard',3299.0000,NULL,NULL,NULL,1),
(255,28,NULL,4,'standard',3299.0000,NULL,NULL,NULL,1),
(256,28,NULL,5,'standard',3499.0000,NULL,NULL,NULL,1),
(257,28,NULL,1,'b2b',2804.0000,NULL,NULL,NULL,1),
(258,29,NULL,1,'standard',1799.0000,NULL,NULL,NULL,1),
(259,29,NULL,2,'standard',1799.0000,NULL,NULL,NULL,1),
(260,29,NULL,3,'standard',1799.0000,NULL,NULL,NULL,1),
(261,29,NULL,4,'standard',1799.0000,NULL,NULL,NULL,1),
(262,29,NULL,1,'b2b',1529.0000,NULL,NULL,NULL,1),
(263,30,NULL,1,'standard',29.0000,NULL,NULL,NULL,1),
(264,30,NULL,2,'standard',29.0000,NULL,NULL,NULL,1),
(265,30,NULL,3,'standard',29.0000,NULL,NULL,NULL,1),
(266,30,NULL,4,'standard',29.0000,NULL,NULL,NULL,1),
(267,30,NULL,5,'standard',32.0000,NULL,NULL,NULL,1),
(268,30,30,1,'standard',29.0000,NULL,NULL,NULL,1),
(269,30,31,1,'standard',29.0000,NULL,NULL,NULL,1),
(270,30,32,1,'standard',39.0000,NULL,NULL,NULL,1),
(271,30,30,1,'b2b',24.0000,NULL,NULL,NULL,1),
(272,30,31,1,'b2b',24.0000,NULL,NULL,NULL,1);
/*!40000 ALTER TABLE `product_branch_prices` ENABLE KEYS */;
UNLOCK TABLES;

LOCK TABLES `product_branch_stock` WRITE;
/*!40000 ALTER TABLE `product_branch_stock` DISABLE KEYS */;
INSERT INTO `product_branch_stock` VALUES
(1,1,1,1,45,3,5,1,0),
(2,1,1,2,23,1,5,1,0),
(3,1,1,3,18,0,3,1,0),
(4,1,1,4,12,2,3,1,0),
(5,1,1,5,8,0,3,1,1),
(6,1,2,1,38,2,5,1,0),
(7,1,2,2,20,0,5,1,0),
(8,1,2,3,15,1,3,1,0),
(9,1,2,4,9,0,3,1,0),
(10,1,3,1,22,0,5,1,0),
(11,1,3,2,11,1,3,1,0),
(12,1,3,3,8,0,3,1,0),
(13,1,3,4,6,0,3,1,0),
(14,1,4,1,8,1,3,1,0),
(15,1,4,2,4,0,3,1,0),
(16,1,4,3,3,0,2,1,0),
(17,1,4,4,2,0,2,1,1),
(18,3,8,1,32,2,5,1,0),
(19,3,8,2,18,1,5,1,0),
(20,3,8,3,22,0,5,1,0),
(21,3,8,4,15,0,3,1,0),
(22,3,9,1,28,0,5,1,0),
(23,3,9,2,16,1,3,1,0),
(24,3,10,1,14,2,3,1,0),
(25,3,10,2,8,0,3,1,0),
(26,3,10,3,10,1,3,1,0),
(27,3,11,1,5,0,2,1,0),
(28,3,11,2,3,0,2,1,1),
(29,4,12,1,55,5,10,1,0),
(30,4,12,2,33,2,5,1,0),
(31,4,12,3,28,0,5,1,0),
(32,4,12,4,21,1,5,1,0),
(33,4,13,1,42,3,10,1,0),
(34,4,13,2,25,0,5,1,0),
(35,4,14,1,28,2,5,1,0),
(36,4,14,2,16,1,3,1,0),
(37,5,NULL,1,20,1,5,1,0),
(38,5,NULL,2,12,0,3,1,0),
(39,5,NULL,3,10,0,3,1,0),
(40,5,NULL,4,8,0,3,1,0),
(41,6,NULL,1,35,0,5,1,0),
(42,6,NULL,2,20,0,5,1,0),
(43,6,NULL,3,15,0,3,1,0),
(44,6,NULL,4,12,0,3,1,0),
(45,7,15,1,28,2,5,1,0),
(46,7,15,2,16,0,3,1,0),
(47,7,15,3,12,1,3,1,0),
(48,7,15,4,9,0,3,1,0),
(49,7,16,1,20,1,5,1,0),
(50,7,16,2,11,0,3,1,0),
(51,7,16,3,8,0,3,1,0),
(52,7,16,4,6,0,2,1,0),
(53,7,17,1,10,0,3,1,0),
(54,7,17,2,6,1,2,1,0),
(55,8,NULL,1,15,1,3,1,0),
(56,8,NULL,2,9,0,3,1,0),
(57,8,NULL,3,7,0,2,1,0),
(58,8,NULL,4,5,0,2,1,1),
(59,9,NULL,1,12,1,3,1,0),
(60,9,NULL,2,7,0,2,1,0),
(61,9,NULL,3,5,0,2,1,0),
(62,9,NULL,4,4,0,2,1,0),
(63,10,NULL,1,18,0,3,1,0),
(64,10,NULL,2,10,0,3,1,0),
(65,10,NULL,3,8,0,2,1,0),
(66,10,NULL,4,6,0,2,1,0),
(67,11,NULL,1,10,0,3,1,0),
(68,11,NULL,2,6,0,2,1,0),
(69,11,NULL,3,5,0,2,1,0),
(70,12,18,1,48,3,10,1,0),
(71,12,18,2,30,1,5,1,0),
(72,12,18,3,25,0,5,1,0),
(73,12,18,4,20,0,5,1,0),
(74,12,18,5,15,0,3,1,0),
(75,12,19,1,22,0,5,1,0),
(76,12,19,2,14,0,3,1,0),
(77,12,19,3,10,0,3,1,0),
(78,12,19,4,8,0,2,1,0),
(79,13,21,1,18,1,3,1,0),
(80,13,21,2,11,0,3,1,0),
(81,13,21,3,9,0,2,1,0),
(82,13,22,1,14,0,3,1,0),
(83,13,22,2,8,0,2,1,0),
(84,14,NULL,1,35,2,5,1,0),
(85,14,NULL,2,20,0,5,1,0),
(86,14,NULL,3,16,1,3,1,0),
(87,14,NULL,4,12,0,3,1,0),
(88,14,NULL,5,10,0,3,1,0),
(89,15,20,1,60,5,10,1,0),
(90,15,20,2,38,2,5,1,0),
(91,15,20,3,32,1,5,1,0),
(92,15,20,4,25,0,5,1,0),
(93,15,20,5,18,0,3,1,0),
(94,16,23,1,42,3,5,1,0),
(95,16,23,2,26,0,5,1,0),
(96,16,23,3,20,0,5,1,0),
(97,16,23,4,15,0,3,1,0),
(98,16,24,1,20,0,5,1,0),
(99,16,24,2,12,0,3,1,0),
(100,17,NULL,1,55,4,10,1,0),
(101,17,NULL,2,32,1,5,1,0),
(102,17,NULL,3,28,0,5,1,0),
(103,17,NULL,4,20,0,5,1,0),
(104,18,NULL,1,80,5,10,1,0),
(105,18,NULL,2,50,2,10,1,0),
(106,18,NULL,3,40,0,5,1,0),
(107,18,NULL,4,35,0,5,1,0),
(108,18,NULL,5,25,0,5,1,0),
(109,19,NULL,1,28,2,5,1,0),
(110,19,NULL,2,18,0,3,1,0),
(111,19,NULL,3,15,1,3,1,0),
(112,19,NULL,4,12,0,3,1,0),
(113,19,NULL,5,10,0,3,1,0),
(114,20,25,1,22,2,5,1,0),
(115,20,25,2,14,1,3,1,0),
(116,20,25,3,12,0,3,1,0),
(117,20,25,4,9,0,3,1,0),
(118,20,26,1,18,1,5,1,0),
(119,20,26,2,10,0,3,1,0),
(120,20,27,1,10,0,3,1,0),
(121,20,27,2,6,0,2,1,0),
(122,21,NULL,1,45,3,10,1,0),
(123,21,NULL,2,28,1,5,1,0),
(124,21,NULL,3,22,0,5,1,0),
(125,21,NULL,4,18,0,5,1,0),
(126,22,NULL,1,30,2,5,1,0),
(127,22,NULL,2,18,0,3,1,0),
(128,22,NULL,3,14,0,3,1,0),
(129,22,NULL,4,10,0,3,1,0),
(130,23,NULL,1,50,3,10,1,0),
(131,23,NULL,2,32,1,5,1,0),
(132,23,NULL,3,28,0,5,1,0),
(133,23,NULL,4,22,0,5,1,0),
(134,23,NULL,5,15,0,3,1,0),
(135,24,NULL,1,25,1,5,1,0),
(136,24,NULL,2,15,0,3,1,0),
(137,24,NULL,3,12,0,3,1,0),
(138,24,NULL,4,9,0,2,1,0),
(139,25,NULL,1,35,2,5,1,0),
(140,25,NULL,2,22,0,5,1,0),
(141,25,NULL,3,18,0,3,1,0),
(142,25,NULL,4,15,0,3,1,0),
(143,25,NULL,5,12,0,3,1,0),
(144,26,28,1,70,5,10,1,0),
(145,26,28,2,45,2,10,1,0),
(146,26,28,3,38,0,5,1,0),
(147,26,28,4,32,0,5,1,0),
(148,26,29,1,55,3,10,1,0),
(149,26,29,2,35,0,5,1,0),
(150,27,NULL,1,40,2,5,1,0),
(151,27,NULL,2,25,0,5,1,0),
(152,27,NULL,3,20,0,3,1,0),
(153,27,NULL,4,16,0,3,1,0),
(154,27,NULL,5,12,0,3,1,1),
(155,28,NULL,1,12,1,3,1,0),
(156,28,NULL,2,8,0,2,1,0),
(157,28,NULL,3,6,0,2,1,0),
(158,28,NULL,4,5,0,2,1,0),
(159,28,NULL,5,4,0,2,1,1),
(160,29,NULL,1,18,1,3,1,0),
(161,29,NULL,2,11,0,3,1,0),
(162,29,NULL,3,9,0,2,1,0),
(163,29,NULL,4,7,0,2,1,0),
(164,30,30,1,200,10,20,1,0),
(165,30,30,2,150,5,20,1,0),
(166,30,30,3,120,0,10,1,0),
(167,30,30,4,100,0,10,1,0),
(168,30,30,5,80,0,10,1,0),
(169,30,31,1,180,8,20,1,0),
(170,30,31,2,120,3,15,1,0),
(171,30,32,1,90,2,10,1,0),
(172,30,32,2,60,0,5,1,0);
/*!40000 ALTER TABLE `product_branch_stock` ENABLE KEYS */;
UNLOCK TABLES;

LOCK TABLES `product_images` WRITE;
/*!40000 ALTER TABLE `product_images` DISABLE KEYS */;
INSERT INTO `product_images` VALUES
(1,1,'products/1/s25-ultra-titanium-gray.webp','Samsung Galaxy S25 Ultra Titanium Gray',0,1),
(2,1,'products/1/s25-ultra-titanium-black.webp','Samsung Galaxy S25 Ultra Titanium Black',1,0),
(3,1,'products/1/s25-ultra-spen-detail.webp','Samsung Galaxy S25 Ultra S Pen Detail',2,0),
(4,2,'products/2/s25-phantom-silver.webp','Samsung Galaxy S25 Phantom Silver',0,1),
(5,2,'products/2/s25-phantom-black.webp','Samsung Galaxy S25 Phantom Black',1,0),
(6,3,'products/3/iphone16pro-desert-titanium.webp','Apple iPhone 16 Pro Desert Titanium',0,1),
(7,3,'products/3/iphone16pro-black-titanium.webp','Apple iPhone 16 Pro Black Titanium',1,0),
(8,3,'products/3/iphone16pro-camera.webp','Apple iPhone 16 Pro Kamerasystem',2,0),
(9,4,'products/4/iphone16-black.webp','Apple iPhone 16 Schwarz',0,1),
(10,4,'products/4/iphone16-ultramarine.webp','Apple iPhone 16 Ultramarine',1,0),
(11,5,'products/5/pixel9pro-obsidian.webp','Google Pixel 9 Pro Obsidian',0,1),
(12,5,'products/5/pixel9pro-porcelain.webp','Google Pixel 9 Pro Porcelain',1,0),
(13,6,'products/6/oneplus12r-iron-gray.webp','OnePlus 12R Iron Gray',0,1),
(14,7,'products/7/mba-m3-midnight.webp','MacBook Air M3 Midnight',0,1),
(15,7,'products/7/mba-m3-starlight.webp','MacBook Air M3 Starlight',1,0),
(16,7,'products/7/mba-m3-silver.webp','MacBook Air M3 Silber',2,0),
(17,8,'products/8/mbp-m4-spacegrau.webp','MacBook Pro M4 Space Grau',0,1),
(18,9,'products/9/dell-xps15-oled.webp','Dell XPS 15 OLED Display',0,1),
(19,9,'products/9/dell-xps15-tastatur.webp','Dell XPS 15 Tastatur Detail',1,0),
(20,10,'products/10/lenovo-x1-carbon.webp','Lenovo ThinkPad X1 Carbon',0,1),
(21,11,'products/11/asus-zenbook-pro.webp','ASUS ZenBook Pro',0,1),
(22,12,'products/12/wh1000xm6-schwarz.webp','Sony WH-1000XM6 Schwarz',0,1),
(23,12,'products/12/wh1000xm6-silber.webp','Sony WH-1000XM6 Silber',1,0),
(24,12,'products/12/wh1000xm6-case.webp','Sony WH-1000XM6 mit Etui',2,0),
(25,13,'products/13/app-max-midnightsky.webp','Apple AirPods Max Midnight Sky',0,1),
(26,13,'products/13/app-max-starlight.webp','Apple AirPods Max Starlight',1,0),
(27,14,'products/14/bose-qc45-schwarz.webp','Bose QuietComfort 45 Schwarz',0,1),
(28,15,'products/15/airpods-pro4-white.webp','Apple AirPods Pro 4 Weiß',0,1),
(29,15,'products/15/airpods-pro4-case.webp','Apple AirPods Pro 4 MagSafe Case',1,0),
(30,16,'products/16/wf1000xm5-schwarz.webp','Sony WF-1000XM5 Schwarz',0,1),
(31,17,'products/17/galaxy-buds-pro3.webp','Samsung Galaxy Buds3 Pro',0,1),
(32,18,'products/18/sony-xb100-schwarz.webp','Sony SRS-XB100 Schwarz',0,1),
(33,19,'products/19/bose-soundlink-max.webp','Bose SoundLink Max',0,1),
(34,19,'products/19/bose-soundlink-max-side.webp','Bose SoundLink Max Seitenansicht',1,0),
(35,20,'products/20/ipad-pro-m4-silber.webp','Apple iPad Pro 13 M4 Silber',0,1),
(36,20,'products/20/ipad-pro-m4-spacegrau.webp','Apple iPad Pro 13 M4 Space Grau',1,0),
(37,20,'products/20/ipad-pro-m4-pencil.webp','Apple iPad Pro M4 mit Apple Pencil Pro',2,0),
(38,21,'products/21/samsung-tab-s9fe-grau.webp','Samsung Galaxy Tab S9 FE Grau',0,1),
(39,22,'products/22/shroud-gsn10-schwarz.webp','SteelSeries Arctis Nova Pro Schwarz',0,1),
(40,23,'products/23/logitech-gpro-x2.webp','Logitech G PRO X 2 Weiß',0,1),
(41,24,'products/24/razer-huntsman-v3.webp','Razer Huntsman V3 Pro',0,1),
(42,25,'products/25/philips-hue-starter.webp','Philips Hue White & Color Starter Kit',0,1),
(43,26,'products/26/amazon-echo-dot5.webp','Amazon Echo Dot 5. Generation',0,1),
(44,27,'products/27/nest-thermostat-4.webp','Google Nest Thermostat 4. Gen.',0,1),
(45,28,'products/28/sony-a7iv-kamera.webp','Sony Alpha 7 IV Gehäuse',0,1),
(46,28,'products/28/sony-a7iv-seite.webp','Sony Alpha 7 IV Seitenansicht',1,0),
(47,29,'products/29/canon-eosr8-front.webp','Canon EOS R8 Gehäuse',0,1),
(48,30,'products/30/apple-usbc-kabel.webp','Apple USB-C Kabel 1 m',0,1);
/*!40000 ALTER TABLE `product_images` ENABLE KEYS */;
UNLOCK TABLES;

LOCK TABLES `product_reviews` WRITE;
/*!40000 ALTER TABLE `product_reviews` DISABLE KEYS */;
INSERT INTO `product_reviews` VALUES
(1,3,1,1,5,'Absolut beeindruckend!','Das iPhone 16 Pro ist das beste Smartphone, das ich je hatte. Die Kamera ist unglaublich – selbst bei Nacht entstehen brillante Fotos. Der A18 Pro Chip macht alles blitzschnell. Camera Control Button ist ein Gamechanger.','approved','2025-02-01 14:30:00'),
(2,3,7,2,5,'Top Kamera, super Performance','Ich bin von Android zu Apple gewechselt und bereue es keinen Moment. Das ProRes-Video ist für meine YouTube-Produktion einfach perfekt.','approved','2025-02-10 11:00:00'),
(3,3,11,3,4,'Sehr gut, aber teuer','Qualität ist erstklassig. 5x Telezoom ist fantastisch. Einziger Kritikpunkt: der Preis. Aber für professionelle Anwender absolut gerechtfertigt.','approved','2025-02-15 09:20:00'),
(4,1,2,1,5,'S Pen macht den Unterschied','Ich nutze das S25 Ultra täglich für Meetings und Notizen. Der S Pen ist reaktionsschnell und das Display einfach traumhaft. Galaxy AI ist überraschend nützlich.','approved','2025-03-05 10:45:00'),
(5,1,9,2,4,'Sehr solides Flaggschiff','Für unsere Außendienstmitarbeiter ist das S25 Ultra ideal. Langlebiger Akku, robustes Design, gute Business-Features. Circle to Search spart täglich Zeit.','approved','2025-03-10 15:00:00'),
(6,12,1,1,5,'Bester Kopfhörer auf dem Markt','Ich habe die Vorgängerversion gehabt – XM6 ist nochmal ein Schritt besser. Das ANC ist phenomenal, der Klang warm und detailreich, Multipoint funktioniert endlich zuverlässig.','approved','2025-01-20 18:00:00'),
(7,12,8,2,5,'Kein Vergleich zu meinem alten Kopfhörer','Pendeln zur Arbeit ist jetzt eine entspannte Erfahrung. 30 Stunden Akku – ich lade ihn noch seltener als gedacht. Sehr empfehlenswert!','approved','2025-02-28 08:30:00'),
(8,12,13,4,4,'Super, aber leicht drückend nach 4h','Klangqualität und ANC sind hervorragend. Nach sehr langen Sessionen (4+ Stunden) spüre ich leichten Druck. Insgesamt aber ein top Produkt.','approved','2025-03-12 21:00:00'),
(9,7,3,1,5,'Perfekter Geschäftslaptop','Wir haben 5 MacBook Air M3 für unser Team gekauft. Schnell, leise, langer Akku – kein einziges Problem nach 3 Monaten. Klare Kaufempfehlung.','approved','2025-02-20 11:00:00'),
(10,7,11,3,5,'Lautlos und schnell','Kein Lüfter = kein Lärm. In der Bibliothek oder in Meetings perfekt. Der M3 ist schneller als alles, was ich bisher hatte.','approved','2025-03-15 16:30:00'),
(11,15,6,1,5,'Endlich perfektes ANC','Adaptives Audio ist genialer als erwartet – wechselt automatisch zwischen ANC und Transparenz. Klang ist klar und räumlich. Der beste Kauf in diesem Jahr.','approved','2025-03-08 20:00:00'),
(12,15,8,2,4,'Sehr gut, aber teurer als früher','Technisch top. ANC ist stark, Transparenzmodus klingt natürlich. Preis ist gestiegen, aber für Apple-Nutzer gibt es nichts Besseres.','approved','2025-03-14 09:00:00'),
(13,19,13,4,5,'Kräftiger Sound, toll für draußen','20 Stunden Akku und IP67 – nehme ihn mit an den See, in den Garten, überall. Der Sound ist erstaunlich voll für einen portablen Lautsprecher.','approved','2025-03-02 17:00:00'),
(14,5,10,2,5,'Beste Kamera in einem Android-Phone','Add Me ist ein Lifesaver – endlich bin ich selbst auf Gruppenfotos drauf. Magic Eraser benutze ich täglich. 7 Jahre Updates geben Sicherheit.','approved','2025-03-16 12:00:00'),
(15,9,3,1,5,'Unser neuer Office-Standard','Für Grafikarbeiten und Video-Konferenzen einfach perfekt. OLED-Display ist Klasse A. RTX 4060 macht auch anspruchsvolle Aufgaben locker.','approved','2025-02-05 14:00:00'),
(16,28,12,3,5,'Professionelle Qualität, zugänglicher Preis','Für unsere Produktfotografie ist die A7 IV ein absoluter Gewinn. 33 MP sind reichlich für jedes Format, der IBIS ermöglicht auch Freihand-Aufnahmen in Innenräumen.','approved','2025-03-18 10:00:00'),
(17,27,15,5,5,'Installation in 20 Minuten, spart wirklich Energie','Einfach zu installieren, App ist intuitiv. Nach zwei Monaten merke ich ca. 12% weniger Gasverbrauch. Google Assistant Integration funktioniert reibungslos.','approved','2025-02-15 11:30:00'),
(18,20,4,1,5,'Das beste iPad – und das dünnste Gerät aller Zeiten','Das Tandem OLED-Display ist einfach spektakulär. Mit Apple Pencil Pro und Magic Keyboard ist es ein vollwertiger Laptop-Ersatz für meine Arbeit.','approved','2025-03-01 09:30:00');
/*!40000 ALTER TABLE `product_reviews` ENABLE KEYS */;
UNLOCK TABLES;

LOCK TABLES `product_translations` WRITE;
/*!40000 ALTER TABLE `product_translations` DISABLE KEYS */;
INSERT INTO `product_translations` VALUES
(1,1,'de','Samsung Galaxy S25 Ultra','Das ultimative Android-Flagship mit Galaxy AI und integriertem S Pen.','<h2>Samsung Galaxy S25 Ultra</h2><p>Das <strong>Galaxy S25 Ultra</strong> setzt neue Maßstäbe im Smartphone-Bereich. Mit dem integrierten S Pen, der leistungsstarken Galaxy AI und dem brillanten 6,9-Zoll-Display ist es das perfekte Gerät für Power-User.</p><h3>Highlights</h3><ul><li>6,9\" Dynamic LTPO AMOLED 2X, 120 Hz</li><li>Snapdragon 8 Elite Prozessor</li><li>200 MP Hauptkamera + dreifacher Telezoom</li><li>5.000 mAh Akku mit 45 W Schnellladen</li><li>S Pen integriert</li><li>Galaxy AI: Circle to Search, Note Assist, Chat Assist</li></ul><p>Erhältlich in Titanium Gray, Titanium Black und Titanium Silver Blue.</p>','Samsung Galaxy S25 Ultra kaufen','Samsung Galaxy S25 Ultra mit 200 MP Kamera und Galaxy AI. Jetzt kaufen & schnell liefern lassen.','samsung-galaxy-s25-ultra'),
(2,1,'en','Samsung Galaxy S25 Ultra','The ultimate Android flagship with Galaxy AI and built-in S Pen.','<h2>Samsung Galaxy S25 Ultra</h2><p>The <strong>Galaxy S25 Ultra</strong> sets new standards. With its built-in S Pen, powerful Galaxy AI and brilliant 6.9-inch display, it is the perfect device for power users.</p><h3>Highlights</h3><ul><li>6.9\" Dynamic LTPO AMOLED 2X, 120 Hz</li><li>Snapdragon 8 Elite processor</li><li>200 MP main camera + triple telephoto zoom</li><li>5,000 mAh battery with 45W fast charging</li><li>Built-in S Pen</li><li>Galaxy AI: Circle to Search, Note Assist, Chat Assist</li></ul>','Buy Samsung Galaxy S25 Ultra','Samsung Galaxy S25 Ultra with 200MP camera & Galaxy AI. Order now with fast delivery.','samsung-galaxy-s25-ultra'),
(3,2,'de','Samsung Galaxy S25','Das Kompakt-Flagship – leistungsstark, dünn und vielseitig.','<h2>Samsung Galaxy S25</h2><p>Das <strong>Galaxy S25</strong> bietet Flagship-Power im kompakten Format. Snapdragon 8 Elite, 50-MP-Kamera und eine lange Akkulaufzeit – alles in einem eleganten Design.</p><ul><li>6,2\" Dynamic AMOLED 2X, 120 Hz</li><li>Snapdragon 8 Elite</li><li>50 MP Hauptkamera</li><li>4.000 mAh Akku</li></ul>','Samsung Galaxy S25 kaufen','Samsung Galaxy S25 – kompaktes Flagship mit Snapdragon 8 Elite.','samsung-galaxy-s25'),
(4,2,'en','Samsung Galaxy S25','The compact flagship – powerful, thin and versatile.','<h2>Samsung Galaxy S25</h2><p>The <strong>Galaxy S25</strong> delivers flagship power in a compact form. Snapdragon 8 Elite, 50MP camera and long battery life.</p><ul><li>6.2\" Dynamic AMOLED 2X, 120 Hz</li><li>Snapdragon 8 Elite</li><li>50 MP main camera</li><li>4,000 mAh battery</li></ul>','Buy Samsung Galaxy S25','Samsung Galaxy S25 – compact flagship with Snapdragon 8 Elite.','samsung-galaxy-s25'),
(5,3,'de','Apple iPhone 16 Pro','Professionelles iPhone mit A18 Pro Chip und 5-fach Teleobjektiv.','<h2>Apple iPhone 16 Pro</h2><p>Das <strong>iPhone 16 Pro</strong> hebt die iPhone-Erfahrung auf ein neues Niveau. Mit dem A18 Pro Chip, dem neuen Camera Control Button und bis zu 33 Stunden Videowiedergabe ist es das leistungsfähigste iPhone aller Zeiten.</p><h3>Kamera-System</h3><ul><li>48 MP Fusion-Kamera (Hauptkamera)</li><li>12 MP Ultraweitwinkel</li><li>12 MP 5-fach Teleobjektiv</li><li>Camera Control-Taste</li><li>4K 120fps ProRes Video</li></ul><h3>Design</h3><p>Titan-Gehäuse in Desert Titanium, Black Titanium, White Titanium und Natural Titanium. Display: 6,3\" Super Retina XDR ProMotion, 120 Hz.</p>','Apple iPhone 16 Pro kaufen','iPhone 16 Pro – A18 Pro, 5-fach Zoom, Titan-Design. Jetzt bestellen.','apple-iphone-16-pro'),
(6,3,'en','Apple iPhone 16 Pro','Professional iPhone with A18 Pro chip and 5x telephoto.','<h2>Apple iPhone 16 Pro</h2><p>The iPhone 16 Pro takes the experience to a new level. A18 Pro chip, Camera Control button and up to 33 hours video playback.</p><ul><li>48 MP Fusion camera</li><li>12 MP ultrawide</li><li>12 MP 5x telephoto</li><li>Camera Control</li><li>4K 120fps ProRes video</li></ul>','Buy Apple iPhone 16 Pro','iPhone 16 Pro – A18 Pro, 5x zoom, titanium design.','apple-iphone-16-pro'),
(7,4,'de','Apple iPhone 16','Das meistverkaufte iPhone mit A18 Chip und Camera Control.','<h2>Apple iPhone 16</h2><p>Das <strong>iPhone 16</strong> bringt viele Pro-Features in ein zugänglicheres Paket. A18 Chip, Camera Control und das neue Action-Erlebnis mit Apple Intelligence.</p><ul><li>6,1\" Super Retina XDR, 60 Hz</li><li>A18 Chip</li><li>48 MP Fusion-Kamera</li><li>3.561 mAh Akku</li></ul>','Apple iPhone 16 kaufen','iPhone 16 mit A18 Chip & Camera Control. Günstig & schnell liefern lassen.','apple-iphone-16'),
(8,4,'en','Apple iPhone 16','The best-selling iPhone with A18 chip and Camera Control.','<h2>Apple iPhone 16</h2><p>The iPhone 16 brings many Pro features into an accessible package. A18 Chip, Camera Control and Apple Intelligence.</p><ul><li>6.1\" Super Retina XDR, 60 Hz</li><li>A18 Chip</li><li>48 MP Fusion camera</li></ul>','Buy Apple iPhone 16','iPhone 16 with A18 chip & Camera Control.','apple-iphone-16'),
(9,5,'de','Google Pixel 9 Pro','Googles bestes Kamera-Smartphone mit Tensor G4 und 7 Jahren Updates.','<h2>Google Pixel 9 Pro</h2><p>Das <strong>Pixel 9 Pro</strong> ist Googles ambitioniertestes Smartphone. Mit dem neuen Tensor G4 Chip, einem überarbeiteten Kamerasystem und sieben Jahren garantierter Updates ist es eine hervorragende Langzeitinvestition.</p><ul><li>6,3\" LTPO OLED, 120 Hz</li><li>Google Tensor G4</li><li>50 MP + 48 MP Ultraweitwinkel + 48 MP Tele (5-fach)</li><li>Add Me, Magic Eraser, Best Take</li><li>7 Jahre OS-Updates</li></ul>','Google Pixel 9 Pro kaufen','Google Pixel 9 Pro – Tensor G4, 7 Jahre Updates, Top-Kamera.','google-pixel-9-pro'),
(10,5,'en','Google Pixel 9 Pro','Google\'s best camera smartphone with Tensor G4 and 7 years of updates.','<h2>Google Pixel 9 Pro</h2><p>The Pixel 9 Pro is Google\'s most ambitious smartphone. Tensor G4, redesigned camera system and seven years of guaranteed updates.</p>','Buy Google Pixel 9 Pro','Google Pixel 9 Pro – Tensor G4, 7 years updates, top camera.','google-pixel-9-pro'),
(11,7,'de','Apple MacBook Air 13\" M3','Der leichteste MacBook Air mit M3 Chip – leistungsstark und fanlos.','<h2>Apple MacBook Air 13\" M3</h2><p>Das <strong>MacBook Air mit M3</strong> ist der perfekte Allrounder. Leicht, leistungsstark und mit bis zu 18 Stunden Akkulaufzeit – ohne Lüfter, ohne Kompromisse.</p><ul><li>13,6\" Liquid Retina Display</li><li>Apple M3 Chip (8-Core CPU, 10-Core GPU)</li><li>8 GB oder 16 GB Unified Memory</li><li>256 GB bis 2 TB SSD</li><li>Bis zu 18 Std. Akkulaufzeit</li><li>MagSafe 3, 2× Thunderbolt 4, 3,5-mm-Klinke</li></ul>','Apple MacBook Air M3 kaufen','MacBook Air M3 – leicht, leistungsstark, bis zu 18 Std. Akku.','apple-macbook-air-m3'),
(12,7,'en','Apple MacBook Air 13\" M3','The lightest MacBook Air with M3 chip – powerful and fanless.','<h2>Apple MacBook Air 13\" M3</h2><p>The MacBook Air with M3 is the perfect all-rounder. Light, powerful and up to 18 hours battery life – fanless, no compromises.</p><ul><li>13.6\" Liquid Retina Display</li><li>Apple M3 (8-core CPU, 10-core GPU)</li><li>8 GB or 16 GB Unified Memory</li><li>Up to 18 hours battery</li></ul>','Buy Apple MacBook Air M3','MacBook Air M3 – light, powerful, up to 18h battery.','apple-macbook-air-m3'),
(13,9,'de','Dell XPS 15 (9530) Intel Core i7','Premium Windows-Laptop mit OLED-Display und InfinityEdge-Design.','<h2>Dell XPS 15</h2><p>Das <strong>Dell XPS 15</strong> ist der Goldstandard unter den Windows-Laptops. Mit einem 3,5K OLED-Touchscreen, Intel Core i7 und NVIDIA GeForce RTX 4060 ist es ideal für kreative Anwender und Profis.</p><ul><li>15,6\" 3,5K OLED Touch (3456×2160)</li><li>Intel Core i7-13700H</li><li>16 GB DDR5-RAM</li><li>512 GB NVMe SSD</li><li>NVIDIA GeForce RTX 4060 (8 GB)</li></ul>','Dell XPS 15 kaufen','Dell XPS 15 mit OLED-Display und RTX 4060 – jetzt kaufen.','dell-xps-15-i7'),
(14,9,'en','Dell XPS 15 (9530) Intel Core i7','Premium Windows laptop with OLED display and InfinityEdge design.','<h2>Dell XPS 15</h2><p>The Dell XPS 15 is the gold standard in Windows laptops. 3.5K OLED touchscreen, Intel Core i7 and NVIDIA GeForce RTX 4060.</p>','Buy Dell XPS 15','Dell XPS 15 with OLED display and RTX 4060.','dell-xps-15-i7'),
(15,12,'de','Sony WH-1000XM6','Der beste Noise-Cancelling-Kopfhörer der Welt – 6. Generation.','<h2>Sony WH-1000XM6</h2><p>Der <strong>WH-1000XM6</strong> setzt die Messlatte für Over-Ear-Kopfhörer erneut höher. Mit 8 Mikrofonen, dem neuen HD Noise Cancelling Processor QN3 und 30 Stunden Akkulaufzeit ist er unerreicht.</p><ul><li>Branchenführendes ANC mit Multi-Noise Sensor</li><li>30 Stunden Laufzeit (ANC ein), 3 Min = 3 Std</li><li>LDAC, DSEE Extreme Upscaling</li><li>Speak-to-Chat & Adaptive Sound Control</li><li>Multipoint-Verbindung (2 Geräte)</li><li>Faltbares Design, mitgeliefertes Etui</li></ul>','Sony WH-1000XM6 kaufen','Sony WH-1000XM6 – bester ANC-Kopfhörer, 30h Akku, LDAC.','sony-wh-1000xm6'),
(16,12,'en','Sony WH-1000XM6','The world\'s best noise-cancelling headphones – 6th generation.','<h2>Sony WH-1000XM6</h2><p>The WH-1000XM6 raises the bar again. 8 microphones, HD Noise Cancelling Processor QN3 and 30-hour battery life.</p><ul><li>Industry-leading ANC</li><li>30h battery, 3 min = 3h</li><li>LDAC, DSEE Extreme</li><li>Multipoint (2 devices)</li></ul>','Buy Sony WH-1000XM6','Sony WH-1000XM6 – best ANC headphones, 30h battery.','sony-wh-1000xm6'),
(17,15,'de','Apple AirPods Pro (4. Generation)','True Wireless Earbuds mit adaptivem ANC und H2 Chip.','<h2>Apple AirPods Pro (4. Generation)</h2><p>Die <strong>AirPods Pro der 4. Generation</strong> bringen das beste ANC aller Zeiten in einen kompakten Earbud. Mit dem H2 Chip, adaptiver Geräuschunterdrückung und Transparenzmodus erleben Sie Sound wie nie zuvor.</p><ul><li>Adaptives Audio (ANC + Transparenz automatisch)</li><li>H2 Chip</li><li>Bis zu 6h (ANC), 30h mit Case</li><li>MagSafe, USB-C und Qi2 Laden</li><li>IPX4 wasserdicht</li></ul>','Apple AirPods Pro 4 kaufen','AirPods Pro 4 – adaptives ANC, H2 Chip, 30h Gesamtlaufzeit.','apple-airpods-pro-4'),
(18,15,'en','Apple AirPods Pro (4th Generation)','True wireless earbuds with adaptive ANC and H2 chip.','<h2>Apple AirPods Pro (4th Generation)</h2><p>The AirPods Pro 4 bring the best ANC ever into a compact earbud. H2 Chip, Adaptive Audio and Transparency Mode.</p><ul><li>Adaptive Audio</li><li>H2 Chip</li><li>Up to 6h (ANC on), 30h with case</li><li>MagSafe, USB-C and Qi2 charging</li></ul>','Buy Apple AirPods Pro 4','AirPods Pro 4 – adaptive ANC, H2 chip, 30h total battery.','apple-airpods-pro-4'),
(19,19,'de','Bose SoundLink Max','Der kraftvollste Bluetooth-Lautsprecher von Bose für drinnen und draußen.','<h2>Bose SoundLink Max</h2><p>Der <strong>Bose SoundLink Max</strong> liefert Bose-typischen Premium-Sound in einem tragbaren Design. Ob am Pool, im Park oder zuhause – 20 Stunden Akkulaufzeit und IP67-Schutz machen ihn zum idealen Begleiter.</p><ul><li>360°-Klang mit kraftvollem Bass</li><li>20h Akkulaufzeit</li><li>IP67: staub- und wasserdicht</li><li>Zwei Lautsprecher koppelbar (Party Mode)</li><li>USB-C Ladeeingang + integriertes Netzkabel</li></ul>','Bose SoundLink Max kaufen','Bose SoundLink Max – 20h Akku, IP67, 360° Sound.','bose-soundlink-max'),
(20,19,'en','Bose SoundLink Max','The most powerful Bose Bluetooth speaker for indoors and outdoors.','<h2>Bose SoundLink Max</h2><p>The Bose SoundLink Max delivers premium sound in a portable design. 20 hours battery and IP67 protection.</p><ul><li>360° sound with powerful bass</li><li>20h battery</li><li>IP67 dustproof & waterproof</li><li>Party Mode (two speakers)</li></ul>','Buy Bose SoundLink Max','Bose SoundLink Max – 20h battery, IP67, 360° sound.','bose-soundlink-max'),
(21,20,'de','Apple iPad Pro 13\" M4','Das leistungsfähigste iPad aller Zeiten mit Ultra Retina XDR Display.','<h2>Apple iPad Pro 13\" M4</h2><p>Das <strong>iPad Pro 13\" M4</strong> ist das dünnste Apple-Produkt aller Zeiten und das leistungsfähigste iPad. Mit dem M4 Chip, dem Ultra Retina XDR Display mit tandem OLED-Technologie und Apple Pencil Pro ist es das perfekte Gerät für Kreative.</p><ul><li>13\" Ultra Retina XDR (Tandem OLED), 120 Hz</li><li>Apple M4 Chip</li><li>256 GB bis 2 TB</li><li>Apple Pencil Pro kompatibel</li><li>Magic Keyboard mit Trackpad kompatibel</li><li>Wi-Fi 6E + optionales 5G</li></ul>','Apple iPad Pro M4 kaufen','iPad Pro 13\" M4 – Tandem OLED, ultra-dünn, professionell.','apple-ipad-pro-13-m4'),
(22,20,'en','Apple iPad Pro 13\" M4','The most capable iPad ever with Ultra Retina XDR display.','<h2>Apple iPad Pro 13\" M4</h2><p>The iPad Pro 13\" M4 is Apple\'s thinnest product ever and the most capable iPad. M4 chip, Ultra Retina XDR with tandem OLED and Apple Pencil Pro.</p>','Buy Apple iPad Pro M4','iPad Pro 13\" M4 – tandem OLED, ultra-thin, professional.','apple-ipad-pro-13-m4'),
(23,23,'de','Logitech G PRO X 2 LIGHTSPEED','Professionelle Gaming-Maus – entwickelt mit Esport-Profis.','<h2>Logitech G PRO X 2 LIGHTSPEED</h2><p>Die <strong>G PRO X 2</strong> ist das Ergebnis jahrelanger Zusammenarbeit mit Esport-Profis. Mit dem HERO 25K Sensor, LIGHTSPEED Wireless und dem leichten Gehäuse (60 g) ist sie eine der präzisesten Mäuse auf dem Markt.</p><ul><li>HERO 25K Sensor (100–25.600 DPI)</li><li>LIGHTSPEED Wireless, bis zu 70h Akku</li><li>Über 5 Mio. Klicks garantiert</li><li>60 g Gewicht</li><li>Windows & Mac kompatibel</li></ul>','Logitech G Pro X 2 kaufen','Logitech G PRO X 2 – HERO 25K, LIGHTSPEED, 60g, 70h Akku.','logitech-g-pro-x2-lightspeed'),
(24,23,'en','Logitech G PRO X 2 LIGHTSPEED','Professional gaming mouse – developed with esport pros.','<h2>Logitech G PRO X 2 LIGHTSPEED</h2><p>The result of years of collaboration with esport pros. HERO 25K Sensor, LIGHTSPEED Wireless and 60g lightweight design.</p>','Buy Logitech G Pro X2','Logitech G PRO X 2 – HERO 25K, LIGHTSPEED, 60g, 70h battery.','logitech-g-pro-x2-lightspeed'),
(25,27,'de','Google Nest Thermostat (4. Generation)','Smarter Thermostat mit KI-Lernfunktion für mehr Komfort und Energiesparen.','<h2>Google Nest Thermostat</h2><p>Der <strong>Google Nest Thermostat</strong> lernt Ihre Gewohnheiten und passt die Temperatur automatisch an. Steuern Sie ihn per App, Stimme oder direkt am Gerät.</p><ul><li>Selbstlernende KI-Funktion</li><li>Google Home & Alexa kompatibel</li><li>Energiesparmodus spart bis zu 15% Heizkosten</li><li>Installierbar in unter 30 Minuten</li><li>OLED-Display</li></ul>','Google Nest Thermostat kaufen','Nest Thermostat 4 – smart, lernfähig, bis 15% Energie sparen.','google-nest-thermostat-4'),
(26,27,'en','Google Nest Thermostat (4th Generation)','Smart thermostat with AI learning for comfort and energy savings.','<h2>Google Nest Thermostat</h2><p>The Nest Thermostat learns your schedule and programs itself. Control it via app, voice or directly on the device.</p>','Buy Google Nest Thermostat','Nest Thermostat 4 – smart, self-learning, save up to 15% energy.','google-nest-thermostat-4'),
(27,28,'de','Sony Alpha 7 IV Gehäuse','Vollformat-Systemkamera für Fotos und Videos auf Profi-Niveau.','<h2>Sony Alpha 7 IV</h2><p>Die <strong>Alpha 7 IV</strong> ist die perfekte Hybridkamera für anspruchsvolle Fotografen und Videografen. 33 MP BSI-CMOS-Sensor, 759 Phasendetektions-AF-Punkte und 4K 60p Video machen sie zur vielseitigsten Kamera in ihrer Klasse.</p><ul><li>33 MP Vollformat BSI-CMOS Sensor</li><li>759 Phasen-AF + 425 Kontrast-AF Punkte</li><li>AI-basiertes Motiv-Tracking (Mensch, Tier, Vogel, Fahrzeug)</li><li>4K 60p (Super 35mm), 4K 30p (Vollformat)</li><li>In-Body Image Stabilization (5,5 Stufen)</li><li>Dual-Card-Slot (CFexpress Typ A + SD)</li></ul>','Sony Alpha 7 IV kaufen','Sony A7 IV – 33 MP, 4K 60p, IBIS, AI-AF. Profi-Hybridkamera.','sony-alpha-7-iv'),
(28,28,'en','Sony Alpha 7 IV Body','Full-frame mirrorless camera for professional photos and video.','<h2>Sony Alpha 7 IV</h2><p>The Alpha 7 IV is the perfect hybrid camera. 33 MP BSI-CMOS sensor, 759 phase-detection AF points and 4K 60p video.</p>','Buy Sony Alpha 7 IV','Sony A7 IV – 33 MP, 4K 60p, IBIS, AI-AF. Professional hybrid camera.','sony-alpha-7-iv'),
(29,30,'de','Apple USB-C Kabel (1 m)','Offizielles Apple USB-C auf USB-C Kabel – MFi-zertifiziert.','<h2>Apple USB-C Kabel 1 m</h2><p>Das originale <strong>Apple USB-C Kabel</strong> lädt Ihr iPhone 15, iPhone 16, iPad oder MacBook zuverlässig und schnell. MFi-zertifiziert, langlebig und flexibel.</p><ul><li>USB 2.0, bis zu 60 W Ladeleistung</li><li>MFi-zertifiziert</li><li>1 m Kabellänge</li><li>Kompatibel mit iPhone 15 / 16, iPad Pro, MacBook</li></ul>','Apple USB-C Kabel kaufen','Apple USB-C Kabel 1m – offiziell, MFi, 60W – günstig kaufen.','apple-usb-c-kabel-1m'),
(30,30,'en','Apple USB-C Cable (1 m)','Official Apple USB-C to USB-C cable – MFi-certified.','<h2>Apple USB-C Cable 1m</h2><p>The original Apple USB-C Cable charges your iPhone 15, iPhone 16, iPad or MacBook reliably and quickly.</p>','Buy Apple USB-C Cable','Apple USB-C Cable 1m – official, MFi, 60W.','apple-usb-c-cable-1m');
/*!40000 ALTER TABLE `product_translations` ENABLE KEYS */;
UNLOCK TABLES;

LOCK TABLES `product_variants` WRITE;
/*!40000 ALTER TABLE `product_variants` DISABLE KEYS */;
INSERT INTO `product_variants` VALUES
(1,1,'SPH-SAM-S25U-256-BLK','{\"farbe\":\"Titanium Black\",\"speicher\":\"256 GB\"}',NULL,1),
(2,1,'SPH-SAM-S25U-256-GRY','{\"farbe\":\"Titanium Gray\",\"speicher\":\"256 GB\"}',NULL,1),
(3,1,'SPH-SAM-S25U-512-BLK','{\"farbe\":\"Titanium Black\",\"speicher\":\"512 GB\"}',NULL,1),
(4,1,'SPH-SAM-S25U-1TB-GRY','{\"farbe\":\"Titanium Gray\",\"speicher\":\"1 TB\"}',NULL,1),
(5,2,'SPH-SAM-S25-128-BLK','{\"farbe\":\"Phantom Black\",\"speicher\":\"128 GB\"}',NULL,1),
(6,2,'SPH-SAM-S25-128-SLV','{\"farbe\":\"Phantom Silver\",\"speicher\":\"128 GB\"}',NULL,1),
(7,2,'SPH-SAM-S25-256-BLK','{\"farbe\":\"Phantom Black\",\"speicher\":\"256 GB\"}',NULL,1),
(8,3,'SPH-APP-IP16P-256-DST','{\"farbe\":\"Desert Titanium\",\"speicher\":\"256 GB\"}',NULL,1),
(9,3,'SPH-APP-IP16P-256-BLK','{\"farbe\":\"Black Titanium\",\"speicher\":\"256 GB\"}',NULL,1),
(10,3,'SPH-APP-IP16P-512-DST','{\"farbe\":\"Desert Titanium\",\"speicher\":\"512 GB\"}',NULL,1),
(11,3,'SPH-APP-IP16P-1TB-BLK','{\"farbe\":\"Black Titanium\",\"speicher\":\"1 TB\"}',NULL,1),
(12,4,'SPH-APP-IP16-128-BLK','{\"farbe\":\"Schwarz\",\"speicher\":\"128 GB\"}',NULL,1),
(13,4,'SPH-APP-IP16-128-WHT','{\"farbe\":\"Weiß\",\"speicher\":\"128 GB\"}',NULL,1),
(14,4,'SPH-APP-IP16-256-BLK','{\"farbe\":\"Schwarz\",\"speicher\":\"256 GB\"}',NULL,1),
(15,7,'LPT-APP-MBA-M3-8-256-MN','{\"farbe\":\"Midnight\",\"ram\":\"8 GB\",\"speicher\":\"256 GB\"}',NULL,1),
(16,7,'LPT-APP-MBA-M3-8-512-SL','{\"farbe\":\"Starlight\",\"ram\":\"8 GB\",\"speicher\":\"512 GB\"}',NULL,1),
(17,7,'LPT-APP-MBA-M3-16-512-SL','{\"farbe\":\"Silber\",\"ram\":\"16 GB\",\"speicher\":\"512 GB\"}',NULL,1),
(18,12,'AUD-SNY-WH1000XM6-BLK','{\"farbe\":\"Schwarz\"}',NULL,1),
(19,12,'AUD-SNY-WH1000XM6-SLV','{\"farbe\":\"Silber\"}',NULL,1),
(20,15,'AUD-APL-APP4-MAGSAFE','{\"farbe\":\"Weiß\"}',NULL,1),
(21,13,'AUD-APL-MAX-MN-BLK','{\"farbe\":\"Midnight Sky\"}',NULL,1),
(22,13,'AUD-APL-MAX-MN-SL','{\"farbe\":\"Starlight\"}',NULL,1),
(23,16,'AUD-SNY-WF1000XM5-BLK','{\"farbe\":\"Schwarz\"}',NULL,1),
(24,16,'AUD-SNY-WF1000XM5-SLV','{\"farbe\":\"Silber\"}',NULL,1),
(25,20,'TAB-APP-IPAP13-256-SLV','{\"farbe\":\"Silber\",\"speicher\":\"256 GB\"}',NULL,1),
(26,20,'TAB-APP-IPAP13-256-SGR','{\"farbe\":\"Space Grau\",\"speicher\":\"256 GB\"}',NULL,1),
(27,20,'TAB-APP-IPAP13-512-SLV','{\"farbe\":\"Silber\",\"speicher\":\"512 GB\"}',NULL,1),
(28,26,'SHM-AMZ-ECHD5-CHAR','{\"farbe\":\"Anthrazit\"}',NULL,1),
(29,26,'SHM-AMZ-ECHD5-BLAU','{\"farbe\":\"Blau\"}',NULL,1),
(30,30,'ACC-APL-USBC-1M-WHT','{\"farbe\":\"Weiß\"}',NULL,1),
(31,30,'ACC-APL-USBC-1M-BLK','{\"farbe\":\"Schwarz\"}',NULL,1),
(32,30,'ACC-APL-USBC-2M-WHT','{\"farbe\":\"Weiß\"}',NULL,1);
/*!40000 ALTER TABLE `product_variants` ENABLE KEYS */;
UNLOCK TABLES;

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES
(1,'SPH-SAM-S25U-256','8806095302714',9,'variable',0.228,7.97,16.27,0.88,'standard',1,1,1,'2026-04-17 08:58:36',NULL),
(2,'SPH-SAM-S25-128','8806095310139',9,'variable',0.162,7.07,15.58,0.77,'standard',1,0,2,'2026-04-17 08:58:36',NULL),
(3,'SPH-APP-IP16P-256','0194253438656',10,'variable',0.227,7.12,16.01,0.82,'standard',1,1,3,'2026-04-17 08:58:36',NULL),
(4,'SPH-APP-IP16-128','0194253438649',10,'variable',0.170,7.08,14.73,0.78,'standard',1,0,4,'2026-04-17 08:58:36',NULL),
(5,'SPH-GOO-P9P-256','0842776112218',9,'simple',0.221,7.68,16.26,0.87,'standard',1,0,5,'2026-04-17 08:58:36',NULL),
(6,'SPH-ONE-12R-256','6921815623947',9,'simple',0.199,7.38,16.36,0.81,'standard',1,0,6,'2026-04-17 08:58:36',NULL),
(7,'LPT-APP-MBA-M3-8','0194253842736',15,'variable',1.240,30.41,21.24,1.13,'standard',1,1,1,'2026-04-17 08:58:36',NULL),
(8,'LPT-APP-MBP-M4-16','0194253998012',15,'variable',1.550,35.57,24.81,1.55,'standard',1,0,2,'2026-04-17 08:58:36',NULL),
(9,'LPT-DEL-XPS-15-I7','DLX15I7512EU',14,'simple',1.860,34.42,23.04,1.84,'standard',1,1,3,'2026-04-17 08:58:36',NULL),
(10,'LPT-LEN-X1C-I5-16','LNX1CI516EU',14,'simple',1.120,31.65,21.73,1.49,'standard',1,0,4,'2026-04-17 08:58:36',NULL),
(11,'LPT-ASU-ZB-I7-32','ASZBI732EU',14,'simple',1.390,32.09,22.41,1.49,'standard',1,0,5,'2026-04-17 08:58:36',NULL),
(12,'AUD-SNY-WH1000XM6','SNY1000XM6EU',11,'variable',0.250,18.00,20.00,8.10,'standard',1,1,1,'2026-04-17 08:58:36',NULL),
(13,'AUD-APL-APP-MAX-SL','0194253086550',11,'variable',0.386,19.30,16.80,8.40,'standard',1,0,2,'2026-04-17 08:58:36',NULL),
(14,'AUD-BOS-QC45-II','QC45IIBLKEU',11,'simple',0.240,18.60,20.00,8.00,'standard',1,0,3,'2026-04-17 08:58:36',NULL),
(15,'AUD-APL-APWP4-WH','0194253900993',13,'variable',0.054,4.62,5.47,2.21,'standard',1,1,1,'2026-04-17 08:58:36',NULL),
(16,'AUD-SNY-WF1000XM5','SNYWF1000EU',13,'variable',0.047,5.10,4.90,2.30,'standard',1,0,2,'2026-04-17 08:58:36',NULL),
(17,'AUD-SAM-GBP3-BK','SAMGBP3BKEU',13,'simple',0.053,4.90,5.20,2.50,'standard',1,0,3,'2026-04-17 08:58:36',NULL),
(18,'AUD-SON-SRS-XB100','SONXB100BLK',12,'variable',0.386,7.30,7.30,7.30,'standard',1,0,1,'2026-04-17 08:58:36',NULL),
(19,'AUD-BOS-SND-300','BOSSND300BLK',12,'simple',1.000,22.00,11.60,9.80,'standard',1,1,2,'2026-04-17 08:58:36',NULL),
(20,'TAB-APP-IPAP13-256','0194253887096',4,'variable',0.617,28.17,21.50,0.62,'standard',1,1,1,'2026-04-17 08:58:36',NULL),
(21,'TAB-SAM-TAB-S9FE-6','8806094854558',4,'simple',0.523,25.40,16.56,0.61,'standard',1,0,2,'2026-04-17 08:58:36',NULL),
(22,'GAM-SHR-GSN-10X','SHRGSNBKEU',16,'variable',0.320,18.00,20.00,8.00,'standard',1,1,1,'2026-04-17 08:58:36',NULL),
(23,'GAM-LGT-G-PRO-X2','LGTGPROX2EU',17,'simple',0.106,6.24,5.00,2.00,'standard',1,1,1,'2026-04-17 08:58:36',NULL),
(24,'GAM-RZR-HNT-V3','RZRHNTV3EU',18,'simple',0.980,36.54,13.93,3.80,'standard',1,0,2,'2026-04-17 08:58:36',NULL),
(25,'SHM-PHI-HUE-STA-4','PHIHUESTA4EU',6,'simple',0.450,10.00,5.00,10.00,'standard',1,0,1,'2026-04-17 08:58:36',NULL),
(26,'SHM-AMZ-ECH-DOT5','ECHD5GRYEU',6,'variable',0.304,9.96,9.96,8.91,'standard',1,0,2,'2026-04-17 08:58:36',NULL),
(27,'SHM-NES-THER-4TH','NESTHR4EU',6,'simple',0.239,10.10,10.10,2.90,'standard',1,1,3,'2026-04-17 08:58:36',NULL),
(28,'CAM-SON-A7IV-BODY','SONYA7IVEU',8,'simple',0.658,13.15,9.63,7.72,'standard',1,1,1,'2026-04-17 08:58:36',NULL),
(29,'CAM-CAN-R8-BODY','CANR8BODY',8,'simple',0.461,13.23,8.60,5.92,'standard',1,0,2,'2026-04-17 08:58:36',NULL),
(30,'ACC-APL-USBC-MFI-1M','0194253901877',5,'variable',0.035,12.00,1.50,1.50,'standard',1,0,1,'2026-04-17 08:58:36',NULL);
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES
(1,'superadmin','{\"all\":true}','2026-04-17 08:58:36'),
(2,'admin','{\"products\":\"rw\",\"orders\":\"rw\",\"customers\":\"rw\",\"cms\":\"rw\",\"campaigns\":\"rw\",\"branches\":\"r\"}','2026-04-17 08:58:36'),
(3,'branch_manager','{\"orders\":\"rw\",\"stock\":\"rw\",\"customers\":\"r\",\"campaigns\":\"r\"}','2026-04-17 08:58:36'),
(4,'editor','{\"products\":\"rw\",\"cms\":\"rw\",\"categories\":\"rw\"}','2026-04-17 08:58:36');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

LOCK TABLES `theme_settings` WRITE;
/*!40000 ALTER TABLE `theme_settings` DISABLE KEYS */;
INSERT INTO `theme_settings` VALUES
(1,NULL,'frontend','default','{\"primary_color\":\"#1a56db\",\"secondary_color\":\"#f59e0b\",\"font\":\"Inter\",\"logo\":null}'),
(2,NULL,'backend','default','{\"sidebar_color\":\"#1e293b\",\"accent\":\"#3b82f6\"}'),
(3,1,'frontend','default','{\"primary_color\":\"#1a56db\",\"branch_accent\":\"#2563eb\",\"hero_image\":\"branches/koeln-hero.webp\"}'),
(4,2,'frontend','default','{\"primary_color\":\"#1a56db\",\"branch_accent\":\"#6d28d9\",\"hero_image\":\"branches/berlin-hero.webp\"}'),
(5,3,'frontend','default','{\"primary_color\":\"#1a56db\",\"branch_accent\":\"#0891b2\",\"hero_image\":\"branches/muenchen-hero.webp\"}'),
(6,4,'frontend','default','{\"primary_color\":\"#1a56db\",\"branch_accent\":\"#0f766e\",\"hero_image\":\"branches/hamburg-hero.webp\"}'),
(7,5,'frontend','minimal','{\"primary_color\":\"#dc2626\",\"branch_accent\":\"#dc2626\",\"hero_image\":\"branches/austria-hero.webp\"}');
/*!40000 ALTER TABLE `theme_settings` ENABLE KEYS */;
UNLOCK TABLES;

LOCK TABLES `translations` WRITE;
/*!40000 ALTER TABLE `translations` DISABLE KEYS */;
INSERT INTO `translations` VALUES
(1,'de','app.name','TechStore','general'),
(2,'de','layout.skip_to_content','Zum Inhalt springen','general'),
(3,'de','nav.home','Startseite','nav'),
(4,'de','nav.back','Zurück','nav'),
(5,'de','nav.search','Suche','nav'),
(6,'de','nav.open_menu','Menü öffnen','nav'),
(7,'de','cart.title','Warenkorb','cart'),
(8,'de','cart.empty','Ihr Warenkorb ist leer.','cart'),
(9,'de','cart.add_to_cart','In den Warenkorb','cart'),
(10,'de','cart.checkout','Zur Kasse','cart'),
(11,'de','cart.total','Gesamtbetrag','cart'),
(12,'de','cart.subtotal','Zwischensumme','cart'),
(13,'de','cart.shipping','Versand','cart'),
(14,'de','cart.quantity','Menge','cart'),
(15,'de','product.in_stock','Auf Lager','product'),
(16,'de','product.out_of_stock','Ausverkauft','product'),
(17,'de','product.add_to_cart','In den Warenkorb','product'),
(18,'de','product.description','Beschreibung','product'),
(19,'de','product.related','Ähnliche Produkte','product'),
(20,'de','checkout.delivery_method','Liefermethode','checkout'),
(21,'de','checkout.shipping','Versand','checkout'),
(22,'de','checkout.pickup','Abholung','checkout'),
(23,'de','checkout.payment','Zahlung','checkout'),
(24,'de','checkout.place_order','Kostenpflichtig bestellen','checkout'),
(25,'de','auth.login','Anmelden','auth'),
(26,'de','auth.logout','Abmelden','auth'),
(27,'de','auth.register','Registrieren','auth'),
(28,'de','auth.email','E-Mail-Adresse','auth'),
(29,'de','auth.password','Passwort','auth'),
(30,'de','account.orders','Meine Bestellungen','account'),
(31,'de','account.profile','Profil','account'),
(32,'de','account.addresses','Adressen','account'),
(33,'de','account.documents','Unternehmensdokumente','account'),
(34,'de','errors.branch_mismatch','Sie können nur bei Ihrer zugewiesenen Filiale bestellen.','errors'),
(35,'de','errors.not_found','Seite nicht gefunden.','errors'),
(36,'de','errors.server_error','Ein Fehler ist aufgetreten.','errors'),
(37,'de','delivery.free','Kostenlos','delivery'),
(38,'de','delivery.shipping_from','Versandkostenfrei ab :amount','delivery'),
(39,'de','delivery.estimated_days','Lieferung in :min–:max Werktagen','delivery'),
(40,'en','app.name','TechStore','general'),
(41,'en','cart.title','Cart','cart'),
(42,'en','cart.empty','Your cart is empty.','cart'),
(43,'en','cart.add_to_cart','Add to Cart','cart'),
(44,'en','cart.checkout','Checkout','cart'),
(45,'en','product.in_stock','In Stock','product'),
(46,'en','product.out_of_stock','Out of Stock','product'),
(47,'en','product.description','Description','product'),
(48,'en','checkout.place_order','Place Order','checkout'),
(49,'en','auth.login','Sign In','auth'),
(50,'en','auth.logout','Sign Out','auth'),
(51,'en','auth.register','Register','auth'),
(52,'en','errors.branch_mismatch','You can only order from your assigned branch.','errors'),
(53,'en','delivery.free','Free','delivery');
/*!40000 ALTER TABLE `translations` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

