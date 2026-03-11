-- phpMyAdmin SQL Dump
-- version 5.1.1deb5ubuntu1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Mar 11, 2026 at 04:09 PM
-- Server version: 8.0.45-0ubuntu0.22.04.1
-- PHP Version: 8.1.2-1ubuntu2.23

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `dine_master`
--

-- --------------------------------------------------------

--
-- Table structure for table `addon_groups`
--

CREATE TABLE `addon_groups` (
  `addon_group_id` bigint UNSIGNED NOT NULL,
  `restaurant_id` bigint UNSIGNED NOT NULL,
  `name` varchar(120) COLLATE utf8mb4_general_ci NOT NULL,
  `min_select` int NOT NULL DEFAULT '0',
  `max_select` int NOT NULL DEFAULT '5',
  `is_required` tinyint(1) NOT NULL DEFAULT '0',
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `added_by` bigint UNSIGNED NOT NULL,
  `updated_by` bigint UNSIGNED DEFAULT NULL,
  `added_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `addon_groups`
--

INSERT INTO `addon_groups` (`addon_group_id`, `restaurant_id`, `name`, `min_select`, `max_select`, `is_required`, `is_active`, `added_by`, `updated_by`, `added_date`, `updated_date`) VALUES
(1, 1, 'Addon Group 1', 0, 3, 1, 1, 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(2, 1, 'Addon Group 2', 0, 3, 0, 1, 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(3, 2, 'Addon Group 1', 0, 3, 0, 1, 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(4, 2, 'Addon Group 2', 0, 3, 1, 1, 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(5, 3, 'Addon Group 1', 0, 3, 1, 1, 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(6, 3, 'Addon Group 2', 0, 3, 1, 1, 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(7, 4, 'Addon Group 1', 0, 3, 0, 1, 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(8, 4, 'Addon Group 2', 0, 3, 0, 1, 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(9, 5, 'Addon Group 1', 0, 3, 0, 1, 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(10, 5, 'Addon Group 2', 0, 3, 0, 1, 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(11, 6, 'Addon Group 1', 0, 3, 1, 1, 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(12, 6, 'Addon Group 2', 0, 3, 0, 1, 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(13, 7, 'Addon Group 1', 0, 3, 1, 1, 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(14, 7, 'Addon Group 2', 0, 3, 1, 1, 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(15, 8, 'Addon Group 1', 0, 3, 1, 1, 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(16, 8, 'Addon Group 2', 0, 3, 1, 1, 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(17, 9, 'Addon Group 1', 0, 3, 1, 1, 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(18, 9, 'Addon Group 2', 0, 3, 1, 1, 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(19, 10, 'Addon Group 1', 0, 3, 1, 1, 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(20, 10, 'Addon Group 2', 0, 3, 1, 1, 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39');

-- --------------------------------------------------------

--
-- Table structure for table `addon_options`
--

CREATE TABLE `addon_options` (
  `addon_option_id` bigint UNSIGNED NOT NULL,
  `addon_group_id` bigint UNSIGNED NOT NULL,
  `name` varchar(120) COLLATE utf8mb4_general_ci NOT NULL,
  `price_delta` decimal(10,2) NOT NULL DEFAULT '0.00',
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `sort_order` int NOT NULL DEFAULT '0',
  `added_by` bigint UNSIGNED NOT NULL,
  `updated_by` bigint UNSIGNED DEFAULT NULL,
  `added_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `addon_options`
--

INSERT INTO `addon_options` (`addon_option_id`, `addon_group_id`, `name`, `price_delta`, `is_active`, `sort_order`, `added_by`, `updated_by`, `added_date`, `updated_date`) VALUES
(1, 1, 'Option 1', '11.00', 1, 1, 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(2, 1, 'Option 2', '26.00', 1, 2, 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(3, 1, 'Option 3', '16.00', 1, 3, 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(4, 2, 'Option 1', '32.00', 1, 1, 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(5, 2, 'Option 2', '20.00', 1, 2, 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(6, 2, 'Option 3', '45.00', 1, 3, 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(7, 3, 'Option 1', '42.00', 1, 1, 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(8, 3, 'Option 2', '32.00', 1, 2, 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(9, 3, 'Option 3', '10.00', 1, 3, 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(10, 4, 'Option 1', '45.00', 1, 1, 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(11, 4, 'Option 2', '10.00', 1, 2, 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(12, 4, 'Option 3', '28.00', 1, 3, 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(13, 5, 'Option 1', '47.00', 1, 1, 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(14, 5, 'Option 2', '10.00', 1, 2, 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(15, 5, 'Option 3', '50.00', 1, 3, 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(16, 6, 'Option 1', '34.00', 1, 1, 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(17, 6, 'Option 2', '38.00', 1, 2, 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(18, 6, 'Option 3', '26.00', 1, 3, 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(19, 7, 'Option 1', '16.00', 1, 1, 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(20, 7, 'Option 2', '13.00', 1, 2, 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(21, 7, 'Option 3', '49.00', 1, 3, 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(22, 8, 'Option 1', '35.00', 1, 1, 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(23, 8, 'Option 2', '34.00', 1, 2, 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(24, 8, 'Option 3', '40.00', 1, 3, 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(25, 9, 'Option 1', '46.00', 1, 1, 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(26, 9, 'Option 2', '34.00', 1, 2, 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(27, 9, 'Option 3', '42.00', 1, 3, 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(28, 10, 'Option 1', '31.00', 1, 1, 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(29, 10, 'Option 2', '41.00', 1, 2, 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(30, 10, 'Option 3', '10.00', 1, 3, 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(31, 11, 'Option 1', '47.00', 1, 1, 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(32, 11, 'Option 2', '13.00', 1, 2, 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(33, 11, 'Option 3', '11.00', 1, 3, 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(34, 12, 'Option 1', '11.00', 1, 1, 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(35, 12, 'Option 2', '24.00', 1, 2, 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(36, 12, 'Option 3', '50.00', 1, 3, 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(37, 13, 'Option 1', '15.00', 1, 1, 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(38, 13, 'Option 2', '40.00', 1, 2, 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(39, 13, 'Option 3', '32.00', 1, 3, 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(40, 14, 'Option 1', '26.00', 1, 1, 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(41, 14, 'Option 2', '12.00', 1, 2, 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(42, 14, 'Option 3', '17.00', 1, 3, 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(43, 15, 'Option 1', '42.00', 1, 1, 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(44, 15, 'Option 2', '43.00', 1, 2, 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(45, 15, 'Option 3', '21.00', 1, 3, 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(46, 16, 'Option 1', '14.00', 1, 1, 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(47, 16, 'Option 2', '35.00', 1, 2, 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(48, 16, 'Option 3', '12.00', 1, 3, 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(49, 17, 'Option 1', '44.00', 1, 1, 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(50, 17, 'Option 2', '20.00', 1, 2, 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(51, 17, 'Option 3', '29.00', 1, 3, 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(52, 18, 'Option 1', '37.00', 1, 1, 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(53, 18, 'Option 2', '25.00', 1, 2, 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(54, 18, 'Option 3', '15.00', 1, 3, 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(55, 19, 'Option 1', '50.00', 1, 1, 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(56, 19, 'Option 2', '15.00', 1, 2, 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(57, 19, 'Option 3', '34.00', 1, 3, 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(58, 20, 'Option 1', '20.00', 1, 1, 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(59, 20, 'Option 2', '22.00', 1, 2, 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(60, 20, 'Option 3', '32.00', 1, 3, 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39');

-- --------------------------------------------------------

--
-- Table structure for table `bills`
--

CREATE TABLE `bills` (
  `bill_id` bigint UNSIGNED NOT NULL,
  `restaurant_id` bigint UNSIGNED NOT NULL,
  `order_id` bigint UNSIGNED NOT NULL,
  `bill_number` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `status` enum('OPEN','ISSUED','VOID') COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'OPEN',
  `subtotal_amount` decimal(12,2) NOT NULL DEFAULT '0.00',
  `discount_amount` decimal(12,2) NOT NULL DEFAULT '0.00',
  `service_charge_amt` decimal(12,2) NOT NULL DEFAULT '0.00',
  `tax_amount` decimal(12,2) NOT NULL DEFAULT '0.00',
  `rounding_adjustment` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_payable` decimal(12,2) NOT NULL DEFAULT '0.00',
  `tax_breakdown` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `issued_at` datetime DEFAULT NULL,
  `pdf_url` varchar(500) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `added_by` bigint UNSIGNED NOT NULL,
  `updated_by` bigint UNSIGNED DEFAULT NULL,
  `added_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ;

--
-- Dumping data for table `bills`
--

INSERT INTO `bills` (`bill_id`, `restaurant_id`, `order_id`, `bill_number`, `status`, `subtotal_amount`, `discount_amount`, `service_charge_amt`, `tax_amount`, `rounding_adjustment`, `total_payable`, `tax_breakdown`, `issued_at`, `pdf_url`, `added_by`, `updated_by`, `added_date`, `updated_date`) VALUES
(1, 1, 1, 'BILL057', 'OPEN', '436.00', '0.00', '10.00', '5.00', '0.00', '115.00', '{\"cgst\": 2.5, \"sgst\": 2.5}', NULL, NULL, 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(2, 1, 2, 'BILL208', 'OPEN', '410.00', '0.00', '10.00', '5.00', '0.00', '115.00', '{\"cgst\": 2.5, \"sgst\": 2.5}', NULL, NULL, 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(3, 2, 3, 'BILL094', 'OPEN', '117.00', '0.00', '10.00', '5.00', '0.00', '115.00', '{\"cgst\": 2.5, \"sgst\": 2.5}', NULL, NULL, 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(4, 2, 4, 'BILL099', 'OPEN', '276.00', '0.00', '10.00', '5.00', '0.00', '115.00', '{\"cgst\": 2.5, \"sgst\": 2.5}', NULL, NULL, 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(5, 3, 5, 'BILL377', 'OPEN', '367.00', '0.00', '10.00', '5.00', '0.00', '115.00', '{\"cgst\": 2.5, \"sgst\": 2.5}', NULL, NULL, 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(6, 3, 6, 'BILL457', 'OPEN', '169.00', '0.00', '10.00', '5.00', '0.00', '115.00', '{\"cgst\": 2.5, \"sgst\": 2.5}', NULL, NULL, 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(7, 4, 7, 'BILL944', 'OPEN', '401.00', '0.00', '10.00', '5.00', '0.00', '115.00', '{\"cgst\": 2.5, \"sgst\": 2.5}', NULL, NULL, 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(8, 4, 8, 'BILL941', 'OPEN', '160.00', '0.00', '10.00', '5.00', '0.00', '115.00', '{\"cgst\": 2.5, \"sgst\": 2.5}', NULL, NULL, 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(9, 5, 9, 'BILL536', 'OPEN', '163.00', '0.00', '10.00', '5.00', '0.00', '115.00', '{\"cgst\": 2.5, \"sgst\": 2.5}', NULL, NULL, 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(10, 5, 10, 'BILL325', 'OPEN', '323.00', '0.00', '10.00', '5.00', '0.00', '115.00', '{\"cgst\": 2.5, \"sgst\": 2.5}', NULL, NULL, 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(11, 6, 11, 'BILL189', 'OPEN', '353.00', '0.00', '10.00', '5.00', '0.00', '115.00', '{\"cgst\": 2.5, \"sgst\": 2.5}', NULL, NULL, 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(12, 6, 12, 'BILL519', 'OPEN', '448.00', '0.00', '10.00', '5.00', '0.00', '115.00', '{\"cgst\": 2.5, \"sgst\": 2.5}', NULL, NULL, 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(13, 7, 13, 'BILL399', 'OPEN', '465.00', '0.00', '10.00', '5.00', '0.00', '115.00', '{\"cgst\": 2.5, \"sgst\": 2.5}', NULL, NULL, 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(14, 7, 14, 'BILL965', 'OPEN', '349.00', '0.00', '10.00', '5.00', '0.00', '115.00', '{\"cgst\": 2.5, \"sgst\": 2.5}', NULL, NULL, 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(15, 8, 15, 'BILL883', 'OPEN', '461.00', '0.00', '10.00', '5.00', '0.00', '115.00', '{\"cgst\": 2.5, \"sgst\": 2.5}', NULL, NULL, 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(16, 8, 16, 'BILL624', 'OPEN', '115.00', '0.00', '10.00', '5.00', '0.00', '115.00', '{\"cgst\": 2.5, \"sgst\": 2.5}', NULL, NULL, 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(17, 9, 17, 'BILL017', 'OPEN', '326.00', '0.00', '10.00', '5.00', '0.00', '115.00', '{\"cgst\": 2.5, \"sgst\": 2.5}', NULL, NULL, 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(18, 9, 18, 'BILL235', 'OPEN', '384.00', '0.00', '10.00', '5.00', '0.00', '115.00', '{\"cgst\": 2.5, \"sgst\": 2.5}', NULL, NULL, 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(19, 10, 19, 'BILL198', 'OPEN', '121.00', '0.00', '10.00', '5.00', '0.00', '115.00', '{\"cgst\": 2.5, \"sgst\": 2.5}', NULL, NULL, 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(20, 10, 20, 'BILL149', 'OPEN', '226.00', '0.00', '10.00', '5.00', '0.00', '115.00', '{\"cgst\": 2.5, \"sgst\": 2.5}', NULL, NULL, 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39');

-- --------------------------------------------------------

--
-- Table structure for table `bill_items`
--

CREATE TABLE `bill_items` (
  `bill_item_id` bigint UNSIGNED NOT NULL,
  `bill_id` bigint UNSIGNED NOT NULL,
  `order_item_id` bigint UNSIGNED NOT NULL,
  `allocated_qty` decimal(10,2) NOT NULL,
  `line_subtotal` decimal(12,2) NOT NULL DEFAULT '0.00',
  `line_discount` decimal(12,2) NOT NULL DEFAULT '0.00',
  `tax_amount` decimal(12,2) NOT NULL DEFAULT '0.00',
  `line_total` decimal(12,2) NOT NULL DEFAULT '0.00',
  `added_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `added_by` bigint UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `category_id` bigint UNSIGNED NOT NULL,
  `restaurant_id` bigint UNSIGNED NOT NULL,
  `name` varchar(120) COLLATE utf8mb4_general_ci NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `sort_order` int NOT NULL DEFAULT '0',
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `added_by` bigint UNSIGNED NOT NULL,
  `updated_by` bigint UNSIGNED DEFAULT NULL,
  `added_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`category_id`, `restaurant_id`, `name`, `description`, `sort_order`, `is_active`, `added_by`, `updated_by`, `added_date`, `updated_date`) VALUES
(1, 1, 'Starters', 'A molestias numquam consequatur ipsa voluptatem itaque.', 7, 1, 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(2, 1, 'Mains', 'Architecto culpa dolorum doloremque eos et aspernatur quia.', 4, 1, 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(3, 1, 'Beverages', 'Asperiores optio dolor illum et nam rerum enim.', 7, 1, 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(4, 1, 'Desserts', 'Molestias excepturi itaque accusantium sit et id esse quia.', 4, 1, 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(5, 2, 'Starters', 'Officiis est accusamus quod omnis hic velit et enim.', 6, 1, 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(6, 2, 'Mains', 'Asperiores quia porro blanditiis dicta quo quam.', 9, 1, 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(7, 2, 'Beverages', 'Placeat blanditiis ut quasi et culpa assumenda ea tempore.', 10, 1, 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(8, 2, 'Desserts', 'Reprehenderit quos asperiores animi dolorem dicta.', 8, 1, 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(9, 3, 'Starters', 'Sint fugiat qui quae sed.', 4, 1, 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(10, 3, 'Mains', 'Et voluptatem sed non in sed.', 2, 1, 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(11, 3, 'Beverages', 'Ea dolorum debitis commodi illo eos cumque.', 4, 1, 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(12, 3, 'Desserts', 'Voluptates aut sequi libero quaerat quibusdam alias.', 4, 1, 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(13, 4, 'Starters', 'Perferendis enim vitae corrupti ratione aut.', 4, 1, 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(14, 4, 'Mains', 'Illo harum rem iste magni rem ullam voluptatem perspiciatis.', 8, 1, 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(15, 4, 'Beverages', 'Et et voluptate rerum laborum.', 5, 1, 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(16, 4, 'Desserts', 'In non temporibus sunt aut amet.', 4, 1, 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(17, 5, 'Starters', 'Eveniet libero ex nihil quisquam labore voluptas tempora.', 3, 1, 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(18, 5, 'Mains', 'Dolores vitae reprehenderit laborum repellat non tempora aperiam.', 9, 1, 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(19, 5, 'Beverages', 'Voluptas rem veniam doloremque.', 8, 1, 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(20, 5, 'Desserts', 'Sapiente temporibus velit vel.', 10, 1, 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(21, 6, 'Starters', 'Voluptatem ullam aut eius.', 3, 1, 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(22, 6, 'Mains', 'Et possimus qui dolores qui culpa.', 4, 1, 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(23, 6, 'Beverages', 'Occaecati omnis nam ad et rerum autem et.', 2, 1, 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(24, 6, 'Desserts', 'Dolores hic quas odio nihil modi praesentium aspernatur.', 1, 1, 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(25, 7, 'Starters', 'Aliquam ex sapiente sapiente qui molestiae rerum et.', 7, 1, 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(26, 7, 'Mains', 'Laborum laborum non esse quis.', 6, 1, 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(27, 7, 'Beverages', 'Facilis dolores ut sunt dolor esse sit pariatur.', 6, 1, 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(28, 7, 'Desserts', 'Eos dicta id rerum aperiam tempore.', 9, 1, 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(29, 8, 'Starters', 'Accusantium quis iure consequatur repellendus et animi.', 9, 1, 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(30, 8, 'Mains', 'Labore labore ut facilis cum non.', 1, 1, 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(31, 8, 'Beverages', 'Ea omnis esse officiis et dolore eum.', 6, 1, 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(32, 8, 'Desserts', 'Quibusdam quis reiciendis voluptas eum et.', 1, 1, 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(33, 9, 'Starters', 'Dolorem tempora necessitatibus numquam aut.', 3, 1, 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(34, 9, 'Mains', 'Perferendis consectetur doloremque ullam dicta.', 3, 1, 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(35, 9, 'Beverages', 'Sed ut dolor molestias voluptatem.', 10, 1, 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(36, 9, 'Desserts', 'Velit architecto voluptatem numquam aliquam eos tenetur optio.', 6, 1, 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(37, 10, 'Starters', 'Eum harum similique nihil sunt ipsa dolorem.', 7, 1, 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(38, 10, 'Mains', 'Harum modi earum eos dolores amet praesentium quos.', 5, 1, 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(39, 10, 'Beverages', 'Autem accusantium sed corrupti dolores dicta qui.', 1, 1, 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(40, 10, 'Desserts', 'Assumenda maxime laboriosam ut sequi non cum.', 3, 1, 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39');

-- --------------------------------------------------------

--
-- Table structure for table `config_setting`
--

CREATE TABLE `config_setting` (
  `id` int NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `value` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `type` enum('check_box','input','date','file') COLLATE utf8mb4_general_ci NOT NULL,
  `company_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

CREATE TABLE `customers` (
  `customer_id` bigint UNSIGNED NOT NULL,
  `restaurant_id` bigint UNSIGNED NOT NULL,
  `name` varchar(150) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `phone` varchar(25) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `email` varchar(150) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `notes` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `added_by` bigint UNSIGNED NOT NULL,
  `updated_by` bigint UNSIGNED DEFAULT NULL,
  `added_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `customers`
--

INSERT INTO `customers` (`customer_id`, `restaurant_id`, `name`, `phone`, `email`, `notes`, `is_active`, `added_by`, `updated_by`, `added_date`, `updated_date`) VALUES
(1, 1, 'Dr. Annabell Shields DDS', '404-309-3755', 'sanford.declan@cummerata.info', 'Beatae porro qui quis beatae nihil.', 1, 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(2, 1, 'Daniela Walker', '+1.248.837.1612', 'douglas.mara@gmail.com', 'Similique ullam laboriosam unde ullam est excepturi vero.', 1, 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(3, 1, 'Prof. Winston Hintz III', '757-952-8732', 'benton.swift@erdman.com', 'Nihil itaque neque repellat et.', 1, 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(4, 1, 'Aubrey O\'Hara', '719.592.8562', 'berge.daphne@gmail.com', 'Eum sit debitis voluptatem numquam molestiae non exercitationem.', 1, 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(5, 1, 'Arno Eichmann', '(301) 894-4237', 'tullrich@dickens.com', 'Excepturi placeat reiciendis eum.', 1, 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(6, 2, 'Sigmund Leffler', '1-231-317-6263', 'garfield18@hotmail.com', 'Et ipsum temporibus esse cumque vel non eveniet.', 1, 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(7, 2, 'Marcella Koelpin DDS', '+1.773.822.9649', 'lkunde@schultz.net', 'Laborum deleniti deleniti ipsam non ullam.', 1, 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(8, 2, 'Noemie O\'Conner', '+1 (520) 726-3141', 'kreinger@yahoo.com', 'Id adipisci odio voluptatem nam dolorem molestiae.', 1, 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(9, 2, 'Nannie Doyle', '+1.928.530.3639', 'brandyn61@gmail.com', 'Saepe dolorem recusandae eum sint alias.', 1, 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(10, 2, 'Gabriel Green', '+1 (720) 992-4628', 'kayden.lynch@hamill.net', 'Magni consequatur quasi voluptas qui.', 1, 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(11, 3, 'Daija Osinski Sr.', '+1 (540) 624-9364', 'pinkie.leuschke@anderson.com', 'Porro non labore sunt laudantium.', 1, 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(12, 3, 'Charles Swaniawski', '1-458-454-4786', 'considine.matilda@shields.biz', 'Quis nam et ut voluptas non explicabo quasi.', 1, 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(13, 3, 'Reece Sipes', '+1 (469) 612-3842', 'quincy90@hotmail.com', 'Molestiae sed eos inventore.', 1, 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(14, 3, 'Jaycee Boyer', '(364) 371-7164', 'langosh.bertha@mohr.com', 'Ea quidem minima sint cum aut.', 1, 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(15, 3, 'Garrett Rogahn Jr.', '(707) 422-4880', 'zhaag@gmail.com', 'Beatae qui deleniti voluptatibus eveniet qui.', 1, 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(16, 4, 'Johnathon Osinski', '1-732-267-8617', 'elton.block@brown.com', 'Nisi excepturi itaque nisi commodi sit.', 1, 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(17, 4, 'Uriel Wehner', '+1.223.462.7260', 'maegan.blick@leuschke.com', 'Quas eos vitae et deserunt atque.', 1, 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(18, 4, 'Alene Dare', '1-440-433-3575', 'rolfson.brandy@leffler.com', 'Sunt ea quis ullam.', 1, 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(19, 4, 'Gianni Lang', '+16516001218', 'eden.kris@yahoo.com', 'Est dolores odio earum et dolore.', 1, 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(20, 4, 'Emory Powlowski', '+14353515940', 'margarette.nicolas@jacobs.com', 'Tempore alias rerum non consequatur voluptas.', 1, 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(21, 5, 'Ila White II', '678-822-9042', 'rita.cronin@walter.org', 'Voluptatem dolorum quam deserunt.', 1, 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(22, 5, 'Roberto Schoen', '385-540-4887', 'friesen.rosa@yahoo.com', 'Placeat laborum nesciunt earum ab aut.', 1, 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(23, 5, 'Prof. Markus Orn DVM', '+1.513.715.9985', 'phickle@dubuque.com', 'Maxime qui ipsum incidunt corrupti voluptas.', 1, 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(24, 5, 'Declan Schulist', '1-651-905-9187', 'tressie70@bartell.com', 'Ex et eos nisi omnis dolores qui.', 1, 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(25, 5, 'Craig Jast', '+1.972.640.7695', 'anika19@hotmail.com', 'Est iste nihil ut fugit accusantium ratione expedita quae.', 1, 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(26, 6, 'Leland Marquardt', '1-320-435-8862', 'probel@kunde.com', 'Consequatur eius vitae veniam omnis non.', 1, 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(27, 6, 'Cordelia McKenzie', '478.530.8299', 'willis96@gmail.com', 'Cum voluptate quas quo.', 1, 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(28, 6, 'Prof. Noemy Sauer Jr.', '1-973-288-1295', 'ischuppe@gmail.com', 'Et necessitatibus culpa praesentium qui enim dolor vel quam.', 1, 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(29, 6, 'Horacio Ebert IV', '276.948.8296', 'tamia.goyette@gmail.com', 'Aut dolor placeat et.', 1, 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(30, 6, 'Rebeca Bednar', '+1.612.902.2583', 'vbechtelar@gmail.com', 'Rerum velit doloribus voluptas quisquam.', 1, 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(31, 7, 'Friedrich Renner', '+1-781-742-2093', 'rpadberg@gmail.com', 'Eum sed enim omnis sunt inventore temporibus quam.', 1, 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(32, 7, 'Daniela Volkman', '(269) 967-1931', 'hilton35@hotmail.com', 'Excepturi sit eos voluptas doloribus ut debitis.', 1, 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(33, 7, 'Ruby Waters', '+1-341-908-6581', 'hazle.rempel@reilly.com', 'Magnam voluptates sunt dolore quidem possimus nobis.', 1, 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(34, 7, 'Scotty Jones', '+1 (308) 592-2633', 'elmo69@gmail.com', 'Officia rerum maxime ut qui quae voluptatem consectetur.', 1, 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(35, 7, 'Noe Turcotte', '1-385-447-7678', 'fausto.greenholt@goodwin.com', 'Unde consequuntur reprehenderit mollitia sed qui voluptates.', 1, 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(36, 8, 'Hubert Hayes', '+12483017074', 'wunsch.beau@greenfelder.info', 'Placeat nulla occaecati nemo tempora praesentium voluptatibus alias necessitatibus.', 1, 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(37, 8, 'Andres Strosin', '+19064878914', 'ztrantow@yahoo.com', 'Dicta inventore aut ut necessitatibus est voluptatem.', 1, 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(38, 8, 'Burdette Stiedemann', '+1.786.357.8786', 'devyn.lubowitz@hotmail.com', 'Et sint quam eum quas.', 1, 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(39, 8, 'Emely Jacobson', '(817) 902-8693', 'kovacek.colin@berge.com', 'Nostrum commodi sunt tempora voluptatem enim laudantium sed eius.', 1, 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(40, 8, 'Francis O\'Conner', '1-925-969-6849', 'upton.liza@streich.com', 'Omnis cum ut debitis eos.', 1, 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(41, 9, 'Hal Wisoky Sr.', '+1 (775) 913-1030', 'bins.brisa@gmail.com', 'Assumenda necessitatibus dolores aut perspiciatis amet eos.', 1, 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(42, 9, 'Ottilie Eichmann', '(217) 978-6500', 'brown.corrine@block.com', 'Sunt quas harum placeat enim laborum.', 1, 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(43, 9, 'Ms. Kayla Schmeler', '346-848-6595', 'ike.boyer@maggio.info', 'Magni nisi culpa voluptatibus magni ut in.', 1, 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(44, 9, 'Laurie Walsh', '(551) 232-6521', 'christian12@runolfsson.com', 'Nemo consequuntur neque necessitatibus expedita maiores ut.', 1, 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(45, 9, 'Mrs. Corine Ferry', '+13523491740', 'adam60@stehr.com', 'Eius expedita nemo quis unde.', 1, 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(46, 10, 'Giovanni Bayer', '+1-559-367-2848', 'lowell.emard@gmail.com', 'Inventore cum commodi quia facere.', 1, 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(47, 10, 'Tristian Hettinger', '+1.248.449.9191', 'abernier@gmail.com', 'Eum iusto in veniam nihil rem sapiente.', 1, 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(48, 10, 'Prof. Randy Schultz', '+1.682.931.0123', 'howell.heaven@yahoo.com', 'Voluptate tempore et sed reprehenderit quos sunt ea.', 1, 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(49, 10, 'Miss Verona McDermott', '1-360-729-7267', 'nicholaus31@yahoo.com', 'Ratione quo dolores nostrum aut id.', 1, 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(50, 10, 'Jeffry Becker Jr.', '(646) 424-7143', 'terrence.kuhic@yahoo.com', 'Quis officiis quis ut qui enim.', 1, 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38');

-- --------------------------------------------------------

--
-- Table structure for table `dining_tables`
--

CREATE TABLE `dining_tables` (
  `table_id` bigint UNSIGNED NOT NULL,
  `restaurant_id` bigint UNSIGNED NOT NULL,
  `floor_id` bigint UNSIGNED NOT NULL,
  `code` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `capacity` int NOT NULL DEFAULT '2',
  `status` enum('FREE','OCCUPIED','RESERVED','BLOCKED') COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'FREE',
  `current_order_id` bigint UNSIGNED DEFAULT NULL,
  `qr_token` char(36) COLLATE utf8mb4_general_ci NOT NULL,
  `qr_image_url` varchar(500) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `added_by` bigint UNSIGNED NOT NULL,
  `updated_by` bigint UNSIGNED DEFAULT NULL,
  `added_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `dining_tables`
--

INSERT INTO `dining_tables` (`table_id`, `restaurant_id`, `floor_id`, `code`, `name`, `capacity`, `status`, `current_order_id`, `qr_token`, `qr_image_url`, `is_active`, `added_by`, `updated_by`, `added_date`, `updated_date`) VALUES
(1, 1, 1, 'T1', 'Table 1', 6, 'FREE', NULL, 'b41322ab-fe10-3038-bf93-67b9544a4752', 'https://via.placeholder.com/640x480.png/0055ee?text=molestiae', 1, 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(2, 1, 1, 'T2', 'Table 2', 6, 'FREE', NULL, '8a704892-af5f-37da-b7f9-9843dded5db0', 'https://via.placeholder.com/640x480.png/0000dd?text=est', 1, 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(3, 1, 1, 'T3', 'Table 3', 4, 'FREE', NULL, '0d1a7b75-ef81-3909-b551-7143b31ba247', 'https://via.placeholder.com/640x480.png/0055dd?text=voluptatem', 1, 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(4, 1, 2, 'T1', 'Table 1', 4, 'FREE', NULL, '189c57f0-23a6-3c00-990b-f13a3d6e3251', 'https://via.placeholder.com/640x480.png/003311?text=modi', 1, 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(5, 1, 2, 'T2', 'Table 2', 6, 'FREE', NULL, 'd36be3b4-3841-3867-8a2a-26f2f711d9d4', 'https://via.placeholder.com/640x480.png/00aa55?text=est', 1, 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(6, 1, 2, 'T3', 'Table 3', 2, 'FREE', NULL, '87773888-21e9-3914-80a6-c3a098dc5d29', 'https://via.placeholder.com/640x480.png/00bb66?text=possimus', 1, 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(7, 2, 3, 'T1', 'Table 1', 4, 'FREE', NULL, '0527ecf8-319f-3389-b214-a5e517c3c2d2', 'https://via.placeholder.com/640x480.png/008822?text=eum', 1, 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(8, 2, 3, 'T2', 'Table 2', 6, 'FREE', NULL, '9bdc579f-23e6-3344-a1df-9c6df1e87d51', 'https://via.placeholder.com/640x480.png/00ee44?text=recusandae', 1, 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(9, 2, 3, 'T3', 'Table 3', 4, 'FREE', NULL, '8b3ba410-ca4e-3752-81d3-76e739de3c73', 'https://via.placeholder.com/640x480.png/00ddcc?text=illo', 1, 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(10, 2, 4, 'T1', 'Table 1', 6, 'FREE', NULL, '16a45a4b-2783-3634-8802-558233ccd121', 'https://via.placeholder.com/640x480.png/0066aa?text=magnam', 1, 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(11, 2, 4, 'T2', 'Table 2', 6, 'FREE', NULL, 'f6c54cdf-ee58-3c76-882a-1d661a138cd7', 'https://via.placeholder.com/640x480.png/00bbff?text=provident', 1, 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(12, 2, 4, 'T3', 'Table 3', 3, 'FREE', NULL, '65946391-45cf-334d-b2a0-5067fd734a78', 'https://via.placeholder.com/640x480.png/003344?text=aspernatur', 1, 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(13, 3, 5, 'T1', 'Table 1', 4, 'FREE', NULL, '1f67a82f-2138-35db-8202-ab6e38add264', 'https://via.placeholder.com/640x480.png/00cc99?text=quaerat', 1, 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(14, 3, 5, 'T2', 'Table 2', 4, 'FREE', NULL, '0edf9091-fd22-3e3e-ab1e-644fba5f29b3', 'https://via.placeholder.com/640x480.png/0022bb?text=possimus', 1, 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(15, 3, 5, 'T3', 'Table 3', 5, 'FREE', NULL, '34c03272-266e-39c2-b2bd-5160eb1f2fc4', 'https://via.placeholder.com/640x480.png/00eeaa?text=veniam', 1, 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(16, 3, 6, 'T1', 'Table 1', 5, 'FREE', NULL, 'a43dac4a-d7c5-3c18-b994-0671d3efcf4a', 'https://via.placeholder.com/640x480.png/00bb00?text=earum', 1, 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(17, 3, 6, 'T2', 'Table 2', 2, 'FREE', NULL, '87ebb70f-b455-327c-bdac-05fee71ad92e', 'https://via.placeholder.com/640x480.png/0055ff?text=impedit', 1, 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(18, 3, 6, 'T3', 'Table 3', 4, 'FREE', NULL, 'd6e5f26a-dd4f-374e-b4cc-9d722e35b4c4', 'https://via.placeholder.com/640x480.png/007711?text=et', 1, 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(19, 4, 7, 'T1', 'Table 1', 2, 'FREE', NULL, '2a71d6e6-dcdc-367b-a625-0fd21cd71d3a', 'https://via.placeholder.com/640x480.png/0077bb?text=libero', 1, 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(20, 4, 7, 'T2', 'Table 2', 3, 'FREE', NULL, '53c2b73c-71c1-357f-ab4b-aba4e1f8c24a', 'https://via.placeholder.com/640x480.png/00bb55?text=porro', 1, 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(21, 4, 7, 'T3', 'Table 3', 6, 'FREE', NULL, '19fa637e-7dab-398a-ba3a-39cd82b45f07', 'https://via.placeholder.com/640x480.png/00ff77?text=laudantium', 1, 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(22, 4, 8, 'T1', 'Table 1', 6, 'FREE', NULL, '87849bfd-b43b-355f-8a2a-93424a76f398', 'https://via.placeholder.com/640x480.png/00aa44?text=aut', 1, 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(23, 4, 8, 'T2', 'Table 2', 6, 'FREE', NULL, '721699e3-9630-3b42-a714-b0b3cafce52c', 'https://via.placeholder.com/640x480.png/009977?text=suscipit', 1, 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(24, 4, 8, 'T3', 'Table 3', 2, 'FREE', NULL, 'b925a787-5c5b-341e-9a0f-ab449fc28c57', 'https://via.placeholder.com/640x480.png/006611?text=dolore', 1, 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(25, 5, 9, 'T1', 'Table 1', 3, 'FREE', NULL, 'fa2ae148-e682-38cb-bd1b-5b8040d4c7e0', 'https://via.placeholder.com/640x480.png/00aa99?text=eveniet', 1, 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(26, 5, 9, 'T2', 'Table 2', 6, 'FREE', NULL, '51c351f0-8281-3fbe-8eee-a624a1d989e7', 'https://via.placeholder.com/640x480.png/001199?text=dignissimos', 1, 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(27, 5, 9, 'T3', 'Table 3', 6, 'FREE', NULL, '681ed2fd-cbf3-322e-a2d8-96000251094d', 'https://via.placeholder.com/640x480.png/00dd88?text=nihil', 1, 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(28, 5, 10, 'T1', 'Table 1', 3, 'FREE', NULL, '1eaa74e5-11af-33af-a542-95868594038e', 'https://via.placeholder.com/640x480.png/00bb44?text=est', 1, 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(29, 5, 10, 'T2', 'Table 2', 5, 'FREE', NULL, '8ca2f7e8-4c2d-38e5-ae87-1f9ff030228d', 'https://via.placeholder.com/640x480.png/00bb44?text=molestiae', 1, 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(30, 5, 10, 'T3', 'Table 3', 4, 'FREE', NULL, '242ba7cb-d423-362e-aec2-618bac3c9446', 'https://via.placeholder.com/640x480.png/00cc33?text=sequi', 1, 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(31, 6, 11, 'T1', 'Table 1', 6, 'FREE', NULL, '00f5bb5e-9e7a-3fe5-9584-928c27f20550', 'https://via.placeholder.com/640x480.png/0011bb?text=tenetur', 1, 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(32, 6, 11, 'T2', 'Table 2', 2, 'FREE', NULL, '1ec25c74-23bd-370f-9bd0-1ca8b26b0d03', 'https://via.placeholder.com/640x480.png/008877?text=beatae', 1, 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(33, 6, 11, 'T3', 'Table 3', 2, 'FREE', NULL, '7248e6cf-94dd-3f11-bd2d-faa99e08b2db', 'https://via.placeholder.com/640x480.png/00ff00?text=eum', 1, 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(34, 6, 12, 'T1', 'Table 1', 4, 'FREE', NULL, '3706c3f3-d2d4-3c5b-af4c-5f5ab24a2bf3', 'https://via.placeholder.com/640x480.png/006655?text=dolor', 1, 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(35, 6, 12, 'T2', 'Table 2', 5, 'FREE', NULL, '7a6e2e35-2040-3a55-a7e5-fe3d4a460c00', 'https://via.placeholder.com/640x480.png/009911?text=et', 1, 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(36, 6, 12, 'T3', 'Table 3', 6, 'FREE', NULL, 'f484c6f9-070d-3758-95f5-e50d85f0aec5', 'https://via.placeholder.com/640x480.png/00ee55?text=odio', 1, 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(37, 7, 13, 'T1', 'Table 1', 6, 'FREE', NULL, 'e7b8bb99-a1a3-338d-8964-9bd7bde2be1c', 'https://via.placeholder.com/640x480.png/0055ff?text=enim', 1, 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(38, 7, 13, 'T2', 'Table 2', 5, 'FREE', NULL, '3a7f3d2a-cba5-33e4-942b-b277c2c7e2a6', 'https://via.placeholder.com/640x480.png/002222?text=repellat', 1, 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(39, 7, 13, 'T3', 'Table 3', 4, 'FREE', NULL, '3e9a8822-6780-308f-8b97-e46da7411572', 'https://via.placeholder.com/640x480.png/004422?text=qui', 1, 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(40, 7, 14, 'T1', 'Table 1', 4, 'FREE', NULL, '7fafc9ba-4ecc-36f7-9ca8-bda4f16020b6', 'https://via.placeholder.com/640x480.png/004444?text=rerum', 1, 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(41, 7, 14, 'T2', 'Table 2', 4, 'FREE', NULL, 'a4cc5085-973e-38b5-a803-41361f081096', 'https://via.placeholder.com/640x480.png/006644?text=quisquam', 1, 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(42, 7, 14, 'T3', 'Table 3', 5, 'FREE', NULL, '42a748e2-9b59-37a6-ac58-aecb0080ff7e', 'https://via.placeholder.com/640x480.png/0000ee?text=voluptatibus', 1, 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(43, 8, 15, 'T1', 'Table 1', 5, 'FREE', NULL, '8a079dbc-770c-3ab1-830b-19f31d89f321', 'https://via.placeholder.com/640x480.png/008800?text=et', 1, 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(44, 8, 15, 'T2', 'Table 2', 2, 'FREE', NULL, 'e0c42650-3701-3b18-8984-fcce558cd2af', 'https://via.placeholder.com/640x480.png/009999?text=sunt', 1, 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(45, 8, 15, 'T3', 'Table 3', 2, 'FREE', NULL, '7bc321d1-1c0f-3474-be15-fbba9f50e181', 'https://via.placeholder.com/640x480.png/00dd33?text=molestias', 1, 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(46, 8, 16, 'T1', 'Table 1', 2, 'FREE', NULL, 'afea5c95-a1ac-3850-bf7d-fffa6fc8682b', 'https://via.placeholder.com/640x480.png/009955?text=hic', 1, 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(47, 8, 16, 'T2', 'Table 2', 4, 'FREE', NULL, 'b241b287-3349-3a5c-aaad-d9a3d5935254', 'https://via.placeholder.com/640x480.png/0099bb?text=culpa', 1, 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(48, 8, 16, 'T3', 'Table 3', 2, 'FREE', NULL, '41fc5435-02d1-32a8-9243-a2db960d6290', 'https://via.placeholder.com/640x480.png/0099ff?text=accusantium', 1, 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(49, 9, 17, 'T1', 'Table 1', 6, 'FREE', NULL, '6dbb48f1-83d1-370e-9686-b18bd852e50e', 'https://via.placeholder.com/640x480.png/006611?text=optio', 1, 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(50, 9, 17, 'T2', 'Table 2', 3, 'FREE', NULL, '6e493fdc-bad2-39c0-aa88-c8f638e49366', 'https://via.placeholder.com/640x480.png/00ff77?text=nulla', 1, 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(51, 9, 17, 'T3', 'Table 3', 4, 'FREE', NULL, '50bd9c7d-f8f2-3f08-9010-5cc63d834c71', 'https://via.placeholder.com/640x480.png/000066?text=nihil', 1, 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(52, 9, 18, 'T1', 'Table 1', 6, 'FREE', NULL, '08d5a127-9147-30d0-b421-7ac367b9fa31', 'https://via.placeholder.com/640x480.png/00ee99?text=enim', 1, 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(53, 9, 18, 'T2', 'Table 2', 2, 'FREE', NULL, 'e2a41d8b-390f-3690-a723-cd1110c29465', 'https://via.placeholder.com/640x480.png/00aa00?text=cum', 1, 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(54, 9, 18, 'T3', 'Table 3', 3, 'FREE', NULL, 'e25c9995-43d4-3ed0-a176-cdf6c43f9f88', 'https://via.placeholder.com/640x480.png/00ff66?text=eos', 1, 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(55, 10, 19, 'T1', 'Table 1', 5, 'FREE', NULL, '4840e208-f51a-317d-a978-68ad8ec85719', 'https://via.placeholder.com/640x480.png/0000bb?text=accusamus', 1, 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(56, 10, 19, 'T2', 'Table 2', 6, 'FREE', NULL, '7739531f-4aab-3bc2-b733-fb8e9d632559', 'https://via.placeholder.com/640x480.png/00ff44?text=amet', 1, 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(57, 10, 19, 'T3', 'Table 3', 4, 'FREE', NULL, '22327af5-8de2-379d-a06e-0a70e98bc876', 'https://via.placeholder.com/640x480.png/00bbbb?text=enim', 1, 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(58, 10, 20, 'T1', 'Table 1', 6, 'FREE', NULL, 'e093160b-42bd-3274-ad0a-c73f769fa0fd', 'https://via.placeholder.com/640x480.png/00dd88?text=nemo', 1, 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(59, 10, 20, 'T2', 'Table 2', 6, 'FREE', NULL, 'c3a16cbd-7a4d-33a4-a7ce-ca4eece7f72e', 'https://via.placeholder.com/640x480.png/00ff88?text=aperiam', 1, 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(60, 10, 20, 'T3', 'Table 3', 2, 'FREE', NULL, 'c797d814-3976-3a29-8be2-20a37208daa2', 'https://via.placeholder.com/640x480.png/0033cc?text=architecto', 1, 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38');

-- --------------------------------------------------------

--
-- Table structure for table `feedback`
--

CREATE TABLE `feedback` (
  `feedback_id` bigint UNSIGNED NOT NULL,
  `restaurant_id` bigint UNSIGNED NOT NULL,
  `order_id` bigint UNSIGNED DEFAULT NULL,
  `customer_id` bigint UNSIGNED DEFAULT NULL,
  `rating` tinyint NOT NULL,
  `comments` varchar(1000) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `added_by` bigint UNSIGNED NOT NULL,
  `added_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `feedback`
--

INSERT INTO `feedback` (`feedback_id`, `restaurant_id`, `order_id`, `customer_id`, `rating`, `comments`, `added_by`, `added_date`) VALUES
(1, 1, NULL, NULL, 4, 'Saepe quia placeat sed libero dicta.', 1, '2025-09-06 16:46:38'),
(2, 1, NULL, NULL, 2, 'Et nemo corporis iusto optio praesentium.', 1, '2025-09-06 16:46:38'),
(3, 2, NULL, NULL, 1, 'Molestiae eum consequatur consequatur et voluptatem.', 1, '2025-09-06 16:46:38'),
(4, 2, NULL, NULL, 3, 'Distinctio quos voluptatem eligendi alias magni omnis alias.', 1, '2025-09-06 16:46:38'),
(5, 3, NULL, NULL, 2, 'Et nesciunt quasi quo quia.', 1, '2025-09-06 16:46:38'),
(6, 3, NULL, NULL, 4, 'Laudantium maxime eos nihil eum.', 1, '2025-09-06 16:46:38'),
(7, 4, NULL, NULL, 1, 'Earum alias quo sit ut magni.', 1, '2025-09-06 16:46:38'),
(8, 4, NULL, NULL, 3, 'Facere dolore accusamus beatae illo voluptatem corrupti voluptas.', 1, '2025-09-06 16:46:38'),
(9, 5, NULL, NULL, 4, 'Voluptatem blanditiis odio et est sequi doloribus sint.', 1, '2025-09-06 16:46:38'),
(10, 5, NULL, NULL, 1, 'Eveniet iste placeat quo rerum accusantium.', 1, '2025-09-06 16:46:38'),
(11, 6, NULL, NULL, 3, 'Sit odit officiis consequuntur ipsum quia.', 1, '2025-09-06 16:46:38'),
(12, 6, NULL, NULL, 5, 'Voluptatibus cumque eveniet sint quos et sed rem ratione.', 1, '2025-09-06 16:46:38'),
(13, 7, NULL, NULL, 5, 'Aut provident quisquam aut qui.', 1, '2025-09-06 16:46:38'),
(14, 7, NULL, NULL, 5, 'Ipsum blanditiis pariatur quia facilis sunt sed.', 1, '2025-09-06 16:46:38'),
(15, 8, NULL, NULL, 2, 'Quae aut atque nemo et.', 1, '2025-09-06 16:46:38'),
(16, 8, NULL, NULL, 2, 'Odit nemo qui aut velit deserunt doloribus deserunt.', 1, '2025-09-06 16:46:38'),
(17, 9, NULL, NULL, 3, 'Nam cupiditate error qui et eum aut.', 1, '2025-09-06 16:46:38'),
(18, 9, NULL, NULL, 1, 'Perferendis itaque odit ut quas est alias.', 1, '2025-09-06 16:46:38'),
(19, 10, NULL, NULL, 1, 'Placeat ut exercitationem illo maxime.', 1, '2025-09-06 16:46:38'),
(20, 10, NULL, NULL, 1, 'Nam distinctio quo natus nesciunt ipsam voluptatum.', 1, '2025-09-06 16:46:38');

-- --------------------------------------------------------

--
-- Table structure for table `floors`
--

CREATE TABLE `floors` (
  `floor_id` bigint UNSIGNED NOT NULL,
  `restaurant_id` bigint UNSIGNED NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `sort_order` int NOT NULL DEFAULT '0',
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `added_by` bigint UNSIGNED NOT NULL,
  `updated_by` bigint UNSIGNED DEFAULT NULL,
  `added_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `floors`
--

INSERT INTO `floors` (`floor_id`, `restaurant_id`, `name`, `sort_order`, `is_active`, `added_by`, `updated_by`, `added_date`, `updated_date`) VALUES
(1, 1, 'Floor 1', 1, 1, 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(2, 1, 'Floor 2', 2, 1, 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(3, 2, 'Floor 1', 1, 1, 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(4, 2, 'Floor 2', 2, 1, 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(5, 3, 'Floor 1', 1, 1, 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(6, 3, 'Floor 2', 2, 1, 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(7, 4, 'Floor 1', 1, 1, 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(8, 4, 'Floor 2', 2, 1, 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(9, 5, 'Floor 1', 1, 1, 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(10, 5, 'Floor 2', 2, 1, 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(11, 6, 'Floor 1', 1, 1, 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(12, 6, 'Floor 2', 2, 1, 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(13, 7, 'Floor 1', 1, 1, 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(14, 7, 'Floor 2', 2, 1, 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(15, 8, 'Floor 1', 1, 1, 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(16, 8, 'Floor 2', 2, 1, 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(17, 9, 'Floor 1', 1, 1, 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(18, 9, 'Floor 2', 2, 1, 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(19, 10, 'Floor 1', 1, 1, 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(20, 10, 'Floor 2', 2, 1, 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38');

-- --------------------------------------------------------

--
-- Table structure for table `group_master`
--

CREATE TABLE `group_master` (
  `group_master_id` int NOT NULL,
  `group_name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `group_code` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `status` enum('Active','Inactive') COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'Inactive'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `group_rights`
--

CREATE TABLE `group_rights` (
  `group_rights_id` int NOT NULL,
  `group_master_id` int NOT NULL,
  `menu_master_id` int NOT NULL,
  `list` enum('Yes','No') COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'No',
  `add` enum('Yes','No') COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'No',
  `update` enum('Yes','No') COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'No',
  `delete` enum('Yes','No') COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'No',
  `export` enum('Yes','No') COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'No',
  `import` enum('Yes','No') COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'No'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `item_addon_groups`
--

CREATE TABLE `item_addon_groups` (
  `item_id` bigint UNSIGNED NOT NULL,
  `addon_group_id` bigint UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `item_addon_groups`
--

INSERT INTO `item_addon_groups` (`item_id`, `addon_group_id`) VALUES
(1, 19),
(2, 15),
(3, 8),
(4, 19),
(5, 13),
(6, 18),
(7, 7),
(8, 17),
(9, 7),
(10, 13),
(11, 19),
(12, 12),
(13, 19),
(14, 1),
(15, 10),
(16, 2),
(17, 5),
(18, 15),
(19, 3),
(20, 4),
(21, 12),
(22, 7),
(23, 2),
(24, 8),
(25, 3),
(26, 7),
(27, 20),
(28, 14),
(29, 3),
(30, 12),
(31, 8),
(32, 16),
(33, 3),
(34, 3),
(35, 1),
(36, 1),
(37, 4),
(38, 4),
(39, 4),
(40, 19),
(41, 10),
(42, 3),
(43, 7),
(44, 3),
(45, 3),
(46, 3),
(47, 3),
(48, 7),
(49, 15),
(50, 13),
(51, 20),
(52, 5),
(53, 4),
(54, 10),
(55, 20),
(56, 16),
(57, 15),
(58, 15),
(59, 11),
(60, 17),
(61, 19),
(62, 14),
(63, 19),
(64, 12),
(65, 3),
(66, 14),
(67, 6),
(68, 12),
(69, 5),
(70, 14),
(71, 3),
(72, 2),
(73, 1),
(74, 15),
(75, 1),
(76, 4),
(77, 2),
(78, 4),
(79, 12),
(80, 5),
(81, 18),
(82, 19),
(83, 4),
(84, 5),
(85, 14),
(86, 20),
(87, 18),
(88, 15),
(89, 8),
(90, 19),
(91, 11),
(92, 10),
(93, 4),
(94, 1),
(95, 6),
(96, 7),
(97, 15),
(98, 4),
(99, 20),
(100, 18),
(101, 14),
(102, 20),
(103, 2),
(104, 14),
(105, 6),
(106, 20),
(107, 5),
(108, 14),
(109, 12),
(110, 10),
(111, 8),
(112, 6),
(113, 16),
(114, 6),
(115, 17),
(116, 10),
(117, 14),
(118, 15),
(119, 7),
(120, 20);

-- --------------------------------------------------------

--
-- Table structure for table `kot_items`
--

CREATE TABLE `kot_items` (
  `kot_item_id` bigint UNSIGNED NOT NULL,
  `kot_id` bigint UNSIGNED NOT NULL,
  `order_item_id` bigint UNSIGNED NOT NULL,
  `quantity` decimal(10,2) NOT NULL,
  `added_by` bigint UNSIGNED NOT NULL,
  `added_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `kot_tickets`
--

CREATE TABLE `kot_tickets` (
  `kot_ticket_id` bigint UNSIGNED NOT NULL,
  `order_id` bigint UNSIGNED NOT NULL,
  `status` enum('QUEUED','PRINTED','CANCELLED') COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'QUEUED',
  `printer_name` varchar(120) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `added_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `added_by` bigint UNSIGNED NOT NULL,
  `printed_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `kot_tickets`
--

INSERT INTO `kot_tickets` (`kot_ticket_id`, `order_id`, `status`, `printer_name`, `added_date`, `added_by`, `printed_at`) VALUES
(1, 1, 'QUEUED', 'Printer1', '2025-09-06 16:46:39', 1, NULL),
(2, 2, 'QUEUED', 'Printer1', '2025-09-06 16:46:39', 1, NULL),
(3, 3, 'QUEUED', 'Printer1', '2025-09-06 16:46:39', 1, NULL),
(4, 4, 'QUEUED', 'Printer1', '2025-09-06 16:46:39', 1, NULL),
(5, 5, 'QUEUED', 'Printer1', '2025-09-06 16:46:39', 1, NULL),
(6, 6, 'QUEUED', 'Printer1', '2025-09-06 16:46:39', 1, NULL),
(7, 7, 'QUEUED', 'Printer1', '2025-09-06 16:46:39', 1, NULL),
(8, 8, 'QUEUED', 'Printer1', '2025-09-06 16:46:39', 1, NULL),
(9, 9, 'QUEUED', 'Printer1', '2025-09-06 16:46:39', 1, NULL),
(10, 10, 'QUEUED', 'Printer1', '2025-09-06 16:46:39', 1, NULL),
(11, 11, 'QUEUED', 'Printer1', '2025-09-06 16:46:39', 1, NULL),
(12, 12, 'QUEUED', 'Printer1', '2025-09-06 16:46:39', 1, NULL),
(13, 13, 'QUEUED', 'Printer1', '2025-09-06 16:46:39', 1, NULL),
(14, 14, 'QUEUED', 'Printer1', '2025-09-06 16:46:39', 1, NULL),
(15, 15, 'QUEUED', 'Printer1', '2025-09-06 16:46:39', 1, NULL),
(16, 16, 'QUEUED', 'Printer1', '2025-09-06 16:46:39', 1, NULL),
(17, 17, 'QUEUED', 'Printer1', '2025-09-06 16:46:39', 1, NULL),
(18, 18, 'QUEUED', 'Printer1', '2025-09-06 16:46:39', 1, NULL),
(19, 19, 'QUEUED', 'Printer1', '2025-09-06 16:46:39', 1, NULL),
(20, 20, 'QUEUED', 'Printer1', '2025-09-06 16:46:39', 1, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `loyalty_transactions`
--

CREATE TABLE `loyalty_transactions` (
  `transaction_id` bigint UNSIGNED NOT NULL,
  `wallet_id` bigint UNSIGNED NOT NULL,
  `order_id` bigint UNSIGNED DEFAULT NULL,
  `points_delta` int NOT NULL,
  `reason` varchar(200) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `added_by` bigint UNSIGNED NOT NULL,
  `added_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `loyalty_transactions`
--

INSERT INTO `loyalty_transactions` (`transaction_id`, `wallet_id`, `order_id`, `points_delta`, `reason`, `added_by`, `added_date`) VALUES
(1, 1, NULL, -22, 'Voluptatem sunt voluptas dolores adipisci at ab omnis.', 1, '2025-09-06 16:46:38'),
(2, 1, NULL, -25, 'Necessitatibus dolore qui non assumenda provident quaerat.', 1, '2025-09-06 16:46:38'),
(3, 2, NULL, 9, 'Optio et repellat autem.', 1, '2025-09-06 16:46:38'),
(4, 2, NULL, -4, 'Expedita cum aut similique cum reiciendis nulla.', 1, '2025-09-06 16:46:38'),
(5, 3, NULL, -20, 'Laboriosam necessitatibus voluptas quod molestias minus.', 1, '2025-09-06 16:46:38'),
(6, 3, NULL, 21, 'Animi illum modi dignissimos sit at.', 1, '2025-09-06 16:46:38'),
(7, 4, NULL, -3, 'Ex temporibus eum facilis sed nobis maxime.', 1, '2025-09-06 16:46:38'),
(8, 4, NULL, -15, 'Voluptate recusandae corrupti vitae qui.', 1, '2025-09-06 16:46:38'),
(9, 5, NULL, 41, 'Vitae et odit libero nisi nihil.', 1, '2025-09-06 16:46:38'),
(10, 5, NULL, 20, 'Eum et aut consequuntur et.', 1, '2025-09-06 16:46:38'),
(11, 6, NULL, -35, 'Quos voluptate modi voluptatem nesciunt quasi ut.', 1, '2025-09-06 16:46:38'),
(12, 6, NULL, -28, 'Qui sunt id autem nihil ipsum id illo.', 1, '2025-09-06 16:46:38'),
(13, 7, NULL, -25, 'Ex vero aperiam ducimus ducimus.', 1, '2025-09-06 16:46:38'),
(14, 7, NULL, -3, 'Quasi doloribus dolorem esse omnis eligendi fugiat ipsum.', 1, '2025-09-06 16:46:38'),
(15, 8, NULL, -2, 'Dicta quam illum et est consequatur soluta necessitatibus.', 1, '2025-09-06 16:46:38'),
(16, 8, NULL, -48, 'Aut at aut quia quos.', 1, '2025-09-06 16:46:38'),
(17, 9, NULL, 38, 'Rerum quae sed rerum aut et ipsam.', 1, '2025-09-06 16:46:38'),
(18, 9, NULL, -30, 'Ut reprehenderit porro velit exercitationem.', 1, '2025-09-06 16:46:38'),
(19, 10, NULL, 13, 'Modi ut optio ullam esse eum ad.', 1, '2025-09-06 16:46:38'),
(20, 10, NULL, 25, 'Voluptatem consequuntur accusantium voluptatem maiores.', 1, '2025-09-06 16:46:38'),
(21, 11, NULL, -42, 'Et quasi nihil debitis fugit sint cumque.', 1, '2025-09-06 16:46:38'),
(22, 11, NULL, -22, 'Ipsam quam suscipit aliquam illum amet vel ex porro.', 1, '2025-09-06 16:46:38'),
(23, 12, NULL, 22, 'Molestiae ea dolor possimus esse architecto quidem rerum.', 1, '2025-09-06 16:46:38'),
(24, 12, NULL, -18, 'Voluptatem sapiente nesciunt alias.', 1, '2025-09-06 16:46:38'),
(25, 13, NULL, -23, 'Aut quo rerum aperiam doloremque.', 1, '2025-09-06 16:46:38'),
(26, 13, NULL, -35, 'Provident aut vero aut quaerat dignissimos in qui.', 1, '2025-09-06 16:46:38'),
(27, 14, NULL, 31, 'Odit inventore impedit eum necessitatibus adipisci ea.', 1, '2025-09-06 16:46:38'),
(28, 14, NULL, -12, 'Et corrupti illo dignissimos assumenda voluptatum facilis id.', 1, '2025-09-06 16:46:38'),
(29, 15, NULL, -34, 'Modi alias rem vel laudantium.', 1, '2025-09-06 16:46:38'),
(30, 15, NULL, 39, 'Eum ut ducimus suscipit eius dignissimos.', 1, '2025-09-06 16:46:38'),
(31, 16, NULL, 23, 'Porro tenetur enim ut nesciunt.', 1, '2025-09-06 16:46:38'),
(32, 16, NULL, -31, 'Iste dolore minus neque quod cupiditate.', 1, '2025-09-06 16:46:38'),
(33, 17, NULL, -13, 'Ullam non numquam nemo quia vel in aut.', 1, '2025-09-06 16:46:38'),
(34, 17, NULL, 18, 'Officiis autem quidem inventore minus.', 1, '2025-09-06 16:46:38'),
(35, 18, NULL, 33, 'Eum ratione voluptatem laborum.', 1, '2025-09-06 16:46:38'),
(36, 18, NULL, -41, 'Nobis eveniet occaecati quae velit.', 1, '2025-09-06 16:46:38'),
(37, 19, NULL, -48, 'Ratione et tempora unde ab voluptatibus dolores natus.', 1, '2025-09-06 16:46:38'),
(38, 19, NULL, -35, 'Voluptas architecto est mollitia suscipit temporibus.', 1, '2025-09-06 16:46:38'),
(39, 20, NULL, -40, 'Earum at et nemo qui.', 1, '2025-09-06 16:46:38'),
(40, 20, NULL, -14, 'Est odio vero eos et voluptates.', 1, '2025-09-06 16:46:38'),
(41, 21, NULL, -14, 'Non accusantium beatae voluptates qui.', 1, '2025-09-06 16:46:38'),
(42, 21, NULL, -47, 'Est eos esse quaerat delectus in recusandae.', 1, '2025-09-06 16:46:38'),
(43, 22, NULL, -19, 'Deleniti eveniet dolorem repellat rem quas.', 1, '2025-09-06 16:46:38'),
(44, 22, NULL, -12, 'Ut vel quod ut quidem accusantium.', 1, '2025-09-06 16:46:38'),
(45, 23, NULL, -22, 'Qui et quibusdam neque.', 1, '2025-09-06 16:46:38'),
(46, 23, NULL, 17, 'Reiciendis dignissimos neque debitis ea ratione nam fugit ducimus.', 1, '2025-09-06 16:46:38'),
(47, 24, NULL, -5, 'Sequi molestias ratione minima illo minus dolorem facere.', 1, '2025-09-06 16:46:38'),
(48, 24, NULL, 34, 'Consequuntur voluptatem aut sit adipisci quia at eum.', 1, '2025-09-06 16:46:38'),
(49, 25, NULL, 4, 'Eum inventore deserunt possimus aperiam iure ipsam eligendi nam.', 1, '2025-09-06 16:46:38'),
(50, 25, NULL, -13, 'Et sunt facere a quisquam.', 1, '2025-09-06 16:46:38'),
(51, 26, NULL, 1, 'Laborum autem eaque provident.', 1, '2025-09-06 16:46:38'),
(52, 26, NULL, 33, 'Labore reprehenderit quae quo unde quo repellendus labore maxime.', 1, '2025-09-06 16:46:38'),
(53, 27, NULL, -19, 'Temporibus impedit dolorum fuga sunt.', 1, '2025-09-06 16:46:38'),
(54, 27, NULL, 14, 'Et necessitatibus eligendi eaque velit esse neque reprehenderit.', 1, '2025-09-06 16:46:38'),
(55, 28, NULL, -17, 'Natus aspernatur cum vel dicta qui.', 1, '2025-09-06 16:46:38'),
(56, 28, NULL, 7, 'Minima reprehenderit dolores qui rerum hic.', 1, '2025-09-06 16:46:38'),
(57, 29, NULL, 30, 'Repudiandae quis mollitia mollitia dolor quo assumenda laudantium.', 1, '2025-09-06 16:46:38'),
(58, 29, NULL, -38, 'Soluta incidunt pariatur sed aut debitis soluta.', 1, '2025-09-06 16:46:38'),
(59, 30, NULL, 10, 'Corporis iste laborum doloremque soluta architecto quod rerum ut.', 1, '2025-09-06 16:46:38'),
(60, 30, NULL, -6, 'Nam sint accusamus eveniet asperiores possimus in.', 1, '2025-09-06 16:46:38'),
(61, 31, NULL, -1, 'Mollitia asperiores facere quos ducimus nisi incidunt.', 1, '2025-09-06 16:46:38'),
(62, 31, NULL, -39, 'Quia quia est rerum et non deserunt.', 1, '2025-09-06 16:46:38'),
(63, 32, NULL, 21, 'Non autem quis iure natus.', 1, '2025-09-06 16:46:38'),
(64, 32, NULL, 41, 'Perspiciatis nihil nisi libero quasi in aut illo commodi.', 1, '2025-09-06 16:46:38'),
(65, 33, NULL, 14, 'Corrupti soluta possimus mollitia beatae voluptatum quo est.', 1, '2025-09-06 16:46:38'),
(66, 33, NULL, 39, 'Exercitationem ratione fugit et et et.', 1, '2025-09-06 16:46:38'),
(67, 34, NULL, -30, 'Vel optio in id nostrum excepturi inventore.', 1, '2025-09-06 16:46:38'),
(68, 34, NULL, -6, 'Nisi atque at dicta numquam temporibus officia.', 1, '2025-09-06 16:46:38'),
(69, 35, NULL, 46, 'Praesentium ut sint autem laboriosam ullam sed sit.', 1, '2025-09-06 16:46:38'),
(70, 35, NULL, -40, 'Qui vitae similique repellendus quos molestiae nesciunt.', 1, '2025-09-06 16:46:38'),
(71, 36, NULL, 50, 'Modi sit reprehenderit doloribus quasi.', 1, '2025-09-06 16:46:38'),
(72, 36, NULL, 13, 'Consequatur fugiat rem ipsum maxime quae tempora impedit.', 1, '2025-09-06 16:46:38'),
(73, 37, NULL, 12, 'Illum dolorem sit dolorum ipsa autem.', 1, '2025-09-06 16:46:38'),
(74, 37, NULL, -26, 'Est corrupti sapiente molestiae ipsum eveniet necessitatibus tempore.', 1, '2025-09-06 16:46:38'),
(75, 38, NULL, -24, 'Temporibus ut itaque sed voluptates earum blanditiis.', 1, '2025-09-06 16:46:38'),
(76, 38, NULL, 7, 'Architecto sed sapiente quisquam assumenda deserunt inventore tempore.', 1, '2025-09-06 16:46:38'),
(77, 39, NULL, -21, 'Cupiditate unde vel sed voluptas.', 1, '2025-09-06 16:46:38'),
(78, 39, NULL, 46, 'Exercitationem aspernatur ut ut consequatur quam tempore assumenda.', 1, '2025-09-06 16:46:38'),
(79, 40, NULL, -24, 'Dolorum aut non dolorem ducimus velit earum ratione.', 1, '2025-09-06 16:46:38'),
(80, 40, NULL, -1, 'Dolore praesentium perspiciatis enim rerum.', 1, '2025-09-06 16:46:38'),
(81, 41, NULL, -2, 'Nesciunt iure eius possimus voluptatem quo velit nisi.', 1, '2025-09-06 16:46:38'),
(82, 41, NULL, 13, 'Quia qui autem molestiae dignissimos iste autem.', 1, '2025-09-06 16:46:38'),
(83, 42, NULL, -18, 'Dolorem sapiente illum aut.', 1, '2025-09-06 16:46:38'),
(84, 42, NULL, 20, 'Dolorem at omnis officia sit quia dolor.', 1, '2025-09-06 16:46:38'),
(85, 43, NULL, -36, 'Aut rerum numquam hic enim.', 1, '2025-09-06 16:46:38'),
(86, 43, NULL, 23, 'Dolor est ex quis dolorem.', 1, '2025-09-06 16:46:38'),
(87, 44, NULL, -30, 'Facere eligendi recusandae distinctio iure possimus.', 1, '2025-09-06 16:46:38'),
(88, 44, NULL, 5, 'Perferendis inventore laudantium porro sunt id.', 1, '2025-09-06 16:46:38'),
(89, 45, NULL, 25, 'Commodi doloribus delectus quia impedit.', 1, '2025-09-06 16:46:38'),
(90, 45, NULL, 33, 'Nemo facere inventore quos error est.', 1, '2025-09-06 16:46:38'),
(91, 46, NULL, -37, 'Fugit unde ipsa sint nemo.', 1, '2025-09-06 16:46:38'),
(92, 46, NULL, 45, 'Saepe qui voluptatem consequuntur libero in quo.', 1, '2025-09-06 16:46:38'),
(93, 47, NULL, -7, 'Placeat consequatur laudantium et omnis at aperiam quasi eos.', 1, '2025-09-06 16:46:38'),
(94, 47, NULL, 4, 'Et et voluptas optio doloremque voluptas.', 1, '2025-09-06 16:46:38'),
(95, 48, NULL, 48, 'Rerum labore autem quisquam eum quae doloribus.', 1, '2025-09-06 16:46:38'),
(96, 48, NULL, 36, 'Est dolores blanditiis laboriosam animi doloremque non assumenda nobis.', 1, '2025-09-06 16:46:38'),
(97, 49, NULL, 26, 'Esse provident consectetur aut et.', 1, '2025-09-06 16:46:38'),
(98, 49, NULL, -32, 'Tempore omnis sunt fugit dolorum iste.', 1, '2025-09-06 16:46:38'),
(99, 50, NULL, 6, 'Perferendis eius esse pariatur cum.', 1, '2025-09-06 16:46:38'),
(100, 50, NULL, 28, 'Velit officia reprehenderit temporibus non dicta consequatur.', 1, '2025-09-06 16:46:38');

-- --------------------------------------------------------

--
-- Table structure for table `loyalty_wallets`
--

CREATE TABLE `loyalty_wallets` (
  `wallet_id` bigint UNSIGNED NOT NULL,
  `customer_id` bigint UNSIGNED NOT NULL,
  `points_balance` int NOT NULL DEFAULT '0',
  `updated_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `loyalty_wallets`
--

INSERT INTO `loyalty_wallets` (`wallet_id`, `customer_id`, `points_balance`, `updated_date`) VALUES
(1, 1, 91, '2025-09-06 16:46:38'),
(2, 2, 261, '2025-09-06 16:46:38'),
(3, 3, 112, '2025-09-06 16:46:38'),
(4, 4, 193, '2025-09-06 16:46:38'),
(5, 5, 312, '2025-09-06 16:46:38'),
(6, 6, 473, '2025-09-06 16:46:38'),
(7, 7, 8, '2025-09-06 16:46:38'),
(8, 8, 364, '2025-09-06 16:46:38'),
(9, 9, 208, '2025-09-06 16:46:38'),
(10, 10, 334, '2025-09-06 16:46:38'),
(11, 11, 351, '2025-09-06 16:46:38'),
(12, 12, 290, '2025-09-06 16:46:38'),
(13, 13, 148, '2025-09-06 16:46:38'),
(14, 14, 84, '2025-09-06 16:46:38'),
(15, 15, 8, '2025-09-06 16:46:38'),
(16, 16, 209, '2025-09-06 16:46:38'),
(17, 17, 210, '2025-09-06 16:46:38'),
(18, 18, 149, '2025-09-06 16:46:38'),
(19, 19, 194, '2025-09-06 16:46:38'),
(20, 20, 442, '2025-09-06 16:46:38'),
(21, 21, 104, '2025-09-06 16:46:38'),
(22, 22, 231, '2025-09-06 16:46:38'),
(23, 23, 113, '2025-09-06 16:46:38'),
(24, 24, 164, '2025-09-06 16:46:38'),
(25, 25, 419, '2025-09-06 16:46:38'),
(26, 26, 308, '2025-09-06 16:46:38'),
(27, 27, 80, '2025-09-06 16:46:38'),
(28, 28, 209, '2025-09-06 16:46:38'),
(29, 29, 311, '2025-09-06 16:46:38'),
(30, 30, 138, '2025-09-06 16:46:38'),
(31, 31, 165, '2025-09-06 16:46:38'),
(32, 32, 475, '2025-09-06 16:46:38'),
(33, 33, 177, '2025-09-06 16:46:38'),
(34, 34, 141, '2025-09-06 16:46:38'),
(35, 35, 498, '2025-09-06 16:46:38'),
(36, 36, 55, '2025-09-06 16:46:38'),
(37, 37, 278, '2025-09-06 16:46:38'),
(38, 38, 287, '2025-09-06 16:46:38'),
(39, 39, 287, '2025-09-06 16:46:38'),
(40, 40, 449, '2025-09-06 16:46:38'),
(41, 41, 80, '2025-09-06 16:46:38'),
(42, 42, 77, '2025-09-06 16:46:38'),
(43, 43, 366, '2025-09-06 16:46:38'),
(44, 44, 35, '2025-09-06 16:46:38'),
(45, 45, 475, '2025-09-06 16:46:38'),
(46, 46, 100, '2025-09-06 16:46:38'),
(47, 47, 107, '2025-09-06 16:46:38'),
(48, 48, 270, '2025-09-06 16:46:38'),
(49, 49, 219, '2025-09-06 16:46:38'),
(50, 50, 177, '2025-09-06 16:46:38');

-- --------------------------------------------------------

--
-- Table structure for table `menu_category`
--

CREATE TABLE `menu_category` (
  `menu_category_id` int NOT NULL,
  `menu_category_code` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `menu_category_name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `menu_items`
--

CREATE TABLE `menu_items` (
  `item_id` bigint UNSIGNED NOT NULL,
  `restaurant_id` bigint UNSIGNED NOT NULL,
  `category_id` bigint UNSIGNED NOT NULL,
  `name` varchar(150) COLLATE utf8mb4_general_ci NOT NULL,
  `code` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `description` varchar(1000) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `base_price` decimal(10,2) NOT NULL,
  `veg_type` enum('VEG','NON_VEG','EGG') COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'VEG',
  `image_url` varchar(500) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `is_available` tinyint(1) NOT NULL DEFAULT '1',
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `tax_rate` decimal(5,2) NOT NULL DEFAULT '0.00',
  `tax_breakdown` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `added_by` bigint UNSIGNED NOT NULL,
  `updated_by` bigint UNSIGNED DEFAULT NULL,
  `added_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ;

--
-- Dumping data for table `menu_items`
--

INSERT INTO `menu_items` (`item_id`, `restaurant_id`, `category_id`, `name`, `code`, `description`, `base_price`, `veg_type`, `image_url`, `is_available`, `is_active`, `tax_rate`, `tax_breakdown`, `added_by`, `updated_by`, `added_date`, `updated_date`) VALUES
(1, 1, 1, 'maiores', 'BGG714', 'Dignissimos odit eius et.', '145.00', 'VEG', 'https://via.placeholder.com/640x480.png/00aaaa?text=animi', 1, 1, '5.00', '{\"cgst\": 2.5, \"sgst\": 2.5}', 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(2, 1, 1, 'et', 'LUS978', 'Id a facere quae repellat.', '201.00', 'NON_VEG', 'https://via.placeholder.com/640x480.png/002266?text=totam', 1, 1, '5.00', '{\"cgst\": 2.5, \"sgst\": 2.5}', 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(3, 1, 1, 'aspernatur', 'JVI512', 'Sed in nostrum voluptatem quia iusto minus vitae.', '185.00', 'VEG', 'https://via.placeholder.com/640x480.png/006677?text=aut', 1, 1, '5.00', '{\"cgst\": 2.5, \"sgst\": 2.5}', 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(4, 1, 2, 'excepturi', 'VKW785', 'Pariatur dolorum cupiditate cum eaque.', '123.00', 'NON_VEG', 'https://via.placeholder.com/640x480.png/0033aa?text=illum', 1, 1, '5.00', '{\"cgst\": 2.5, \"sgst\": 2.5}', 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(5, 1, 2, 'commodi', 'CES381', 'Ipsa sunt deleniti facilis aspernatur similique.', '298.00', 'EGG', 'https://via.placeholder.com/640x480.png/003344?text=eum', 1, 1, '5.00', '{\"cgst\": 2.5, \"sgst\": 2.5}', 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(6, 1, 2, 'qui', 'WWT501', 'Voluptates qui sunt eligendi iusto aut.', '350.00', 'EGG', 'https://via.placeholder.com/640x480.png/005588?text=unde', 1, 1, '5.00', '{\"cgst\": 2.5, \"sgst\": 2.5}', 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(7, 1, 3, 'delectus', 'HOD098', 'Quia rerum quia sed quos in recusandae ratione.', '115.00', 'VEG', 'https://via.placeholder.com/640x480.png/00ee44?text=rem', 1, 1, '5.00', '{\"cgst\": 2.5, \"sgst\": 2.5}', 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(8, 1, 3, 'laudantium', 'RAS531', 'Aliquid voluptas tempore aut perspiciatis quae aspernatur.', '218.00', 'VEG', 'https://via.placeholder.com/640x480.png/006600?text=quia', 1, 1, '5.00', '{\"cgst\": 2.5, \"sgst\": 2.5}', 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(9, 1, 3, 'soluta', 'ZCM865', 'Dolores dolores voluptas et.', '460.00', 'EGG', 'https://via.placeholder.com/640x480.png/009966?text=enim', 1, 1, '5.00', '{\"cgst\": 2.5, \"sgst\": 2.5}', 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(10, 1, 4, 'quia', 'RJO280', 'Qui voluptate officiis quas in.', '372.00', 'NON_VEG', 'https://via.placeholder.com/640x480.png/00ccee?text=et', 1, 1, '5.00', '{\"cgst\": 2.5, \"sgst\": 2.5}', 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(11, 1, 4, 'sint', 'YFL671', 'Dolorum est delectus sit beatae magni aliquam modi odit.', '192.00', 'EGG', 'https://via.placeholder.com/640x480.png/00dd88?text=hic', 1, 1, '5.00', '{\"cgst\": 2.5, \"sgst\": 2.5}', 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(12, 1, 4, 'nulla', 'FWW392', 'Provident temporibus est et quod voluptatem omnis et.', '354.00', 'NON_VEG', 'https://via.placeholder.com/640x480.png/00dd55?text=beatae', 1, 1, '5.00', '{\"cgst\": 2.5, \"sgst\": 2.5}', 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(13, 2, 5, 'voluptatibus', 'OUX144', 'Ut nisi maiores error fuga laborum.', '405.00', 'EGG', 'https://via.placeholder.com/640x480.png/00cc44?text=sed', 1, 1, '5.00', '{\"cgst\": 2.5, \"sgst\": 2.5}', 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(14, 2, 5, 'ea', 'NBJ261', 'Ut eos omnis eaque eius impedit illo et corporis.', '150.00', 'VEG', 'https://via.placeholder.com/640x480.png/000033?text=recusandae', 1, 1, '5.00', '{\"cgst\": 2.5, \"sgst\": 2.5}', 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(15, 2, 5, 'et', 'IMN410', 'Ipsam repellendus provident et dolor nihil.', '259.00', 'NON_VEG', 'https://via.placeholder.com/640x480.png/005511?text=labore', 1, 1, '5.00', '{\"cgst\": 2.5, \"sgst\": 2.5}', 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(16, 2, 6, 'eius', 'QGP423', 'Enim voluptatem accusamus et ut.', '453.00', 'VEG', 'https://via.placeholder.com/640x480.png/00ddbb?text=ipsam', 1, 1, '5.00', '{\"cgst\": 2.5, \"sgst\": 2.5}', 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(17, 2, 6, 'aut', 'LDN137', 'Voluptatem qui praesentium quaerat consequatur nisi non.', '306.00', 'VEG', 'https://via.placeholder.com/640x480.png/007766?text=sequi', 1, 1, '5.00', '{\"cgst\": 2.5, \"sgst\": 2.5}', 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(18, 2, 6, 'facere', 'ALU846', 'Eum dolorum saepe ipsum ipsam eius eius.', '171.00', 'NON_VEG', 'https://via.placeholder.com/640x480.png/0088dd?text=ut', 1, 1, '5.00', '{\"cgst\": 2.5, \"sgst\": 2.5}', 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(19, 2, 7, 'sit', 'TII920', 'Alias eligendi officia numquam qui alias ut.', '333.00', 'EGG', 'https://via.placeholder.com/640x480.png/00ddbb?text=dolorum', 1, 1, '5.00', '{\"cgst\": 2.5, \"sgst\": 2.5}', 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(20, 2, 7, 'at', 'VVI684', 'Non officia suscipit velit.', '347.00', 'EGG', 'https://via.placeholder.com/640x480.png/00cc66?text=vel', 1, 1, '5.00', '{\"cgst\": 2.5, \"sgst\": 2.5}', 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(21, 2, 7, 'sunt', 'JSP043', 'Dolore ab accusamus ipsum quia.', '252.00', 'NON_VEG', 'https://via.placeholder.com/640x480.png/0033aa?text=distinctio', 1, 1, '5.00', '{\"cgst\": 2.5, \"sgst\": 2.5}', 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(22, 2, 8, 'iure', 'OQU077', 'Aut itaque distinctio voluptas fugit earum fugiat.', '414.00', 'VEG', 'https://via.placeholder.com/640x480.png/008855?text=ut', 1, 1, '5.00', '{\"cgst\": 2.5, \"sgst\": 2.5}', 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(23, 2, 8, 'mollitia', 'OCA906', 'Est inventore sapiente minus ullam dolorum dolores.', '449.00', 'NON_VEG', 'https://via.placeholder.com/640x480.png/0033ff?text=nihil', 1, 1, '5.00', '{\"cgst\": 2.5, \"sgst\": 2.5}', 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(24, 2, 8, 'non', 'MBJ187', 'Perferendis saepe ut quos voluptas et iure.', '372.00', 'EGG', 'https://via.placeholder.com/640x480.png/0011aa?text=sed', 1, 1, '5.00', '{\"cgst\": 2.5, \"sgst\": 2.5}', 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(25, 3, 9, 'consequatur', 'AFW489', 'Voluptas repudiandae perspiciatis vel esse pariatur animi cumque.', '337.00', 'NON_VEG', 'https://via.placeholder.com/640x480.png/007722?text=velit', 1, 1, '5.00', '{\"cgst\": 2.5, \"sgst\": 2.5}', 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(26, 3, 9, 'placeat', 'ZMA546', 'Ut ut quasi sunt iusto modi.', '174.00', 'VEG', 'https://via.placeholder.com/640x480.png/0066aa?text=id', 1, 1, '5.00', '{\"cgst\": 2.5, \"sgst\": 2.5}', 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(27, 3, 9, 'culpa', 'CNJ845', 'Illo incidunt et fuga.', '317.00', 'EGG', 'https://via.placeholder.com/640x480.png/001155?text=error', 1, 1, '5.00', '{\"cgst\": 2.5, \"sgst\": 2.5}', 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(28, 3, 10, 'voluptas', 'MXQ751', 'Ut facere asperiores quia voluptatem sit ipsa provident.', '364.00', 'NON_VEG', 'https://via.placeholder.com/640x480.png/0077ee?text=ab', 1, 1, '5.00', '{\"cgst\": 2.5, \"sgst\": 2.5}', 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(29, 3, 10, 'dolor', 'OEG086', 'Voluptatum nam voluptate labore in.', '410.00', 'NON_VEG', 'https://via.placeholder.com/640x480.png/009900?text=nobis', 1, 1, '5.00', '{\"cgst\": 2.5, \"sgst\": 2.5}', 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(30, 3, 10, 'fuga', 'PIN869', 'Ipsa et quia voluptas ipsa omnis accusamus mollitia.', '253.00', 'NON_VEG', 'https://via.placeholder.com/640x480.png/00dd00?text=dignissimos', 1, 1, '5.00', '{\"cgst\": 2.5, \"sgst\": 2.5}', 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(31, 3, 11, 'aut', 'KRJ078', 'Aperiam ratione distinctio explicabo.', '152.00', 'NON_VEG', 'https://via.placeholder.com/640x480.png/0033ee?text=nesciunt', 1, 1, '5.00', '{\"cgst\": 2.5, \"sgst\": 2.5}', 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(32, 3, 11, 'quia', 'CEZ423', 'Voluptatem vel dolore a debitis quia qui dicta et.', '284.00', 'VEG', 'https://via.placeholder.com/640x480.png/0000dd?text=perspiciatis', 1, 1, '5.00', '{\"cgst\": 2.5, \"sgst\": 2.5}', 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(33, 3, 11, 'quo', 'QOV237', 'Quam quae dicta fuga voluptas vero perferendis.', '155.00', 'EGG', 'https://via.placeholder.com/640x480.png/00ee88?text=rerum', 1, 1, '5.00', '{\"cgst\": 2.5, \"sgst\": 2.5}', 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(34, 3, 12, 'fugit', 'RGK061', 'Et accusamus soluta quo qui quas non autem quibusdam.', '305.00', 'EGG', 'https://via.placeholder.com/640x480.png/0011cc?text=asperiores', 1, 1, '5.00', '{\"cgst\": 2.5, \"sgst\": 2.5}', 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(35, 3, 12, 'quidem', 'JXN862', 'Magni cupiditate eos laboriosam quia ratione.', '284.00', 'EGG', 'https://via.placeholder.com/640x480.png/0000ee?text=laboriosam', 1, 1, '5.00', '{\"cgst\": 2.5, \"sgst\": 2.5}', 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(36, 3, 12, 'temporibus', 'WSJ700', 'Ut impedit fugiat illo optio inventore quo.', '140.00', 'EGG', 'https://via.placeholder.com/640x480.png/00ccbb?text=ab', 1, 1, '5.00', '{\"cgst\": 2.5, \"sgst\": 2.5}', 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(37, 4, 13, 'nisi', 'XHX936', 'Dolore dolorem in qui.', '225.00', 'VEG', 'https://via.placeholder.com/640x480.png/004455?text=itaque', 1, 1, '5.00', '{\"cgst\": 2.5, \"sgst\": 2.5}', 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(38, 4, 13, 'in', 'JHE839', 'Et quia nobis ut eos adipisci pariatur ut.', '340.00', 'VEG', 'https://via.placeholder.com/640x480.png/00aa88?text=sequi', 1, 1, '5.00', '{\"cgst\": 2.5, \"sgst\": 2.5}', 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(39, 4, 13, 'maxime', 'KVV959', 'Aut odit qui molestiae sapiente et.', '388.00', 'EGG', 'https://via.placeholder.com/640x480.png/003355?text=quas', 1, 1, '5.00', '{\"cgst\": 2.5, \"sgst\": 2.5}', 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(40, 4, 14, 'pariatur', 'ZKU046', 'Reprehenderit exercitationem eligendi a.', '417.00', 'VEG', 'https://via.placeholder.com/640x480.png/0099aa?text=porro', 1, 1, '5.00', '{\"cgst\": 2.5, \"sgst\": 2.5}', 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(41, 4, 14, 'iure', 'LEG093', 'Ratione ipsa sunt quo incidunt neque facilis et.', '205.00', 'NON_VEG', 'https://via.placeholder.com/640x480.png/009933?text=est', 1, 1, '5.00', '{\"cgst\": 2.5, \"sgst\": 2.5}', 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(42, 4, 14, 'est', 'ADQ664', 'Non doloribus est unde mollitia dolores minima accusamus.', '195.00', 'EGG', 'https://via.placeholder.com/640x480.png/002244?text=iure', 1, 1, '5.00', '{\"cgst\": 2.5, \"sgst\": 2.5}', 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(43, 4, 15, 'ea', 'NUC868', 'Hic provident veritatis omnis velit quia.', '273.00', 'NON_VEG', 'https://via.placeholder.com/640x480.png/0055bb?text=modi', 1, 1, '5.00', '{\"cgst\": 2.5, \"sgst\": 2.5}', 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(44, 4, 15, 'qui', 'CGJ556', 'Nulla corrupti asperiores fuga culpa a amet.', '400.00', 'NON_VEG', 'https://via.placeholder.com/640x480.png/008800?text=quidem', 1, 1, '5.00', '{\"cgst\": 2.5, \"sgst\": 2.5}', 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(45, 4, 15, 'enim', 'GTZ422', 'Molestias et aut porro et ipsa.', '168.00', 'EGG', 'https://via.placeholder.com/640x480.png/005522?text=occaecati', 1, 1, '5.00', '{\"cgst\": 2.5, \"sgst\": 2.5}', 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(46, 4, 16, 'quia', 'GJI784', 'Facere omnis est nihil aliquid sit fuga.', '145.00', 'EGG', 'https://via.placeholder.com/640x480.png/00bb77?text=nobis', 1, 1, '5.00', '{\"cgst\": 2.5, \"sgst\": 2.5}', 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(47, 4, 16, 'temporibus', 'LAD355', 'Sed autem dolores in repellendus perspiciatis illum.', '148.00', 'NON_VEG', 'https://via.placeholder.com/640x480.png/0066ee?text=temporibus', 1, 1, '5.00', '{\"cgst\": 2.5, \"sgst\": 2.5}', 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(48, 4, 16, 'est', 'ZVF846', 'Repellat sit hic pariatur vitae eos.', '251.00', 'NON_VEG', 'https://via.placeholder.com/640x480.png/001199?text=sint', 1, 1, '5.00', '{\"cgst\": 2.5, \"sgst\": 2.5}', 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(49, 5, 17, 'reiciendis', 'MGO017', 'Ea in sit et et laborum et expedita.', '498.00', 'VEG', 'https://via.placeholder.com/640x480.png/009922?text=explicabo', 1, 1, '5.00', '{\"cgst\": 2.5, \"sgst\": 2.5}', 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(50, 5, 17, 'voluptas', 'YBN303', 'Ducimus rerum labore id nihil laudantium adipisci adipisci doloremque.', '154.00', 'EGG', 'https://via.placeholder.com/640x480.png/00ff55?text=quibusdam', 1, 1, '5.00', '{\"cgst\": 2.5, \"sgst\": 2.5}', 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(51, 5, 17, 'nobis', 'EGE905', 'Ut minima tempora autem ut sint facere.', '387.00', 'EGG', 'https://via.placeholder.com/640x480.png/001111?text=consequatur', 1, 1, '5.00', '{\"cgst\": 2.5, \"sgst\": 2.5}', 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(52, 5, 18, 'quos', 'IVK523', 'Minima ratione unde autem odit alias quod ipsum.', '456.00', 'VEG', 'https://via.placeholder.com/640x480.png/005533?text=ut', 1, 1, '5.00', '{\"cgst\": 2.5, \"sgst\": 2.5}', 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(53, 5, 18, 'voluptates', 'SKB294', 'Commodi minus inventore explicabo quia et nostrum pariatur.', '396.00', 'EGG', 'https://via.placeholder.com/640x480.png/00cc99?text=voluptas', 1, 1, '5.00', '{\"cgst\": 2.5, \"sgst\": 2.5}', 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(54, 5, 18, 'sapiente', 'ADR998', 'Ratione rem rerum et sed aspernatur nihil autem.', '202.00', 'NON_VEG', 'https://via.placeholder.com/640x480.png/00ccaa?text=sed', 1, 1, '5.00', '{\"cgst\": 2.5, \"sgst\": 2.5}', 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(55, 5, 19, 'maxime', 'VRB479', 'Qui sit et veritatis rem.', '148.00', 'NON_VEG', 'https://via.placeholder.com/640x480.png/00dd55?text=ut', 1, 1, '5.00', '{\"cgst\": 2.5, \"sgst\": 2.5}', 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(56, 5, 19, 'cupiditate', 'QQF081', 'Et nemo explicabo atque voluptate tempora vel.', '294.00', 'EGG', 'https://via.placeholder.com/640x480.png/0033bb?text=omnis', 1, 1, '5.00', '{\"cgst\": 2.5, \"sgst\": 2.5}', 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(57, 5, 19, 'consequuntur', 'SAT640', 'Vero totam ipsam mollitia sit.', '301.00', 'NON_VEG', 'https://via.placeholder.com/640x480.png/0055dd?text=possimus', 1, 1, '5.00', '{\"cgst\": 2.5, \"sgst\": 2.5}', 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(58, 5, 20, 'enim', 'KWB463', 'Libero officia perferendis dolorem aut quasi tempora.', '257.00', 'NON_VEG', 'https://via.placeholder.com/640x480.png/00cc22?text=est', 1, 1, '5.00', '{\"cgst\": 2.5, \"sgst\": 2.5}', 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(59, 5, 20, 'cumque', 'WWL006', 'Aliquid sed est saepe omnis nam consequatur provident non.', '387.00', 'EGG', 'https://via.placeholder.com/640x480.png/00bb99?text=corrupti', 1, 1, '5.00', '{\"cgst\": 2.5, \"sgst\": 2.5}', 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(60, 5, 20, 'sit', 'RMK032', 'Saepe ab nemo atque.', '404.00', 'EGG', 'https://via.placeholder.com/640x480.png/00aa00?text=beatae', 1, 1, '5.00', '{\"cgst\": 2.5, \"sgst\": 2.5}', 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(61, 6, 21, 'sit', 'GWI797', 'Id sit eos voluptatem.', '232.00', 'EGG', 'https://via.placeholder.com/640x480.png/00ee33?text=voluptates', 1, 1, '5.00', '{\"cgst\": 2.5, \"sgst\": 2.5}', 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(62, 6, 21, 'reiciendis', 'RYI944', 'Aliquid deserunt eos culpa harum voluptas aut quaerat.', '313.00', 'NON_VEG', 'https://via.placeholder.com/640x480.png/002288?text=pariatur', 1, 1, '5.00', '{\"cgst\": 2.5, \"sgst\": 2.5}', 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(63, 6, 21, 'consequatur', 'BZX199', 'Eligendi aut omnis perspiciatis iusto.', '233.00', 'EGG', 'https://via.placeholder.com/640x480.png/005577?text=sit', 1, 1, '5.00', '{\"cgst\": 2.5, \"sgst\": 2.5}', 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(64, 6, 22, 'nihil', 'BZZ922', 'Facere harum delectus animi voluptas officia et corrupti.', '212.00', 'NON_VEG', 'https://via.placeholder.com/640x480.png/001166?text=ipsum', 1, 1, '5.00', '{\"cgst\": 2.5, \"sgst\": 2.5}', 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(65, 6, 22, 'ut', 'QAT503', 'Qui nihil quasi quaerat accusantium dignissimos consectetur.', '251.00', 'EGG', 'https://via.placeholder.com/640x480.png/00eeff?text=sunt', 1, 1, '5.00', '{\"cgst\": 2.5, \"sgst\": 2.5}', 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(66, 6, 22, 'maiores', 'HAZ723', 'Ducimus quia est facilis deleniti voluptatem nihil.', '452.00', 'NON_VEG', 'https://via.placeholder.com/640x480.png/00cc99?text=dolorum', 1, 1, '5.00', '{\"cgst\": 2.5, \"sgst\": 2.5}', 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(67, 6, 23, 'molestiae', 'CCI197', 'Eveniet totam ut sed provident rerum dolore ut.', '303.00', 'VEG', 'https://via.placeholder.com/640x480.png/006622?text=nostrum', 1, 1, '5.00', '{\"cgst\": 2.5, \"sgst\": 2.5}', 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(68, 6, 23, 'doloribus', 'RUX727', 'Voluptatem iusto corrupti et ut debitis.', '313.00', 'EGG', 'https://via.placeholder.com/640x480.png/0033bb?text=quia', 1, 1, '5.00', '{\"cgst\": 2.5, \"sgst\": 2.5}', 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(69, 6, 23, 'est', 'NRN826', 'Est nisi voluptas illum modi nostrum sed.', '366.00', 'NON_VEG', 'https://via.placeholder.com/640x480.png/004422?text=nihil', 1, 1, '5.00', '{\"cgst\": 2.5, \"sgst\": 2.5}', 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(70, 6, 24, 'minus', 'XQP184', 'Natus est eligendi neque odio facere.', '285.00', 'NON_VEG', 'https://via.placeholder.com/640x480.png/00dd22?text=dolore', 1, 1, '5.00', '{\"cgst\": 2.5, \"sgst\": 2.5}', 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(71, 6, 24, 'corrupti', 'KET265', 'Sunt non beatae consequuntur excepturi omnis quae.', '127.00', 'VEG', 'https://via.placeholder.com/640x480.png/0022ee?text=quas', 1, 1, '5.00', '{\"cgst\": 2.5, \"sgst\": 2.5}', 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(72, 6, 24, 'ea', 'CGV842', 'Odio dicta iusto omnis vitae fugit impedit.', '498.00', 'NON_VEG', 'https://via.placeholder.com/640x480.png/0055bb?text=sunt', 1, 1, '5.00', '{\"cgst\": 2.5, \"sgst\": 2.5}', 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(73, 7, 25, 'eveniet', 'MGP409', 'Minima nam quia ut enim.', '425.00', 'EGG', 'https://via.placeholder.com/640x480.png/004455?text=ab', 1, 1, '5.00', '{\"cgst\": 2.5, \"sgst\": 2.5}', 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(74, 7, 25, 'quam', 'VXD872', 'Omnis deleniti placeat qui alias.', '434.00', 'VEG', 'https://via.placeholder.com/640x480.png/00cc55?text=enim', 1, 1, '5.00', '{\"cgst\": 2.5, \"sgst\": 2.5}', 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(75, 7, 25, 'velit', 'FPF963', 'Similique occaecati vel libero repellat.', '390.00', 'NON_VEG', 'https://via.placeholder.com/640x480.png/003344?text=sit', 1, 1, '5.00', '{\"cgst\": 2.5, \"sgst\": 2.5}', 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(76, 7, 26, 'doloribus', 'IZO353', 'Aut ut nesciunt ipsum.', '320.00', 'NON_VEG', 'https://via.placeholder.com/640x480.png/0088ff?text=nihil', 1, 1, '5.00', '{\"cgst\": 2.5, \"sgst\": 2.5}', 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(77, 7, 26, 'assumenda', 'BRO480', 'Laudantium et recusandae illum ea sit.', '437.00', 'EGG', 'https://via.placeholder.com/640x480.png/009900?text=voluptatem', 1, 1, '5.00', '{\"cgst\": 2.5, \"sgst\": 2.5}', 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(78, 7, 26, 'laudantium', 'SNB479', 'Aut quo veritatis quo autem veritatis placeat.', '371.00', 'VEG', 'https://via.placeholder.com/640x480.png/00ff11?text=non', 1, 1, '5.00', '{\"cgst\": 2.5, \"sgst\": 2.5}', 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(79, 7, 27, 'corporis', 'MYH915', 'Dicta iusto molestiae tempora deserunt.', '470.00', 'NON_VEG', 'https://via.placeholder.com/640x480.png/0077aa?text=eius', 1, 1, '5.00', '{\"cgst\": 2.5, \"sgst\": 2.5}', 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(80, 7, 27, 'est', 'LNS373', 'Dolorem sunt est eveniet non id laudantium voluptates.', '115.00', 'EGG', 'https://via.placeholder.com/640x480.png/009955?text=beatae', 1, 1, '5.00', '{\"cgst\": 2.5, \"sgst\": 2.5}', 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(81, 7, 27, 'repellendus', 'VVH052', 'Animi dolore ipsam eum.', '151.00', 'VEG', 'https://via.placeholder.com/640x480.png/001122?text=officia', 1, 1, '5.00', '{\"cgst\": 2.5, \"sgst\": 2.5}', 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(82, 7, 28, 'suscipit', 'OIS264', 'Repellat architecto aut voluptate voluptatibus nam.', '305.00', 'NON_VEG', 'https://via.placeholder.com/640x480.png/00ff55?text=ullam', 1, 1, '5.00', '{\"cgst\": 2.5, \"sgst\": 2.5}', 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(83, 7, 28, 'sit', 'LYP465', 'Nam et reiciendis quis voluptatem.', '123.00', 'EGG', 'https://via.placeholder.com/640x480.png/003399?text=rerum', 1, 1, '5.00', '{\"cgst\": 2.5, \"sgst\": 2.5}', 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(84, 7, 28, 'ipsam', 'KHI957', 'Omnis qui ex molestiae quas.', '393.00', 'EGG', 'https://via.placeholder.com/640x480.png/00ccdd?text=voluptas', 1, 1, '5.00', '{\"cgst\": 2.5, \"sgst\": 2.5}', 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(85, 8, 29, 'ut', 'XFY707', 'Possimus alias suscipit recusandae porro iusto assumenda.', '335.00', 'EGG', 'https://via.placeholder.com/640x480.png/001111?text=et', 1, 1, '5.00', '{\"cgst\": 2.5, \"sgst\": 2.5}', 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(86, 8, 29, 'fugit', 'PLV856', 'Enim laborum corrupti est et error voluptatem commodi.', '303.00', 'VEG', 'https://via.placeholder.com/640x480.png/00aa88?text=blanditiis', 1, 1, '5.00', '{\"cgst\": 2.5, \"sgst\": 2.5}', 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(87, 8, 29, 'ut', 'OKG554', 'Modi quaerat quo culpa.', '451.00', 'VEG', 'https://via.placeholder.com/640x480.png/008811?text=consequatur', 1, 1, '5.00', '{\"cgst\": 2.5, \"sgst\": 2.5}', 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(88, 8, 30, 'ut', 'TZA731', 'Dolor magni neque et totam velit mollitia nulla.', '443.00', 'NON_VEG', 'https://via.placeholder.com/640x480.png/005533?text=velit', 1, 1, '5.00', '{\"cgst\": 2.5, \"sgst\": 2.5}', 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(89, 8, 30, 'iusto', 'DGX818', 'Error nostrum magni est non voluptas quaerat.', '497.00', 'VEG', 'https://via.placeholder.com/640x480.png/006677?text=expedita', 1, 1, '5.00', '{\"cgst\": 2.5, \"sgst\": 2.5}', 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(90, 8, 30, 'aperiam', 'KGH570', 'Reprehenderit ut quaerat minima aliquid fuga et.', '398.00', 'VEG', 'https://via.placeholder.com/640x480.png/0000ff?text=quibusdam', 1, 1, '5.00', '{\"cgst\": 2.5, \"sgst\": 2.5}', 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(91, 8, 31, 'nam', 'QVB618', 'Quibusdam qui voluptatem voluptatem dolor dolores.', '101.00', 'NON_VEG', 'https://via.placeholder.com/640x480.png/007700?text=vitae', 1, 1, '5.00', '{\"cgst\": 2.5, \"sgst\": 2.5}', 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(92, 8, 31, 'quia', 'KBF411', 'Facilis mollitia et omnis.', '185.00', 'NON_VEG', 'https://via.placeholder.com/640x480.png/00aa88?text=voluptatem', 1, 1, '5.00', '{\"cgst\": 2.5, \"sgst\": 2.5}', 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(93, 8, 31, 'esse', 'PLH815', 'Consequatur sed provident earum est id cumque.', '237.00', 'NON_VEG', 'https://via.placeholder.com/640x480.png/003377?text=eos', 1, 1, '5.00', '{\"cgst\": 2.5, \"sgst\": 2.5}', 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(94, 8, 32, 'ab', 'HKX406', 'Quia dolores vero sapiente sapiente.', '181.00', 'EGG', 'https://via.placeholder.com/640x480.png/00bb88?text=cupiditate', 1, 1, '5.00', '{\"cgst\": 2.5, \"sgst\": 2.5}', 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(95, 8, 32, 'quia', 'WCE915', 'Dolorum est ut a atque numquam.', '208.00', 'NON_VEG', 'https://via.placeholder.com/640x480.png/00aaee?text=illo', 1, 1, '5.00', '{\"cgst\": 2.5, \"sgst\": 2.5}', 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(96, 8, 32, 'perspiciatis', 'IGY108', 'Animi quasi qui veniam consequatur.', '138.00', 'NON_VEG', 'https://via.placeholder.com/640x480.png/009911?text=in', 1, 1, '5.00', '{\"cgst\": 2.5, \"sgst\": 2.5}', 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(97, 9, 33, 'eos', 'YQK398', 'Dolores facere soluta nemo ipsam nulla non mollitia.', '277.00', 'VEG', 'https://via.placeholder.com/640x480.png/00aa99?text=beatae', 1, 1, '5.00', '{\"cgst\": 2.5, \"sgst\": 2.5}', 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(98, 9, 33, 'optio', 'ULM216', 'Atque sequi possimus maxime laborum nostrum expedita.', '125.00', 'VEG', 'https://via.placeholder.com/640x480.png/00bbcc?text=minima', 1, 1, '5.00', '{\"cgst\": 2.5, \"sgst\": 2.5}', 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(99, 9, 33, 'et', 'RBT943', 'Rem voluptate id magnam qui quo aut.', '320.00', 'NON_VEG', 'https://via.placeholder.com/640x480.png/00aaff?text=quia', 1, 1, '5.00', '{\"cgst\": 2.5, \"sgst\": 2.5}', 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(100, 9, 34, 'atque', 'UBH262', 'Unde in mollitia deserunt occaecati.', '210.00', 'VEG', 'https://via.placeholder.com/640x480.png/00ccbb?text=tempora', 1, 1, '5.00', '{\"cgst\": 2.5, \"sgst\": 2.5}', 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(101, 9, 34, 'dolores', 'GXA385', 'Sunt porro quia illo.', '410.00', 'NON_VEG', 'https://via.placeholder.com/640x480.png/00eecc?text=commodi', 1, 1, '5.00', '{\"cgst\": 2.5, \"sgst\": 2.5}', 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(102, 9, 34, 'vitae', 'IKJ861', 'Quis non et accusantium sequi quisquam.', '138.00', 'EGG', 'https://via.placeholder.com/640x480.png/00ee33?text=nulla', 1, 1, '5.00', '{\"cgst\": 2.5, \"sgst\": 2.5}', 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(103, 9, 35, 'rerum', 'BIJ121', 'Dignissimos ipsa voluptas illum aspernatur tenetur ea.', '239.00', 'NON_VEG', 'https://via.placeholder.com/640x480.png/008877?text=aut', 1, 1, '5.00', '{\"cgst\": 2.5, \"sgst\": 2.5}', 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(104, 9, 35, 'eaque', 'OHH814', 'Est quia ab ipsa eaque ex reprehenderit dignissimos.', '169.00', 'NON_VEG', 'https://via.placeholder.com/640x480.png/007799?text=consequatur', 1, 1, '5.00', '{\"cgst\": 2.5, \"sgst\": 2.5}', 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(105, 9, 35, 'dolorum', 'SFS350', 'Fugiat asperiores reprehenderit dolores quo sit.', '326.00', 'EGG', 'https://via.placeholder.com/640x480.png/00bb22?text=sequi', 1, 1, '5.00', '{\"cgst\": 2.5, \"sgst\": 2.5}', 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(106, 9, 36, 'natus', 'CBA379', 'Esse fuga ut qui debitis perspiciatis.', '344.00', 'NON_VEG', 'https://via.placeholder.com/640x480.png/006600?text=consectetur', 1, 1, '5.00', '{\"cgst\": 2.5, \"sgst\": 2.5}', 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(107, 9, 36, 'nihil', 'LLX015', 'Corrupti nihil commodi voluptatibus provident et ut.', '115.00', 'EGG', 'https://via.placeholder.com/640x480.png/0088ff?text=ut', 1, 1, '5.00', '{\"cgst\": 2.5, \"sgst\": 2.5}', 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(108, 9, 36, 'sit', 'GMN161', 'Consequatur ad culpa sit quasi ipsa ratione non.', '239.00', 'EGG', 'https://via.placeholder.com/640x480.png/00ee99?text=et', 1, 1, '5.00', '{\"cgst\": 2.5, \"sgst\": 2.5}', 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(109, 10, 37, 'voluptatem', 'XFN886', 'Esse facilis sint cumque pariatur.', '179.00', 'EGG', 'https://via.placeholder.com/640x480.png/002266?text=aspernatur', 1, 1, '5.00', '{\"cgst\": 2.5, \"sgst\": 2.5}', 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(110, 10, 37, 'sit', 'VBA607', 'Fugiat porro a quo excepturi necessitatibus recusandae.', '428.00', 'EGG', 'https://via.placeholder.com/640x480.png/004400?text=ut', 1, 1, '5.00', '{\"cgst\": 2.5, \"sgst\": 2.5}', 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(111, 10, 37, 'earum', 'KSD169', 'Rerum aut reprehenderit perspiciatis maxime totam.', '170.00', 'NON_VEG', 'https://via.placeholder.com/640x480.png/00bb44?text=modi', 1, 1, '5.00', '{\"cgst\": 2.5, \"sgst\": 2.5}', 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(112, 10, 38, 'sed', 'SLF324', 'Est nulla suscipit aliquid praesentium nostrum vero.', '161.00', 'EGG', 'https://via.placeholder.com/640x480.png/008844?text=laborum', 1, 1, '5.00', '{\"cgst\": 2.5, \"sgst\": 2.5}', 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(113, 10, 38, 'et', 'SSZ861', 'Ex distinctio exercitationem fugiat officia perferendis non.', '394.00', 'NON_VEG', 'https://via.placeholder.com/640x480.png/0033bb?text=aspernatur', 1, 1, '5.00', '{\"cgst\": 2.5, \"sgst\": 2.5}', 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(114, 10, 38, 'accusantium', 'NIS936', 'Et ipsa animi modi impedit.', '397.00', 'VEG', 'https://via.placeholder.com/640x480.png/008866?text=rem', 1, 1, '5.00', '{\"cgst\": 2.5, \"sgst\": 2.5}', 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(115, 10, 39, 'ut', 'RDY847', 'Blanditiis corrupti facere ut omnis natus molestiae.', '375.00', 'EGG', 'https://via.placeholder.com/640x480.png/00ee66?text=minima', 1, 1, '5.00', '{\"cgst\": 2.5, \"sgst\": 2.5}', 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(116, 10, 39, 'quam', 'UUQ296', 'Sed voluptatem quidem natus hic earum voluptatem dicta assumenda.', '487.00', 'EGG', 'https://via.placeholder.com/640x480.png/0022ff?text=ipsam', 1, 1, '5.00', '{\"cgst\": 2.5, \"sgst\": 2.5}', 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(117, 10, 39, 'eum', 'DEW044', 'Eos atque harum odio.', '264.00', 'NON_VEG', 'https://via.placeholder.com/640x480.png/00aa44?text=rerum', 1, 1, '5.00', '{\"cgst\": 2.5, \"sgst\": 2.5}', 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(118, 10, 40, 'nemo', 'STZ277', 'Nihil fuga quam iure necessitatibus.', '420.00', 'VEG', 'https://via.placeholder.com/640x480.png/003399?text=laudantium', 1, 1, '5.00', '{\"cgst\": 2.5, \"sgst\": 2.5}', 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(119, 10, 40, 'aliquam', 'TMW967', 'Non alias laborum harum aut dolorum.', '260.00', 'EGG', 'https://via.placeholder.com/640x480.png/00ff33?text=voluptas', 1, 1, '5.00', '{\"cgst\": 2.5, \"sgst\": 2.5}', 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(120, 10, 40, 'harum', 'XRF476', 'Optio itaque magni velit blanditiis velit qui.', '281.00', 'NON_VEG', 'https://via.placeholder.com/640x480.png/00ee77?text=qui', 1, 1, '5.00', '{\"cgst\": 2.5, \"sgst\": 2.5}', 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39');

-- --------------------------------------------------------

--
-- Table structure for table `menu_master`
--

CREATE TABLE `menu_master` (
  `menu_master_id` int NOT NULL,
  `menu_category_id` int NOT NULL,
  `diaplay_name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `url` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `status` enum('Active','Inactive') COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'Inactive'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `order_id` bigint UNSIGNED NOT NULL,
  `restaurant_id` bigint UNSIGNED NOT NULL,
  `table_id` bigint UNSIGNED DEFAULT NULL,
  `customer_id` bigint UNSIGNED DEFAULT NULL,
  `waiter_id` bigint UNSIGNED DEFAULT NULL,
  `order_type` enum('DINE_IN','TAKEAWAY') COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'DINE_IN',
  `status` enum('PLACED','PREPARING','READY','SERVED','COMPLETED','CANCELLED') COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'PLACED',
  `placed_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `completed_at` datetime DEFAULT NULL,
  `subtotal_amount` decimal(12,2) NOT NULL DEFAULT '0.00',
  `discount_amount` decimal(12,2) NOT NULL DEFAULT '0.00',
  `service_charge_pct` decimal(5,2) NOT NULL DEFAULT '0.00',
  `service_charge_amt` decimal(12,2) NOT NULL DEFAULT '0.00',
  `tax_amount` decimal(12,2) NOT NULL DEFAULT '0.00',
  `rounding_adjustment` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_payable` decimal(12,2) NOT NULL DEFAULT '0.00',
  `tax_breakdown` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `notes` varchar(500) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `payment_status` enum('UNPAID','PARTIAL','PAID','REFUNDED') COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'UNPAID',
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `added_by` bigint UNSIGNED NOT NULL,
  `updated_by` bigint UNSIGNED DEFAULT NULL,
  `added_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`order_id`, `restaurant_id`, `table_id`, `customer_id`, `waiter_id`, `order_type`, `status`, `placed_at`, `completed_at`, `subtotal_amount`, `discount_amount`, `service_charge_pct`, `service_charge_amt`, `tax_amount`, `rounding_adjustment`, `total_payable`, `tax_breakdown`, `notes`, `payment_status`, `is_active`, `added_by`, `updated_by`, `added_date`, `updated_date`) VALUES
(1, 1, 4, 2, 4, 'DINE_IN', 'PLACED', '2025-09-06 16:46:39', NULL, '897.00', '0.00', '5.00', '50.00', '30.00', '0.00', '1080.00', '{\"cgst\": 15, \"sgst\": 15}', 'Temporibus consectetur quaerat autem vitae quia.', 'UNPAID', 1, 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(2, 1, 4, 4, 5, 'DINE_IN', 'PLACED', '2025-09-06 16:46:39', NULL, '765.00', '0.00', '5.00', '50.00', '30.00', '0.00', '1080.00', '{\"cgst\": 15, \"sgst\": 15}', 'Cumque quo harum dolores impedit earum quam.', 'UNPAID', 1, 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(3, 2, 7, 8, 11, 'DINE_IN', 'PLACED', '2025-09-06 16:46:39', NULL, '230.00', '0.00', '5.00', '50.00', '30.00', '0.00', '1080.00', '{\"cgst\": 15, \"sgst\": 15}', 'A repellendus voluptas at iste sint impedit.', 'UNPAID', 1, 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(4, 2, 8, 10, 7, 'DINE_IN', 'PLACED', '2025-09-06 16:46:39', NULL, '906.00', '0.00', '5.00', '50.00', '30.00', '0.00', '1080.00', '{\"cgst\": 15, \"sgst\": 15}', 'Magni et non sed facere omnis eum accusamus.', 'UNPAID', 1, 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(5, 3, 15, 15, 17, 'DINE_IN', 'PLACED', '2025-09-06 16:46:39', NULL, '232.00', '0.00', '5.00', '50.00', '30.00', '0.00', '1080.00', '{\"cgst\": 15, \"sgst\": 15}', 'Nam recusandae exercitationem quo sapiente.', 'UNPAID', 1, 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(6, 3, 14, 14, 14, 'DINE_IN', 'PLACED', '2025-09-06 16:46:39', NULL, '486.00', '0.00', '5.00', '50.00', '30.00', '0.00', '1080.00', '{\"cgst\": 15, \"sgst\": 15}', 'Illo quaerat ducimus necessitatibus.', 'UNPAID', 1, 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(7, 4, 21, 20, 19, 'DINE_IN', 'PLACED', '2025-09-06 16:46:39', NULL, '671.00', '0.00', '5.00', '50.00', '30.00', '0.00', '1080.00', '{\"cgst\": 15, \"sgst\": 15}', 'Et soluta qui possimus vel molestiae.', 'UNPAID', 1, 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(8, 4, 19, 17, 22, 'DINE_IN', 'PLACED', '2025-09-06 16:46:39', NULL, '588.00', '0.00', '5.00', '50.00', '30.00', '0.00', '1080.00', '{\"cgst\": 15, \"sgst\": 15}', 'Quia earum et provident esse nemo in repellendus est.', 'UNPAID', 1, 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(9, 5, 29, 21, 30, 'DINE_IN', 'PLACED', '2025-09-06 16:46:39', NULL, '680.00', '0.00', '5.00', '50.00', '30.00', '0.00', '1080.00', '{\"cgst\": 15, \"sgst\": 15}', 'Fugiat omnis modi repudiandae ab.', 'UNPAID', 1, 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(10, 5, 25, 22, 28, 'DINE_IN', 'PLACED', '2025-09-06 16:46:39', NULL, '846.00', '0.00', '5.00', '50.00', '30.00', '0.00', '1080.00', '{\"cgst\": 15, \"sgst\": 15}', 'Quasi dolorum autem quasi velit ea aut aperiam veniam.', 'UNPAID', 1, 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(11, 6, 34, 30, 36, 'DINE_IN', 'PLACED', '2025-09-06 16:46:39', NULL, '749.00', '0.00', '5.00', '50.00', '30.00', '0.00', '1080.00', '{\"cgst\": 15, \"sgst\": 15}', 'Quia dolor ut ipsam.', 'UNPAID', 1, 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(12, 6, 35, 28, 35, 'DINE_IN', 'PLACED', '2025-09-06 16:46:39', NULL, '135.00', '0.00', '5.00', '50.00', '30.00', '0.00', '1080.00', '{\"cgst\": 15, \"sgst\": 15}', 'Et et qui architecto sunt et totam.', 'UNPAID', 1, 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(13, 7, 40, 33, 42, 'DINE_IN', 'PLACED', '2025-09-06 16:46:39', NULL, '794.00', '0.00', '5.00', '50.00', '30.00', '0.00', '1080.00', '{\"cgst\": 15, \"sgst\": 15}', 'Autem et omnis nostrum quas aut.', 'UNPAID', 1, 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(14, 7, 41, 32, 41, 'DINE_IN', 'PLACED', '2025-09-06 16:46:39', NULL, '514.00', '0.00', '5.00', '50.00', '30.00', '0.00', '1080.00', '{\"cgst\": 15, \"sgst\": 15}', 'Est dicta quidem consequuntur ratione suscipit.', 'UNPAID', 1, 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(15, 8, 45, 36, 45, 'DINE_IN', 'PLACED', '2025-09-06 16:46:39', NULL, '765.00', '0.00', '5.00', '50.00', '30.00', '0.00', '1080.00', '{\"cgst\": 15, \"sgst\": 15}', 'Aut nam illo consequatur placeat et.', 'UNPAID', 1, 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(16, 8, 47, 37, 48, 'DINE_IN', 'PLACED', '2025-09-06 16:46:39', NULL, '515.00', '0.00', '5.00', '50.00', '30.00', '0.00', '1080.00', '{\"cgst\": 15, \"sgst\": 15}', 'Voluptatem ea provident aut dignissimos quo.', 'UNPAID', 1, 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(17, 9, 50, 41, 54, 'DINE_IN', 'PLACED', '2025-09-06 16:46:39', NULL, '206.00', '0.00', '5.00', '50.00', '30.00', '0.00', '1080.00', '{\"cgst\": 15, \"sgst\": 15}', 'Modi quia dignissimos dignissimos sit sed.', 'UNPAID', 1, 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(18, 9, 49, 44, 52, 'DINE_IN', 'PLACED', '2025-09-06 16:46:39', NULL, '856.00', '0.00', '5.00', '50.00', '30.00', '0.00', '1080.00', '{\"cgst\": 15, \"sgst\": 15}', 'Laudantium repudiandae labore sit.', 'UNPAID', 1, 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(19, 10, 60, 48, 55, 'DINE_IN', 'PLACED', '2025-09-06 16:46:39', NULL, '401.00', '0.00', '5.00', '50.00', '30.00', '0.00', '1080.00', '{\"cgst\": 15, \"sgst\": 15}', 'Tenetur perferendis consequatur qui nobis.', 'UNPAID', 1, 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(20, 10, 56, 48, 60, 'DINE_IN', 'PLACED', '2025-09-06 16:46:39', NULL, '751.00', '0.00', '5.00', '50.00', '30.00', '0.00', '1080.00', '{\"cgst\": 15, \"sgst\": 15}', 'Dignissimos sint dolorum nostrum qui illum.', 'UNPAID', 1, 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39');

-- --------------------------------------------------------

--
-- Table structure for table `order_items`
--

CREATE TABLE `order_items` (
  `order_item_id` bigint UNSIGNED NOT NULL,
  `order_id` bigint UNSIGNED NOT NULL,
  `item_id` bigint UNSIGNED NOT NULL,
  `item_name` varchar(150) COLLATE utf8mb4_general_ci NOT NULL,
  `veg_type` enum('VEG','NON_VEG','EGG') COLLATE utf8mb4_general_ci NOT NULL,
  `unit_price` decimal(12,2) NOT NULL,
  `quantity` decimal(10,2) NOT NULL DEFAULT '1.00',
  `notes` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `tax_rate` decimal(5,2) NOT NULL DEFAULT '0.00',
  `tax_breakdown` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `tax_amount` decimal(12,2) NOT NULL DEFAULT '0.00',
  `line_subtotal` decimal(12,2) NOT NULL DEFAULT '0.00',
  `line_discount` decimal(12,2) NOT NULL DEFAULT '0.00',
  `line_total` decimal(12,2) NOT NULL DEFAULT '0.00',
  `added_by` bigint UNSIGNED NOT NULL,
  `updated_by` bigint UNSIGNED DEFAULT NULL,
  `added_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ;

--
-- Dumping data for table `order_items`
--

INSERT INTO `order_items` (`order_item_id`, `order_id`, `item_id`, `item_name`, `veg_type`, `unit_price`, `quantity`, `notes`, `tax_rate`, `tax_breakdown`, `tax_amount`, `line_subtotal`, `line_discount`, `line_total`, `added_by`, `updated_by`, `added_date`, `updated_date`) VALUES
(1, 1, 1, 'Paneer Tikka', 'VEG', '250.00', '2.00', NULL, '5.00', NULL, '25.00', '500.00', '0.00', '525.00', 1, 1, '2025-09-09 05:38:59', '2025-10-02 16:13:27'),
(2, 1, 5, 'Butter Naan', 'VEG', '60.00', '3.00', NULL, '5.00', NULL, '9.00', '180.00', '0.00', '189.00', 1, 1, '2025-09-09 05:38:59', '2025-10-02 16:13:27'),
(3, 1, 8, 'Mango Lassi', 'VEG', '150.00', '1.00', NULL, '5.00', NULL, '7.50', '150.00', '0.00', '157.50', 1, 1, '2025-09-09 05:38:59', '2025-10-02 16:13:27'),
(4, 2, 2, 'Chicken Tikka', 'NON_VEG', '300.00', '2.00', NULL, '5.00', NULL, '30.00', '600.00', '0.00', '630.00', 1, 1, '2025-09-09 05:38:59', '2025-10-02 16:13:27'),
(5, 2, 3, 'Butter Chicken', 'NON_VEG', '350.00', '1.00', NULL, '5.00', NULL, '17.50', '350.00', '0.00', '367.50', 1, 1, '2025-09-09 05:38:59', '2025-10-02 16:13:27'),
(6, 2, 5, 'Butter Naan', 'VEG', '60.00', '2.00', NULL, '5.00', NULL, '6.00', '120.00', '0.00', '126.00', 1, 1, '2025-09-09 05:38:59', '2025-10-02 16:13:27'),
(7, 2, 8, 'Mango Lassi', 'VEG', '150.00', '1.00', NULL, '5.00', NULL, '7.50', '150.00', '0.00', '157.50', 1, 1, '2025-09-09 05:38:59', '2025-10-02 16:13:27'),
(8, 3, 4, 'Paneer Butter Masala', 'VEG', '320.00', '1.00', NULL, '5.00', NULL, '16.00', '320.00', '0.00', '336.00', 1, 1, '2025-09-09 05:38:59', '2025-10-02 16:13:27'),
(9, 3, 5, 'Butter Naan', 'VEG', '60.00', '2.00', NULL, '5.00', NULL, '6.00', '120.00', '0.00', '126.00', 1, 1, '2025-09-09 05:38:59', '2025-10-02 16:13:27'),
(10, 3, 6, 'Vegetable Biryani', 'VEG', '280.00', '1.00', NULL, '5.00', NULL, '14.00', '280.00', '0.00', '294.00', 1, 1, '2025-09-09 05:38:59', '2025-10-02 16:13:27');

-- --------------------------------------------------------

--
-- Table structure for table `order_item_addons`
--

CREATE TABLE `order_item_addons` (
  `order_item_addon_id` bigint UNSIGNED NOT NULL,
  `order_item_id` bigint UNSIGNED NOT NULL,
  `addon_option_id` bigint UNSIGNED NOT NULL,
  `addon_name` varchar(120) COLLATE utf8mb4_general_ci NOT NULL,
  `price_delta` decimal(12,2) NOT NULL DEFAULT '0.00',
  `added_by` bigint UNSIGNED NOT NULL,
  `added_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `order_status_history`
--

CREATE TABLE `order_status_history` (
  `order_status_history_id` bigint UNSIGNED NOT NULL,
  `order_id` bigint UNSIGNED NOT NULL,
  `from_status` enum('PLACED','PREPARING','READY','SERVED','COMPLETED','CANCELLED') COLLATE utf8mb4_general_ci DEFAULT NULL,
  `to_status` enum('PLACED','PREPARING','READY','SERVED','COMPLETED','CANCELLED') COLLATE utf8mb4_general_ci NOT NULL,
  `updated_by` bigint UNSIGNED DEFAULT NULL,
  `updated_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `note` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `order_status_history`
--

INSERT INTO `order_status_history` (`order_status_history_id`, `order_id`, `from_status`, `to_status`, `updated_by`, `updated_date`, `note`) VALUES
(1, 1, 'PLACED', 'PREPARING', 1, '2025-09-06 16:46:39', 'Order started'),
(2, 2, 'PLACED', 'PREPARING', 1, '2025-09-06 16:46:39', 'Order started'),
(3, 3, 'PLACED', 'PREPARING', 1, '2025-09-06 16:46:39', 'Order started'),
(4, 4, 'PLACED', 'PREPARING', 1, '2025-09-06 16:46:39', 'Order started'),
(5, 5, 'PLACED', 'PREPARING', 1, '2025-09-06 16:46:39', 'Order started'),
(6, 6, 'PLACED', 'PREPARING', 1, '2025-09-06 16:46:39', 'Order started'),
(7, 7, 'PLACED', 'PREPARING', 1, '2025-09-06 16:46:39', 'Order started'),
(8, 8, 'PLACED', 'PREPARING', 1, '2025-09-06 16:46:39', 'Order started'),
(9, 9, 'PLACED', 'PREPARING', 1, '2025-09-06 16:46:39', 'Order started'),
(10, 10, 'PLACED', 'PREPARING', 1, '2025-09-06 16:46:39', 'Order started'),
(11, 11, 'PLACED', 'PREPARING', 1, '2025-09-06 16:46:39', 'Order started'),
(12, 12, 'PLACED', 'PREPARING', 1, '2025-09-06 16:46:39', 'Order started'),
(13, 13, 'PLACED', 'PREPARING', 1, '2025-09-06 16:46:39', 'Order started'),
(14, 14, 'PLACED', 'PREPARING', 1, '2025-09-06 16:46:39', 'Order started'),
(15, 15, 'PLACED', 'PREPARING', 1, '2025-09-06 16:46:39', 'Order started'),
(16, 16, 'PLACED', 'PREPARING', 1, '2025-09-06 16:46:39', 'Order started'),
(17, 17, 'PLACED', 'PREPARING', 1, '2025-09-06 16:46:39', 'Order started'),
(18, 18, 'PLACED', 'PREPARING', 1, '2025-09-06 16:46:39', 'Order started'),
(19, 19, 'PLACED', 'PREPARING', 1, '2025-09-06 16:46:39', 'Order started'),
(20, 20, 'PLACED', 'PREPARING', 1, '2025-09-06 16:46:39', 'Order started');

-- --------------------------------------------------------

--
-- Table structure for table `payments`
--

CREATE TABLE `payments` (
  `payment_id` bigint UNSIGNED NOT NULL,
  `restaurant_id` bigint UNSIGNED NOT NULL,
  `order_id` bigint UNSIGNED NOT NULL,
  `bill_id` bigint UNSIGNED DEFAULT NULL,
  `method` enum('CASH','CARD','UPI','WALLET') COLLATE utf8mb4_general_ci NOT NULL,
  `amount` decimal(12,2) NOT NULL,
  `status` enum('PENDING','SUCCESS','FAILED','REFUNDED') COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'PENDING',
  `txn_ref` varchar(120) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `gateway_name` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `payload` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `paid_at` datetime DEFAULT NULL,
  `added_by` bigint UNSIGNED NOT NULL,
  `updated_by` bigint UNSIGNED DEFAULT NULL,
  `added_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ;

--
-- Dumping data for table `payments`
--

INSERT INTO `payments` (`payment_id`, `restaurant_id`, `order_id`, `bill_id`, `method`, `amount`, `status`, `txn_ref`, `gateway_name`, `payload`, `paid_at`, `added_by`, `updated_by`, `added_date`, `updated_date`) VALUES
(1, 1, 1, NULL, 'CASH', '232.00', 'SUCCESS', 'TXN03365', 'DummyGateway', '{\"info\": \"dummy\"}', '2025-09-06 16:46:39', 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(2, 1, 2, NULL, 'CASH', '216.00', 'SUCCESS', 'TXN18674', 'DummyGateway', '{\"info\": \"dummy\"}', '2025-09-06 16:46:39', 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(3, 2, 3, NULL, 'CASH', '184.00', 'SUCCESS', 'TXN00760', 'DummyGateway', '{\"info\": \"dummy\"}', '2025-09-06 16:46:39', 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(4, 2, 4, NULL, 'CASH', '394.00', 'SUCCESS', 'TXN73797', 'DummyGateway', '{\"info\": \"dummy\"}', '2025-09-06 16:46:39', 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(5, 3, 5, NULL, 'CASH', '120.00', 'SUCCESS', 'TXN78397', 'DummyGateway', '{\"info\": \"dummy\"}', '2025-09-06 16:46:39', 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(6, 3, 6, NULL, 'CASH', '424.00', 'SUCCESS', 'TXN67542', 'DummyGateway', '{\"info\": \"dummy\"}', '2025-09-06 16:46:39', 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(7, 4, 7, NULL, 'CASH', '289.00', 'SUCCESS', 'TXN60803', 'DummyGateway', '{\"info\": \"dummy\"}', '2025-09-06 16:46:39', 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(8, 4, 8, NULL, 'CASH', '473.00', 'SUCCESS', 'TXN59695', 'DummyGateway', '{\"info\": \"dummy\"}', '2025-09-06 16:46:39', 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(9, 5, 9, NULL, 'CASH', '269.00', 'SUCCESS', 'TXN09580', 'DummyGateway', '{\"info\": \"dummy\"}', '2025-09-06 16:46:39', 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(10, 5, 10, NULL, 'CASH', '485.00', 'SUCCESS', 'TXN83999', 'DummyGateway', '{\"info\": \"dummy\"}', '2025-09-06 16:46:39', 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(11, 6, 11, NULL, 'CASH', '363.00', 'SUCCESS', 'TXN28890', 'DummyGateway', '{\"info\": \"dummy\"}', '2025-09-06 16:46:39', 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(12, 6, 12, NULL, 'CASH', '237.00', 'SUCCESS', 'TXN43516', 'DummyGateway', '{\"info\": \"dummy\"}', '2025-09-06 16:46:39', 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(13, 7, 13, NULL, 'CASH', '303.00', 'SUCCESS', 'TXN17470', 'DummyGateway', '{\"info\": \"dummy\"}', '2025-09-06 16:46:39', 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(14, 7, 14, NULL, 'CASH', '213.00', 'SUCCESS', 'TXN53446', 'DummyGateway', '{\"info\": \"dummy\"}', '2025-09-06 16:46:39', 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(15, 8, 15, NULL, 'CASH', '444.00', 'SUCCESS', 'TXN61625', 'DummyGateway', '{\"info\": \"dummy\"}', '2025-09-06 16:46:39', 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(16, 8, 16, NULL, 'CASH', '392.00', 'SUCCESS', 'TXN26087', 'DummyGateway', '{\"info\": \"dummy\"}', '2025-09-06 16:46:39', 1, NULL, '2025-09-06 16:46:39', '2025-09-06 16:46:39'),
(17, 9, 17, NULL, 'CASH', '358.00', 'SUCCESS', 'TXN58075', 'DummyGateway', '{\"info\": \"dummy\"}', '2025-09-06 16:46:40', 1, NULL, '2025-09-06 16:46:40', '2025-09-06 16:46:40'),
(18, 9, 18, NULL, 'CASH', '356.00', 'SUCCESS', 'TXN51729', 'DummyGateway', '{\"info\": \"dummy\"}', '2025-09-06 16:46:40', 1, NULL, '2025-09-06 16:46:40', '2025-09-06 16:46:40'),
(19, 10, 19, NULL, 'CASH', '245.00', 'SUCCESS', 'TXN06290', 'DummyGateway', '{\"info\": \"dummy\"}', '2025-09-06 16:46:40', 1, NULL, '2025-09-06 16:46:40', '2025-09-06 16:46:40'),
(20, 10, 20, NULL, 'CASH', '105.00', 'SUCCESS', 'TXN08062', 'DummyGateway', '{\"info\": \"dummy\"}', '2025-09-06 16:46:40', 1, NULL, '2025-09-06 16:46:40', '2025-09-06 16:46:40');

-- --------------------------------------------------------

--
-- Table structure for table `permissions`
--

CREATE TABLE `permissions` (
  `permission_id` bigint UNSIGNED NOT NULL,
  `code` varchar(120) COLLATE utf8mb4_general_ci NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `permissions`
--

INSERT INTO `permissions` (`permission_id`, `code`, `description`) VALUES
(1, 'menu.read', 'Menu read'),
(2, 'order.manage', 'Order manage'),
(3, 'payment.process', 'Payment process'),
(4, 'user.create', 'User create'),
(5, 'reservation.manage', 'Reservation manage');

-- --------------------------------------------------------

--
-- Table structure for table `reservations`
--

CREATE TABLE `reservations` (
  `reservation_id` bigint UNSIGNED NOT NULL,
  `restaurant_id` bigint UNSIGNED NOT NULL,
  `table_id` bigint UNSIGNED DEFAULT NULL,
  `customer_id` bigint UNSIGNED DEFAULT NULL,
  `guest_name` varchar(150) COLLATE utf8mb4_general_ci NOT NULL,
  `guest_phone` varchar(25) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `party_size` int NOT NULL DEFAULT '2',
  `start_time` datetime NOT NULL,
  `end_time` datetime NOT NULL,
  `status` enum('PENDING','CONFIRMED','SEATED','CANCELLED','NO_SHOW','COMPLETED') COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'PENDING',
  `notes` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `added_by` bigint UNSIGNED NOT NULL,
  `updated_by` bigint UNSIGNED DEFAULT NULL,
  `added_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `reservations`
--

INSERT INTO `reservations` (`reservation_id`, `restaurant_id`, `table_id`, `customer_id`, `guest_name`, `guest_phone`, `party_size`, `start_time`, `end_time`, `status`, `notes`, `added_by`, `updated_by`, `added_date`, `updated_date`) VALUES
(1, 1, NULL, 27, 'Cordelia McKenzie', '+12398250496', 2, '2025-09-06 17:46:40', '2025-09-06 19:46:40', 'PENDING', 'A omnis qui inventore ratione perspiciatis magni.', 1, NULL, '2025-09-06 16:46:40', '2025-09-06 16:46:40'),
(2, 1, NULL, 26, 'Leland Marquardt', '815.332.8657', 4, '2025-09-06 18:46:40', '2025-09-06 20:46:40', 'PENDING', 'Consectetur et quam impedit minima quaerat.', 1, NULL, '2025-09-06 16:46:40', '2025-09-06 16:46:40'),
(3, 2, NULL, 45, 'Mrs. Corine Ferry', '1-681-792-2411', 5, '2025-09-06 17:46:40', '2025-09-06 19:46:40', 'PENDING', 'Vel ab commodi libero ut amet in vero.', 1, NULL, '2025-09-06 16:46:40', '2025-09-06 16:46:40'),
(4, 2, NULL, 20, 'Emory Powlowski', '+1-283-294-1726', 2, '2025-09-06 18:46:40', '2025-09-06 20:46:40', 'PENDING', 'Quae vitae mollitia adipisci molestias.', 1, NULL, '2025-09-06 16:46:40', '2025-09-06 16:46:40'),
(5, 3, NULL, 23, 'Prof. Markus Orn DVM', '1-661-649-0490', 6, '2025-09-06 17:46:40', '2025-09-06 19:46:40', 'PENDING', 'Minus adipisci et sed perspiciatis molestias.', 1, NULL, '2025-09-06 16:46:40', '2025-09-06 16:46:40'),
(6, 3, NULL, 33, 'Ruby Waters', '+1.727.865.7943', 3, '2025-09-06 18:46:40', '2025-09-06 20:46:40', 'PENDING', 'Amet nam odit cumque qui at.', 1, NULL, '2025-09-06 16:46:40', '2025-09-06 16:46:40'),
(7, 4, NULL, 11, 'Daija Osinski Sr.', '276-530-4202', 6, '2025-09-06 17:46:40', '2025-09-06 19:46:40', 'PENDING', 'Laboriosam ut harum nisi ducimus aut dignissimos.', 1, NULL, '2025-09-06 16:46:40', '2025-09-06 16:46:40'),
(8, 4, NULL, 22, 'Roberto Schoen', '+1.682.314.6361', 6, '2025-09-06 18:46:40', '2025-09-06 20:46:40', 'PENDING', 'Enim labore ab mollitia quas non enim.', 1, NULL, '2025-09-06 16:46:40', '2025-09-06 16:46:40'),
(9, 5, NULL, 10, 'Gabriel Green', '331-571-1546', 5, '2025-09-06 17:46:40', '2025-09-06 19:46:40', 'PENDING', 'Qui quasi nostrum voluptate suscipit aut nobis.', 1, NULL, '2025-09-06 16:46:40', '2025-09-06 16:46:40'),
(10, 5, NULL, 26, 'Leland Marquardt', '+1-716-683-1889', 6, '2025-09-06 18:46:40', '2025-09-06 20:46:40', 'PENDING', 'Assumenda nisi molestias pariatur consectetur sunt.', 1, NULL, '2025-09-06 16:46:40', '2025-09-06 16:46:40'),
(11, 6, NULL, 35, 'Noe Turcotte', '+17705167628', 6, '2025-09-06 17:46:40', '2025-09-06 19:46:40', 'PENDING', 'Maxime voluptas ad tempora eligendi ut vel earum.', 1, NULL, '2025-09-06 16:46:40', '2025-09-06 16:46:40'),
(12, 6, NULL, 28, 'Prof. Noemy Sauer Jr.', '442-719-9739', 4, '2025-09-06 18:46:40', '2025-09-06 20:46:40', 'PENDING', 'Accusamus dolor molestiae nesciunt.', 1, NULL, '2025-09-06 16:46:40', '2025-09-06 16:46:40'),
(13, 7, NULL, 50, 'Jeffry Becker Jr.', '(203) 574-3272', 4, '2025-09-06 17:46:40', '2025-09-06 19:46:40', 'PENDING', 'Harum quae odio pariatur unde ratione qui.', 1, NULL, '2025-09-06 16:46:40', '2025-09-06 16:46:40'),
(14, 7, NULL, 8, 'Noemie O\'Conner', '+1 (310) 424-9851', 4, '2025-09-06 18:46:40', '2025-09-06 20:46:40', 'PENDING', 'Consequatur expedita natus perferendis aut dolorem sit expedita.', 1, NULL, '2025-09-06 16:46:40', '2025-09-06 16:46:40'),
(15, 8, NULL, 5, 'Arno Eichmann', '(551) 495-2429', 1, '2025-09-06 17:46:40', '2025-09-06 19:46:40', 'PENDING', 'Deleniti quia odit dolores ipsa in illo qui.', 1, NULL, '2025-09-06 16:46:40', '2025-09-06 16:46:40'),
(16, 8, NULL, 7, 'Marcella Koelpin DDS', '309-419-1320', 1, '2025-09-06 18:46:40', '2025-09-06 20:46:40', 'PENDING', 'Quidem velit nihil delectus blanditiis rerum sed.', 1, NULL, '2025-09-06 16:46:40', '2025-09-06 16:46:40'),
(17, 9, NULL, 43, 'Ms. Kayla Schmeler', '317.785.3403', 2, '2025-09-06 17:46:40', '2025-09-06 19:46:40', 'PENDING', 'Voluptatem rerum odit nobis architecto et.', 1, NULL, '2025-09-06 16:46:40', '2025-09-06 16:46:40'),
(18, 9, NULL, 22, 'Roberto Schoen', '678-895-3173', 4, '2025-09-06 18:46:40', '2025-09-06 20:46:40', 'PENDING', 'Quidem doloremque sequi sit aliquid rem maxime doloremque.', 1, NULL, '2025-09-06 16:46:40', '2025-09-06 16:46:40'),
(19, 10, NULL, 48, 'Prof. Randy Schultz', '+1-979-425-5448', 5, '2025-09-06 17:46:40', '2025-09-06 19:46:40', 'PENDING', 'Quis voluptatem molestiae omnis veniam unde iusto aspernatur.', 1, NULL, '2025-09-06 16:46:40', '2025-09-06 16:46:40'),
(20, 10, NULL, 38, 'Burdette Stiedemann', '+1-740-363-3747', 1, '2025-09-06 18:46:40', '2025-09-06 20:46:40', 'PENDING', 'Eos id repellendus et eum dolorem non libero aut.', 1, NULL, '2025-09-06 16:46:40', '2025-09-06 16:46:40');

-- --------------------------------------------------------

--
-- Table structure for table `restaurants`
--

CREATE TABLE `restaurants` (
  `restaurant_id` bigint UNSIGNED NOT NULL,
  `name` varchar(150) COLLATE utf8mb4_general_ci NOT NULL,
  `legal_name` varchar(200) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `gstin` varchar(20) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `contact_email` varchar(150) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `contact_phone` varchar(25) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `address_line1` varchar(200) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `address_line2` varchar(200) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `city` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `state` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `postal_code` varchar(20) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `country` varchar(100) COLLATE utf8mb4_general_ci DEFAULT 'India',
  `logo_url` varchar(500) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `timezone` varchar(64) COLLATE utf8mb4_general_ci DEFAULT 'Asia/Kolkata',
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `added_by` bigint UNSIGNED NOT NULL,
  `updated_by` bigint UNSIGNED DEFAULT NULL,
  `added_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `restaurants`
--

INSERT INTO `restaurants` (`restaurant_id`, `name`, `legal_name`, `gstin`, `contact_email`, `contact_phone`, `address_line1`, `address_line2`, `city`, `state`, `postal_code`, `country`, `logo_url`, `timezone`, `is_active`, `added_by`, `updated_by`, `added_date`, `updated_date`) VALUES
(1, 'Thiel, Batz and Labadie', 'Hansen LLC Pvt Ltd', 'HL6566745535R', 'kiarra.gleason@hotmail.com', '+1 (832) 383-6175', '7567 Hegmann Stream Suite 462', 'Apt. 810', 'Lisandrobury', 'District of Columbia', '44205', 'India', 'https://via.placeholder.com/640x480.png/002244?text=itaque', 'Asia/Kolkata', 1, 1, NULL, '2025-09-06 16:46:34', '2025-09-06 16:46:34'),
(2, 'Bartoletti, Macejkovic and Tromp', 'Nienow, Kuhn and Hodkiewicz Pvt Ltd', 'UV2389528818D', 'ivah.lynch@yahoo.com', '952.424.0782', '1726 Ewell Orchard', 'Suite 739', 'Bryonmouth', 'Mississippi', '16516-1166', 'India', 'https://via.placeholder.com/640x480.png/0033ff?text=magni', 'Asia/Kolkata', 1, 1, NULL, '2025-09-06 16:46:34', '2025-09-06 16:46:34'),
(3, 'Boehm, Hills and Rosenbaum', 'Von Inc Pvt Ltd', 'UP6492584105F', 'gorczany.ida@hotmail.com', '+1-720-718-6303', '47045 Gunner Knoll', 'Suite 006', 'Flatleyton', 'New York', '78773-1503', 'India', 'https://via.placeholder.com/640x480.png/00cc33?text=aut', 'Asia/Kolkata', 1, 1, NULL, '2025-09-06 16:46:34', '2025-09-06 16:46:34'),
(4, 'Hermann, Hane and Hermiston', 'Kemmer PLC Pvt Ltd', 'SX6832448263W', 'stephen85@gmail.com', '283.490.9504', '681 Ibrahim Divide', 'Suite 255', 'East Dorothy', 'North Dakota', '44154', 'India', 'https://via.placeholder.com/640x480.png/00ff99?text=laboriosam', 'Asia/Kolkata', 1, 1, NULL, '2025-09-06 16:46:34', '2025-09-06 16:46:34'),
(5, 'Raynor-Kulas', 'Ernser-Hauck Pvt Ltd', 'QZ9604699155B', 'zbins@gmail.com', '646-538-3938', '951 Joe Mountains Suite 033', 'Suite 447', 'Lake Yvonnehaven', 'Texas', '72259-0301', 'India', 'https://via.placeholder.com/640x480.png/0011cc?text=possimus', 'Asia/Kolkata', 1, 1, NULL, '2025-09-06 16:46:34', '2025-09-06 16:46:34'),
(6, 'Sporer-Mills', 'Baumbach-Kirlin Pvt Ltd', 'MG7529792775K', 'jeff.strosin@yahoo.com', '+1-862-437-3124', '6516 Yvette Club Apt. 605', 'Apt. 797', 'Port Lorenzfurt', 'Montana', '42641-0104', 'India', 'https://via.placeholder.com/640x480.png/00ee44?text=eveniet', 'Asia/Kolkata', 1, 1, NULL, '2025-09-06 16:46:34', '2025-09-06 16:46:34'),
(7, 'Fahey and Sons', 'Swift, Labadie and VonRueden Pvt Ltd', 'YO9488643198B', 'robel.franz@hansen.biz', '+1 (947) 200-1609', '3533 Kuvalis Radial Apt. 008', 'Apt. 812', 'North Estefania', 'Ohio', '77960', 'India', 'https://via.placeholder.com/640x480.png/00ccff?text=et', 'Asia/Kolkata', 1, 1, NULL, '2025-09-06 16:46:34', '2025-09-06 16:46:34'),
(8, 'Lubowitz, Adams and Hodkiewicz', 'Jones-Abbott Pvt Ltd', 'AU1664049866N', 'kutch.emmitt@fahey.com', '(646) 231-7897', '5874 Alena Lake Apt. 200', 'Apt. 194', 'North Adalberto', 'Louisiana', '96968', 'India', 'https://via.placeholder.com/640x480.png/00ee66?text=non', 'Asia/Kolkata', 1, 1, NULL, '2025-09-06 16:46:34', '2025-09-06 16:46:34'),
(9, 'Prohaska PLC', 'O\'Hara, Auer and Wisoky Pvt Ltd', 'BQ7756570453M', 'rhea.reilly@mccullough.com', '423-905-5659', '8416 Leila Turnpike Apt. 108', 'Apt. 951', 'Tellymouth', 'Alaska', '84917-3660', 'India', 'https://via.placeholder.com/640x480.png/0033dd?text=sit', 'Asia/Kolkata', 1, 1, NULL, '2025-09-06 16:46:34', '2025-09-06 16:46:34'),
(10, 'Bernier PLC', 'Paucek, Dicki and Berge Pvt Ltd', 'NS7736065454V', 'stiedemann.guadalupe@stokes.com', '1-757-631-4231', '8361 Quitzon Drive Suite 041', 'Apt. 740', 'Virgieberg', 'Georgia', '88515', 'India', 'https://via.placeholder.com/640x480.png/0088cc?text=est', 'Asia/Kolkata', 1, 1, NULL, '2025-09-06 16:46:34', '2025-09-06 16:46:34');

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `role_id` bigint UNSIGNED NOT NULL,
  `restaurant_id` bigint UNSIGNED NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `is_system` tinyint(1) NOT NULL DEFAULT '0',
  `added_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `added_by` bigint UNSIGNED NOT NULL,
  `updated_by` bigint UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`role_id`, `restaurant_id`, `name`, `description`, `is_system`, `added_date`, `updated_date`, `added_by`, `updated_by`) VALUES
(1, 1, 'Economist', 'Est suscipit quam officiis ut.', 0, '2025-09-06 16:46:34', '2025-09-06 16:46:34', 1, NULL),
(2, 1, 'Fiberglass Laminator and Fabricator', 'Aliquam aut est quia esse rerum quidem.', 1, '2025-09-06 16:46:34', '2025-09-06 16:46:34', 1, NULL),
(3, 1, 'Interviewer', 'Aut quos neque amet dolorem mollitia eos.', 1, '2025-09-06 16:46:34', '2025-09-06 16:46:34', 1, NULL),
(4, 2, 'Technical Specialist', 'Ut eos facilis aut provident maiores.', 0, '2025-09-06 16:46:34', '2025-09-06 16:46:34', 1, NULL),
(5, 2, 'Director Of Social Media Marketing', 'Quia nobis et corrupti ut eveniet.', 1, '2025-09-06 16:46:34', '2025-09-06 16:46:34', 1, NULL),
(6, 2, 'Power Plant Operator', 'Ab vel accusantium dolore ut sed.', 0, '2025-09-06 16:46:34', '2025-09-06 16:46:34', 1, NULL),
(7, 3, 'Bindery Machine Operator', 'Nulla est libero aut et.', 1, '2025-09-06 16:46:34', '2025-09-06 16:46:34', 1, NULL),
(8, 3, 'Conveyor Operator', 'Nemo iure voluptatem possimus facilis.', 1, '2025-09-06 16:46:34', '2025-09-06 16:46:34', 1, NULL),
(9, 3, 'Social Service Specialists', 'Veniam est architecto suscipit consequatur beatae.', 1, '2025-09-06 16:46:34', '2025-09-06 16:46:34', 1, NULL),
(10, 4, 'Glazier', 'Nostrum accusamus illo molestias quasi voluptas consequatur ad.', 1, '2025-09-06 16:46:34', '2025-09-06 16:46:34', 1, NULL),
(11, 4, 'Printing Machine Operator', 'Omnis quos quisquam et vitae explicabo in repudiandae.', 1, '2025-09-06 16:46:34', '2025-09-06 16:46:34', 1, NULL),
(12, 4, 'Soil Scientist', 'Voluptates doloremque suscipit similique.', 0, '2025-09-06 16:46:34', '2025-09-06 16:46:34', 1, NULL),
(13, 5, 'Nursing Aide', 'Enim et deleniti quam dolores veniam voluptas blanditiis.', 1, '2025-09-06 16:46:34', '2025-09-06 16:46:34', 1, NULL),
(14, 5, 'Travel Guide', 'Atque non nemo labore ut magnam.', 1, '2025-09-06 16:46:34', '2025-09-06 16:46:34', 1, NULL),
(15, 5, 'Aircraft Launch Specialist', 'Ut laboriosam eius aliquam doloribus non provident.', 1, '2025-09-06 16:46:34', '2025-09-06 16:46:34', 1, NULL),
(16, 6, 'Philosophy and Religion Teacher', 'Molestias ex facere deserunt accusamus.', 1, '2025-09-06 16:46:34', '2025-09-06 16:46:34', 1, NULL),
(17, 6, 'Usher', 'Voluptas consectetur est autem consectetur et et qui neque.', 1, '2025-09-06 16:46:34', '2025-09-06 16:46:34', 1, NULL),
(18, 6, 'Actuary', 'Tempora et blanditiis odio sunt ab dolor.', 1, '2025-09-06 16:46:34', '2025-09-06 16:46:34', 1, NULL),
(19, 7, 'Business Manager', 'Placeat sit id delectus sint numquam voluptas assumenda voluptatum.', 1, '2025-09-06 16:46:34', '2025-09-06 16:46:34', 1, NULL),
(20, 7, 'Plumber OR Pipefitter OR Steamfitter', 'Praesentium omnis aut quibusdam cupiditate natus quaerat molestias.', 0, '2025-09-06 16:46:34', '2025-09-06 16:46:34', 1, NULL),
(21, 7, 'CSI', 'Vel voluptas similique eum omnis debitis suscipit facilis.', 1, '2025-09-06 16:46:34', '2025-09-06 16:46:34', 1, NULL),
(22, 8, 'Financial Analyst', 'Impedit amet repellat commodi voluptatibus.', 0, '2025-09-06 16:46:34', '2025-09-06 16:46:34', 1, NULL),
(23, 8, 'Commercial and Industrial Designer', 'Vel sequi eveniet error eos.', 0, '2025-09-06 16:46:34', '2025-09-06 16:46:34', 1, NULL),
(24, 8, 'ccc', 'Et eligendi harum totam libero voluptate dolor.', 0, '2025-09-06 16:46:34', '2025-09-06 16:46:34', 1, NULL),
(25, 9, 'Printing Machine Operator', 'Debitis provident consequatur laboriosam assumenda dolores quis sed.', 1, '2025-09-06 16:46:34', '2025-09-06 16:46:34', 1, NULL),
(26, 9, 'Life Science Technician', 'Facere voluptatibus error est similique consectetur.', 0, '2025-09-06 16:46:34', '2025-09-06 16:46:34', 1, NULL),
(27, 9, 'Purchasing Agent', 'Omnis voluptatum earum ut autem.', 0, '2025-09-06 16:46:34', '2025-09-06 16:46:34', 1, NULL),
(28, 10, 'Child Care', 'Quod saepe atque recusandae.', 1, '2025-09-06 16:46:34', '2025-09-06 16:46:34', 1, NULL),
(29, 10, 'Merchandise Displayer OR Window Trimmer', 'Nemo minima voluptas perspiciatis voluptates.', 0, '2025-09-06 16:46:34', '2025-09-06 16:46:34', 1, NULL),
(30, 10, 'Security Systems Installer OR Fire Alarm Systems Installer', 'Assumenda aperiam ut doloribus ad voluptatem.', 0, '2025-09-06 16:46:34', '2025-09-06 16:46:34', 1, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `role_permissions`
--

CREATE TABLE `role_permissions` (
  `role_permission_id` bigint UNSIGNED NOT NULL,
  `role_id` bigint UNSIGNED NOT NULL,
  `permission_id` bigint UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `role_permissions`
--

INSERT INTO `role_permissions` (`role_permission_id`, `role_id`, `permission_id`) VALUES
(1, 1, 1),
(2, 1, 2),
(3, 1, 3),
(4, 1, 4),
(5, 1, 5),
(6, 2, 1),
(7, 2, 2),
(8, 2, 3),
(9, 2, 4),
(10, 2, 5),
(11, 3, 1),
(12, 3, 2),
(13, 3, 3),
(14, 3, 4),
(15, 3, 5),
(16, 4, 1),
(17, 4, 2),
(18, 4, 3),
(19, 4, 4),
(20, 4, 5),
(21, 5, 1),
(22, 5, 2),
(23, 5, 3),
(24, 5, 4),
(25, 5, 5),
(26, 6, 1),
(27, 6, 2),
(28, 6, 3),
(29, 6, 4),
(30, 6, 5),
(31, 7, 1),
(32, 7, 2),
(33, 7, 3),
(34, 7, 4),
(35, 7, 5),
(36, 8, 1),
(37, 8, 2),
(38, 8, 3),
(39, 8, 4),
(40, 8, 5),
(41, 9, 1),
(42, 9, 2),
(43, 9, 3),
(44, 9, 4),
(45, 9, 5),
(46, 10, 1),
(47, 10, 2),
(48, 10, 3),
(49, 10, 4),
(50, 10, 5),
(51, 11, 1),
(52, 11, 2),
(53, 11, 3),
(54, 11, 4),
(55, 11, 5),
(56, 12, 1),
(57, 12, 2),
(58, 12, 3),
(59, 12, 4),
(60, 12, 5),
(61, 13, 1),
(62, 13, 2),
(63, 13, 3),
(64, 13, 4),
(65, 13, 5),
(66, 14, 1),
(67, 14, 2),
(68, 14, 3),
(69, 14, 4),
(70, 14, 5),
(71, 15, 1),
(72, 15, 2),
(73, 15, 3),
(74, 15, 4),
(75, 15, 5),
(76, 16, 1),
(77, 16, 2),
(78, 16, 3),
(79, 16, 4),
(80, 16, 5),
(81, 17, 1),
(82, 17, 2),
(83, 17, 3),
(84, 17, 4),
(85, 17, 5),
(86, 18, 1),
(87, 18, 2),
(88, 18, 3),
(89, 18, 4),
(90, 18, 5),
(91, 19, 1),
(92, 19, 2),
(93, 19, 3),
(94, 19, 4),
(95, 19, 5),
(96, 20, 1),
(97, 20, 2),
(98, 20, 3),
(99, 20, 4),
(100, 20, 5),
(101, 21, 1),
(102, 21, 2),
(103, 21, 3),
(104, 21, 4),
(105, 21, 5),
(106, 22, 1),
(107, 22, 2),
(108, 22, 3),
(109, 22, 4),
(110, 22, 5),
(111, 23, 1),
(112, 23, 2),
(113, 23, 3),
(114, 23, 4),
(115, 23, 5),
(116, 24, 1),
(117, 24, 2),
(118, 24, 3),
(119, 24, 4),
(120, 24, 5),
(121, 25, 1),
(122, 25, 2),
(123, 25, 3),
(124, 25, 4),
(125, 25, 5),
(126, 26, 1),
(127, 26, 2),
(128, 26, 3),
(129, 26, 4),
(130, 26, 5),
(131, 27, 1),
(132, 27, 2),
(133, 27, 3),
(134, 27, 4),
(135, 27, 5),
(136, 28, 1),
(137, 28, 2),
(138, 28, 3),
(139, 28, 4),
(140, 28, 5),
(141, 29, 1),
(142, 29, 2),
(143, 29, 3),
(144, 29, 4),
(145, 29, 5),
(146, 30, 1),
(147, 30, 2),
(148, 30, 3),
(149, 30, 4),
(150, 30, 5);

-- --------------------------------------------------------

--
-- Table structure for table `table_status_logs`
--

CREATE TABLE `table_status_logs` (
  `table_status_log_id` bigint UNSIGNED NOT NULL,
  `table_id` bigint UNSIGNED NOT NULL,
  `from_status` enum('FREE','OCCUPIED','RESERVED','BLOCKED') COLLATE utf8mb4_general_ci DEFAULT NULL,
  `to_status` enum('FREE','OCCUPIED','RESERVED','BLOCKED') COLLATE utf8mb4_general_ci NOT NULL,
  `added_by` bigint UNSIGNED NOT NULL,
  `updated_by` bigint UNSIGNED DEFAULT NULL,
  `added_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `table_status_logs`
--

INSERT INTO `table_status_logs` (`table_status_log_id`, `table_id`, `from_status`, `to_status`, `added_by`, `updated_by`, `added_date`, `updated_date`) VALUES
(1, 1, 'FREE', 'OCCUPIED', 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(2, 2, 'FREE', 'OCCUPIED', 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(3, 3, 'FREE', 'OCCUPIED', 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(4, 4, 'FREE', 'OCCUPIED', 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(5, 5, 'FREE', 'OCCUPIED', 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(6, 6, 'FREE', 'OCCUPIED', 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(7, 7, 'FREE', 'OCCUPIED', 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(8, 8, 'FREE', 'OCCUPIED', 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(9, 9, 'FREE', 'OCCUPIED', 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(10, 10, 'FREE', 'OCCUPIED', 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(11, 11, 'FREE', 'OCCUPIED', 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(12, 12, 'FREE', 'OCCUPIED', 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(13, 13, 'FREE', 'OCCUPIED', 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(14, 14, 'FREE', 'OCCUPIED', 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(15, 15, 'FREE', 'OCCUPIED', 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(16, 16, 'FREE', 'OCCUPIED', 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(17, 17, 'FREE', 'OCCUPIED', 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(18, 18, 'FREE', 'OCCUPIED', 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(19, 19, 'FREE', 'OCCUPIED', 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(20, 20, 'FREE', 'OCCUPIED', 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(21, 21, 'FREE', 'OCCUPIED', 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(22, 22, 'FREE', 'OCCUPIED', 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(23, 23, 'FREE', 'OCCUPIED', 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(24, 24, 'FREE', 'OCCUPIED', 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(25, 25, 'FREE', 'OCCUPIED', 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(26, 26, 'FREE', 'OCCUPIED', 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(27, 27, 'FREE', 'OCCUPIED', 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(28, 28, 'FREE', 'OCCUPIED', 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(29, 29, 'FREE', 'OCCUPIED', 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(30, 30, 'FREE', 'OCCUPIED', 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(31, 31, 'FREE', 'OCCUPIED', 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(32, 32, 'FREE', 'OCCUPIED', 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(33, 33, 'FREE', 'OCCUPIED', 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(34, 34, 'FREE', 'OCCUPIED', 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(35, 35, 'FREE', 'OCCUPIED', 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(36, 36, 'FREE', 'OCCUPIED', 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(37, 37, 'FREE', 'OCCUPIED', 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(38, 38, 'FREE', 'OCCUPIED', 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(39, 39, 'FREE', 'OCCUPIED', 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(40, 40, 'FREE', 'OCCUPIED', 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(41, 41, 'FREE', 'OCCUPIED', 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(42, 42, 'FREE', 'OCCUPIED', 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(43, 43, 'FREE', 'OCCUPIED', 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(44, 44, 'FREE', 'OCCUPIED', 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(45, 45, 'FREE', 'OCCUPIED', 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(46, 46, 'FREE', 'OCCUPIED', 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(47, 47, 'FREE', 'OCCUPIED', 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(48, 48, 'FREE', 'OCCUPIED', 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(49, 49, 'FREE', 'OCCUPIED', 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(50, 50, 'FREE', 'OCCUPIED', 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(51, 51, 'FREE', 'OCCUPIED', 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(52, 52, 'FREE', 'OCCUPIED', 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(53, 53, 'FREE', 'OCCUPIED', 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(54, 54, 'FREE', 'OCCUPIED', 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(55, 55, 'FREE', 'OCCUPIED', 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(56, 56, 'FREE', 'OCCUPIED', 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(57, 57, 'FREE', 'OCCUPIED', 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(58, 58, 'FREE', 'OCCUPIED', 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(59, 59, 'FREE', 'OCCUPIED', 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38'),
(60, 60, 'FREE', 'OCCUPIED', 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` bigint UNSIGNED NOT NULL,
  `restaurant_id` bigint UNSIGNED NOT NULL,
  `user_role` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `user_email` varchar(150) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `phone` varchar(25) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `user_name` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `user_password` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `last_login_at` datetime DEFAULT NULL,
  `added_by` bigint UNSIGNED NOT NULL,
  `updated_by` bigint UNSIGNED DEFAULT NULL,
  `added_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `login_attempt` int NOT NULL DEFAULT '0',
  `status` enum('Active','Inactive') COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'Active',
  `api_token` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `token_issued_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `restaurant_id`, `user_role`, `user_email`, `phone`, `user_name`, `user_password`, `last_login_at`, `added_by`, `updated_by`, `added_date`, `updated_date`, `login_attempt`, `status`, `api_token`, `token_issued_at`) VALUES
(1, 1, '1', 'adrienne.schaden@gmail.com', '260.346.8607', 'odell44', '$2y$10$UJvdT4G5RZe/bSp4QaS0yOQMueyr59kBFlV3FTLoelDj49PAFO8I6', '2025-05-23 00:08:33', 1, NULL, '2025-09-06 16:46:35', '2026-03-10 08:29:00', 0, 'Active', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1aWQiOiIxIiwiaWF0IjoxNzczMTMxMzQwLCJleHAiOjE3NzMxMzQ5NDB9.6ohgaeF2GJsIOvEIsrB_ICf61rbVVZS0_JJNth09BSU', '2026-03-10 08:29:00'),
(2, 1, '1', 'spouros@hotmail.com', '386-488-8555', 'eldred57', '$2y$10$10QZmyGsW7l8hRFuihSZdetEHfUC1qvdNS2ze.NncJlnO0Y5opJZS', '2025-07-18 22:56:42', 1, NULL, '2025-09-06 16:46:35', '2025-09-06 16:46:35', 0, 'Active', '', '2025-09-10 17:38:19'),
(3, 1, '2', 'vpacocha@yahoo.com', '240.365.6190', 'heidenreich.daisy', '$2y$10$kOJkug7qvUYlAeeWNTvLS.9ONyWz613B7F7xzgjHPcVrt5spNZsYa', '2025-02-06 04:54:35', 1, NULL, '2025-09-06 16:46:35', '2025-09-06 16:46:35', 0, 'Active', '', '2025-09-10 17:38:19'),
(4, 1, '2', 'xbatz@jacobson.com', '1-385-409-8705', 'breana.stanton', '$2y$10$AIPIB7Hk6j780WA3O8us3.2zMFlsE7gFErDwMN2g2qH9ZqNP8le.q', '2025-02-04 13:42:05', 1, NULL, '2025-09-06 16:46:35', '2025-09-06 16:46:35', 0, 'Active', '', '2025-09-10 17:38:19'),
(5, 1, '3', 'jgraham@trantow.com', '+1.701.486.4854', 'russel.moises', '$2y$10$tGvH9d5xkJ5401v.YEvtc.QhhpVgPm1yE3IE/LshQz5w0ZkrlRBh2', '2025-01-29 23:50:34', 1, NULL, '2025-09-06 16:46:35', '2025-09-06 16:46:35', 0, 'Active', '', '2025-09-10 17:38:19'),
(6, 1, '3', 'marisol11@gmail.com', '1-386-968-4710', 'weston67', '$2y$10$7hiU2a8ACHEEKsHtuX3hze1y0jhYMT13OdtSV9KhQkEQTO3oXmYFC', '2025-07-19 07:10:07', 1, NULL, '2025-09-06 16:46:35', '2025-09-06 16:46:35', 0, 'Active', '', '2025-09-10 17:38:19'),
(7, 2, '4', 'keebler.ryleigh@yost.com', '+1-872-564-3389', 'cathy.balistreri', '$2y$10$B7wsb3vj5fgmDrvwIMzFZOauXCNUiF.rnRwc32MPOAc0xX6gJwBpi', '2025-05-22 12:28:49', 1, NULL, '2025-09-06 16:46:35', '2025-09-06 16:46:35', 0, 'Active', '', '2025-09-10 17:38:19'),
(8, 2, '4', 'hazel.fadel@mante.com', '786-949-0728', 'viviane86', '$2y$10$vXL8Y8H8g30x9Yhliis0I.w/ZHVqjqpUtl6S35BIYEDH0ZuGNq5QK', '2025-05-04 19:50:39', 1, NULL, '2025-09-06 16:46:35', '2025-09-06 16:46:35', 0, 'Active', '', '2025-09-10 17:38:19'),
(9, 2, '5', 'enola99@hills.com', '620-590-1216', 'annabel82', '$2y$10$ERNXcjaSi1gCKwVdy2Ou3u/DWBZVcqU05muiQTXaiFZkvT7vK59Se', '2025-04-18 06:38:18', 1, NULL, '2025-09-06 16:46:35', '2025-09-06 16:46:35', 0, 'Active', '', '2025-09-10 17:38:19'),
(10, 2, '5', 'kirsten16@yahoo.com', '+1-423-254-4390', 'medhurst.lawrence', '$2y$10$sTtE05Hk6YBCVOMr8I/siu2E3ogvbN/pTMoSIo.i9eofsK86pcnei', '2025-05-10 12:02:40', 1, NULL, '2025-09-06 16:46:35', '2025-09-06 16:46:35', 0, 'Active', '', '2025-09-10 17:38:19'),
(11, 2, '6', 'wisozk.heidi@kreiger.biz', '904.436.2434', 'bonnie.schulist', '$2y$10$ihSTO0GTdlVXP3akJJSGxeQbQ7X5QKfyLnVGdI1wCs2YZAJ0mAPD.', '2025-02-24 08:12:21', 1, NULL, '2025-09-06 16:46:35', '2025-09-06 16:46:35', 0, 'Active', '', '2025-09-10 17:38:19'),
(12, 2, '6', 'eino10@hotmail.com', '+19083070045', 'bart36', '$2y$10$0BcepYEbBUYqP4hk6SYspO47tXcMOeShOw8vFI4XZznJK3qBJ1INS', '2025-02-13 19:35:55', 1, NULL, '2025-09-06 16:46:35', '2025-09-06 16:46:35', 0, 'Active', '', '2025-09-10 17:38:19'),
(13, 3, '7', 'qlangworth@barrows.com', '870-956-0333', 'verna54', '$2y$10$kZFclg4.gxRNS5x.Ct7BTOJi9irfCC/v/.N6CoVGZY/owA/Cq2WJO', '2025-03-07 00:47:23', 1, NULL, '2025-09-06 16:46:35', '2025-09-06 16:46:35', 0, 'Active', '', '2025-09-10 17:38:19'),
(14, 3, '7', 'joesph35@hotmail.com', '(980) 343-3688', 'zgaylord', '$2y$10$aM4z6p1BSKom..MvDhPGEekZ/meOXUY0wT73kfm77098nJOTGQGLG', '2025-02-07 19:30:29', 1, NULL, '2025-09-06 16:46:35', '2025-09-06 16:46:35', 0, 'Active', '', '2025-09-10 17:38:19'),
(15, 3, '8', 'howell56@schowalter.biz', '(361) 413-8555', 'delphia.turcotte', '$2y$10$miCwPrVQOSL/x/IoTs9QKurz5JkAkoNSEs4/M5EdeyTySa56foSdS', '2025-07-06 17:10:21', 1, NULL, '2025-09-06 16:46:35', '2025-09-06 16:46:35', 0, 'Active', '', '2025-09-10 17:38:19'),
(16, 3, '8', 'laurine.conroy@yahoo.com', '1-269-698-2306', 'wbalistreri', '$2y$10$8bF5sYukAvnM3Xwr3v9myeRLCcQrszqVAS2tcLvsnkgBxeuz816G2', '2025-08-06 12:08:04', 1, NULL, '2025-09-06 16:46:35', '2025-09-06 16:46:35', 0, 'Active', '', '2025-09-10 17:38:19'),
(17, 3, '9', 'rkerluke@yahoo.com', '1-270-620-6297', 'lavinia48', '$2y$10$O7eUoQWyugR2Rg1zvk/t9eT01K1tGH0Vgb5Balh/sbZxq19uGWj.i', '2025-08-15 05:28:51', 1, NULL, '2025-09-06 16:46:36', '2025-09-06 16:46:36', 0, 'Active', '', '2025-09-10 17:38:19'),
(18, 3, '9', 'hauck.talia@effertz.net', '+1.803.738.8363', 'boehm.magnus', '$2y$10$dVzWCJ0aZCvIIxwNFo8Tle.wSKvKDjPw/mbZkm/HeDg0gMDTPHjo6', '2025-06-05 10:30:07', 1, NULL, '2025-09-06 16:46:36', '2025-09-06 16:46:36', 0, 'Active', '', '2025-09-10 17:38:19'),
(19, 4, '10', 'rruecker@hotmail.com', '651-395-1169', 'alysha.heidenreich', '$2y$10$DM/eXaC3wfo7PbrUB/a.eeE3T4gFAYH5BEWOeJTiyDesZ7sJ86b9a', '2025-05-15 17:37:30', 1, NULL, '2025-09-06 16:46:36', '2025-09-06 16:46:36', 0, 'Active', '', '2025-09-10 17:38:19'),
(20, 4, '10', 'lilyan56@yahoo.com', '+1.726.668.5396', 'elmo.kunde', '$2y$10$BMux.4J8gv2bpNmO0eIHHed5Qj.KfTJ7.t732tRXb4hYKiaHIOttq', '2025-03-07 14:56:04', 1, NULL, '2025-09-06 16:46:36', '2025-09-06 16:46:36', 0, 'Active', '', '2025-09-10 17:38:19'),
(21, 4, '11', 'furman.yost@bashirian.com', '772.285.2575', 'abdul.abshire', '$2y$10$HYw6gXWimrpbuYug0/aO8.UbV7tGPJ6qZTyPK8ljpAVNlDWVDi5C.', '2025-03-22 18:47:20', 1, NULL, '2025-09-06 16:46:36', '2025-09-06 16:46:36', 0, 'Active', '', '2025-09-10 17:38:19'),
(22, 4, '11', 'bonnie07@gmail.com', '262.454.7950', 'wgulgowski', '$2y$10$sevoNzLI5FKJ4LDUXfrtCexLk7c8kFsrsi9wgiZK5m8H9jTajm9pe', '2025-06-24 10:57:35', 1, NULL, '2025-09-06 16:46:36', '2025-09-06 16:46:36', 0, 'Active', '', '2025-09-10 17:38:19'),
(23, 4, '12', 'xfarrell@yahoo.com', '+1.331.990.9117', 'barrows.stevie', '$2y$10$vcFPXZEj5dUmO62oWxaYyeRd3vYAUvdOvZgISLlOAfM0z4EdjUbKW', '2025-05-17 07:32:06', 1, NULL, '2025-09-06 16:46:36', '2025-09-06 16:46:36', 0, 'Active', '', '2025-09-10 17:38:19'),
(24, 4, '12', 'henri.kshlerin@abshire.info', '239-358-3863', 'bayer.stewart', '$2y$10$OFp2eNRJy.09X1CqieKJJO1HuETOs7GKPhck3Xya8FHyiT5/UCzjm', '2025-01-27 15:42:41', 1, NULL, '2025-09-06 16:46:36', '2025-09-06 16:46:36', 0, 'Active', '', '2025-09-10 17:38:19'),
(25, 5, '13', 'macie.upton@medhurst.com', '1-702-988-4940', 'johan28', '$2y$10$Ku1hxYO3f1vDWwRU7Z0YFud/HNGo.QcEx5f84y8eZklTPO13Sdfby', '2025-06-12 01:05:41', 1, NULL, '2025-09-06 16:46:36', '2025-09-06 16:46:36', 0, 'Active', '', '2025-09-10 17:38:19'),
(26, 5, '13', 'russ50@yahoo.com', '(307) 593-1245', 'andres.cartwright', '$2y$10$Qfmk1eNX.0aGMHMCV/uaRu/EzkpHm7FzY0hJ0/NNOC8LW14saS7v2', '2025-06-17 20:52:37', 1, NULL, '2025-09-06 16:46:36', '2025-09-06 16:46:36', 0, 'Active', '', '2025-09-10 17:38:19'),
(27, 5, '14', 'nicolas.laisha@reichel.com', '+1 (571) 878-3654', 'chad.kovacek', '$2y$10$8/oLJnPzWOsqNoOsZumAteAyfPJ8whPx5kGpFFe3gt47kFbAbR3/u', '2025-08-12 18:22:45', 1, NULL, '2025-09-06 16:46:36', '2025-09-06 16:46:36', 0, 'Active', '', '2025-09-10 17:38:19'),
(28, 5, '14', 'pat.ratke@gmail.com', '+1 (260) 549-9436', 'icie.toy', '$2y$10$7qxkstJT5HN0MJuTkHae2.RujKwzF8csBXvFB7IbGlBxiYlDSDrtW', '2025-01-19 17:44:09', 1, NULL, '2025-09-06 16:46:36', '2025-09-06 16:46:36', 0, 'Active', '', '2025-09-10 17:38:19'),
(29, 5, '15', 'kaia99@gmail.com', '929-776-0778', 'randy74', '$2y$10$xozIVUvkCIT.aF0m0dmfxO1C0VKCe8Y5DYQRB/y5zhagF9E4ODCD.', '2025-06-05 08:39:57', 1, NULL, '2025-09-06 16:46:36', '2025-09-06 16:46:36', 0, 'Active', '', '2025-09-10 17:38:19'),
(30, 5, '15', 'sarai.mcclure@gmail.com', '(219) 715-7175', 'windler.anna', '$2y$10$mwDEEJ68Ze6J7AgioYiaDOTZmkOyoAS5P0NqH4FTZCxJmJF9/m9vy', '2025-04-08 13:03:16', 1, NULL, '2025-09-06 16:46:36', '2025-09-06 16:46:36', 0, 'Active', '', '2025-09-10 17:38:19'),
(31, 6, '16', 'kgreen@hotmail.com', '920.775.4076', 'clay91', '$2y$10$lnwTeuVKxsMQ96Sf2ZME2eL1/zgodJ8XjvNu4wet41owm0sofFDaO', '2025-02-01 11:53:42', 1, NULL, '2025-09-06 16:46:36', '2025-09-06 16:46:36', 0, 'Active', '', '2025-09-10 17:38:19'),
(32, 6, '16', 'ghessel@schuster.com', '(212) 748-4386', 'yvolkman', '$2y$10$n1EEZL1xbNHc.AWjzbJyNejnalyYriURdlkM9Y3cIrXNihjKfEsdm', '2025-07-09 18:21:42', 1, NULL, '2025-09-06 16:46:36', '2025-09-06 16:46:36', 0, 'Active', '', '2025-09-10 17:38:19'),
(33, 6, '17', 'ikertzmann@yahoo.com', '+1-678-684-6401', 'brody94', '$2y$10$UICVzLNqkXrPGtgFeTclN.cYzXql9GwgjLlZgKfk9fmPwpI1aGbji', '2025-07-13 06:55:22', 1, NULL, '2025-09-06 16:46:36', '2025-09-06 16:46:36', 0, 'Active', '', '2025-09-10 17:38:19'),
(34, 6, '17', 'hand.lauren@oconnell.com', '+18783323045', 'chelsea.beahan', '$2y$10$weVVT.p6SKnvYkJKw5i3/.UjOrgYh4BtTHIg8PxrTj61z9XP9go0u', '2025-08-06 15:36:10', 1, NULL, '2025-09-06 16:46:36', '2025-09-06 16:46:36', 0, 'Active', '', '2025-09-10 17:38:19'),
(35, 6, '18', 'wmurray@gmail.com', '727-963-2163', 'yzieme', '$2y$10$CoFrxaqShBs9QK5r.91mvu1HElSM0bsKP2bWBXhB3d5JOv97iG1sW', '2025-08-25 12:47:10', 1, NULL, '2025-09-06 16:46:36', '2025-09-06 16:46:36', 0, 'Active', '', '2025-09-10 17:38:19'),
(36, 6, '18', 'ernser.rodrick@stehr.org', '612-709-2288', 'ndietrich', '$2y$10$WSvjPn4KGE8V4jv9ajEXTeiXsX9LIAIGZ6f14PmXTZnUMWso1fZYm', '2025-04-10 17:57:51', 1, NULL, '2025-09-06 16:46:36', '2025-09-06 16:46:36', 0, 'Active', '', '2025-09-10 17:38:19'),
(37, 7, '19', 'blanda.misty@schimmel.org', '+1.240.281.6105', 'nstroman', '$2y$10$Q2s//bBi3HX9xiZvVCQ7wOJ0L6ZgLBpqYZ4dpcBClTjl2EJWI2Wwe', '2025-02-07 18:23:19', 1, NULL, '2025-09-06 16:46:36', '2025-09-06 16:46:36', 0, 'Active', '', '2025-09-10 17:38:19'),
(38, 7, '19', 'xjohnston@braun.org', '(940) 222-2391', 'nsteuber', '$2y$10$uOqCaK5jc.PaubFs2nyOyOJoLgecqblszt9FcCaOFc1gCTmNS0huW', '2025-03-19 20:32:54', 1, NULL, '2025-09-06 16:46:37', '2025-09-06 16:46:37', 0, 'Active', '', '2025-09-10 17:38:19'),
(39, 7, '20', 'mollie41@yahoo.com', '(928) 463-2313', 'bart94', '$2y$10$4HzzZryc4OUW8txJbMTluu5t4JnYB2Bg9wqZYS3qe5sdCVmr2czn2', '2025-07-04 19:11:16', 1, NULL, '2025-09-06 16:46:37', '2025-09-06 16:46:37', 0, 'Active', '', '2025-09-10 17:38:19'),
(40, 7, '20', 'candida.gutkowski@rice.com', '(843) 324-7916', 'doberbrunner', '$2y$10$0bb.ZYqsb/lCFeMsSASXF.IlZ39F6/Ow6gZQ5mCUgTrrzciV4ef06', '2025-06-04 23:04:04', 1, NULL, '2025-09-06 16:46:37', '2025-09-06 16:46:37', 0, 'Active', '', '2025-09-10 17:38:19'),
(41, 7, '21', 'wbarton@gmail.com', '847-524-4648', 'klein.idella', '$2y$10$q/WLCsRapkw3GXyDZ1WfxuRgBm.xvnwZBkCFm5mqk81HDIWyVVnE.', '2025-01-23 05:25:04', 1, NULL, '2025-09-06 16:46:37', '2025-09-06 16:46:37', 0, 'Active', '', '2025-09-10 17:38:19'),
(42, 7, '21', 'frami.estrella@hickle.com', '410-642-6847', 'ddavis', '$2y$10$dEqXrxcJmvaUc9Hgn.9c.uCWmKlFnR/WBJZETjFda.sfUBoPMS.h6', '2025-04-15 20:00:35', 1, NULL, '2025-09-06 16:46:37', '2025-09-06 16:46:37', 0, 'Active', '', '2025-09-10 17:38:19'),
(43, 8, '22', 'whitney.treutel@kautzer.com', '1-706-345-5091', 'rhoda.williamson', '$2y$10$XhLMA58/q/PaPgvTpa9uhuGjDXN4Lywc4R0g0qS0A.QV2Oij59P.q', '2025-01-02 14:02:20', 1, NULL, '2025-09-06 16:46:37', '2025-09-06 16:46:37', 0, 'Active', '', '2025-09-10 17:38:19'),
(44, 8, '22', 'helga07@wisoky.com', '215.832.4085', 'igutkowski', '$2y$10$CMRWeJfpb6xmZ7HAUB3/a./Iy9GRUsmNH6TtFqYOX2L1/7Xrs3rOi', '2025-01-22 03:55:44', 1, NULL, '2025-09-06 16:46:37', '2025-09-06 16:46:37', 0, 'Active', '', '2025-09-10 17:38:19'),
(45, 8, '23', 'zfeest@hotmail.com', '1-786-433-3490', 'lmueller', '$2y$10$fHkuXFqO5xjG1oenS9umF.OWp2eFZRxnIDKIUUzdOFa1dufepWYGu', '2025-02-06 04:43:17', 1, NULL, '2025-09-06 16:46:37', '2025-09-06 16:46:37', 0, 'Active', '', '2025-09-10 17:38:19'),
(46, 8, '23', 'dquigley@gmail.com', '1-606-355-6533', 'champlin.felicia', '$2y$10$K7HUtA6ToQy64A3DslI4GOeG2HXcvhQDRCuyAQT1xCNLtFpH75m2e', '2025-09-02 23:28:59', 1, NULL, '2025-09-06 16:46:37', '2025-09-06 16:46:37', 0, 'Active', '', '2025-09-10 17:38:19'),
(47, 8, '24', 'juliana.cormier@gmail.com', '+1 (843) 796-2901', 'bayer.darian', '$2y$10$t44DNBWYBG7.tR/2x.Rp/e.Yrdv0CYuOiWnxljuX8msQ8l0QaW96.', '2025-04-18 16:49:47', 1, NULL, '2025-09-06 16:46:37', '2025-09-06 16:46:37', 0, 'Active', '', '2025-09-10 17:38:19'),
(48, 8, '24', 'marisol.spencer@medhurst.com', '440.851.2283', 'emmet58', '$2y$10$wjoQ3GXhON4BiWBjkZm5t.xamLEPOy6cE2gdFVFd/BYIMXeGkWdKi', '2025-07-08 01:18:01', 1, NULL, '2025-09-06 16:46:37', '2025-09-06 16:46:37', 0, 'Active', '', '2025-09-10 17:38:19'),
(49, 9, '25', 'fkerluke@christiansen.net', '+1-215-798-6211', 'travis74', '$2y$10$QpodL85gYk1eJuRDV.qMOuQPRmnToWeULgcyRzJ/o8p0g0Lg2lvhG', '2025-01-08 00:49:01', 1, NULL, '2025-09-06 16:46:37', '2025-09-06 16:46:37', 0, 'Active', '', '2025-09-10 17:38:19'),
(50, 9, '25', 'simonis.lilliana@gmail.com', '720.594.6200', 'retta99', '$2y$10$cmqZizShEm47AzceNIUUyu/XHXZ4a5DNKAYMA20nG/IG6CBcFOKgy', '2025-01-24 11:03:07', 1, NULL, '2025-09-06 16:46:37', '2025-09-06 16:46:37', 0, 'Active', '', '2025-09-10 17:38:19'),
(51, 9, '26', 'mcdermott.marta@hotmail.com', '+1-305-424-5383', 'femmerich', '$2y$10$WG/vEAqRKCRa1tt1cD/f/.A1YkHE7.8Ku88ff/NifX0i8l7qQyyni', '2025-08-15 10:56:37', 1, NULL, '2025-09-06 16:46:37', '2025-09-06 16:46:37', 0, 'Active', '', '2025-09-10 17:38:19'),
(52, 9, '26', 'grimes.alysha@roberts.com', '+18146913015', 'melvina16', '$2y$10$SKGEn8XCJt98a0/Ib6AkCeW0SHQ3vdkKHUncf4T3FqeWJebJuelmK', '2025-02-05 19:36:32', 1, NULL, '2025-09-06 16:46:37', '2025-09-06 16:46:37', 0, 'Active', '', '2025-09-10 17:38:19'),
(53, 9, '27', 'bheidenreich@weissnat.com', '+1-915-281-9293', 'mayert.sharon', '$2y$10$SkSBEK2skyeVG8lSn91je.s3VOI6AdgLcHiXwRSgxuTEs/zOeGSYC', '2025-05-26 22:18:30', 1, NULL, '2025-09-06 16:46:37', '2025-09-06 16:46:37', 0, 'Active', '', '2025-09-10 17:38:19'),
(54, 9, '27', 'hsawayn@wehner.com', '+17573286492', 'nswift', '$2y$10$KEyTGooGdSekMJHQFXJqJuUTxl1yH/.KvpY2wLzjLl1Kv.AFoSYKC', '2025-09-01 20:02:44', 1, NULL, '2025-09-06 16:46:37', '2025-09-06 16:46:37', 0, 'Active', '', '2025-09-10 17:38:19'),
(55, 10, '28', 'jazmyne.ohara@kemmer.org', '+1-601-747-3121', 'carolyn59', '$2y$10$cjNkxfKbBv4mms19vXLI2uWsr9eJom1edAgO.NmEXFuho0f2t98b2', '2025-03-11 22:18:36', 1, NULL, '2025-09-06 16:46:37', '2025-09-06 16:46:37', 0, 'Active', '', '2025-09-10 17:38:19'),
(56, 10, '28', 'ddickinson@beatty.com', '1-651-973-5180', 'kamryn.green', '$2y$10$RA5Rr0GLG239opswrD5T0OVbn/2pIjLGYLvBeZ3JA3Cf3pBbA.bQu', '2025-06-10 08:13:49', 1, NULL, '2025-09-06 16:46:37', '2025-09-06 16:46:37', 0, 'Active', '', '2025-09-10 17:38:19'),
(57, 10, '29', 'ydibbert@hansen.com', '1-430-415-2248', 'jedidiah.wyman', '$2y$10$D1GouQk/.pjX1rSUJBsrvuCP8d4Uy0Au0OJPe0HBg1bXL9aW1z6Mu', '2025-01-20 21:33:02', 1, NULL, '2025-09-06 16:46:37', '2025-09-06 16:46:37', 0, 'Active', '', '2025-09-10 17:38:19'),
(58, 10, '29', 'medhurst.wilhelm@yahoo.com', '(458) 775-2077', 'alexandrea.glover', '$2y$10$z9FQxe4bzDJcmPn7MqUwiuQRqh443DO8rGqRC1NxOCshIFf4it8Ay', '2025-03-25 10:43:20', 1, NULL, '2025-09-06 16:46:37', '2025-09-06 16:46:37', 0, 'Active', '', '2025-09-10 17:38:19'),
(59, 10, '30', 'jamey.crist@wilderman.com', '(804) 668-0986', 'wgerhold', '$2y$10$zFx9MQbFYDcMHyGSg.YpRuXBcfl8KE5g75AV.XB1dfHpePpcqpboa', '2025-02-21 18:35:31', 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38', 0, 'Active', '', '2025-09-10 17:38:19'),
(60, 10, '30', 'marvin.percy@yahoo.com', '+1-586-846-9448', 'icie.hartmann', '$2y$10$BwrmEjaw0SwDssLrmpGQduU7x5vFjhDQrP1McR3Cj2DD8/IiZF.ui', '2025-03-14 06:18:49', 1, NULL, '2025-09-06 16:46:38', '2025-09-06 16:46:38', 0, 'Active', '', '2025-09-10 17:38:19');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `addon_groups`
--
ALTER TABLE `addon_groups`
  ADD PRIMARY KEY (`addon_group_id`);

--
-- Indexes for table `addon_options`
--
ALTER TABLE `addon_options`
  ADD PRIMARY KEY (`addon_option_id`);

--
-- Indexes for table `bills`
--
ALTER TABLE `bills`
  ADD PRIMARY KEY (`bill_id`);

--
-- Indexes for table `bill_items`
--
ALTER TABLE `bill_items`
  ADD PRIMARY KEY (`bill_item_id`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`category_id`);

--
-- Indexes for table `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`customer_id`);

--
-- Indexes for table `dining_tables`
--
ALTER TABLE `dining_tables`
  ADD PRIMARY KEY (`table_id`);

--
-- Indexes for table `feedback`
--
ALTER TABLE `feedback`
  ADD PRIMARY KEY (`feedback_id`);

--
-- Indexes for table `floors`
--
ALTER TABLE `floors`
  ADD PRIMARY KEY (`floor_id`);

--
-- Indexes for table `item_addon_groups`
--
ALTER TABLE `item_addon_groups`
  ADD PRIMARY KEY (`item_id`,`addon_group_id`);

--
-- Indexes for table `kot_items`
--
ALTER TABLE `kot_items`
  ADD PRIMARY KEY (`kot_item_id`);

--
-- Indexes for table `kot_tickets`
--
ALTER TABLE `kot_tickets`
  ADD PRIMARY KEY (`kot_ticket_id`);

--
-- Indexes for table `loyalty_transactions`
--
ALTER TABLE `loyalty_transactions`
  ADD PRIMARY KEY (`transaction_id`);

--
-- Indexes for table `loyalty_wallets`
--
ALTER TABLE `loyalty_wallets`
  ADD PRIMARY KEY (`wallet_id`);

--
-- Indexes for table `menu_items`
--
ALTER TABLE `menu_items`
  ADD PRIMARY KEY (`item_id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`order_id`);

--
-- Indexes for table `order_items`
--
ALTER TABLE `order_items`
  ADD PRIMARY KEY (`order_item_id`);

--
-- Indexes for table `order_item_addons`
--
ALTER TABLE `order_item_addons`
  ADD PRIMARY KEY (`order_item_addon_id`);

--
-- Indexes for table `order_status_history`
--
ALTER TABLE `order_status_history`
  ADD PRIMARY KEY (`order_status_history_id`);

--
-- Indexes for table `payments`
--
ALTER TABLE `payments`
  ADD PRIMARY KEY (`payment_id`);

--
-- Indexes for table `permissions`
--
ALTER TABLE `permissions`
  ADD PRIMARY KEY (`permission_id`);

--
-- Indexes for table `reservations`
--
ALTER TABLE `reservations`
  ADD PRIMARY KEY (`reservation_id`);

--
-- Indexes for table `restaurants`
--
ALTER TABLE `restaurants`
  ADD PRIMARY KEY (`restaurant_id`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`role_id`);

--
-- Indexes for table `role_permissions`
--
ALTER TABLE `role_permissions`
  ADD PRIMARY KEY (`role_permission_id`);

--
-- Indexes for table `table_status_logs`
--
ALTER TABLE `table_status_logs`
  ADD PRIMARY KEY (`table_status_log_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `addon_groups`
--
ALTER TABLE `addon_groups`
  MODIFY `addon_group_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `addon_options`
--
ALTER TABLE `addon_options`
  MODIFY `addon_option_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=61;

--
-- AUTO_INCREMENT for table `bills`
--
ALTER TABLE `bills`
  MODIFY `bill_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `bill_items`
--
ALTER TABLE `bill_items`
  MODIFY `bill_item_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `category_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT for table `customers`
--
ALTER TABLE `customers`
  MODIFY `customer_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=51;

--
-- AUTO_INCREMENT for table `dining_tables`
--
ALTER TABLE `dining_tables`
  MODIFY `table_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=61;

--
-- AUTO_INCREMENT for table `feedback`
--
ALTER TABLE `feedback`
  MODIFY `feedback_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `floors`
--
ALTER TABLE `floors`
  MODIFY `floor_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `kot_items`
--
ALTER TABLE `kot_items`
  MODIFY `kot_item_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `kot_tickets`
--
ALTER TABLE `kot_tickets`
  MODIFY `kot_ticket_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `loyalty_transactions`
--
ALTER TABLE `loyalty_transactions`
  MODIFY `transaction_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=101;

--
-- AUTO_INCREMENT for table `loyalty_wallets`
--
ALTER TABLE `loyalty_wallets`
  MODIFY `wallet_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=51;

--
-- AUTO_INCREMENT for table `menu_items`
--
ALTER TABLE `menu_items`
  MODIFY `item_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `order_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `order_items`
--
ALTER TABLE `order_items`
  MODIFY `order_item_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `order_item_addons`
--
ALTER TABLE `order_item_addons`
  MODIFY `order_item_addon_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `order_status_history`
--
ALTER TABLE `order_status_history`
  MODIFY `order_status_history_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `payments`
--
ALTER TABLE `payments`
  MODIFY `payment_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `permissions`
--
ALTER TABLE `permissions`
  MODIFY `permission_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `reservations`
--
ALTER TABLE `reservations`
  MODIFY `reservation_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `restaurants`
--
ALTER TABLE `restaurants`
  MODIFY `restaurant_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `role_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT for table `role_permissions`
--
ALTER TABLE `role_permissions`
  MODIFY `role_permission_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=151;

--
-- AUTO_INCREMENT for table `table_status_logs`
--
ALTER TABLE `table_status_logs`
  MODIFY `table_status_log_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=61;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=61;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
