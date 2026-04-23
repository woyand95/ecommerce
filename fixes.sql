-- 1. Table `api_tokens`
CREATE TABLE `api_tokens` (
    `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
    `customer_id` INT(10) UNSIGNED NOT NULL,
    `token` VARCHAR(64) NOT NULL,
    `is_revoked` TINYINT(1) DEFAULT 0,
    `expires_at` DATETIME NOT NULL,
    `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    UNIQUE KEY `idx_token` (`token`),
    KEY `idx_customer` (`customer_id`),
    CONSTRAINT `api_tokens_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 2. Table `customer_sessions`
CREATE TABLE `customer_sessions` (
    `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
    `customer_id` INT(10) UNSIGNED NOT NULL,
    `token` VARCHAR(64) NOT NULL,
    `expires_at` DATETIME NOT NULL,
    `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    UNIQUE KEY `idx_token` (`token`),
    KEY `idx_customer` (`customer_id`),
    CONSTRAINT `customer_sessions_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 3. Table `customer_documents`
CREATE TABLE `customer_documents` (
    `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
    `customer_id` INT(10) UNSIGNED NOT NULL,
    `document_type` VARCHAR(50) NOT NULL,
    `file_path` VARCHAR(255) NOT NULL,
    `original_filename` VARCHAR(255) NOT NULL,
    `file_size` INT(10) UNSIGNED NOT NULL,
    `mime_type` VARCHAR(100) NOT NULL,
    `status` ENUM('pending','approved','rejected') DEFAULT 'pending',
    `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP,
    `updated_at` DATETIME DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    KEY `idx_customer` (`customer_id`),
    CONSTRAINT `customer_documents_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 4. Table `campaign_uses`
CREATE TABLE `campaign_uses` (
    `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
    `campaign_id` INT(10) UNSIGNED NOT NULL,
    `customer_id` INT(10) UNSIGNED NOT NULL,
    `used_at` DATETIME DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    KEY `idx_campaign` (`campaign_id`),
    KEY `idx_customer` (`customer_id`),
    CONSTRAINT `campaign_uses_ibfk_1` FOREIGN KEY (`campaign_id`) REFERENCES `campaigns` (`id`) ON DELETE CASCADE,
    CONSTRAINT `campaign_uses_ibfk_2` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 5. Table `campaign_translations`
CREATE TABLE `campaign_translations` (
    `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
    `campaign_id` INT(10) UNSIGNED NOT NULL,
    `lang_code` VARCHAR(10) NOT NULL,
    `title` VARCHAR(200) NOT NULL,
    `description` TEXT DEFAULT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `uq_campaign_lang` (`campaign_id`,`lang_code`),
    CONSTRAINT `campaign_translations_ibfk_1` FOREIGN KEY (`campaign_id`) REFERENCES `campaigns` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 6. Table `order_addresses`
CREATE TABLE `order_addresses` (
    `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
    `order_id` INT(10) UNSIGNED NOT NULL,
    `address_type` ENUM('billing','shipping') NOT NULL,
    `first_name` VARCHAR(80) DEFAULT NULL,
    `last_name` VARCHAR(80) DEFAULT NULL,
    `company` VARCHAR(200) DEFAULT NULL,
    `street` VARCHAR(255) NOT NULL,
    `address_line2` VARCHAR(255) DEFAULT NULL,
    `city` VARCHAR(100) NOT NULL,
    `postal_code` VARCHAR(20) NOT NULL,
    `country_code` CHAR(2) NOT NULL,
    `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    KEY `idx_order` (`order_id`),
    CONSTRAINT `order_addresses_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 7. Modify `customers` table
-- The column `type` is enum('private', 'company'). The code expects `customer_type`.
ALTER TABLE `customers` CHANGE `type` `customer_type` ENUM('private','company', 'B2C', 'B2B') NOT NULL DEFAULT 'private';

-- 8. Modify `campaigns` table
-- The code expects `campaign_type` column for distinction between promotion and coupon.
ALTER TABLE `campaigns` ADD COLUMN `campaign_type` ENUM('promotion','coupon') NOT NULL DEFAULT 'coupon' AFTER `code`;
