-- Database Upgrade Script for Order Management Flow

-- 1. Update Dining Tables status enum to include CLEANING
ALTER TABLE `dining_tables` 
MODIFY COLUMN `status` ENUM('FREE', 'OCCUPIED', 'RESERVED', 'BLOCKED', 'CLEANING') NOT NULL DEFAULT 'FREE';

-- 2. Add order_number to orders table
ALTER TABLE `orders` 
ADD COLUMN `order_number` VARCHAR(50) AFTER `order_id`;

-- 3. Update orders status to include RUNNING (mapping Running -> PLACED or adding it)
ALTER TABLE `orders` 
MODIFY COLUMN `status` ENUM('PLACED', 'RUNNING', 'PREPARING', 'READY', 'SERVED', 'COMPLETED', 'CANCELLED') NOT NULL DEFAULT 'PLACED';

-- 4. Add status to order_items for kitchen tracking
ALTER TABLE `order_items` 
ADD COLUMN `status` ENUM('PENDING', 'PREPARING', 'READY', 'SERVED') NOT NULL DEFAULT 'PENDING' AFTER `notes`;

-- 5. Ensure order_items can store instructions/notes (already exists)
-- 6. Ensure payments can handle different methods (already exists)
