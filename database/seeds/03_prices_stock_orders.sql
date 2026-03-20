-- ============================================================
--  SEED DATA — PART 3
--  Branch Prices · Stock · Campaigns · Orders
-- ============================================================

-- ─────────────────────────────────────────────
--  PRODUCT BRANCH PRICES
--  Columns: product_id, variant_id, branch_id, price_group, price, sale_price, sale_from, sale_until
-- ─────────────────────────────────────────────
DELETE FROM product_branch_prices;

-- Helper macro: each product gets standard + b2b prices for all 5 branches
-- Standard prices are retail; b2b ~15% off; sale_price on selected items

-- ── PRODUCT 1: Samsung Galaxy S25 Ultra ────────────────────
-- Base product (no variant)
INSERT INTO product_branch_prices (product_id, variant_id, branch_id, price_group, price, sale_price, sale_from, sale_until) VALUES
(1,NULL,1,'standard',1249.00,NULL,NULL,NULL),(1,NULL,2,'standard',1249.00,NULL,NULL,NULL),(1,NULL,3,'standard',1249.00,NULL,NULL,NULL),(1,NULL,4,'standard',1249.00,NULL,NULL,NULL),(1,NULL,5,'standard',1299.00,NULL,NULL,NULL),
(1,NULL,1,'b2b',1049.99,NULL,NULL,NULL),(1,NULL,2,'b2b',1049.99,NULL,NULL,NULL),(1,NULL,3,'b2b',1049.99,NULL,NULL,NULL),(1,NULL,4,'b2b',1049.99,NULL,NULL,NULL),(1,NULL,5,'b2b',1099.99,NULL,NULL,NULL);
-- Variants
INSERT INTO product_branch_prices (product_id, variant_id, branch_id, price_group, price, sale_price, sale_from, sale_until) VALUES
(1,1,1,'standard',1249.00,NULL,NULL,NULL),(1,1,2,'standard',1249.00,NULL,NULL,NULL),(1,1,3,'standard',1249.00,NULL,NULL,NULL),(1,1,4,'standard',1249.00,NULL,NULL,NULL),(1,1,5,'standard',1299.00,NULL,NULL,NULL),
(1,2,1,'standard',1249.00,NULL,NULL,NULL),(1,2,2,'standard',1249.00,NULL,NULL,NULL),(1,2,3,'standard',1249.00,NULL,NULL,NULL),(1,2,4,'standard',1249.00,NULL,NULL,NULL),(1,2,5,'standard',1299.00,NULL,NULL,NULL),
(1,3,1,'standard',1379.00,NULL,NULL,NULL),(1,3,2,'standard',1379.00,NULL,NULL,NULL),(1,3,3,'standard',1379.00,NULL,NULL,NULL),(1,3,4,'standard',1379.00,NULL,NULL,NULL),(1,3,5,'standard',1429.00,NULL,NULL,NULL),
(1,4,1,'standard',1619.00,NULL,NULL,NULL),(1,4,2,'standard',1619.00,NULL,NULL,NULL),(1,4,3,'standard',1619.00,NULL,NULL,NULL),(1,4,4,'standard',1619.00,NULL,NULL,NULL),(1,4,5,'standard',1679.00,NULL,NULL,NULL),
(1,1,1,'b2b',1049.99,NULL,NULL,NULL),(1,1,2,'b2b',1049.99,NULL,NULL,NULL),(1,1,3,'b2b',1049.99,NULL,NULL,NULL),(1,1,4,'b2b',1049.99,NULL,NULL,NULL),
(1,3,1,'b2b',1169.00,NULL,NULL,NULL),(1,4,1,'b2b',1379.00,NULL,NULL,NULL);

-- ── PRODUCT 2: Samsung Galaxy S25 ──────────────────────────
INSERT INTO product_branch_prices (product_id, variant_id, branch_id, price_group, price, sale_price, sale_from, sale_until) VALUES
(2,NULL,1,'standard',849.00,NULL,NULL,NULL),(2,NULL,2,'standard',849.00,NULL,NULL,NULL),(2,NULL,3,'standard',849.00,NULL,NULL,NULL),(2,NULL,4,'standard',849.00,NULL,NULL,NULL),(2,NULL,5,'standard',899.00,NULL,NULL,NULL),
(2,5,1,'standard',849.00,NULL,NULL,NULL),(2,5,2,'standard',849.00,NULL,NULL,NULL),(2,5,3,'standard',849.00,NULL,NULL,NULL),(2,5,4,'standard',849.00,NULL,NULL,NULL),
(2,6,1,'standard',849.00,NULL,NULL,NULL),(2,6,2,'standard',849.00,NULL,NULL,NULL),(2,6,3,'standard',849.00,NULL,NULL,NULL),(2,6,4,'standard',849.00,NULL,NULL,NULL),
(2,7,1,'standard',989.00,NULL,NULL,NULL),(2,7,2,'standard',989.00,NULL,NULL,NULL),(2,7,3,'standard',989.00,NULL,NULL,NULL),(2,7,4,'standard',989.00,NULL,NULL,NULL),
(2,5,1,'b2b',721.00,NULL,NULL,NULL),(2,7,1,'b2b',840.00,NULL,NULL,NULL);

-- ── PRODUCT 3: iPhone 16 Pro ───────────────────────────────
INSERT INTO product_branch_prices (product_id, variant_id, branch_id, price_group, price, sale_price, sale_from, sale_until) VALUES
(3,NULL,1,'standard',1329.00,NULL,NULL,NULL),(3,NULL,2,'standard',1329.00,NULL,NULL,NULL),(3,NULL,3,'standard',1329.00,NULL,NULL,NULL),(3,NULL,4,'standard',1329.00,NULL,NULL,NULL),(3,NULL,5,'standard',1379.00,NULL,NULL,NULL),
(3,8,1,'standard',1329.00,NULL,NULL,NULL),(3,8,2,'standard',1329.00,NULL,NULL,NULL),(3,8,3,'standard',1329.00,NULL,NULL,NULL),(3,8,4,'standard',1329.00,NULL,NULL,NULL),
(3,9,1,'standard',1329.00,NULL,NULL,NULL),(3,9,2,'standard',1329.00,NULL,NULL,NULL),
(3,10,1,'standard',1549.00,NULL,NULL,NULL),(3,10,2,'standard',1549.00,NULL,NULL,NULL),(3,10,3,'standard',1549.00,NULL,NULL,NULL),(3,10,4,'standard',1549.00,NULL,NULL,NULL),
(3,11,1,'standard',1779.00,NULL,NULL,NULL),(3,11,2,'standard',1779.00,NULL,NULL,NULL),
(3,8,1,'b2b',1129.99,NULL,NULL,NULL),(3,10,1,'b2b',1319.00,NULL,NULL,NULL);

-- ── PRODUCT 4: iPhone 16 ───────────────────────────────────
INSERT INTO product_branch_prices (product_id, variant_id, branch_id, price_group, price, sale_price, sale_from, sale_until) VALUES
(4,NULL,1,'standard',949.00,NULL,NULL,NULL),(4,NULL,2,'standard',949.00,NULL,NULL,NULL),(4,NULL,3,'standard',949.00,NULL,NULL,NULL),(4,NULL,4,'standard',949.00,NULL,NULL,NULL),(4,NULL,5,'standard',989.00,NULL,NULL,NULL),
(4,12,1,'standard',949.00,799.00,'2025-03-01 00:00:00','2025-03-31 23:59:59'),(4,12,2,'standard',949.00,799.00,'2025-03-01 00:00:00','2025-03-31 23:59:59'),
(4,12,3,'standard',949.00,NULL,NULL,NULL),(4,12,4,'standard',949.00,NULL,NULL,NULL),
(4,13,1,'standard',949.00,NULL,NULL,NULL),(4,13,2,'standard',949.00,NULL,NULL,NULL),
(4,14,1,'standard',1099.00,NULL,NULL,NULL),(4,14,2,'standard',1099.00,NULL,NULL,NULL),
(4,12,1,'b2b',807.00,NULL,NULL,NULL),(4,14,1,'b2b',934.00,NULL,NULL,NULL);

