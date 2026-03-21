-- Database Upgrade Script for Roles (Waiter Module Support)

-- 1. Truncate the roles table to clear old data
TRUNCATE TABLE `roles`;

-- 2. Insert the updated roles (superadmin, admin, manager, waiter)
-- Note: Assuming restaurant_id = 1 for the default/base restaurant. You may need to duplicate these roles for other restaurant_ids if applicable.
INSERT INTO `roles` (`role_id`, `restaurant_id`, `name`, `description`, `is_system`, `added_by`) VALUES
(1, 1, 'superadmin', 'System Super Administrator', 1, 1),
(2, 1, 'admin', 'Restaurant Administrator', 1, 1),
(3, 1, 'manager', 'Restaurant Manager', 1, 1),
(4, 1, 'waiter', 'Waiter / Service Staff', 0, 1);


ALTER TABLE users 
ADD COLUMN reset_token VARCHAR(255) DEFAULT NULL,
ADD COLUMN token_expiry DATETIME DEFAULT NULL;
 
-- 3. Subscription Module Tables
CREATE TABLE IF NOT EXISTS `subscription_plans` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `restaurant_id` INT NOT NULL,
    `plan_name` VARCHAR(255) NOT NULL,
    `price` DECIMAL(10, 2) NOT NULL,
    `validity` VARCHAR(100) NOT NULL, -- e.g., '30 Days', '1 Year'
    `features` TEXT, -- Feature list as JSON or text
    `is_active` tinyint(1) NOT NULL DEFAULT '1',
    `added_by` bigint UNSIGNED NOT NULL,
    `updated_by` bigint UNSIGNED DEFAULT NULL,
    `added_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS `restaurant_subscriptions` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `restaurant_id` INT NOT NULL,
    `plan_id` INT NOT NULL,
    `activation_date` DATE NOT NULL,
    `expiry_date` DATE NOT NULL,
    `status` ENUM('ACTIVE', 'EXPIRED', 'CANCELLED') DEFAULT 'ACTIVE',
    `payment_id` VARCHAR(255) DEFAULT NULL,
    `added_by` bigint UNSIGNED NOT NULL,
    `updated_by` bigint UNSIGNED DEFAULT NULL,
    `added_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- 4. Initial/Sample Subscription Plans
INSERT INTO `subscription_plans` (`restaurant_id`, `plan_name`, `price`, `validity`, `features`, `is_active`, `added_by`) VALUES
(1, 'Starter Pack', 499.00, '30 Days', 'Basic Table Management\nDigital Menu Access\nDaily Sales Report', 1, 1),
(1, 'Professional Plan', 999.00, '90 Days', 'Advanced Analytics\nKitchen Display System\nPriority Support\nInventory Tracking', 1, 1),
(1, 'Enterprise Yearly', 4999.00, '365 Days', 'Multi-restaurant Management\nCustom Branding\nDedicated Manager\nUnlimited Staff Accounts', 1, 1);

CREATE TABLE IF NOT EXISTS `payment_transactions` (
    `payment_transaction_id` INT AUTO_INCREMENT PRIMARY KEY,
    `transaction_id` VARCHAR(255) NOT NULL,
    `order_id` VARCHAR(255) DEFAULT NULL,
    `user_id` INT NOT NULL,
    `amount` DECIMAL(10, 2) NOT NULL,
    `subscription_id` INT DEFAULT NULL,
    `error_code` VARCHAR(100) DEFAULT NULL,
    `error_description` TEXT,
    `status` VARCHAR(50) DEFAULT 'success',
    `response_json` TEXT,
    `added_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
);
-- 5. Restaurant GST Configuration
-- Adds GST fields to the restaurants table with safe defaults for existing records
ALTER TABLE `restaurants`
    ADD COLUMN `gst_applicable` ENUM('yes','no') NOT NULL DEFAULT 'no' COMMENT 'Whether GST is applicable for this restaurant',
    ADD COLUMN `gst_percentage` DECIMAL(5,2) NOT NULL DEFAULT 0.00 COMMENT 'GST percentage (0-100)';
