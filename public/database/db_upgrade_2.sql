-- Database Upgrade Script 2
-- Adds GST configurations and operating hours to restaurants table

ALTER TABLE `restaurants`
ADD COLUMN `gst_applicable` ENUM('yes', 'no') NOT NULL DEFAULT 'no' AFTER `gstin`,
ADD COLUMN `gst_percentage` DECIMAL(5,2) DEFAULT 0 AFTER `gst_applicable`,
ADD COLUMN `start_time` TIME DEFAULT NULL AFTER `gst_percentage`,
ADD COLUMN `end_time` TIME DEFAULT NULL AFTER `start_time`;