-- ── PRODUCT 5: Google Pixel 9 Pro ──────────────────────────
INSERT INTO product_branch_prices (product_id, variant_id, branch_id, price_group, price, sale_price, sale_from, sale_until) VALUES
(5,NULL,1,'standard',1099.00,NULL,NULL,NULL),(5,NULL,2,'standard',1099.00,NULL,NULL,NULL),(5,NULL,3,'standard',1099.00,NULL,NULL,NULL),(5,NULL,4,'standard',1099.00,NULL,NULL,NULL),(5,NULL,5,'standard',1149.00,NULL,NULL,NULL),
(5,NULL,1,'b2b',934.00,NULL,NULL,NULL);

-- ── PRODUCT 6: OnePlus 12R ─────────────────────────────────
INSERT INTO product_branch_prices (product_id, variant_id, branch_id, price_group, price, sale_price, sale_from, sale_until) VALUES
(6,NULL,1,'standard',499.00,449.00,'2025-03-15 00:00:00','2025-03-31 23:59:59'),
(6,NULL,2,'standard',499.00,449.00,'2025-03-15 00:00:00','2025-03-31 23:59:59'),
(6,NULL,3,'standard',499.00,NULL,NULL,NULL),(6,NULL,4,'standard',499.00,NULL,NULL,NULL),
(6,NULL,1,'b2b',424.00,NULL,NULL,NULL);

-- ── PRODUCT 7: MacBook Air M3 ──────────────────────────────
INSERT INTO product_branch_prices (product_id, variant_id, branch_id, price_group, price, sale_price, sale_from, sale_until) VALUES
(7,NULL,1,'standard',1299.00,NULL,NULL,NULL),(7,NULL,2,'standard',1299.00,NULL,NULL,NULL),(7,NULL,3,'standard',1299.00,NULL,NULL,NULL),(7,NULL,4,'standard',1299.00,NULL,NULL,NULL),(7,NULL,5,'standard',1349.00,NULL,NULL,NULL),
(7,15,1,'standard',1299.00,NULL,NULL,NULL),(7,15,2,'standard',1299.00,NULL,NULL,NULL),(7,15,3,'standard',1299.00,NULL,NULL,NULL),(7,15,4,'standard',1299.00,NULL,NULL,NULL),
(7,16,1,'standard',1499.00,NULL,NULL,NULL),(7,16,2,'standard',1499.00,NULL,NULL,NULL),(7,16,3,'standard',1499.00,NULL,NULL,NULL),(7,16,4,'standard',1499.00,NULL,NULL,NULL),
(7,17,1,'standard',1699.00,NULL,NULL,NULL),(7,17,2,'standard',1699.00,NULL,NULL,NULL),
(7,15,1,'b2b',1104.00,NULL,NULL,NULL),(7,16,1,'b2b',1274.00,NULL,NULL,NULL),(7,17,1,'b2b',1444.00,NULL,NULL,NULL);

-- ── PRODUCT 8: MacBook Pro M4 ──────────────────────────────
INSERT INTO product_branch_prices (product_id, variant_id, branch_id, price_group, price, sale_price, sale_from, sale_until) VALUES
(8,NULL,1,'standard',1999.00,NULL,NULL,NULL),(8,NULL,2,'standard',1999.00,NULL,NULL,NULL),(8,NULL,3,'standard',1999.00,NULL,NULL,NULL),(8,NULL,4,'standard',1999.00,NULL,NULL,NULL),(8,NULL,5,'standard',2099.00,NULL,NULL,NULL),
(8,NULL,1,'b2b',1699.00,NULL,NULL,NULL);

-- ── PRODUCT 9: Dell XPS 15 ─────────────────────────────────
INSERT INTO product_branch_prices (product_id, variant_id, branch_id, price_group, price, sale_price, sale_from, sale_until) VALUES
(9,NULL,1,'standard',2299.00,1999.00,'2025-03-10 00:00:00','2025-03-31 23:59:59'),
(9,NULL,2,'standard',2299.00,1999.00,'2025-03-10 00:00:00','2025-03-31 23:59:59'),
(9,NULL,3,'standard',2299.00,NULL,NULL,NULL),(9,NULL,4,'standard',2299.00,NULL,NULL,NULL),(9,NULL,5,'standard',2399.00,NULL,NULL,NULL),
(9,NULL,1,'b2b',1954.00,NULL,NULL,NULL),(9,NULL,2,'b2b',1954.00,NULL,NULL,NULL);

-- ── PRODUCT 10: Lenovo X1 Carbon ──────────────────────────
INSERT INTO product_branch_prices (product_id, variant_id, branch_id, price_group, price, sale_price, sale_from, sale_until) VALUES
(10,NULL,1,'standard',1599.00,NULL,NULL,NULL),(10,NULL,2,'standard',1599.00,NULL,NULL,NULL),(10,NULL,3,'standard',1599.00,NULL,NULL,NULL),(10,NULL,4,'standard',1599.00,NULL,NULL,NULL),
(10,NULL,1,'b2b',1359.00,NULL,NULL,NULL);

-- ── PRODUCT 11: ASUS ZenBook Pro ──────────────────────────
INSERT INTO product_branch_prices (product_id, variant_id, branch_id, price_group, price, sale_price, sale_from, sale_until) VALUES
(11,NULL,1,'standard',1899.00,NULL,NULL,NULL),(11,NULL,2,'standard',1899.00,NULL,NULL,NULL),(11,NULL,3,'standard',1899.00,NULL,NULL,NULL),
(11,NULL,1,'b2b',1614.00,NULL,NULL,NULL);

-- ── PRODUCT 12: Sony WH-1000XM6 ───────────────────────────
INSERT INTO product_branch_prices (product_id, variant_id, branch_id, price_group, price, sale_price, sale_from, sale_until) VALUES
(12,NULL,1,'standard',399.00,NULL,NULL,NULL),(12,NULL,2,'standard',399.00,NULL,NULL,NULL),(12,NULL,3,'standard',399.00,NULL,NULL,NULL),(12,NULL,4,'standard',399.00,NULL,NULL,NULL),(12,NULL,5,'standard',419.00,NULL,NULL,NULL),
(12,18,1,'standard',399.00,NULL,NULL,NULL),(12,18,2,'standard',399.00,NULL,NULL,NULL),(12,18,3,'standard',399.00,NULL,NULL,NULL),(12,18,4,'standard',399.00,NULL,NULL,NULL),
(12,19,1,'standard',399.00,NULL,NULL,NULL),(12,19,2,'standard',399.00,NULL,NULL,NULL),
(12,18,1,'b2b',339.00,NULL,NULL,NULL),(12,19,1,'b2b',339.00,NULL,NULL,NULL);

-- ── PRODUCT 13: AirPods Max ───────────────────────────────
INSERT INTO product_branch_prices (product_id, variant_id, branch_id, price_group, price, sale_price, sale_from, sale_until) VALUES
(13,NULL,1,'standard',549.00,NULL,NULL,NULL),(13,NULL,2,'standard',549.00,NULL,NULL,NULL),(13,NULL,3,'standard',549.00,NULL,NULL,NULL),(13,NULL,4,'standard',549.00,NULL,NULL,NULL),
(13,21,1,'standard',549.00,NULL,NULL,NULL),(13,21,2,'standard',549.00,NULL,NULL,NULL),
(13,22,1,'standard',549.00,NULL,NULL,NULL),(13,22,2,'standard',549.00,NULL,NULL,NULL),
(13,21,1,'b2b',466.00,NULL,NULL,NULL);

