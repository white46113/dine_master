-- Database Upgrade Script
-- Added table_no column to dining_tables table

ALTER TABLE `dining_tables` ADD COLUMN `table_no` VARCHAR(50) AFTER `code`;
UPDATE `dining_tables` SET `table_no` = `code`;