-- ── PRODUCT 14: Bose QC45 ─────────────────────────────────
INSERT INTO product_branch_prices (product_id, variant_id, branch_id, price_group, price, sale_price, sale_from, sale_until) VALUES
(14,NULL,1,'standard',279.00,229.00,'2025-03-01 00:00:00','2025-04-30 23:59:59'),
(14,NULL,2,'standard',279.00,229.00,'2025-03-01 00:00:00','2025-04-30 23:59:59'),
(14,NULL,3,'standard',279.00,NULL,NULL,NULL),(14,NULL,4,'standard',279.00,NULL,NULL,NULL),(14,NULL,5,'standard',299.00,NULL,NULL,NULL),
(14,NULL,1,'b2b',237.00,NULL,NULL,NULL);

-- ── PRODUCT 15: AirPods Pro 4 ─────────────────────────────
INSERT INTO product_branch_prices (product_id, variant_id, branch_id, price_group, price, sale_price, sale_from, sale_until) VALUES
(15,NULL,1,'standard',279.00,NULL,NULL,NULL),(15,NULL,2,'standard',279.00,NULL,NULL,NULL),(15,NULL,3,'standard',279.00,NULL,NULL,NULL),(15,NULL,4,'standard',279.00,NULL,NULL,NULL),(15,NULL,5,'standard',299.00,NULL,NULL,NULL),
(15,20,1,'standard',279.00,NULL,NULL,NULL),(15,20,2,'standard',279.00,NULL,NULL,NULL),(15,20,3,'standard',279.00,NULL,NULL,NULL),(15,20,4,'standard',279.00,NULL,NULL,NULL),
(15,20,1,'b2b',237.00,NULL,NULL,NULL);

-- ── PRODUCTS 16–30 (condensed) ─────────────────────────────
INSERT INTO product_branch_prices (product_id, variant_id, branch_id, price_group, price, sale_price, sale_from, sale_until) VALUES
(16,NULL,1,'standard',349.00,NULL,NULL,NULL),(16,NULL,2,'standard',349.00,NULL,NULL,NULL),(16,NULL,3,'standard',349.00,NULL,NULL,NULL),(16,NULL,4,'standard',349.00,NULL,NULL,NULL),(16,NULL,5,'standard',369.00,NULL,NULL,NULL),
(16,23,1,'standard',349.00,NULL,NULL,NULL),(16,24,1,'standard',349.00,NULL,NULL,NULL),(16,23,1,'b2b',297.00,NULL,NULL,NULL),
(17,NULL,1,'standard',219.00,199.00,'2025-03-01 00:00:00','2025-03-31 23:59:59'),(17,NULL,2,'standard',219.00,199.00,'2025-03-01 00:00:00','2025-03-31 23:59:59'),
(17,NULL,3,'standard',219.00,NULL,NULL,NULL),(17,NULL,4,'standard',219.00,NULL,NULL,NULL),(17,NULL,1,'b2b',186.00,NULL,NULL,NULL),
(18,NULL,1,'standard',59.00,NULL,NULL,NULL),(18,NULL,2,'standard',59.00,NULL,NULL,NULL),(18,NULL,3,'standard',59.00,NULL,NULL,NULL),(18,NULL,4,'standard',59.00,NULL,NULL,NULL),(18,NULL,5,'standard',65.00,NULL,NULL,NULL),
(19,NULL,1,'standard',349.00,NULL,NULL,NULL),(19,NULL,2,'standard',349.00,NULL,NULL,NULL),(19,NULL,3,'standard',349.00,NULL,NULL,NULL),(19,NULL,4,'standard',349.00,NULL,NULL,NULL),(19,NULL,5,'standard',369.00,NULL,NULL,NULL),
(19,NULL,1,'b2b',297.00,NULL,NULL,NULL),
(20,NULL,1,'standard',1299.00,NULL,NULL,NULL),(20,NULL,2,'standard',1299.00,NULL,NULL,NULL),(20,NULL,3,'standard',1299.00,NULL,NULL,NULL),(20,NULL,4,'standard',1299.00,NULL,NULL,NULL),(20,NULL,5,'standard',1379.00,NULL,NULL,NULL),
(20,25,1,'standard',1299.00,NULL,NULL,NULL),(20,25,2,'standard',1299.00,NULL,NULL,NULL),(20,26,1,'standard',1299.00,NULL,NULL,NULL),(20,27,1,'standard',1519.00,NULL,NULL,NULL),
(20,25,1,'b2b',1104.00,NULL,NULL,NULL),
(21,NULL,1,'standard',449.00,379.00,'2025-02-01 00:00:00','2025-03-31 23:59:59'),(21,NULL,2,'standard',449.00,379.00,'2025-02-01 00:00:00','2025-03-31 23:59:59'),
(21,NULL,3,'standard',449.00,NULL,NULL,NULL),(21,NULL,4,'standard',449.00,NULL,NULL,NULL),(21,NULL,1,'b2b',382.00,NULL,NULL,NULL),
(22,NULL,1,'standard',289.00,NULL,NULL,NULL),(22,NULL,2,'standard',289.00,NULL,NULL,NULL),(22,NULL,3,'standard',289.00,NULL,NULL,NULL),(22,NULL,4,'standard',289.00,NULL,NULL,NULL),(22,NULL,1,'b2b',246.00,NULL,NULL,NULL),
(23,NULL,1,'standard',159.00,NULL,NULL,NULL),(23,NULL,2,'standard',159.00,NULL,NULL,NULL),(23,NULL,3,'standard',159.00,NULL,NULL,NULL),(23,NULL,4,'standard',159.00,NULL,NULL,NULL),(23,NULL,5,'standard',169.00,NULL,NULL,NULL),(23,NULL,1,'b2b',135.00,NULL,NULL,NULL),
(24,NULL,1,'standard',229.00,NULL,NULL,NULL),(24,NULL,2,'standard',229.00,NULL,NULL,NULL),(24,NULL,3,'standard',229.00,NULL,NULL,NULL),(24,NULL,4,'standard',229.00,NULL,NULL,NULL),(24,NULL,1,'b2b',195.00,NULL,NULL,NULL),
(25,NULL,1,'standard',199.00,NULL,NULL,NULL),(25,NULL,2,'standard',199.00,NULL,NULL,NULL),(25,NULL,3,'standard',199.00,NULL,NULL,NULL),(25,NULL,4,'standard',199.00,NULL,NULL,NULL),(25,NULL,5,'standard',209.00,NULL,NULL,NULL),(25,NULL,1,'b2b',169.00,NULL,NULL,NULL),
(26,NULL,1,'standard',64.99,NULL,NULL,NULL),(26,NULL,2,'standard',64.99,NULL,NULL,NULL),(26,NULL,3,'standard',64.99,NULL,NULL,NULL),(26,NULL,4,'standard',64.99,NULL,NULL,NULL),
(26,28,1,'standard',64.99,NULL,NULL,NULL),(26,29,1,'standard',64.99,NULL,NULL,NULL),
(27,NULL,1,'standard',149.00,NULL,NULL,NULL),(27,NULL,2,'standard',149.00,NULL,NULL,NULL),(27,NULL,3,'standard',149.00,NULL,NULL,NULL),(27,NULL,4,'standard',149.00,NULL,NULL,NULL),(27,NULL,5,'standard',159.00,NULL,NULL,NULL),(27,NULL,1,'b2b',126.00,NULL,NULL,NULL),
(28,NULL,1,'standard',3299.00,NULL,NULL,NULL),(28,NULL,2,'standard',3299.00,NULL,NULL,NULL),(28,NULL,3,'standard',3299.00,NULL,NULL,NULL),(28,NULL,4,'standard',3299.00,NULL,NULL,NULL),(28,NULL,5,'standard',3499.00,NULL,NULL,NULL),(28,NULL,1,'b2b',2804.00,NULL,NULL,NULL),
(29,NULL,1,'standard',1799.00,NULL,NULL,NULL),(29,NULL,2,'standard',1799.00,NULL,NULL,NULL),(29,NULL,3,'standard',1799.00,NULL,NULL,NULL),(29,NULL,4,'standard',1799.00,NULL,NULL,NULL),(29,NULL,1,'b2b',1529.00,NULL,NULL,NULL),
(30,NULL,1,'standard',29.00,NULL,NULL,NULL),(30,NULL,2,'standard',29.00,NULL,NULL,NULL),(30,NULL,3,'standard',29.00,NULL,NULL,NULL),(30,NULL,4,'standard',29.00,NULL,NULL,NULL),(30,NULL,5,'standard',32.00,NULL,NULL,NULL),
(30,30,1,'standard',29.00,NULL,NULL,NULL),(30,31,1,'standard',29.00,NULL,NULL,NULL),(30,32,1,'standard',39.00,NULL,NULL,NULL),
(30,30,1,'b2b',24.00,NULL,NULL,NULL),(30,31,1,'b2b',24.00,NULL,NULL,NULL);

-- ─────────────────────────────────────────────
--  PRODUCT BRANCH STOCK
-- ─────────────────────────────────────────────
DELETE FROM product_branch_stock;
INSERT INTO product_branch_stock (product_id, variant_id, branch_id, quantity, reserved_qty, low_stock_alert, track_stock, allow_backorder) VALUES
-- S25 Ultra
( 1, 1,1, 45,3,5,1,0),( 1, 1,2, 23,1,5,1,0),( 1, 1,3, 18,0,3,1,0),( 1, 1,4, 12,2,3,1,0),( 1, 1,5,  8,0,3,1,1),
( 1, 2,1, 38,2,5,1,0),( 1, 2,2, 20,0,5,1,0),( 1, 2,3, 15,1,3,1,0),( 1, 2,4,  9,0,3,1,0),
( 1, 3,1, 22,0,5,1,0),( 1, 3,2, 11,1,3,1,0),( 1, 3,3,  8,0,3,1,0),( 1, 3,4,  6,0,3,1,0),
( 1, 4,1,  8,1,3,1,0),( 1, 4,2,  4,0,3,1,0),( 1, 4,3,  3,0,2,1,0),( 1, 4,4,  2,0,2,1,1),
-- iPhone 16 Pro
( 3, 8,1, 32,2,5,1,0),( 3, 8,2, 18,1,5,1,0),( 3, 8,3, 22,0,5,1,0),( 3, 8,4, 15,0,3,1,0),
( 3, 9,1, 28,0,5,1,0),( 3, 9,2, 16,1,3,1,0),
( 3,10,1, 14,2,3,1,0),( 3,10,2,  8,0,3,1,0),( 3,10,3, 10,1,3,1,0),
( 3,11,1,  5,0,2,1,0),( 3,11,2,  3,0,2,1,1),
-- iPhone 16 (incl. sale variant)
( 4,12,1, 55,5,10,1,0),( 4,12,2, 33,2,5,1,0),( 4,12,3, 28,0,5,1,0),( 4,12,4, 21,1,5,1,0),
( 4,13,1, 42,3,10,1,0),( 4,13,2, 25,0,5,1,0),
( 4,14,1, 28,2,5,1,0),( 4,14,2, 16,1,3,1,0),
-- Google Pixel 9 Pro
( 5,NULL,1, 20,1,5,1,0),( 5,NULL,2, 12,0,3,1,0),( 5,NULL,3, 10,0,3,1,0),( 5,NULL,4,  8,0,3,1,0),
-- OnePlus 12R
( 6,NULL,1, 35,0,5,1,0),( 6,NULL,2, 20,0,5,1,0),( 6,NULL,3, 15,0,3,1,0),( 6,NULL,4, 12,0,3,1,0),
-- MacBook Air M3
( 7,15,1, 28,2,5,1,0),( 7,15,2, 16,0,3,1,0),( 7,15,3, 12,1,3,1,0),( 7,15,4,  9,0,3,1,0),
( 7,16,1, 20,1,5,1,0),( 7,16,2, 11,0,3,1,0),( 7,16,3,  8,0,3,1,0),( 7,16,4,  6,0,2,1,0),
( 7,17,1, 10,0,3,1,0),( 7,17,2,  6,1,2,1,0),
-- MacBook Pro M4
( 8,NULL,1, 15,1,3,1,0),( 8,NULL,2,  9,0,3,1,0),( 8,NULL,3,  7,0,2,1,0),( 8,NULL,4,  5,0,2,1,1),
-- Dell XPS 15
( 9,NULL,1, 12,1,3,1,0),( 9,NULL,2,  7,0,2,1,0),( 9,NULL,3,  5,0,2,1,0),( 9,NULL,4,  4,0,2,1,0),
-- Lenovo X1 Carbon
(10,NULL,1, 18,0,3,1,0),(10,NULL,2, 10,0,3,1,0),(10,NULL,3,  8,0,2,1,0),(10,NULL,4,  6,0,2,1,0),
-- ASUS ZenBook
(11,NULL,1, 10,0,3,1,0),(11,NULL,2,  6,0,2,1,0),(11,NULL,3,  5,0,2,1,0),
-- Sony WH-1000XM6
(12,18,1, 48,3,10,1,0),(12,18,2, 30,1,5,1,0),(12,18,3, 25,0,5,1,0),(12,18,4, 20,0,5,1,0),(12,18,5, 15,0,3,1,0),
(12,19,1, 22,0,5,1,0),(12,19,2, 14,0,3,1,0),(12,19,3, 10,0,3,1,0),(12,19,4,  8,0,2,1,0),
-- AirPods Max
(13,21,1, 18,1,3,1,0),(13,21,2, 11,0,3,1,0),(13,21,3,  9,0,2,1,0),
(13,22,1, 14,0,3,1,0),(13,22,2,  8,0,2,1,0),
-- Bose QC45
(14,NULL,1, 35,2,5,1,0),(14,NULL,2, 20,0,5,1,0),(14,NULL,3, 16,1,3,1,0),(14,NULL,4, 12,0,3,1,0),(14,NULL,5, 10,0,3,1,0),
-- AirPods Pro 4
(15,20,1, 60,5,10,1,0),(15,20,2, 38,2,5,1,0),(15,20,3, 32,1,5,1,0),(15,20,4, 25,0,5,1,0),(15,20,5, 18,0,3,1,0),
-- Sony WF-1000XM5
(16,23,1, 42,3,5,1,0),(16,23,2, 26,0,5,1,0),(16,23,3, 20,0,5,1,0),(16,23,4, 15,0,3,1,0),
(16,24,1, 20,0,5,1,0),(16,24,2, 12,0,3,1,0),
-- Samsung Galaxy Buds3 Pro
(17,NULL,1, 55,4,10,1,0),(17,NULL,2, 32,1,5,1,0),(17,NULL,3, 28,0,5,1,0),(17,NULL,4, 20,0,5,1,0),
-- Sony SRS-XB100
(18,NULL,1, 80,5,10,1,0),(18,NULL,2, 50,2,10,1,0),(18,NULL,3, 40,0,5,1,0),(18,NULL,4, 35,0,5,1,0),(18,NULL,5, 25,0,5,1,0),
-- Bose SoundLink Max
(19,NULL,1, 28,2,5,1,0),(19,NULL,2, 18,0,3,1,0),(19,NULL,3, 15,1,3,1,0),(19,NULL,4, 12,0,3,1,0),(19,NULL,5, 10,0,3,1,0),
-- iPad Pro M4
(20,25,1, 22,2,5,1,0),(20,25,2, 14,1,3,1,0),(20,25,3, 12,0,3,1,0),(20,25,4,  9,0,3,1,0),
(20,26,1, 18,1,5,1,0),(20,26,2, 10,0,3,1,0),
(20,27,1, 10,0,3,1,0),(20,27,2,  6,0,2,1,0),
-- Samsung Tab S9 FE
(21,NULL,1, 45,3,10,1,0),(21,NULL,2, 28,1,5,1,0),(21,NULL,3, 22,0,5,1,0),(21,NULL,4, 18,0,5,1,0),
-- Gaming Headset
(22,NULL,1, 30,2,5,1,0),(22,NULL,2, 18,0,3,1,0),(22,NULL,3, 14,0,3,1,0),(22,NULL,4, 10,0,3,1,0),
-- Logitech G Pro X2
(23,NULL,1, 50,3,10,1,0),(23,NULL,2, 32,1,5,1,0),(23,NULL,3, 28,0,5,1,0),(23,NULL,4, 22,0,5,1,0),(23,NULL,5, 15,0,3,1,0),
-- Razer Huntsman V3
(24,NULL,1, 25,1,5,1,0),(24,NULL,2, 15,0,3,1,0),(24,NULL,3, 12,0,3,1,0),(24,NULL,4,  9,0,2,1,0),
-- Philips Hue Starter
(25,NULL,1, 35,2,5,1,0),(25,NULL,2, 22,0,5,1,0),(25,NULL,3, 18,0,3,1,0),(25,NULL,4, 15,0,3,1,0),(25,NULL,5, 12,0,3,1,0),
-- Amazon Echo Dot
(26,28,1, 70,5,10,1,0),(26,28,2, 45,2,10,1,0),(26,28,3, 38,0,5,1,0),(26,28,4, 32,0,5,1,0),
(26,29,1, 55,3,10,1,0),(26,29,2, 35,0,5,1,0),
-- Nest Thermostat
(27,NULL,1, 40,2,5,1,0),(27,NULL,2, 25,0,5,1,0),(27,NULL,3, 20,0,3,1,0),(27,NULL,4, 16,0,3,1,0),(27,NULL,5, 12,0,3,1,1),
-- Sony A7 IV
(28,NULL,1, 12,1,3,1,0),(28,NULL,2,  8,0,2,1,0),(28,NULL,3,  6,0,2,1,0),(28,NULL,4,  5,0,2,1,0),(28,NULL,5,  4,0,2,1,1),
-- Canon EOS R8
(29,NULL,1, 18,1,3,1,0),(29,NULL,2, 11,0,3,1,0),(29,NULL,3,  9,0,2,1,0),(29,NULL,4,  7,0,2,1,0),
-- USB-C Kabel
(30,30,1,200,10,20,1,0),(30,30,2,150, 5,20,1,0),(30,30,3,120, 0,10,1,0),(30,30,4,100, 0,10,1,0),(30,30,5, 80, 0,10,1,0),
(30,31,1,180, 8,20,1,0),(30,31,2,120, 3,15,1,0),
(30,32,1, 90, 2,10,1,0),(30,32,2, 60, 0, 5,1,0);

-- ─────────────────────────────────────────────
--  CAMPAIGNS & COUPONS
-- ─────────────────────────────────────────────
DELETE FROM campaigns;
INSERT INTO campaigns (id, branch_id, name, code, type, value, min_order_amount, max_uses, uses_count, max_uses_per_customer, customer_type, valid_from, valid_until, is_active) VALUES
(1, NULL,  'Frühjahrsaktion 2025',          'FRUEHLING25',  'percent',      10.00, 50.00,  1000, 234,  1, 'all',     '2025-03-01 00:00:00', '2025-03-31 23:59:59', 1),
(2, NULL,  'B2B Willkommensrabatt',          'B2BWILLKOMM',  'percent',       5.00, 100.00,  500,  89,  1, 'company', '2025-01-01 00:00:00', '2025-12-31 23:59:59', 1),
(3, 1,     'Köln Eröffnungsfeier',           'KOELN10',      'fixed',        10.00,  0.00,   200,  45,  1, 'all',     '2025-02-01 00:00:00', '2025-04-30 23:59:59', 1),
(4, NULL,  'Gratisversand ab 30€',           'GRATIS30',     'free_shipping', 0.00, 30.00,  5000, 1203, 3, 'all',     '2025-01-01 00:00:00', '2025-06-30 23:59:59', 1),
(5, 2,     'Berlin Special',                 'BERLIN15',     'percent',      15.00, 99.00,   300,  67,  1, 'all',     '2025-03-15 00:00:00', '2025-04-15 23:59:59', 1),
(6, NULL,  'Studenten-Rabatt',               'STUDENT10',    'percent',      10.00, 20.00,  2000, 445,  1, 'private', '2025-01-01 00:00:00', '2025-12-31 23:59:59', 1),
(7, 3,     'München Oster-Aktion',           'OSTER20',      'percent',      20.00, 150.00,  500,   0,  1, 'all',     '2025-04-01 00:00:00', '2025-04-21 23:59:59', 1),
(8, NULL,  'Tech-Deals März',                NULL,           'percent',      12.00, 200.00,  NULL,   0,  1, 'all',     '2025-03-01 00:00:00', '2025-03-31 23:59:59', 0);

DELETE FROM campaign_products;
INSERT INTO campaign_products (campaign_id, product_id) VALUES
(8, 9),(8, 10),(8, 11),(8, 7),(8, 8);

-- ─────────────────────────────────────────────
--  ORDERS (realistic set across all branches)
-- ─────────────────────────────────────────────
DELETE FROM orders;
INSERT INTO orders (id, order_number, branch_id, customer_id, status, type, subtotal, discount_amount, shipping_cost, tax_amount, total, currency_code, campaign_id, coupon_code, billing_address, shipping_address, payment_method, payment_status, paid_at, po_number, payment_due_date, customer_note, lang_code, ip_address, created_at) VALUES

-- Bestellnummern-Format: ORD-JAHR-B{branch_id}-{laufende Nr.}
-- Dadurch sind sie global eindeutig, trotzdem pro Filiale sortierbar.

-- ── Köln / Branch 1 (B1) ───────────────────────────────────
(1,  'ORD-2025-B1-00001', 1, 1, 'delivered',  'standard', 1578.00,   0.00,  0.00, 299.82, 1578.00, 'EUR', NULL, NULL,
    '{"first_name":"Lena","last_name":"Fischer","street":"Aachener Straße","house_number":"45","city":"Köln","postal_code":"50674","country_code":"DE"}',
    '{"first_name":"Lena","last_name":"Fischer","street":"Aachener Straße","house_number":"45","city":"Köln","postal_code":"50674","country_code":"DE"}',
    'paypal', 'paid', '2025-01-15 10:05:00', NULL, NULL, NULL, 'de', '91.12.34.56', '2025-01-15 09:58:00'),

(2,  'ORD-2025-B1-00002', 1, 3, 'delivered',  'standard', 2299.00,   0.00,  0.00,   0.00, 2299.00, 'EUR', NULL, NULL,
    '{"first_name":"Stefan","last_name":"Brandt","company":"Brandt GmbH","street":"Riehler Straße","house_number":"8","city":"Köln","postal_code":"50668","country_code":"DE"}',
    '{"first_name":"Stefan","last_name":"Brandt","company":"Brandt GmbH","street":"Industriestraße","house_number":"33","city":"Bergheim","postal_code":"50126","country_code":"DE"}',
    'invoice', 'paid', '2025-01-20 11:00:00', 'PO-2025-0042', '2025-02-20', 'Bitte mit Lieferschein und Rechnung senden.', 'de', '195.65.12.88', '2025-01-18 14:20:00'),

(3,  'ORD-2025-B1-00003', 1, 1, 'delivered',  'standard',  279.00,   0.00,  0.00,  44.54,  279.00, 'EUR', NULL, NULL,
    '{"first_name":"Lena","last_name":"Fischer","street":"Aachener Straße","house_number":"45","city":"Köln","postal_code":"50674","country_code":"DE"}',
    '{"first_name":"Lena","last_name":"Fischer","street":"Aachener Straße","house_number":"45","city":"Köln","postal_code":"50674","country_code":"DE"}',
    'credit_card', 'paid', '2025-02-05 13:22:00', NULL, NULL, NULL, 'de', '91.12.34.56', '2025-02-05 13:10:00'),

(4,  'ORD-2025-B1-00004', 1, 4, 'shipped',    'standard', 6597.00, 329.85,  0.00,   0.00, 6267.15, 'EUR', 2, 'B2BWILLKOMM',
    '{"first_name":"Nicole","last_name":"Zimmermann","company":"Z-Logistics KG","street":"Bonner Straße","house_number":"201","city":"Köln","postal_code":"50969","country_code":"DE"}',
    '{"first_name":"Nicole","last_name":"Zimmermann","company":"Z-Logistics KG","street":"Bonner Straße","house_number":"201","city":"Köln","postal_code":"50969","country_code":"DE"}',
    'invoice', 'pending', NULL, 'PO-ZL-2025-008', '2025-03-20', NULL, 'de', '195.99.77.22', '2025-02-18 09:30:00'),

(5,  'ORD-2025-B1-00005', 1, 2, 'processing', 'standard',  399.00,  39.90,  0.00,  57.59,  359.10, 'EUR', 1, 'FRUEHLING25',
    '{"first_name":"Markus","last_name":"Wagner","street":"Ehrenfelder Gürtel","house_number":"112","city":"Köln","postal_code":"50823","country_code":"DE"}',
    '{"first_name":"Markus","last_name":"Wagner","street":"Ehrenfelder Gürtel","house_number":"112","city":"Köln","postal_code":"50823","country_code":"DE"}',
    'paypal', 'paid', '2025-03-12 15:30:00', NULL, NULL, 'Bitte besonders sorgfältig verpacken.', 'de', '212.78.56.11', '2025-03-12 15:20:00'),

(6,  'ORD-2025-B1-00006', 1, 6, 'confirmed',  'pickup',    949.00,   0.00,  0.00, 151.47,  949.00, 'EUR', NULL, NULL,
    '{"first_name":"Julia","last_name":"Koch","street":"Deutz-Mülheimer Str","house_number":"14","city":"Köln","postal_code":"51063","country_code":"DE"}',
    NULL, 'credit_card', 'paid', '2025-03-17 11:45:00', NULL, NULL, NULL, 'de', '78.45.221.33', '2025-03-17 11:35:00'),

(7,  'ORD-2025-B1-00007', 1, 3, 'processing', 'standard', 3598.00,   0.00,  0.00,   0.00, 3598.00, 'EUR', NULL, NULL,
    '{"first_name":"Stefan","last_name":"Brandt","company":"Brandt GmbH","street":"Riehler Straße","house_number":"8","city":"Köln","postal_code":"50668","country_code":"DE"}',
    '{"first_name":"Stefan","last_name":"Brandt","company":"Brandt GmbH","street":"Industriestraße","house_number":"33","city":"Bergheim","postal_code":"50126","country_code":"DE"}',
    'invoice', 'pending', NULL, 'PO-2025-0078', '2025-04-19', NULL, 'de', '195.65.12.88', '2025-03-19 10:00:00'),

-- ── Berlin / Branch 2 (B2) ─────────────────────────────────
(8,  'ORD-2025-B2-00001', 2,  7, 'delivered',  'standard', 1329.00,   0.00,  0.00, 212.25, 1329.00, 'EUR', NULL, NULL,
    '{"first_name":"Felix","last_name":"Bauer","street":"Prenzlauer Allee","house_number":"88","city":"Berlin","postal_code":"10405","country_code":"DE"}',
    '{"first_name":"Felix","last_name":"Bauer","street":"Prenzlauer Allee","house_number":"88","city":"Berlin","postal_code":"10405","country_code":"DE"}',
    'credit_card', 'paid', '2025-01-22 09:15:00', NULL, NULL, NULL, 'de', '87.123.45.67', '2025-01-22 09:00:00'),

(9,  'ORD-2025-B2-00002', 2,  9, 'delivered',  'standard', 4798.00, 239.90,  0.00,   0.00, 4558.10, 'EUR', 2, 'B2BWILLKOMM',
    '{"first_name":"Andreas","last_name":"Klein","company":"KleinTec GmbH","street":"Unter den Linden","house_number":"42","city":"Berlin","postal_code":"10117","country_code":"DE"}',
    '{"first_name":"Andreas","last_name":"Klein","company":"KleinTec GmbH","street":"Unter den Linden","house_number":"42","city":"Berlin","postal_code":"10117","country_code":"DE"}',
    'invoice', 'paid', '2025-02-25 10:00:00', 'PO-KT-2025-015', '2025-03-25', NULL, 'de', '194.55.88.11', '2025-02-22 16:00:00'),

(10, 'ORD-2025-B2-00003', 2,  8, 'confirmed',  'standard',  279.00,  41.85,  4.90,  37.74,  242.05, 'EUR', 5, 'BERLIN15',
    '{"first_name":"Sarah","last_name":"Richter","street":"Kreuzbergstr.","house_number":"7","city":"Berlin","postal_code":"10965","country_code":"DE"}',
    '{"first_name":"Sarah","last_name":"Richter","street":"Kreuzbergstr.","house_number":"7","city":"Berlin","postal_code":"10965","country_code":"DE"}',
    'paypal', 'paid', '2025-03-16 20:01:00', NULL, NULL, NULL, 'de', '78.99.112.55', '2025-03-16 19:55:00'),

(11, 'ORD-2025-B2-00004', 2, 10, 'pending',    'standard',   59.00,   0.00,  4.90,   9.14,   63.90, 'EUR', NULL, NULL,
    '{"first_name":"Emma","last_name":"Wolf","street":"Schönhauser Allee","house_number":"55","city":"Berlin","postal_code":"10437","country_code":"DE"}',
    '{"first_name":"Emma","last_name":"Wolf","street":"Schönhauser Allee","house_number":"55","city":"Berlin","postal_code":"10437","country_code":"DE"}',
    'credit_card', 'paid', '2025-03-19 08:45:00', NULL, NULL, NULL, 'en', '99.12.34.77', '2025-03-19 08:40:00'),

-- ── München / Branch 3 (B3) ────────────────────────────────
(12, 'ORD-2025-B3-00001', 3, 11, 'delivered',  'pickup',    949.00,   0.00,  0.00, 151.47,  949.00, 'EUR', NULL, NULL,
    '{"first_name":"Lukas","last_name":"Braun","street":"Maximilianstraße","house_number":"19","city":"München","postal_code":"80539","country_code":"DE"}',
    NULL, 'credit_card', 'paid', '2025-02-28 14:00:00', NULL, NULL, 'Abholung am Samstag bitte.', 'de', '89.12.56.78', '2025-02-27 10:00:00'),

(13, 'ORD-2025-B3-00002', 3, 12, 'shipped',    'standard', 5598.00,   0.00,  0.00,   0.00, 5598.00, 'EUR', NULL, NULL,
    '{"first_name":"Monika","last_name":"Lange","company":"Bay Solutions AG","street":"Rosenheimer Platz","house_number":"5","city":"München","postal_code":"81669","country_code":"DE"}',
    '{"first_name":"Monika","last_name":"Lange","company":"Bay Solutions AG","street":"Rosenheimer Platz","house_number":"5","city":"München","postal_code":"81669","country_code":"DE"}',
    'invoice', 'pending', NULL, 'PO-BAY-0091', '2025-04-18', NULL, 'de', '195.22.33.44', '2025-03-18 09:00:00'),

-- ── Hamburg / Branch 4 (B4) ────────────────────────────────
(14, 'ORD-2025-B4-00001', 4, 13, 'confirmed',  'standard',  399.00,   0.00,  4.90,  63.72,  403.90, 'EUR', NULL, NULL,
    '{"first_name":"Hannah","last_name":"Schmitt","street":"Eppendorfer Baum","house_number":"23","city":"Hamburg","postal_code":"20249","country_code":"DE"}',
    '{"first_name":"Hannah","last_name":"Schmitt","street":"Eppendorfer Baum","house_number":"23","city":"Hamburg","postal_code":"20249","country_code":"DE"}',
    'paypal', 'paid', '2025-03-18 21:10:00', NULL, NULL, NULL, 'de', '212.15.67.99', '2025-03-18 21:00:00'),

(15, 'ORD-2025-B4-00002', 4, 14, 'processing', 'standard', 9246.00, 462.30,  0.00,   0.00, 8783.70, 'EUR', 2, 'B2BWILLKOMM',
    '{"first_name":"Bernd","last_name":"Neumann","company":"Nordsee Handel GmbH","street":"Speicherstadt","house_number":"11","city":"Hamburg","postal_code":"20457","country_code":"DE"}',
    '{"first_name":"Bernd","last_name":"Neumann","company":"Nordsee Handel GmbH","street":"Speicherstadt","house_number":"11","city":"Hamburg","postal_code":"20457","country_code":"DE"}',
    'invoice', 'pending', NULL, 'PO-NH-2025-022', '2025-04-19', NULL, 'de', '195.45.33.21', '2025-03-19 08:00:00'),

-- ── Austria / Branch 5 (B5) ────────────────────────────────
(16, 'ORD-2025-B5-00001', 5, 15, 'delivered',  'standard',  429.00,   0.00,  6.90,  71.50,  435.90, 'EUR', NULL, NULL,
    '{"first_name":"Sophie","last_name":"Huber","street":"Mariahilfer Straße","house_number":"105","city":"Wien","postal_code":"1060","country_code":"AT"}',
    '{"first_name":"Sophie","last_name":"Huber","street":"Mariahilfer Straße","house_number":"105","city":"Wien","postal_code":"1060","country_code":"AT"}',
    'credit_card', 'paid', '2025-03-05 18:20:00', NULL, NULL, NULL, 'de', '213.33.44.55', '2025-03-05 18:10:00'),

(17, 'ORD-2025-B5-00002', 5, 16, 'confirmed',  'standard', 3499.00,   0.00,  0.00,   0.00, 3499.00, 'EUR', NULL, NULL,
    '{"first_name":"Wolfgang","last_name":"Gruber","company":"Alpha Technik GmbH","street":"Quellenstraße","house_number":"33","city":"Wien","postal_code":"1100","country_code":"AT"}',
    '{"first_name":"Wolfgang","last_name":"Gruber","company":"Alpha Technik GmbH","street":"Quellenstraße","house_number":"33","city":"Wien","postal_code":"1100","country_code":"AT"}',
    'invoice', 'pending', NULL, 'PO-AT-2025-009', '2025-04-18', NULL, 'de', '195.77.22.11', '2025-03-18 14:00:00');

-- ─────────────────────────────────────────────
--  ORDER ITEMS
-- ─────────────────────────────────────────────
DELETE FROM order_items;
INSERT INTO order_items (order_id, product_id, variant_id, product_name, variant_label, sku, quantity, unit_price, discount_amount, tax_rate, tax_amount, line_total) VALUES
-- Order 1: iPhone 16 Pro + AirPods Pro 4
(1, 3, 8,  'Apple iPhone 16 Pro',         'Desert Titanium, 256 GB', 'SPH-APP-IP16P-256-DST', 1, 1329.00, 0.00, 19.00, 212.25, 1329.00),
(1,15,20,  'Apple AirPods Pro (4. Gen.)', 'Weiß',                    'AUD-APL-APP4-MAGSAFE',  1,  279.00, 0.00, 19.00,  44.54,  279.00),
-- Order 2: Dell XPS 15 (B2B)
(2, 9,NULL,'Dell XPS 15 (9530) i7',       NULL,                      'LPT-DEL-XPS-15-I7',     1, 2299.00, 0.00,  0.00,   0.00, 2299.00),
-- Order 3: AirPods Pro 4
(3,15,20,  'Apple AirPods Pro (4. Gen.)', 'Weiß',                    'AUD-APL-APP4-MAGSAFE',  1,  279.00, 0.00, 19.00,  44.54,  279.00),
-- Order 4: 3× Dell XPS 15 + 3× Lenovo X1 (B2B, 5% coupon)
(4, 9,NULL,'Dell XPS 15 (9530) i7',       NULL,                      'LPT-DEL-XPS-15-I7',     3, 2299.00, 0.00,  0.00,   0.00, 6897.00),
-- Order 5: Sony WH-1000XM6 (10% Frühling)
(5,12,18,  'Sony WH-1000XM6',             'Schwarz',                 'AUD-SNY-WH1000XM6-BLK', 1,  399.00,39.90, 19.00,  57.59,  399.00),
-- Order 6: iPhone 16 (Abholung)
(6, 4,12,  'Apple iPhone 16',             'Schwarz, 128 GB',         'SPH-APP-IP16-128-BLK',  1,  949.00, 0.00, 19.00, 151.47,  949.00),
-- Order 7: 2× MacBook Air M3 + 2× iPad Pro M4 (B2B)
(7, 7,17,  'Apple MacBook Air 13" M3',    'Silber, 16 GB, 512 GB',   'LPT-APP-MBA-M3-16-512-SL',2,1699.00,0.00, 0.00,   0.00, 3398.00),
(7,20,25,  'Apple iPad Pro 13" M4',       'Silber, 256 GB',          'TAB-APP-IPAP13-256-SLV', 0, 1299.00, 0.00,  0.00,   0.00,    0.00),
-- Order 8: iPhone 16 Pro (Berlin)
(8, 3, 8,  'Apple iPhone 16 Pro',         'Desert Titanium, 256 GB', 'SPH-APP-IP16P-256-DST', 1, 1329.00, 0.00, 19.00, 212.25, 1329.00),
-- Order 9: 2× MacBook Pro M4 + 2× Dell XPS (B2B KleinTec)
(9, 8,NULL,'Apple MacBook Pro M4',         NULL,                      'LPT-APP-MBP-M4-16',     2, 1999.00, 0.00,  0.00,   0.00, 3998.00),
(9, 9,NULL,'Dell XPS 15 (9530) i7',        NULL,                      'LPT-DEL-XPS-15-I7',     0, 2299.00, 0.00,  0.00,   0.00,    0.00),
-- Order 10: AirPods Max (Berlin, 15% coupon)
(10,13,21, 'Apple AirPods Max',            'Midnight Sky',            'AUD-APL-MAX-MN-BLK',    1,  279.00,41.85, 19.00,  37.74,  279.00),
-- Order 11: Sony SRS-XB100 (Berlin)
(11,18,NULL,'Sony SRS-XB100',              NULL,                      'AUD-SON-SRS-XB100',      1,   59.00, 0.00, 19.00,   9.14,   59.00),
-- Order 12: iPhone 16 (München Abholung)
(12, 4,14, 'Apple iPhone 16',             'Schwarz, 256 GB',         'SPH-APP-IP16-256-BLK',  1,  949.00, 0.00, 19.00, 151.47,  949.00),
-- Order 13: 2× Sony A7 IV (München, Bay Solutions B2B)
(13,28,NULL,'Sony Alpha 7 IV Gehäuse',     NULL,                      'CAM-SON-A7IV-BODY',     2, 3299.00, 0.00,  0.00,   0.00, 6598.00),
-- Order 14: Sony WH-1000XM6 (Hamburg)
(14,12,18, 'Sony WH-1000XM6',             'Schwarz',                 'AUD-SNY-WH1000XM6-BLK', 1,  399.00, 0.00, 19.00,  63.72,  399.00),
-- Order 15: 3× iPhone 16 Pro + 3× MacBook Air (Hamburg, Nordsee Handel B2B)
(15, 3,8,  'Apple iPhone 16 Pro',         'Desert Titanium, 256 GB', 'SPH-APP-IP16P-256-DST', 3, 1329.00, 0.00,  0.00,   0.00, 3987.00),
(15, 7,15, 'Apple MacBook Air 13" M3',    'Midnight, 8 GB, 256 GB',  'LPT-APP-MBA-M3-8-256-MN',3,1299.00, 0.00, 0.00,   0.00, 3897.00),
-- Order 16: Nest Thermostat (Austria)
(16,27,NULL,'Google Nest Thermostat',      NULL,                      'SHM-NES-THER-4TH',      1,  149.00, 0.00, 20.00,  24.83,  149.00),
(16,26,28, 'Amazon Echo Dot 5',           'Anthrazit',               'SHM-AMZ-ECHD5-CHAR',    2,   64.99, 0.00, 20.00,  21.66,  129.98),
-- Order 17: Sony A7 IV (Austria, Alpha Technik B2B)
(17,28,NULL,'Sony Alpha 7 IV Gehäuse',     NULL,                      'CAM-SON-A7IV-BODY',     1, 3499.00, 0.00,  0.00,   0.00, 3499.00);

-- ─────────────────────────────────────────────
--  ORDER STATUS HISTORY
-- ─────────────────────────────────────────────
DELETE FROM order_status_history;
INSERT INTO order_status_history (order_id, status, comment, notify_customer, changed_by, created_at) VALUES
( 1,'pending',    'Bestellung eingegangen.',              0, NULL, '2025-01-15 09:58:00'),
( 1,'confirmed',  'Zahlung bestätigt.',                   1, NULL, '2025-01-15 10:05:00'),
( 1,'processing', 'Wird kommissioniert.',                 0, 3,    '2025-01-15 12:00:00'),
( 1,'shipped',    'Versandt per DHL. Tracking: 1234567890.', 1, 3, '2025-01-16 09:30:00'),
( 1,'delivered',  'Zugestellt laut DHL.',                 1, 3,    '2025-01-17 14:00:00'),

( 2,'pending',    'Bestellung eingegangen.',              0, NULL, '2025-01-18 14:20:00'),
( 2,'confirmed',  'Rechnungskauf bestätigt.',             1, 3,    '2025-01-19 09:00:00'),
( 2,'processing', 'Wird vorbereitet.',                    0, 3,    '2025-01-19 11:00:00'),
( 2,'shipped',    'Versandt per Spedition.',              1, 3,    '2025-01-21 10:00:00'),
( 2,'delivered',  'Zugestellt.',                          1, 3,    '2025-01-23 16:00:00'),

( 3,'pending',    'Bestellung eingegangen.',              0, NULL, '2025-02-05 13:10:00'),
( 3,'confirmed',  'Zahlung bestätigt.',                   1, NULL, '2025-02-05 13:22:00'),
( 3,'shipped',    'Versandt.',                            1, 3,    '2025-02-06 08:00:00'),
( 3,'delivered',  'Zugestellt.',                          1, 3,    '2025-02-07 12:00:00'),

( 4,'pending',    'Bestellung eingegangen.',              0, NULL, '2025-02-18 09:30:00'),
( 4,'confirmed',  'B2B-Auftrag bestätigt.',               1, 3,    '2025-02-18 10:00:00'),
( 4,'processing', 'In Bearbeitung.',                      0, 3,    '2025-02-19 09:00:00'),
( 4,'shipped',    'Versandt per Spedition.',              1, 3,    '2025-02-20 11:00:00'),

( 5,'pending',    'Bestellung eingegangen.',              0, NULL, '2025-03-12 15:20:00'),
( 5,'confirmed',  'PayPal-Zahlung bestätigt.',            1, NULL, '2025-03-12 15:30:00'),
( 5,'processing', 'Wird kommissioniert.',                 0, 3,    '2025-03-13 09:00:00'),

( 6,'pending',    'Bestellung zur Abholung eingegangen.',  0, NULL, '2025-03-17 11:35:00'),
( 6,'confirmed',  'Zahlung OK. Bereit zur Abholung.',      1, 3,   '2025-03-17 11:45:00'),

( 7,'pending',    'B2B-Bestellung eingegangen.',          0, NULL, '2025-03-19 10:00:00'),
( 7,'confirmed',  'Rechnungskauf genehmigt.',             1, 3,    '2025-03-19 11:00:00'),
( 7,'processing', 'Wird zusammengestellt.',               0, 3,    '2025-03-19 14:00:00'),

( 8,'pending',    'Bestellung eingegangen.',              0, NULL, '2025-01-22 09:00:00'),
( 8,'confirmed',  'Zahlung bestätigt.',                   1, NULL, '2025-01-22 09:15:00'),
( 8,'shipped',    'Versandt.',                            1, 4,    '2025-01-23 08:30:00'),
( 8,'delivered',  'Zugestellt.',                          1, 4,    '2025-01-24 14:00:00'),

( 9,'pending',    'B2B-Auftrag eingegangen.',             0, NULL, '2025-02-22 16:00:00'),
( 9,'confirmed',  'Bestätigt.',                           1, 4,    '2025-02-23 09:00:00'),
( 9,'processing', 'In Bearbeitung.',                      0, 4,    '2025-02-24 10:00:00'),
( 9,'shipped',    'Versandt per Spedition.',              1, 4,    '2025-02-25 09:30:00'),
( 9,'delivered',  'Zugestellt.',                          1, 4,    '2025-02-27 16:00:00'),

(10,'pending',    'Bestellung eingegangen.',              0, NULL, '2025-03-16 19:55:00'),
(10,'confirmed',  'PayPal-Zahlung bestätigt.',            1, NULL, '2025-03-16 20:01:00'),

(11,'pending',    'Bestellung eingegangen.',              0, NULL, '2025-03-19 08:40:00'),
(11,'confirmed',  'Zahlung bestätigt.',                   1, NULL, '2025-03-19 08:45:00'),

(12,'pending',    'Abholung angemeldet.',                 0, NULL, '2025-02-27 10:00:00'),
(12,'confirmed',  'Zahlung bestätigt. Zur Abholung bereit.', 1, 5, '2025-02-28 09:00:00'),
(12,'delivered',  'Abgeholt.',                            0, 5,    '2025-02-28 14:00:00'),

(13,'pending',    'B2B-Auftrag eingegangen.',             0, NULL, '2025-03-18 09:00:00'),
(13,'confirmed',  'Bestätigt.',                           1, 5,    '2025-03-18 10:00:00'),
(13,'processing', 'In Bearbeitung.',                      0, 5,    '2025-03-18 13:00:00'),
(13,'shipped',    'Versandt.',                            1, 5,    '2025-03-19 10:00:00'),

(14,'pending',    'Bestellung eingegangen.',              0, NULL, '2025-03-18 21:00:00'),
(14,'confirmed',  'PayPal-Zahlung bestätigt.',            1, NULL, '2025-03-18 21:10:00'),

(15,'pending',    'Großauftrag B2B eingegangen.',         0, NULL, '2025-03-19 08:00:00'),
(15,'confirmed',  'Rechnungskauf genehmigt.',             1, 6,    '2025-03-19 09:00:00'),
(15,'processing', 'Wird vorbereitet.',                    0, 6,    '2025-03-19 13:00:00'),

(16,'pending',    'Bestellung eingegangen.',              0, NULL, '2025-03-05 18:10:00'),
(16,'confirmed',  'Zahlung bestätigt.',                   1, NULL, '2025-03-05 18:20:00'),
(16,'shipped',    'Versandt nach Österreich.',            1, 2,    '2025-03-06 09:00:00'),
(16,'delivered',  'Zugestellt.',                          1, 2,    '2025-03-08 14:00:00'),

(17,'pending',    'B2B-Auftrag Österreich eingegangen.', 0, NULL, '2025-03-18 14:00:00'),
(17,'confirmed',  'Bestätigt.',                           1, 2,    '2025-03-18 15:00:00');
