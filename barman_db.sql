/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

CREATE TABLE IF NOT EXISTS  `alembic_version` (
  `version_num` varchar(32) NOT NULL,
  PRIMARY KEY (`version_num`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS  `apportion` (
  `id` int NOT NULL AUTO_INCREMENT,
  `dept` varchar(80) NOT NULL,
  `product_title` varchar(255) NOT NULL,
  `main_qty` int NOT NULL,
  `initial_apportioning` int NOT NULL,
  `apportioned_qty` int NOT NULL,
  `extracted_qty` int DEFAULT NULL,
  `cost_price` int DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS  `apportion_items_association` (
  `apportion_id` int DEFAULT NULL,
  `items_id` int DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  KEY `apportion_id` (`apportion_id`),
  KEY `items_id` (`items_id`),
  CONSTRAINT `apportion_items_association_ibfk_1` FOREIGN KEY (`apportion_id`) REFERENCES `apportion` (`id`),
  CONSTRAINT `apportion_items_association_ibfk_2` FOREIGN KEY (`items_id`) REFERENCES `items` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS  `category` (
  `id` int NOT NULL AUTO_INCREMENT,
  `parent` int DEFAULT NULL,
  `lev` int DEFAULT NULL,
  `name` varchar(50) NOT NULL,
  `desc` varchar(100) DEFAULT NULL,
  `photo` varchar(50) DEFAULT NULL,
  `dept` varchar(50) NOT NULL,
  `created` datetime DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `parent` (`parent`),
  CONSTRAINT `category_ibfk_1` FOREIGN KEY (`parent`) REFERENCES `category` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=97 DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS  `expenses` (
  `id` int NOT NULL AUTO_INCREMENT,
  `cost` int DEFAULT NULL,
  `dept` varchar(80) NOT NULL,
  `comment` varchar(100) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS  `extracted` (
  `id` int NOT NULL AUTO_INCREMENT,
  `extracted_title` varchar(255) NOT NULL,
  `extracted_qty` int NOT NULL,
  `remaining_stock` int DEFAULT NULL,
  `descr` varchar(255) DEFAULT NULL,
  `apportion_id` int NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `apportion_id` (`apportion_id`),
  CONSTRAINT `extracted_ibfk_1` FOREIGN KEY (`apportion_id`) REFERENCES `apportion` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS  `feedback` (
  `id` int NOT NULL AUTO_INCREMENT,
  `rating` int DEFAULT NULL,
  `comment` text,
  `created` datetime DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  `user` int NOT NULL,
  `items` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `items` (`items`),
  KEY `user` (`user`),
  CONSTRAINT `feedback_ibfk_1` FOREIGN KEY (`items`) REFERENCES `items` (`id`),
  CONSTRAINT `feedback_ibfk_2` FOREIGN KEY (`user`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS  `items` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `name` varchar(80) NOT NULL,
  `dept` varchar(80) NOT NULL,
  `in_stock` int DEFAULT NULL,
  `c_price` int DEFAULT NULL,
  `s_price` int NOT NULL,
  `new_stock` int DEFAULT NULL,
  `photos` json DEFAULT NULL,
  `disc` int DEFAULT NULL,
  `desc` text,
  `attributes` json DEFAULT NULL,
  `color` json DEFAULT NULL,
  `size` json DEFAULT NULL,
  `sku` varchar(1000) DEFAULT NULL,
  `ip` varchar(50) DEFAULT NULL,
  `status` tinyint(1) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `category_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`,`category_id`,`dept`,`deleted`),
  KEY `category_id` (`category_id`),
  CONSTRAINT `items_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=221 DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS  `notification` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(128) DEFAULT NULL,
  `message` varchar(255) DEFAULT NULL,
  `photo` varchar(255) DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  `is_read` tinyint(1) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `ix_notification_title` (`title`),
  CONSTRAINT `notification_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS  `order` (
  `id` int NOT NULL AUTO_INCREMENT,
  `usr_id` int DEFAULT NULL,
  `order_item` json DEFAULT NULL,
  `order_id` int NOT NULL,
  `pment_option` varchar(45) NOT NULL,
  `order_status` varchar(50) DEFAULT NULL,
  `in_cart` tinyint(1) DEFAULT NULL,
  `name` varchar(45) DEFAULT NULL,
  `email` varchar(100) NOT NULL,
  `phone` varchar(45) DEFAULT NULL,
  `zipcode` varchar(45) NOT NULL,
  `adrs` varchar(45) NOT NULL,
  `state` varchar(45) NOT NULL,
  `country` varchar(45) NOT NULL,
  `created` datetime DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `order_id` (`order_id`),
  KEY `usr_id` (`usr_id`),
  KEY `ix_order_email` (`email`),
  CONSTRAINT `order_ibfk_1` FOREIGN KEY (`usr_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS  `plans` (
  `id` int NOT NULL AUTO_INCREMENT,
  `plan_title` varchar(100) DEFAULT NULL,
  `plan_amount` int DEFAULT NULL,
  `plan_currency` varchar(100) DEFAULT NULL,
  `plan_descr` text,
  `plan_type` varchar(100) DEFAULT NULL,
  `plan_duration` int DEFAULT NULL,
  `plan_features` json DEFAULT NULL,
  `plan_avatar` varchar(100) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS  `role` (
  `id` int NOT NULL AUTO_INCREMENT,
  `type` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `type` (`type`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS  `sales` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(100) DEFAULT NULL,
  `qty_left` int DEFAULT NULL,
  `qty` int DEFAULT NULL,
  `price` int DEFAULT NULL,
  `total` int DEFAULT NULL,
  `dept` varchar(80) NOT NULL,
  `comment` varchar(100) DEFAULT NULL,
  `item_id` int DEFAULT NULL,
  `extracted_id` int DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `extracted_id` (`extracted_id`),
  KEY `item_id` (`item_id`),
  CONSTRAINT `sales_ibfk_1` FOREIGN KEY (`extracted_id`) REFERENCES `extracted` (`id`),
  CONSTRAINT `sales_ibfk_2` FOREIGN KEY (`item_id`) REFERENCES `items` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS  `stock_history` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `in_stock` int NOT NULL,
  `desc` text,
  `version` int NOT NULL,
  `difference` int NOT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `apportion_id` int DEFAULT NULL,
  `extracted_id` int DEFAULT NULL,
  `item_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `apportion_id` (`apportion_id`),
  KEY `extracted_id` (`extracted_id`),
  KEY `item_id` (`item_id`),
  CONSTRAINT `stock_history_ibfk_1` FOREIGN KEY (`apportion_id`) REFERENCES `apportion` (`id`),
  CONSTRAINT `stock_history_ibfk_2` FOREIGN KEY (`extracted_id`) REFERENCES `extracted` (`id`),
  CONSTRAINT `stock_history_ibfk_3` FOREIGN KEY (`item_id`) REFERENCES `items` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS  `transactions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `plan_id` int DEFAULT NULL,
  `is_subscription` tinyint(1) NOT NULL,
  `tx_ref` varchar(100) DEFAULT NULL,
  `tx_amount` int DEFAULT NULL,
  `tx_descr` text,
  `tx_status` varchar(100) DEFAULT NULL,
  `currency_code` varchar(100) DEFAULT NULL,
  `provider` varchar(100) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `tx_id` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `plan_id` (`plan_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `transactions_ibfk_1` FOREIGN KEY (`plan_id`) REFERENCES `plans` (`id`),
  CONSTRAINT `transactions_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS  `user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `username` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `password` varchar(500) NOT NULL,
  `photo` varchar(1000) DEFAULT NULL,
  `admin` tinyint(1) DEFAULT NULL,
  `gender` varchar(50) DEFAULT NULL,
  `city` varchar(50) DEFAULT NULL,
  `about` varchar(5000) DEFAULT NULL,
  `ratings` int DEFAULT NULL,
  `reviews` int DEFAULT NULL,
  `acct_no` varchar(50) DEFAULT NULL,
  `bank` varchar(50) DEFAULT NULL,
  `socials` json DEFAULT NULL,
  `src` varchar(50) DEFAULT NULL,
  `cate` varchar(50) DEFAULT NULL,
  `online` tinyint(1) DEFAULT NULL,
  `status` tinyint(1) DEFAULT NULL,
  `verified` tinyint(1) DEFAULT NULL,
  `ip` varchar(50) DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  UNIQUE KEY `ix_user_email` (`email`),
  UNIQUE KEY `ix_user_username` (`username`),
  UNIQUE KEY `ix_user_phone` (`phone`),
  KEY `ix_user_name` (`name`),
  KEY `ix_user_password` (`password`)
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS  `user_role_association` (
  `user_id` int DEFAULT NULL,
  `role_id` int DEFAULT NULL,
  KEY `role_id` (`role_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `user_role_association_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`),
  CONSTRAINT `user_role_association_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `alembic_version` (`version_num`) VALUES
('b55cc679677d');


INSERT INTO `apportion` (`id`, `dept`, `product_title`, `main_qty`, `initial_apportioning`, `apportioned_qty`, `extracted_qty`, `cost_price`, `created_at`, `updated_at`, `deleted`) VALUES
(1, 'k', 'Rice Bag', 1, 0, 37, 0, 0, '2024-11-08 11:30:32', '2024-11-10 17:02:55', 0);
INSERT INTO `apportion` (`id`, `dept`, `product_title`, `main_qty`, `initial_apportioning`, `apportioned_qty`, `extracted_qty`, `cost_price`, `created_at`, `updated_at`, `deleted`) VALUES
(2, 'k', 'Bag of rice', 1, 37, 30, 0, 0, '2024-11-10 16:58:49', '2024-11-10 16:59:58', 0);
INSERT INTO `apportion` (`id`, `dept`, `product_title`, `main_qty`, `initial_apportioning`, `apportioned_qty`, `extracted_qty`, `cost_price`, `created_at`, `updated_at`, `deleted`) VALUES
(3, 'k', 'Rice', 1, 37, 37, 0, 0, '2024-11-10 17:02:17', '2024-11-10 17:02:17', 0);
INSERT INTO `apportion` (`id`, `dept`, `product_title`, `main_qty`, `initial_apportioning`, `apportioned_qty`, `extracted_qty`, `cost_price`, `created_at`, `updated_at`, `deleted`) VALUES
(4, 'k', 'vegetable', 1, 25, 0, 0, 0, '2024-11-10 17:07:59', '2024-11-10 17:08:53', 0);



INSERT INTO `category` (`id`, `parent`, `lev`, `name`, `desc`, `photo`, `dept`, `created`, `updated`, `deleted`) VALUES
(25, NULL, 0, 'Drinks', NULL, NULL, 'b', '2023-09-20 09:52:47', '2023-09-20 09:52:47', 1);
INSERT INTO `category` (`id`, `parent`, `lev`, `name`, `desc`, `photo`, `dept`, `created`, `updated`, `deleted`) VALUES
(39, NULL, 0, 'Swallow', NULL, NULL, 'k', '2023-09-21 11:30:56', '2023-09-21 11:30:56', 0);
INSERT INTO `category` (`id`, `parent`, `lev`, `name`, `desc`, `photo`, `dept`, `created`, `updated`, `deleted`) VALUES
(52, NULL, 0, 'Spices', NULL, NULL, 'c', '2023-09-28 14:30:10', '2023-09-28 14:30:10', 1);
INSERT INTO `category` (`id`, `parent`, `lev`, `name`, `desc`, `photo`, `dept`, `created`, `updated`, `deleted`) VALUES
(65, NULL, 0, 'Smoothie', NULL, NULL, 'c', '2023-09-29 06:05:11', '2023-09-29 06:05:11', 1),
(66, NULL, 0, 'Soup', NULL, NULL, 'k', '2023-09-29 06:09:07', '2023-09-29 06:09:07', 0),
(67, NULL, 0, 'Continental', NULL, NULL, 'k', '2023-09-29 06:09:46', '2023-09-29 06:09:46', 0),
(68, NULL, 0, 'Olmeca Tots', NULL, NULL, 'c', '2023-09-29 06:11:59', '2023-09-29 06:11:59', 1),
(69, NULL, 0, 'Sierra Tots', NULL, NULL, 'c', '2023-09-29 06:12:38', '2023-09-29 06:12:38', 1),
(70, NULL, 0, 'Tequila ', NULL, NULL, 'c', '2023-09-29 06:17:16', '2023-09-29 06:17:16', 0),
(71, NULL, 0, 'Beer', NULL, NULL, 'b', '2023-09-29 06:30:24', '2023-09-29 06:30:24', 0),
(72, NULL, 0, 'Energy drink', NULL, NULL, 'b', '2023-10-01 12:24:11', '2023-10-01 12:24:11', 0),
(73, NULL, 0, 'Spirit', NULL, NULL, 'c', '2023-10-01 12:56:17', '2023-10-01 12:56:17', 0),
(74, NULL, 0, 'Smoothie', NULL, NULL, 'c', '2023-10-01 12:56:29', '2023-10-01 12:56:29', 0),
(75, NULL, 0, 'Wine', NULL, NULL, 'c', '2023-10-01 12:57:32', '2023-10-01 12:57:32', 0),
(76, NULL, 0, 'Brandy', NULL, NULL, 'c', '2023-10-03 22:21:15', '2023-10-03 22:21:15', 0),
(77, NULL, 0, 'Protein', NULL, NULL, 'k', '2023-10-05 18:16:24', '2023-10-05 18:16:24', 0),
(78, NULL, 0, 'Pasta', NULL, NULL, 'k', '2023-10-05 18:42:53', '2023-10-05 18:42:53', 0),
(79, NULL, 0, 'Special ', NULL, NULL, 'k', '2023-10-06 11:18:58', '2023-10-06 11:18:58', 0),
(80, NULL, 0, 'Spices', NULL, NULL, 'k', '2023-10-06 11:33:06', '2023-10-06 11:33:06', 0),
(81, NULL, 0, 'Grilled', NULL, NULL, 'k', '2023-10-06 11:59:50', '2023-10-06 11:59:50', 0),
(82, NULL, 0, 'Platter', NULL, NULL, 'k', '2023-10-06 12:05:19', '2023-10-06 12:05:19', 0),
(83, NULL, 0, 'Vodka', NULL, NULL, 'c', '2023-10-06 12:28:05', '2023-10-06 12:28:05', 0),
(84, NULL, 0, 'Spirit', NULL, NULL, 'b', '2023-10-11 00:25:05', '2023-10-11 00:25:05', 0),
(85, NULL, 0, 'Whisky', NULL, NULL, 'c', '2023-10-11 00:38:11', '2023-10-11 00:38:11', 0),
(86, NULL, 0, 'Rum', NULL, NULL, 'c', '2023-10-11 00:56:54', '2023-10-11 00:56:54', 0),
(87, NULL, 0, 'Test C. edited', NULL, NULL, 'b', '2023-10-14 19:31:59', '2023-10-14 19:31:59', 1),
(88, NULL, 0, 'Herbal Drinks', NULL, NULL, 'b', '2023-10-14 19:33:15', '2023-10-14 19:33:15', 0),
(89, NULL, 0, 'Soft Drink', NULL, NULL, 'b', '2023-10-24 12:48:18', '2023-10-24 12:48:18', 0),
(90, NULL, 0, 'Juice', NULL, NULL, 'b', '2023-10-24 12:52:14', '2023-10-24 12:52:14', 0),
(91, NULL, 0, 'Milk & Cream', NULL, NULL, 'b', '2023-10-24 12:52:56', '2023-10-24 12:52:56', 0),
(92, NULL, 0, 'Water', NULL, NULL, 'b', '2023-10-24 12:57:03', '2023-10-24 12:57:03', 0),
(93, NULL, 0, 'Red wine', NULL, NULL, 'c', '2023-11-10 09:18:09', '2023-11-10 09:18:09', 0),
(94, NULL, 0, 'Aperitifs', NULL, NULL, 'c', '2023-11-10 09:43:13', '2023-11-10 09:43:13', 0),
(95, NULL, 0, 'Sparklingwine  Champ', NULL, NULL, 'c', '2023-11-10 09:54:04', '2023-11-10 09:54:04', 0),
(96, NULL, 0, 'Big', NULL, NULL, 'b', '2024-11-03 21:03:17', '2024-11-03 21:03:17', 1);

INSERT INTO `expenses` (`id`, `cost`, `dept`, `comment`, `deleted`, `created`, `updated`) VALUES
(1, 2000, 'k', ' bunch of vegetable', 0, '2024-11-10 18:12:14', '2024-11-10 18:12:14');


INSERT INTO `extracted` (`id`, `extracted_title`, `extracted_qty`, `remaining_stock`, `descr`, `apportion_id`, `created_at`, `updated_at`, `deleted`) VALUES
(1, '7 Bag Collected', 7, 30, NULL, 1, '2024-11-08 21:20:58', '2024-11-08 21:20:58', 0);
INSERT INTO `extracted` (`id`, `extracted_title`, `extracted_qty`, `remaining_stock`, `descr`, `apportion_id`, `created_at`, `updated_at`, `deleted`) VALUES
(2, '7 bag colleted', 7, 30, NULL, 2, '2024-11-10 16:59:58', '2024-11-10 16:59:58', 0);
INSERT INTO `extracted` (`id`, `extracted_title`, `extracted_qty`, `remaining_stock`, `descr`, `apportion_id`, `created_at`, `updated_at`, `deleted`) VALUES
(3, '25 portions', 25, 0, NULL, 4, '2024-11-10 17:08:53', '2024-11-10 17:08:53', 0);



INSERT INTO `items` (`id`, `user_id`, `name`, `dept`, `in_stock`, `c_price`, `s_price`, `new_stock`, `photos`, `disc`, `desc`, `attributes`, `color`, `size`, `sku`, `ip`, `status`, `deleted`, `created`, `updated`, `category_id`) VALUES
(6, 38, 'Medium Stout', 'b', 0, 0, 1000, 0, '\"photo.png\"', 0, NULL, NULL, NULL, NULL, NULL, '105.113.90.131', 1, 0, '2023-09-24 07:02:10', '2023-09-24 07:02:10', 71);
INSERT INTO `items` (`id`, `user_id`, `name`, `dept`, `in_stock`, `c_price`, `s_price`, `new_stock`, `photos`, `disc`, `desc`, `attributes`, `color`, `size`, `sku`, `ip`, `status`, `deleted`, `created`, `updated`, `category_id`) VALUES
(7, 38, 'Trophy premium', 'b', 0, 450, 500, 0, '\"photo.png\"', 0, NULL, NULL, NULL, NULL, NULL, '105.112.70.175', 1, 0, '2023-09-24 07:04:40', '2023-09-24 07:04:40', 71);
INSERT INTO `items` (`id`, `user_id`, `name`, `dept`, `in_stock`, `c_price`, `s_price`, `new_stock`, `photos`, `disc`, `desc`, `attributes`, `color`, `size`, `sku`, `ip`, `status`, `deleted`, `created`, `updated`, `category_id`) VALUES
(8, 38, 'Heineken', 'b', 0, 0, 1200, 0, '\"photo.png\"', 0, NULL, NULL, NULL, NULL, NULL, '105.113.90.131', 1, 0, '2023-09-24 07:06:32', '2023-09-24 07:06:32', 71);
INSERT INTO `items` (`id`, `user_id`, `name`, `dept`, `in_stock`, `c_price`, `s_price`, `new_stock`, `photos`, `disc`, `desc`, `attributes`, `color`, `size`, `sku`, `ip`, `status`, `deleted`, `created`, `updated`, `category_id`) VALUES
(9, 18, 'Budweiser ', 'b', 0, 0, 1000, 0, '\"photo.png\"', 0, NULL, NULL, NULL, NULL, NULL, '102.89.46.30', 1, 0, '2023-09-24 07:07:28', '2023-09-24 07:07:28', 71),
(10, 38, 'Big Stout', 'b', 0, 0, 1200, 0, '\"photo.png\"', 0, NULL, NULL, NULL, NULL, NULL, '105.113.90.131', 1, 0, '2023-09-24 07:12:18', '2023-09-24 07:12:18', 71),
(11, 38, 'Small Stout', 'b', 0, 0, 800, 0, '\"photo.png\"', 0, NULL, NULL, NULL, NULL, NULL, '105.112.70.175', 1, 0, '2023-09-24 07:12:59', '2023-09-24 07:12:59', 71),
(12, 38, 'Trophy Stout', 'b', 0, 0, 800, 0, '\"photo.png\"', 0, NULL, NULL, NULL, NULL, NULL, '105.112.70.175', 1, 0, '2023-09-24 07:13:32', '2023-09-24 07:13:32', 71),
(13, 38, '33', 'b', 0, 0, 700, 0, '\"photo.png\"', 0, NULL, NULL, NULL, NULL, NULL, '105.112.70.175', 1, 0, '2023-09-24 07:14:03', '2023-09-24 07:14:03', 71),
(14, 38, 'Legend', 'b', 0, 0, 1000, 0, '\"photo.png\"', 0, NULL, NULL, NULL, NULL, NULL, '105.112.70.175', 1, 0, '2023-09-24 07:14:34', '2023-09-24 07:14:34', 71),
(15, 38, 'Goldberg', 'b', 0, 0, 500, 0, '\"photo.png\"', 0, NULL, NULL, NULL, NULL, NULL, '105.113.90.131', 1, 0, '2023-09-24 07:15:07', '2023-09-24 07:15:07', 71),
(16, 38, 'Star', 'b', 0, 0, 700, 0, '\"photo.png\"', 0, NULL, NULL, NULL, NULL, NULL, '105.112.70.175', 1, 0, '2023-09-24 07:15:34', '2023-09-24 07:15:34', 71),
(17, 38, 'Flying Fish', 'b', 0, 0, 700, 0, '\"photo.png\"', 0, NULL, NULL, NULL, NULL, NULL, '105.112.70.175', 1, 0, '2023-09-24 07:16:59', '2023-09-24 07:16:59', 71),
(18, 38, 'Tiger', 'b', 0, 0, 700, 0, '\"photo.png\"', 0, NULL, NULL, NULL, NULL, NULL, '105.112.70.175', 1, 0, '2023-09-24 07:17:23', '2023-09-24 07:17:23', 71),
(19, 38, 'Origin Beer', 'b', 0, 0, 1000, 0, '\"photo.png\"', 0, NULL, NULL, NULL, NULL, NULL, '105.113.90.131', 1, 0, '2023-09-24 07:17:47', '2023-09-24 07:17:47', 71),
(20, 38, 'Small Smirnoff', 'b', 0, 0, 800, 0, '\"photo.png\"', 0, NULL, NULL, NULL, NULL, NULL, '105.113.90.131', 1, 0, '2023-09-24 07:18:28', '2023-09-24 07:18:28', 71),
(21, 38, 'Small Whiskey', 'b', 0, 0, 1200, 0, '\"photo.png\"', 0, NULL, NULL, NULL, NULL, NULL, '105.112.70.175', 1, 0, '2023-09-24 07:19:14', '2023-09-24 07:19:14', 71),
(22, 38, 'Turbo King', 'b', 0, 0, 800, 0, '\"photo.png\"', 0, NULL, NULL, NULL, NULL, NULL, '102.88.34.26', 1, 0, '2023-09-24 07:20:04', '2023-09-24 07:20:04', 71),
(23, 38, 'Gulder', 'b', 0, 0, 700, 0, '\"photo.png\"', 0, NULL, NULL, NULL, NULL, NULL, '105.112.70.175', 1, 0, '2023-09-24 07:20:34', '2023-09-24 07:20:34', 71),
(24, 38, 'Malt ', 'b', 0, 0, 500, 0, '\"photo.png\"', 0, NULL, NULL, NULL, NULL, NULL, '105.112.70.175', 1, 0, '2023-09-24 07:21:21', '2023-09-24 07:21:21', 89),
(25, 38, 'Small Eva', 'b', 0, 0, 300, 0, '\"photo.png\"', 0, NULL, NULL, NULL, NULL, NULL, '105.112.70.175', 1, 0, '2023-09-24 07:21:59', '2023-09-24 07:21:59', 92),
(26, 38, 'Big Eva', 'b', 0, 0, 500, 0, '\"photo.png\"', 0, NULL, NULL, NULL, NULL, NULL, '105.112.70.175', 1, 0, '2023-09-24 07:22:26', '2023-09-24 07:22:26', 92),
(27, 38, 'Coco Samber', 'b', 0, 0, 500, 0, '\"photo.png\"', 0, NULL, NULL, NULL, NULL, NULL, '105.112.70.175', 1, 0, '2023-09-24 07:23:25', '2023-09-24 07:23:25', 88),
(28, 38, 'Chivita ', 'b', 0, 0, 1500, 0, '\"photo.png\"', 0, NULL, NULL, NULL, NULL, NULL, '102.89.22.172', 1, 0, '2023-09-24 07:24:10', '2023-09-24 07:24:10', 90),
(29, 38, 'Hollandia Yoghurt', 'b', 0, 0, 1500, 0, '\"photo.png\"', 0, NULL, NULL, NULL, NULL, NULL, '102.89.23.225', 1, 0, '2023-09-24 07:24:59', '2023-09-24 07:24:59', 91),
(30, 38, 'Vita Milk', 'b', 0, 0, 1000, 0, '\"photo.png\"', 0, NULL, NULL, NULL, NULL, NULL, '105.112.70.175', 1, 0, '2023-09-24 07:25:19', '2023-09-24 07:25:19', 88),
(31, 38, 'Baby Oku', 'b', 0, 0, 500, 0, '\"photo.png\"', 0, NULL, NULL, NULL, NULL, NULL, '102.88.62.57', 1, 0, '2023-09-24 07:25:43', '2023-09-24 07:25:43', 88),
(32, 38, 'Bullet', 'b', 0, 0, 1200, 0, '\"photo.png\"', 0, NULL, NULL, NULL, NULL, NULL, '102.89.23.225', 1, 0, '2023-09-24 07:26:03', '2023-09-24 07:26:03', 89),
(33, 38, 'Fearless', 'b', 0, 0, 500, 0, '\"photo.png\"', 0, NULL, NULL, NULL, NULL, NULL, '102.89.23.177', 1, 0, '2023-09-24 07:26:35', '2023-09-24 07:26:35', 89),
(34, 38, 'Climax', 'b', 0, 0, 700, 0, '\"photo.png\"', 0, NULL, NULL, NULL, NULL, NULL, '102.89.22.127', 1, 0, '2023-09-24 07:28:51', '2023-09-24 07:28:51', 89),
(35, 38, 'Commando', 'b', 0, 0, 500, 0, '\"photo.png\"', 0, NULL, NULL, NULL, NULL, NULL, '105.112.70.175', 1, 0, '2023-09-24 07:29:28', '2023-09-24 07:29:28', 72),
(36, 38, 'Schweppes', 'b', 0, 0, 500, 0, '\"photo.png\"', 0, NULL, NULL, NULL, NULL, NULL, '105.112.70.175', 1, 0, '2023-09-24 07:30:28', '2023-09-24 07:30:28', 89),
(37, 38, 'Coke', 'b', 0, 0, 500, 0, '\"photo.png\"', 0, NULL, NULL, NULL, NULL, NULL, '102.89.22.172', 1, 0, '2023-09-24 07:30:49', '2023-09-24 07:30:49', 89),
(38, 38, 'Origin Bitters', 'b', 0, 0, 1000, 0, '\"photo.png\"', 0, NULL, NULL, NULL, NULL, NULL, '105.113.90.131', 1, 0, '2023-09-24 07:31:28', '2023-09-24 07:31:28', 88),
(39, 38, 'Fayrouz', 'b', 0, 0, 500, 0, '\"photo.png\"', 0, NULL, NULL, NULL, NULL, NULL, '102.88.34.86', 1, 1, '2023-09-24 07:31:59', '2023-09-24 07:31:59', 88),
(40, 38, 'Action Bitters', 'b', 0, 0, 1000, 0, '\"photo.png\"', 0, NULL, NULL, NULL, NULL, NULL, '105.112.70.175', 1, 0, '2023-09-24 07:32:22', '2023-09-24 07:32:22', 88),
(41, 38, 'Doings Bitters', 'b', 0, 0, 700, 0, '\"photo.png\"', 0, NULL, NULL, NULL, NULL, NULL, '102.88.62.57', 1, 0, '2023-09-24 07:32:49', '2023-09-24 07:32:49', 88),
(42, 38, 'Big Smirnoff', 'b', 0, 0, 1200, 0, '\"photo.png\"', 0, NULL, NULL, NULL, NULL, NULL, '105.113.90.131', 1, 0, '2023-09-24 07:33:22', '2023-09-24 07:33:22', 71),
(43, 38, 'Monster', 'b', 0, 0, 1000, 0, '\"photo.png\"', 0, NULL, NULL, NULL, NULL, NULL, '102.89.22.172', 1, 0, '2023-09-24 07:33:43', '2023-09-24 07:33:43', 88),
(44, 38, 'Long Jack', 'b', 0, 0, 1000, 0, '\"photo.png\"', 0, NULL, NULL, NULL, NULL, NULL, '105.112.70.175', 1, 0, '2023-09-24 07:34:09', '2023-09-24 07:34:09', 88),
(45, 38, 'Best Cream', 'b', 0, 0, 1500, 0, '\"photo.png\"', 0, NULL, NULL, NULL, NULL, NULL, '105.112.70.175', 1, 0, '2023-09-24 07:34:37', '2023-09-24 07:34:37', 84),
(46, 38, 'Medium Chelsea', 'b', 0, 0, 1000, 0, '\"photo.png\"', 0, NULL, NULL, NULL, NULL, NULL, '105.112.70.175', 1, 0, '2023-09-24 07:35:23', '2023-09-24 07:35:23', 84),
(47, 38, 'Warrior ', 'b', 0, 0, 1000, 0, '\"photo.png\"', 0, NULL, NULL, NULL, NULL, NULL, '102.88.62.57', 1, 0, '2023-09-24 07:36:18', '2023-09-24 07:36:18', 71),
(48, 38, 'Hero', 'b', 0, 0, 500, 0, '\"photo.png\"', 0, NULL, NULL, NULL, NULL, NULL, '102.89.41.165', 1, 0, '2023-09-24 07:36:41', '2023-09-24 07:36:41', 71),
(49, 38, 'Power Horse', 'b', 0, 0, 1500, 0, '\"photo.png\"', 0, NULL, NULL, NULL, NULL, NULL, '102.88.62.57', 1, 0, '2023-09-24 08:00:04', '2023-09-24 08:00:04', 72),
(50, 38, 'Red Bull', 'b', 0, 0, 1000, 0, '\"photo.png\"', 0, NULL, NULL, NULL, NULL, NULL, '102.89.22.127', 1, 0, '2023-09-24 08:00:26', '2023-09-24 08:00:26', 72),
(79, 38, 'Egunsi Soup', 'k', 0, 0, 1000, 0, '\"photo.png\"', 0, NULL, NULL, NULL, NULL, NULL, '102.88.35.180', 1, 0, '2023-10-01 12:20:28', '2023-10-01 12:20:28', 66),
(80, 38, 'Olmeca Tots', 'c', 0, 0, 2000, 0, '\"photo.png\"', 0, NULL, NULL, NULL, NULL, NULL, '102.88.35.180', 1, 0, '2023-10-01 12:21:38', '2023-10-01 12:21:38', 70),
(81, 18, 'vegetable', 'k', 6, 400, 1000, 0, '\"photo.png\"', 0, NULL, NULL, NULL, NULL, NULL, '102.88.82.176', 1, 0, '2023-10-01 12:53:42', '2023-10-01 12:53:42', 66),
(82, 38, 'Ogbono ', 'k', 0, 0, 1500, 0, '\"photo.png\"', 0, NULL, NULL, NULL, NULL, NULL, '102.88.34.248', 1, 0, '2023-10-01 12:54:28', '2023-10-01 12:54:28', 66),
(83, 38, 'Oha', 'k', 0, 0, 1500, 0, '\"photo.png\"', 0, NULL, NULL, NULL, NULL, NULL, '102.88.34.248', 1, 0, '2023-10-01 12:54:49', '2023-10-01 12:54:49', 66),
(84, 38, 'white Soup', 'k', 0, 0, 1500, 0, '\"photo.png\"', 0, NULL, NULL, NULL, NULL, NULL, '102.88.34.248', 1, 0, '2023-10-01 12:55:12', '2023-10-01 12:55:12', 66),
(85, 18, 'Sierra Tots', 'c', 25, 700, 1500, 0, '\"photo.png\"', 0, NULL, NULL, NULL, NULL, NULL, '102.88.82.176', 1, 0, '2023-10-01 12:58:16', '2023-10-01 12:58:16', 70),
(86, 38, 'Olmeca Bottle', 'c', 0, 0, 30000, 0, '\"photo.png\"', 0, NULL, NULL, NULL, NULL, NULL, '105.113.88.213', 1, 0, '2023-10-01 12:59:25', '2023-10-01 12:59:25', 70),
(87, 38, 'Sierra Bottle', 'c', 0, 0, 20000, 0, '\"photo.png\"', 0, NULL, NULL, NULL, NULL, NULL, '102.88.62.250', 1, 0, '2023-10-01 13:00:21', '2023-10-01 13:00:21', 70),
(88, 38, 'Hennessey   XO', 'c', 0, 0, 50000, 0, '\"photo.png\"', 0, NULL, NULL, NULL, NULL, NULL, '102.88.33.211', 1, 0, '2023-10-03 22:13:40', '2023-10-03 22:13:40', 76),
(89, 38, 'Hennessey  V.S.O.P', 'c', 0, 0, 170000, 0, '\"photo.png\"', 0, NULL, NULL, NULL, NULL, NULL, '102.88.35.37', 1, 0, '2023-10-03 22:20:11', '2023-10-03 22:20:11', 76),
(93, 38, 'Hennessey   VS Big', 'c', 0, 0, 35000, 0, '\"photo.png\"', 0, NULL, NULL, NULL, NULL, NULL, '102.88.36.242', 1, 0, '2023-10-05 18:09:36', '2023-10-05 18:09:36', 76),
(94, 18, 'Garri', 'k', 6, 200, 1000, 0, '\"photo.png\"', 0, NULL, NULL, NULL, NULL, NULL, '102.88.82.176', 1, 0, '2023-10-05 18:10:35', '2023-10-05 18:10:35', 39),
(95, 38, 'Semo', 'k', 0, 0, 500, 0, '\"photo.png\"', 0, NULL, NULL, NULL, NULL, NULL, '102.88.63.191', 1, 0, '2023-10-05 18:12:26', '2023-10-05 18:12:26', 39),
(96, 38, 'Poundo', 'k', 0, 0, 1000, 0, '\"photo.png\"', 0, NULL, NULL, NULL, NULL, NULL, '102.88.35.186', 1, 0, '2023-10-05 18:14:38', '2023-10-05 18:14:38', 39),
(98, 38, 'Titus', 'k', 0, 0, 1000, 0, '\"photo.png\"', 0, NULL, NULL, NULL, NULL, NULL, '102.88.34.149', 1, 1, '2023-10-05 18:17:24', '2023-10-05 18:17:24', 77),
(99, 18, 'Beef', 'k', 6, 100, 1000, 0, '\"photo.png\"', 0, NULL, NULL, NULL, NULL, NULL, '102.88.82.176', 1, 0, '2023-10-05 18:18:27', '2023-10-05 18:18:27', 77),
(100, 38, 'Titus', 'k', 0, 0, 1000, 0, '\"photo.png\"', 0, NULL, NULL, NULL, NULL, NULL, '102.88.34.149', 1, 0, '2023-10-05 18:18:50', '2023-10-05 18:18:50', 77),
(101, 38, 'Goat Meat', 'k', 0, 0, 2000, 0, '\"photo.png\"', 0, NULL, NULL, NULL, NULL, NULL, '102.88.35.186', 1, 0, '2023-10-05 18:19:36', '2023-10-05 18:19:36', 77),
(102, 18, 'Cow Leg', 'k', 0, 0, 2000, 0, '\"photo.png\"', 0, NULL, NULL, NULL, NULL, NULL, '102.89.40.74', 1, 0, '2023-10-05 18:20:16', '2023-10-05 18:20:16', 77),
(103, 38, 'Assorted', 'k', 0, 0, 2000, 0, '\"photo.png\"', 0, NULL, NULL, NULL, NULL, NULL, '102.88.35.186', 1, 0, '2023-10-05 18:20:56', '2023-10-05 18:20:56', 77),
(104, 38, 'Chicken', 'k', 0, 0, 2500, 0, '\"photo.png\"', 0, NULL, NULL, NULL, NULL, NULL, '102.88.35.186', 1, 0, '2023-10-05 18:21:31', '2023-10-05 18:21:31', 77),
(105, 38, 'Gizzard', 'k', 0, 0, 2000, 0, '\"photo.png\"', 0, NULL, NULL, NULL, NULL, NULL, '102.88.35.186', 1, 0, '2023-10-05 18:21:56', '2023-10-05 18:21:56', 77),
(106, 38, 'Turkey', 'k', 0, 0, 2500, 0, '\"photo.png\"', 0, NULL, NULL, NULL, NULL, NULL, '102.89.41.165', 1, 0, '2023-10-05 18:23:09', '2023-10-05 18:23:09', 77),
(107, 38, 'Hake', 'k', 0, 0, 2000, 0, '\"photo.png\"', 0, NULL, NULL, NULL, NULL, NULL, '102.88.63.191', 1, 0, '2023-10-05 18:24:00', '2023-10-05 18:24:00', 77),
(108, 38, 'Basmati Rice', 'k', 0, 0, 4000, 0, '\"photo.png\"', 0, NULL, NULL, NULL, NULL, NULL, '102.88.63.191', 1, 1, '2023-10-05 18:29:12', '2023-10-05 18:29:12', 67),
(109, 38, 'white Rice', 'k', 0, 0, 1500, 0, '\"photo.png\"', 0, NULL, NULL, NULL, NULL, NULL, '105.112.70.175', 1, 0, '2023-10-05 18:29:54', '2023-10-05 18:29:54', 77),
(110, 38, 'Fried Rice', 'k', 0, 0, 2000, 0, '\"photo.png\"', 0, NULL, NULL, NULL, NULL, NULL, '105.112.70.175', 1, 0, '2023-10-05 18:30:43', '2023-10-05 18:30:43', 67),
(111, 38, 'Jollof Rice', 'k', 0, 0, 2000, 0, '\"photo.png\"', 0, NULL, NULL, NULL, NULL, NULL, '105.112.70.175', 1, 0, '2023-10-05 18:31:25', '2023-10-05 18:31:25', 67),
(112, 38, 'Coconut Rice', 'k', 0, 0, 2000, 0, '\"photo.png\"', 0, NULL, NULL, NULL, NULL, NULL, '105.112.70.175', 1, 0, '2023-10-05 18:31:59', '2023-10-05 18:31:59', 67),
(113, 38, 'Basmati Fried Rice', 'k', 0, 0, 3500, 0, '\"photo.png\"', 0, NULL, NULL, NULL, NULL, NULL, '105.112.70.175', 1, 0, '2023-10-05 18:32:56', '2023-10-05 18:32:56', 67),
(114, 18, 'Egg Rice', 'k', 0, 0, 2500, 0, '\"photo.png\"', 0, NULL, NULL, NULL, NULL, NULL, '102.89.40.74', 1, 0, '2023-10-05 18:33:35', '2023-10-05 18:33:35', 67),
(115, 38, 'Singapore  Noodles', 'k', 0, 0, 3500, 0, '\"photo.png\"', 0, NULL, NULL, NULL, NULL, NULL, '102.88.63.20', 1, 0, '2023-10-05 18:44:47', '2023-10-05 18:44:47', 78),
(116, 38, 'Spa Jollof', 'k', 0, 0, 2000, 0, '\"photo.png\"', 0, NULL, NULL, NULL, NULL, NULL, '102.88.63.20', 1, 0, '2023-10-05 18:46:00', '2023-10-05 18:46:00', 78),
(117, 38, 'Spaghetti Bolognaise', 'k', 0, 0, 3000, 0, '\"photo.png\"', 0, NULL, NULL, NULL, NULL, NULL, '102.88.63.69', 1, 0, '2023-10-05 18:49:26', '2023-10-05 18:49:26', 78),
(118, 38, 'Ofada', 'k', 0, 0, 3000, 0, '\"photo.png\"', 0, NULL, NULL, NULL, NULL, NULL, '102.88.35.177', 1, 0, '2023-10-06 11:14:30', '2023-10-06 11:14:30', 79),
(119, 38, 'Porridge Yam', 'k', 0, 0, 2000, 0, '\"photo.png\"', 0, NULL, NULL, NULL, NULL, NULL, '102.88.63.93', 1, 0, '2023-10-06 11:16:10', '2023-10-06 11:16:10', 67),
(120, 18, 'Africana Rice', 'k', 0, 0, 3500, 0, '\"photo.png\"', 0, NULL, NULL, NULL, NULL, NULL, '102.89.40.74', 1, 0, '2023-10-06 11:17:42', '2023-10-06 11:17:42', 79),
(121, 38, 'Yamarita', 'k', 0, 0, 2500, 0, '\"photo.png\"', 0, NULL, NULL, NULL, NULL, NULL, '102.88.35.177', 1, 0, '2023-10-06 11:21:53', '2023-10-06 11:21:53', 79),
(122, 38, 'Assorted Pepper Soup', 'k', 0, 0, 2000, 0, '\"photo.png\"', 0, NULL, NULL, NULL, NULL, NULL, '102.88.35.177', 1, 0, '2023-10-06 11:32:06', '2023-10-06 11:32:06', 80),
(123, 38, 'Goat pepper soup', 'k', 0, 0, 2500, 0, '\"photo.png\"', 0, NULL, NULL, NULL, NULL, NULL, '102.88.35.177', 1, 0, '2023-10-06 11:35:41', '2023-10-06 11:35:41', 80),
(124, 38, 'Cow Leg  pepper soup', 'k', 0, 0, 2000, 0, '\"photo.png\"', 0, NULL, NULL, NULL, NULL, NULL, '102.88.35.177', 1, 0, '2023-10-06 11:36:52', '2023-10-06 11:36:52', 80),
(125, 38, 'Catfish Pepper Soup', 'k', 0, 0, 12000, 0, '\"photo.png\"', 0, NULL, NULL, NULL, NULL, NULL, '105.112.70.175', 1, 0, '2023-10-06 11:37:50', '2023-10-06 11:37:50', 80),
(126, 38, 'Nkwobi', 'k', 0, 0, 2000, 0, '\"photo.png\"', 0, NULL, NULL, NULL, NULL, NULL, '102.88.35.177', 1, 0, '2023-10-06 11:43:16', '2023-10-06 11:43:16', 80),
(127, 38, 'Isiewu Small', 'k', 0, 0, 5500, 0, '\"photo.png\"', 0, NULL, NULL, NULL, NULL, NULL, '102.88.35.177', 1, 0, '2023-10-06 11:44:30', '2023-10-06 11:44:30', 80),
(128, 38, 'Isiewu Big', 'k', 0, 0, 8000, 0, '\"photo.png\"', 0, NULL, NULL, NULL, NULL, NULL, '102.88.35.177', 1, 0, '2023-10-06 11:45:19', '2023-10-06 11:45:19', 80),
(129, 38, 'King Size Catfish', 'k', 0, 0, 15000, 0, '\"photo.png\"', 0, NULL, NULL, NULL, NULL, NULL, '105.112.70.175', 1, 0, '2023-10-06 11:48:40', '2023-10-06 11:48:40', 81),
(130, 38, 'Quarter Size Catfish', 'k', 0, 0, 10000, 0, '\"photo.png\"', 0, NULL, NULL, NULL, NULL, NULL, '105.112.70.175', 1, 0, '2023-10-06 11:53:58', '2023-10-06 11:53:58', 81),
(131, 38, 'Crocker Fish', 'k', 0, 0, 8000, 0, '\"photo.png\"', 0, NULL, NULL, NULL, NULL, NULL, '105.112.70.175', 1, 0, '2023-10-06 11:55:38', '2023-10-06 11:55:38', 81),
(132, 38, 'Chiken  Lap', 'k', 0, 0, 3000, 0, '\"photo.png\"', 0, NULL, NULL, NULL, NULL, NULL, '102.89.40.74', 1, 0, '2023-10-06 12:02:43', '2023-10-06 12:02:43', 81),
(133, 38, 'Chicken Platter', 'k', 0, 0, 15000, 0, '\"photo.png\"', 0, NULL, NULL, NULL, NULL, NULL, '102.88.35.177', 1, 0, '2023-10-06 12:07:17', '2023-10-06 12:07:17', 82),
(134, 38, 'Sea Food  Platter', 'k', 0, 0, 20000, 0, '\"photo.png\"', 0, NULL, NULL, NULL, NULL, NULL, '102.88.63.184', 1, 0, '2023-10-06 12:08:10', '2023-10-06 12:08:10', 82),
(135, 38, 'Sea Food Okro', 'k', 0, 0, 10000, 0, '\"photo.png\"', 0, NULL, NULL, NULL, NULL, NULL, '105.112.70.175', 1, 0, '2023-10-06 12:09:21', '2023-10-06 12:09:21', 66),
(136, 38, 'Hennessey  V.S Small', 'c', 0, 0, 35000, 0, '\"photo.png\"', 0, NULL, NULL, NULL, NULL, NULL, '105.112.198.92', 1, 0, '2023-10-06 12:13:25', '2023-10-06 12:13:25', 76),
(137, 38, 'Remy Martins V.S.O.P', 'c', 0, 0, 45000, 0, '\"photo.png\"', 0, NULL, NULL, NULL, NULL, NULL, '102.88.35.225', 1, 0, '2023-10-06 12:20:57', '2023-10-06 12:20:57', 76),
(138, 38, 'Remy Martins X.O', 'c', 0, 0, 150000, 0, '\"photo.png\"', 0, NULL, NULL, NULL, NULL, NULL, '102.88.63.170', 1, 0, '2023-10-06 12:21:58', '2023-10-06 12:21:58', 76),
(139, 38, 'Martel VS', 'c', 0, 0, 35000, 0, '\"photo.png\"', 0, NULL, NULL, NULL, NULL, NULL, '102.88.63.170', 1, 0, '2023-10-06 12:22:45', '2023-10-06 12:22:45', 76),
(140, 38, 'Martel Blue Swift', 'c', 0, 0, 50000, 0, '\"photo.png\"', 0, NULL, NULL, NULL, NULL, NULL, '102.88.33.211', 1, 0, '2023-10-06 12:23:42', '2023-10-06 12:23:42', 76),
(141, 38, 'Belvedere', 'c', 0, 0, 30000, 0, '\"photo.png\"', 0, NULL, NULL, NULL, NULL, NULL, '102.88.35.225', 1, 0, '2023-10-06 12:31:59', '2023-10-06 12:31:59', 83),
(142, 38, 'Absolute   Tot', 'c', 0, 0, 1500, 0, '\"photo.png\"', 0, NULL, NULL, NULL, NULL, NULL, '102.88.37.51', 1, 0, '2023-10-06 12:32:41', '2023-10-06 12:32:41', 83),
(143, 38, 'Smirnoff', 'c', 0, 0, 10000, 0, '\"photo.png\"', 0, NULL, NULL, NULL, NULL, NULL, '102.88.63.93', 1, 0, '2023-10-06 12:33:25', '2023-10-06 12:33:25', 83),
(144, 38, 'Ciroc ', 'c', 0, 0, 70000, 0, '\"photo.png\"', 0, NULL, NULL, NULL, NULL, NULL, '102.88.35.155', 1, 0, '2023-10-11 00:33:13', '2023-10-11 00:33:13', 83),
(145, 38, 'Grey  Goose', 'c', 0, 0, 60000, 0, '\"photo.png\"', 0, NULL, NULL, NULL, NULL, NULL, '102.88.63.39', 1, 0, '2023-10-11 00:34:43', '2023-10-11 00:34:43', 83),
(146, 18, 'Pravda', 'c', 0, 0, 50000, 0, '\"photo.png\"', 0, NULL, NULL, NULL, NULL, NULL, '127.0.0.1', 1, 0, '2023-10-11 00:36:27', '2023-10-11 00:36:27', 83),
(147, 38, 'Skyy', 'c', 0, 0, 15000, 0, '\"photo.png\"', 0, NULL, NULL, NULL, NULL, NULL, '102.88.63.192', 1, 1, '2023-10-11 00:37:10', '2023-10-11 00:37:10', 83),
(148, 38, 'Skyy', 'c', 0, 0, 15000, 0, '\"photo.png\"', 0, NULL, NULL, NULL, NULL, NULL, '102.88.63.192', 1, 0, '2023-10-11 00:37:10', '2023-10-11 00:37:10', 83),
(149, 38, 'Red Label', 'c', 0, 0, 15000, 0, '\"photo.png\"', 0, NULL, NULL, NULL, NULL, NULL, '102.88.36.242', 1, 0, '2023-10-11 00:39:19', '2023-10-11 00:39:19', 85),
(150, 38, 'Black Label', 'c', 0, 0, 25000, 0, '\"photo.png\"', 0, NULL, NULL, NULL, NULL, NULL, '102.88.37.13', 1, 0, '2023-10-11 00:39:57', '2023-10-11 00:39:57', 85),
(151, 38, 'Jack Daniel', 'c', 0, 0, 18000, 0, '\"photo.png\"', 0, NULL, NULL, NULL, NULL, NULL, '102.88.37.51', 1, 0, '2023-10-11 00:40:31', '2023-10-11 00:40:31', 85),
(152, 38, 'Chivao Regal', 'c', 0, 0, 25000, 0, '\"photo.png\"', 0, NULL, NULL, NULL, NULL, NULL, '102.88.63.192', 1, 0, '2023-10-11 00:43:50', '2023-10-11 00:43:50', 85),
(153, 38, 'Jameson Green', 'c', 0, 0, 20000, 0, '\"photo.png\"', 0, NULL, NULL, NULL, NULL, NULL, '102.88.33.211', 1, 0, '2023-10-11 00:44:54', '2023-10-11 00:44:54', 85),
(154, 38, 'Jameson Black Barrel', 'c', 0, 0, 25000, 0, '\"photo.png\"', 0, NULL, NULL, NULL, NULL, NULL, '102.88.36.242', 1, 0, '2023-10-11 00:45:47', '2023-10-11 00:45:47', 85),
(155, 38, 'Gleriffididi 12yrs', 'c', 0, 0, 25000, 0, '\"photo.png\"', 0, NULL, NULL, NULL, NULL, NULL, '102.88.62.66', 1, 0, '2023-10-11 00:46:53', '2023-10-11 00:46:53', 85),
(156, 38, 'Gleriffididi 15yrs', 'c', 0, 0, 35000, 0, '\"photo.png\"', 0, NULL, NULL, NULL, NULL, NULL, '102.88.62.66', 1, 0, '2023-10-11 00:47:23', '2023-10-11 00:47:23', 85),
(157, 38, 'Gleriffididi 21yrs', 'c', 0, 0, 170000, 0, '\"photo.png\"', 0, NULL, NULL, NULL, NULL, NULL, '102.88.62.66', 1, 0, '2023-10-11 00:48:21', '2023-10-11 00:48:21', 85),
(158, 38, 'Singleton', 'c', 0, 0, 55000, 0, '\"photo.png\"', 0, NULL, NULL, NULL, NULL, NULL, '102.88.62.66', 1, 0, '2023-10-11 00:48:59', '2023-10-11 00:48:59', 85),
(159, 38, 'Glenmoragin ', 'c', 0, 0, 55000, 0, '\"photo.png\"', 0, NULL, NULL, NULL, NULL, NULL, '102.88.62.55', 1, 0, '2023-10-11 00:50:01', '2023-10-11 00:50:01', 85),
(160, 38, 'Gleriffididi 18yrs', 'c', 0, 0, 50000, 0, '\"photo.png\"', 0, NULL, NULL, NULL, NULL, NULL, '102.88.62.66', 1, 0, '2023-10-11 00:51:00', '2023-10-11 00:51:00', 85),
(161, 38, 'Sierra', 'c', 0, 0, 15000, 0, '\"photo.png\"', 0, NULL, NULL, NULL, NULL, NULL, '102.88.63.39', 1, 0, '2023-10-11 00:52:02', '2023-10-11 00:52:02', 70),
(162, 38, 'Camino', 'c', 0, 0, 15000, 0, '\"photo.png\"', 0, NULL, NULL, NULL, NULL, NULL, '102.88.63.39', 1, 0, '2023-10-11 00:52:37', '2023-10-11 00:52:37', 70),
(164, 38, 'Azul', 'c', 0, 0, 200000, 0, '\"photo.png\"', 0, NULL, NULL, NULL, NULL, NULL, '102.88.63.39', 1, 0, '2023-10-11 00:54:01', '2023-10-11 00:54:01', 70),
(165, 38, 'Shipmaster Tots', 'c', 0, 0, 1000, 0, '\"photo.png\"', 0, NULL, NULL, NULL, NULL, NULL, '105.112.198.92', 1, 0, '2023-10-11 00:57:44', '2023-10-11 00:57:44', 86),
(166, 38, 'Bacardi White', 'c', 0, 0, 10000, 0, '\"photo.png\"', 0, NULL, NULL, NULL, NULL, NULL, '102.88.63.39', 1, 0, '2023-10-11 00:58:35', '2023-10-11 00:58:35', 86),
(167, 38, 'Bacardi Gold', 'c', 0, 0, 13000, 0, '\"photo.png\"', 0, NULL, NULL, NULL, NULL, NULL, '102.88.35.153', 1, 0, '2023-10-11 00:59:15', '2023-10-11 00:59:15', 86),
(168, 38, 'Captain Morgan', 'c', 0, 0, 25000, 0, '\"photo.png\"', 0, NULL, NULL, NULL, NULL, NULL, '102.88.63.39', 1, 0, '2023-10-11 00:59:50', '2023-10-11 00:59:50', 86),
(169, 38, 'Goat Pepper Meat', 'k', 0, 0, 2500, 0, '\"photo.png\"', 0, NULL, NULL, NULL, NULL, NULL, '102.89.40.74', 1, 0, '2023-10-24 13:40:46', '2023-10-24 13:40:46', 80),
(170, 38, 'Star Raddler', 'b', 0, 0, 700, 0, '\"photo.png\"', 0, NULL, NULL, NULL, NULL, NULL, '102.89.22.127', 1, 0, '2023-11-03 10:48:23', '2023-11-03 10:48:23', 71),
(171, 44, 'Desperado', 'b', 670, 500, 800, 0, '\"photo.png\"', 0, NULL, NULL, NULL, NULL, NULL, '127.0.0.1', 1, 0, '2023-11-03 11:11:06', '2023-11-03 11:11:06', 71),
(172, 38, 'Amber', 'b', 0, 0, 1000, 0, '\"photo.png\"', 0, NULL, NULL, NULL, NULL, NULL, '105.112.70.175', 1, 0, '2023-11-03 11:12:56', '2023-11-03 11:12:56', 72),
(173, 38, 'London Best', 'b', 0, 0, 800, 0, '\"photo.png\"', 0, NULL, NULL, NULL, NULL, NULL, '102.89.41.165', 1, 0, '2023-11-03 11:14:37', '2023-11-03 11:14:37', 72),
(174, 38, 'Castle Lite', 'b', 0, 0, 700, 0, '\"photo.png\"', 0, NULL, NULL, NULL, NULL, NULL, '105.112.70.175', 1, 0, '2023-11-03 11:43:06', '2023-11-03 11:43:06', 71),
(175, 38, 'Baileys', 'c', 0, 0, 23000, 0, '\"photo.png\"', 0, NULL, NULL, NULL, NULL, NULL, '102.88.36.242', 1, 0, '2023-11-08 12:37:24', '2023-11-08 12:37:24', 94),
(176, 38, 'Big Campari', 'c', 0, 0, 16000, 0, '\"photo.png\"', 0, NULL, NULL, NULL, NULL, NULL, '102.88.36.242', 1, 0, '2023-11-10 08:51:20', '2023-11-10 08:51:20', 76),
(177, 38, 'Small Campari', 'c', 0, 0, 5000, 0, '\"photo.png\"', 0, NULL, NULL, NULL, NULL, NULL, '102.88.36.242', 1, 0, '2023-11-10 08:52:38', '2023-11-10 08:52:38', 76),
(178, 38, 'Gordon Gin Tots', 'c', 0, 0, 1000, 0, '\"photo.png\"', 0, NULL, NULL, NULL, NULL, NULL, '105.112.198.92', 1, 0, '2023-11-10 09:05:09', '2023-11-10 09:05:09', 86),
(179, 38, 'Gordon  Bottle', 'c', 0, 0, 8000, 0, '\"photo.png\"', 0, NULL, NULL, NULL, NULL, NULL, '197.210.84.200', 1, 0, '2023-11-10 09:06:26', '2023-11-10 09:06:26', 86),
(180, 38, 'Triple Sec totmix  ', 'c', 0, 0, 1000, 0, '\"photo.png\"', 0, NULL, NULL, NULL, NULL, NULL, '102.88.33.211', 1, 0, '2023-11-10 09:13:30', '2023-11-10 09:13:30', 86),
(181, 38, 'Four Cousins  white', 'c', 0, 0, 10000, 0, '\"photo.png\"', 0, NULL, NULL, NULL, NULL, NULL, '102.88.36.135', 1, 0, '2023-11-10 09:19:11', '2023-11-10 09:19:11', 93),
(182, 38, 'Dorado ', 'c', 0, 0, 10000, 0, '\"photo.png\"', 0, NULL, NULL, NULL, NULL, NULL, '102.88.33.211', 1, 0, '2023-11-10 09:20:05', '2023-11-10 09:20:05', 93),
(183, 38, 'Carlo Rossi', 'c', 0, 0, 10000, 0, '\"photo.png\"', 0, NULL, NULL, NULL, NULL, NULL, '102.88.33.36', 1, 0, '2023-11-10 09:20:39', '2023-11-10 09:20:39', 93),
(184, 38, 'Expression ', 'c', 0, 0, 10000, 0, '\"photo.png\"', 0, NULL, NULL, NULL, NULL, NULL, '105.113.88.213', 1, 0, '2023-11-10 09:21:16', '2023-11-10 09:21:16', 93),
(185, 18, 'Leon', 'c', 0, 3000, 5000, 0, '\"photo.png\"', 0, NULL, NULL, NULL, NULL, NULL, '127.0.0.1', 1, 0, '2023-11-10 09:21:42', '2023-11-10 09:21:42', 93),
(186, 38, 'Four Street', 'c', 0, 0, 10000, 0, '\"photo.png\"', 0, NULL, NULL, NULL, NULL, NULL, '102.88.36.135', 1, 0, '2023-11-10 09:22:21', '2023-11-10 09:22:21', 93),
(187, 38, 'Martini ex-dry', 'c', 0, 0, 20000, 0, '\"photo.png\"', 0, NULL, NULL, NULL, NULL, NULL, '197.210.84.200', 1, 0, '2023-11-10 09:32:33', '2023-11-10 09:32:33', 94),
(188, 38, 'Martini Bianco', 'c', 0, 0, 20000, 0, '\"photo.png\"', 0, NULL, NULL, NULL, NULL, NULL, '197.210.78.141', 1, 0, '2023-11-10 09:43:50', '2023-11-10 09:43:50', 94),
(189, 38, 'Martini Rose', 'c', 0, 0, 15000, 0, '\"photo.png\"', 0, NULL, NULL, NULL, NULL, NULL, '105.113.88.213', 1, 0, '2023-11-10 09:50:32', '2023-11-10 09:50:32', 94),
(190, 38, 'Amarulla', 'c', 0, 0, 12000, 0, '\"photo.png\"', 0, NULL, NULL, NULL, NULL, NULL, '197.210.79.157', 1, 0, '2023-11-10 09:51:25', '2023-11-10 09:51:25', 94);
INSERT INTO `items` (`id`, `user_id`, `name`, `dept`, `in_stock`, `c_price`, `s_price`, `new_stock`, `photos`, `disc`, `desc`, `attributes`, `color`, `size`, `sku`, `ip`, `status`, `deleted`, `created`, `updated`, `category_id`) VALUES
(191, 38, 'Moet Brut', 'c', 0, 0, 50000, 0, '\"photo.png\"', 0, NULL, NULL, NULL, NULL, NULL, '102.88.63.49', 1, 0, '2023-11-10 10:02:48', '2023-11-10 10:02:48', 95),
(192, 38, 'Moet Rose', 'c', 0, 0, 65000, 0, '\"photo.png\"', 0, NULL, NULL, NULL, NULL, NULL, '105.113.88.213', 1, 0, '2023-11-10 10:03:24', '2023-11-10 10:03:24', 95),
(193, 38, 'Moet  Imperial', 'c', 0, 0, 60000, 0, '\"photo.png\"', 0, NULL, NULL, NULL, NULL, NULL, '102.88.62.79', 1, 0, '2023-11-10 10:04:36', '2023-11-10 10:04:36', 95),
(194, 38, 'Veuve Clicguot', 'c', 0, 0, 70000, 0, '\"photo.png\"', 0, NULL, NULL, NULL, NULL, NULL, '102.88.63.49', 1, 0, '2023-11-10 10:06:56', '2023-11-10 10:06:56', 95),
(195, 38, 'Don Perignon', 'c', 0, 0, 200000, 0, '\"photo.png\"', 0, NULL, NULL, NULL, NULL, NULL, '102.88.35.178', 1, 0, '2023-11-10 10:17:43', '2023-11-10 10:17:43', 95),
(196, 38, 'Crystal', 'c', 0, 0, 150000, 0, '\"photo.png\"', 0, NULL, NULL, NULL, NULL, NULL, '102.88.34.86', 1, 0, '2023-11-10 10:18:19', '2023-11-10 10:18:19', 95),
(197, 38, 'Ace of Spades', 'c', 0, 0, 200000, 0, '\"photo.png\"', 0, NULL, NULL, NULL, NULL, NULL, '102.88.62.79', 1, 0, '2023-11-10 10:19:07', '2023-11-10 10:19:07', 95),
(198, 38, 'Verve Du Vernay', 'c', 0, 0, 12000, 0, '\"photo.png\"', 0, NULL, NULL, NULL, NULL, NULL, '102.88.33.211', 1, 0, '2023-11-10 10:19:58', '2023-11-10 10:19:58', 95),
(199, 38, 'Andre Rose', 'c', 0, 0, 10000, 0, '\"photo.png\"', 0, NULL, NULL, NULL, NULL, NULL, '105.113.88.213', 1, 0, '2023-11-10 10:20:46', '2023-11-10 10:20:46', 95),
(200, 38, 'Baileys Delight', 'c', 0, 0, 18000, 0, '\"photo.png\"', 0, NULL, NULL, NULL, NULL, NULL, '102.88.33.211', 1, 0, '2023-11-10 11:19:50', '2023-11-10 11:19:50', 94),
(201, 38, 'Valeta', 'c', 0, 0, 5000, 0, '\"photo.png\"', 0, NULL, NULL, NULL, NULL, NULL, '105.113.88.213', 1, 0, '2023-11-10 11:24:49', '2023-11-10 11:24:49', 75),
(203, 38, 'Maximo ', 'c', 0, 0, 15000, 0, '\"photo.png\"', 0, NULL, NULL, NULL, NULL, NULL, '105.113.88.213', 1, 0, '2023-11-10 11:28:03', '2023-11-10 11:28:03', 75),
(204, 38, 'Rajska', 'c', 0, 0, 12000, 0, '\"photo.png\"', 0, NULL, NULL, NULL, NULL, NULL, '102.88.35.13', 1, 1, '2023-11-10 13:41:04', '2023-11-10 13:41:04', 83),
(205, 38, 'Jagga', 'b', 0, 0, 700, 0, '\"photo.png\"', 0, NULL, NULL, NULL, NULL, NULL, '102.88.35.152', 1, 0, '2023-11-10 13:53:17', '2023-11-10 13:53:17', 88),
(206, 38, 'Bogo', 'b', 0, 0, 800, 0, '\"photo.png\"', 0, NULL, NULL, NULL, NULL, NULL, '105.112.70.175', 1, 0, '2023-11-10 13:54:36', '2023-11-10 13:54:36', 72),
(207, 38, 'Full chicken', 'k', 0, 0, 8000, 0, '\"photo.png\"', 0, NULL, NULL, NULL, NULL, NULL, '102.89.41.165', 1, 0, '2023-11-10 14:43:01', '2023-11-10 14:43:01', 80),
(208, 38, 'Titus fish', 'k', 0, 0, 1500, 0, '\"photo.png\"', 0, NULL, NULL, NULL, NULL, NULL, '102.89.40.74', 1, 0, '2023-11-10 14:45:12', '2023-11-10 14:45:12', 77),
(209, 18, 'Chicken wings', 'k', 0, 0, 2500, 0, '\"photo.png\"', 0, NULL, NULL, NULL, NULL, NULL, '127.0.0.1', 1, 0, '2023-11-10 15:16:19', '2023-11-10 15:16:19', 80),
(210, 18, 'Rajska Tots', 'c', 0, 0, 1000, 0, '\"photo.png\"', 0, NULL, NULL, NULL, NULL, NULL, '127.0.0.1', 1, 0, '2023-11-14 11:26:33', '2023-11-14 11:26:33', 83),
(211, 38, 'Black Goldberg', 'b', 0, 0, 700, 0, '\"photo.png\"', 0, NULL, NULL, NULL, NULL, NULL, '105.112.70.175', 1, 0, '2023-12-23 12:05:37', '2023-12-23 12:05:37', 71),
(212, 38, 'Fayrouz', 'b', 0, 0, 500, 0, '\"photo.png\"', 0, NULL, NULL, NULL, NULL, NULL, '102.89.22.172', 1, 0, '2023-12-23 14:39:19', '2023-12-23 14:39:19', 89),
(213, 38, 'Predator', 'b', 0, 0, 500, 0, '\"photo.png\"', 0, NULL, NULL, NULL, NULL, NULL, '105.112.70.175', 1, 0, '2023-12-23 14:51:23', '2023-12-23 14:51:23', 72),
(214, 18, 'Jigga', 'b', 0, 1000, 1500, 0, '\"photo.png\"', 0, NULL, NULL, NULL, NULL, NULL, '127.0.0.1', 1, 0, '2023-12-23 14:57:39', '2023-12-23 14:57:39', 84),
(215, 18, 'chips ', 'k', 0, 1200, 3200, 0, '\"photo.png\"', 0, NULL, NULL, NULL, NULL, NULL, '127.0.0.1', 1, 0, '2023-12-23 15:15:19', '2023-12-23 15:15:19', 67),
(216, 18, 'Black Label Tot', 'c', 0, 1200, 2000, 0, '\"photo.png\"', 0, NULL, NULL, NULL, NULL, NULL, '102.22.216.158', 1, 0, '2023-12-23 17:19:52', '2023-12-23 17:19:52', 76),
(217, 18, 'Smirnoff', 'b', 0, 1250, 2100, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, '127.0.0.1', 1, 1, '2024-11-02 02:51:37', '2024-11-02 02:51:37', 71),
(219, 18, 'Big cocktail', 'c', 0, 0, 8900, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, '127.0.0.1', 1, 1, '2024-11-04 00:03:23', '2024-11-04 00:03:23', 95),
(220, 18, 'Big cocktail', 'b', 0, 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, '127.0.0.1', 1, 1, '2024-11-04 01:51:08', '2024-11-04 01:51:08', 92);





INSERT INTO `plans` (`id`, `plan_title`, `plan_amount`, `plan_currency`, `plan_descr`, `plan_type`, `plan_duration`, `plan_features`, `plan_avatar`, `created_at`, `updated_at`, `deleted`) VALUES
(1, 'Weekly', 1500, 'NGN', 'For businesses needing quick insights to stay on top of daily activities and receive instant alerts for effective decision-making. Essential features for immediate impact.', 'weekly', 7, '[\"Start scaling!\", \"Watch and analyze your business growth without a data analyst.\", \"Track inventory and measure sales.\", \"Manage your users/workers in one place.\", \"Receive timely alerts on low stock to prevent any interruptions in business operations.\", \"Stay informed about stock status changes in real-time to address shortages or excess inventory.\"]', NULL, '2024-11-15 11:19:28', '2024-11-15 11:19:28', 0);
INSERT INTO `plans` (`id`, `plan_title`, `plan_amount`, `plan_currency`, `plan_descr`, `plan_type`, `plan_duration`, `plan_features`, `plan_avatar`, `created_at`, `updated_at`, `deleted`) VALUES
(2, 'Monthly', 5000, 'NGN', 'For businesses looking to manage and measure their performance comprehensively. Monthly plans offer enhanced reporting and tracking capabilities.', 'monthly', 30, '[\"Get started now!\", \"Track monthly profits or losses to assess business health and profitability.\", \"Get detailed sales reports every month to understand sales trends and plan inventory accordingly.\", \"Manage multiple businesses simultaneously, simplifying multi-business operations.\", \"Organize inventory, sales, and personnel based on departmental structures for more granular management.\", \"Access reports for various date ranges to analyze performance metrics and support month-to-month planning.\"]', NULL, '2024-11-15 11:19:28', '2024-11-15 11:19:28', 0);
INSERT INTO `plans` (`id`, `plan_title`, `plan_amount`, `plan_currency`, `plan_descr`, `plan_type`, `plan_duration`, `plan_features`, `plan_avatar`, `created_at`, `updated_at`, `deleted`) VALUES
(3, 'Yearly', 50000, 'NGN', 'Ideal for large-scale businesses requiring continuous, unrestricted access. Yearly plans unlock all features and support strategic growth and long-term analysis.', 'yearly', 365, '[\"Get inventory-pro!\", \"Regular updates with new features, custom domain, and priority email/WhatsApp support.\", \"Apportioning: Allocate resources precisely across departments, locations, or time periods to improve efficiency and budget management.\", \"Register as many products as needed without restrictions, accommodating business growth and expanded offerings.\", \"Storage unlimited: Enjoy unlimited storage, ideal for businesses with extensive product ranges and historical data.\", \"Export data to other platforms or software, streamlining inventory management and allowing for easier data transfer.\"]', NULL, '2024-11-15 11:19:29', '2024-11-15 11:19:29', 0);

INSERT INTO `role` (`id`, `type`) VALUES
(1, 'admin');
INSERT INTO `role` (`id`, `type`) VALUES
(4, 'bar');
INSERT INTO `role` (`id`, `type`) VALUES
(6, 'cleaning');
INSERT INTO `role` (`id`, `type`) VALUES
(5, 'cocktail'),
(3, 'kitchen'),
(7, 'manager'),
(2, 'user');

INSERT INTO `sales` (`id`, `title`, `qty_left`, `qty`, `price`, `total`, `dept`, `comment`, `item_id`, `extracted_id`, `deleted`, `created`, `updated`) VALUES
(11, 'vegetable', 0, 4, NULL, 4000, 'k', NULL, 81, NULL, 0, '2024-11-10 18:04:13', '2024-11-10 18:04:12');
INSERT INTO `sales` (`id`, `title`, `qty_left`, `qty`, `price`, `total`, `dept`, `comment`, `item_id`, `extracted_id`, `deleted`, `created`, `updated`) VALUES
(12, 'Garri', 0, 4, NULL, 4000, 'k', NULL, 94, NULL, 0, '2024-11-10 18:04:31', '2024-11-10 18:04:30');
INSERT INTO `sales` (`id`, `title`, `qty_left`, `qty`, `price`, `total`, `dept`, `comment`, `item_id`, `extracted_id`, `deleted`, `created`, `updated`) VALUES
(13, 'Beef', 0, 4, 1000, 4000, 'k', NULL, 99, NULL, 0, '2024-11-10 18:04:40', '2024-11-10 18:04:39');
INSERT INTO `sales` (`id`, `title`, `qty_left`, `qty`, `price`, `total`, `dept`, `comment`, `item_id`, `extracted_id`, `deleted`, `created`, `updated`) VALUES
(14, 'Sierra Tots', 0, 45, NULL, 67500, 'c', NULL, 85, NULL, 0, '2024-11-10 18:28:21', '2024-11-10 18:28:20'),
(15, 'Sierra Tots', 0, 20, NULL, 30000, 'c', NULL, 85, NULL, 0, '2024-11-10 18:31:16', '2024-11-10 18:31:16'),
(16, 'Desperado', 0, 670, NULL, 536000, 'b', NULL, 171, NULL, 0, '2025-01-01 20:00:56', '2025-01-01 20:00:56'),
(17, 'Bananas', 0, 1, 3400, 3400, 'k', NULL, NULL, NULL, 0, '2025-01-01 20:09:09', '2025-01-01 20:09:09');

INSERT INTO `stock_history` (`id`, `user_id`, `in_stock`, `desc`, `version`, `difference`, `deleted`, `created`, `updated`, `apportion_id`, `extracted_id`, `item_id`) VALUES
(21, 18, 10, 'Beef stock updated to 10 by hacker', 10, 10, 0, '2024-11-10 18:01:54', '2024-11-10 18:01:54', NULL, NULL, 99);
INSERT INTO `stock_history` (`id`, `user_id`, `in_stock`, `desc`, `version`, `difference`, `deleted`, `created`, `updated`, `apportion_id`, `extracted_id`, `item_id`) VALUES
(22, 18, 10, 'Beef stock updated to 10 by hacker', 10, 10, 0, '2024-11-10 18:02:01', '2024-11-10 18:02:01', NULL, NULL, 99);
INSERT INTO `stock_history` (`id`, `user_id`, `in_stock`, `desc`, `version`, `difference`, `deleted`, `created`, `updated`, `apportion_id`, `extracted_id`, `item_id`) VALUES
(23, 18, 10, 'Garri stock updated to 10 by hacker', 10, 10, 0, '2024-11-10 18:02:26', '2024-11-10 18:02:26', NULL, NULL, 94);
INSERT INTO `stock_history` (`id`, `user_id`, `in_stock`, `desc`, `version`, `difference`, `deleted`, `created`, `updated`, `apportion_id`, `extracted_id`, `item_id`) VALUES
(24, 18, 10, 'vegetable stock updated to 10 by hacker', 10, 10, 0, '2024-11-10 18:02:48', '2024-11-10 18:02:48', NULL, NULL, 81),
(25, 18, -4, 'Sale recorded for 4 units.', 10, -4, 0, '2024-11-10 18:04:12', '2024-11-10 18:04:12', NULL, NULL, 81),
(26, 18, -4, 'Sale recorded for 4 units.', 11, -4, 0, '2024-11-10 18:04:30', '2024-11-10 18:04:30', NULL, NULL, 94),
(27, 18, -4, 'Sale recorded for 4 units.', 12, -4, 0, '2024-11-10 18:04:39', '2024-11-10 18:04:39', NULL, NULL, 99),
(28, 18, 6, 'Beef stock updated to 6 by hacker', 10, 6, 0, '2024-11-10 18:06:30', '2024-11-10 18:06:30', NULL, NULL, 99),
(29, 18, -45, 'Sale recorded for 45 units.', 10, -45, 0, '2024-11-10 18:28:20', '2024-11-10 18:28:20', NULL, NULL, 85),
(30, 18, 45, 'Sierra Tots stock updated to 45 by hacker', 10, 45, 0, '2024-11-10 18:29:28', '2024-11-10 18:29:28', NULL, NULL, 85),
(31, 18, 45, 'Sierra Tots stock updated to 45 by hacker', 11, 45, 0, '2024-11-10 18:29:56', '2024-11-10 18:29:56', NULL, NULL, 85),
(32, 18, -20, 'Sale recorded for 20 units.', 10, -20, 0, '2024-11-10 18:31:16', '2024-11-10 18:31:16', NULL, NULL, 85),
(33, 18, 0, 'Sale updated from 4 to 4.', 10, 0, 0, '2024-11-11 10:23:22', '2024-11-11 10:23:22', NULL, NULL, 99),
(34, 18, 0, 'Sale updated from 4 to 4.', 11, 0, 0, '2024-11-11 10:23:31', '2024-11-11 10:23:31', NULL, NULL, 99),
(35, 44, -670, 'Sale recorded for 670 units.', 10, -670, 0, '2025-01-01 20:00:56', '2025-01-01 20:00:56', NULL, NULL, 171),
(36, 44, 670, 'Desperado stock updated to 670 by jameschristo962', 10, 670, 0, '2025-01-01 20:06:03', '2025-01-01 20:06:03', NULL, NULL, 171),
(37, 44, 670, 'Desperado stock updated to 670 by jameschristo962', 11, 670, 0, '2025-01-01 20:06:56', '2025-01-01 20:06:56', NULL, NULL, 171);

INSERT INTO `transactions` (`id`, `user_id`, `plan_id`, `is_subscription`, `tx_ref`, `tx_amount`, `tx_descr`, `tx_status`, `currency_code`, `provider`, `deleted`, `created_at`, `updated_at`, `tx_id`) VALUES
(1, 43, 2, 1, 'Techa-h3fym', 5000, 'Subscription for plan: Monthly', 'pending', 'NGN', 'flutterwave', 0, '2024-11-18 18:53:41', '2024-11-18 18:53:41', NULL);
INSERT INTO `transactions` (`id`, `user_id`, `plan_id`, `is_subscription`, `tx_ref`, `tx_amount`, `tx_descr`, `tx_status`, `currency_code`, `provider`, `deleted`, `created_at`, `updated_at`, `tx_id`) VALUES
(2, 43, 1, 1, 'Techa-snzep', 1500, 'Subscription for plan: Weekly', 'pending', 'NGN', 'flutterwave', 0, '2024-11-19 00:13:09', '2024-11-19 00:13:09', NULL);
INSERT INTO `transactions` (`id`, `user_id`, `plan_id`, `is_subscription`, `tx_ref`, `tx_amount`, `tx_descr`, `tx_status`, `currency_code`, `provider`, `deleted`, `created_at`, `updated_at`, `tx_id`) VALUES
(3, 43, 1, 1, 'Techa-alwwo', 1500, 'Subscription for plan: Weekly', 'pending', 'NGN', 'flutterwave', 0, '2024-11-19 00:13:19', '2024-11-19 00:13:19', NULL);
INSERT INTO `transactions` (`id`, `user_id`, `plan_id`, `is_subscription`, `tx_ref`, `tx_amount`, `tx_descr`, `tx_status`, `currency_code`, `provider`, `deleted`, `created_at`, `updated_at`, `tx_id`) VALUES
(4, 45, 2, 1, 'Techa-4jwcd', 5000, 'Subscription for plan: Monthly', 'cancelled', 'NGN', 'flutterwave', 0, '2024-11-19 00:13:52', '2024-11-19 00:13:52', NULL),
(5, 45, 2, 1, 'Techa-7ycxg', 5000, 'Subscription for plan: Monthly', 'pending', 'NGN', 'flutterwave', 0, '2024-11-19 00:17:21', '2024-11-19 00:17:21', NULL),
(6, 45, 3, 1, 'Techa-d74gr', 50000, 'Subscription for plan: Yearly', 'pending', 'NGN', 'flutterwave', 0, '2024-11-19 00:17:37', '2024-11-19 00:17:37', NULL),
(7, 45, 2, 1, 'Techa-lmucc', 5000, 'Subscription for plan: Monthly', 'pending', 'NGN', 'flutterwave', 0, '2024-11-19 00:17:37', '2024-11-19 00:17:37', NULL),
(8, 44, 1, 1, 'Techa-hncmw', 1500, 'Subscription for plan: Weekly', 'cancelled', 'NGN', 'flutterwave', 0, '2024-11-19 00:18:09', '2024-11-19 00:18:09', NULL),
(9, 43, 3, 1, 'Techa-1tyiv', 50000, 'Subscription for plan: Yearly', 'cancelled', 'NGN', 'flutterwave', 0, '2024-11-19 00:46:36', '2024-11-19 00:46:36', NULL),
(10, 46, 3, 1, 'Techa-72uhz', 50000, 'Subscription for plan: Yearly', 'pending', 'NGN', 'flutterwave', 0, '2024-11-19 08:55:19', '2024-11-19 08:55:19', NULL),
(11, 46, 3, 1, 'Techa-giv3i', 50000, 'Subscription for plan: Yearly', 'pending', 'NGN', 'flutterwave', 0, '2024-11-19 08:56:30', '2024-11-19 08:56:30', NULL),
(12, 46, 2, 1, 'Techa-wusah', 5000, 'Subscription for plan: Monthly', 'cancelled', 'NGN', 'flutterwave', 0, '2024-11-19 09:07:42', '2024-11-19 09:07:42', NULL),
(13, 43, 2, 1, 'Techa-phqh5', 5000, 'Subscription for plan: Monthly', 'pending', 'NGN', 'flutterwave', 0, '2024-11-19 09:14:35', '2024-11-19 09:14:35', NULL),
(14, 46, 3, 1, 'Techa-iddf5', 50000, 'Subscription for plan: Yearly', 'pending', 'NGN', 'flutterwave', 0, '2024-11-19 10:35:02', '2024-11-19 10:35:02', NULL),
(15, 46, 2, 1, 'Techa-nests', 5000, 'Subscription for plan: Monthly', 'pending', 'NGN', 'flutterwave', 0, '2024-11-19 10:35:02', '2024-11-19 10:35:02', NULL),
(16, 46, 1, 1, 'Techa-4w0tu', 1500, 'Subscription for plan: Weekly', 'pending', 'NGN', 'flutterwave', 0, '2024-11-19 10:35:54', '2024-11-19 10:35:54', NULL),
(17, 47, 2, 1, 'Techa-9ixov', 5000, 'Subscription for plan: Monthly', 'cancelled', 'NGN', 'flutterwave', 0, '2024-11-19 20:36:58', '2024-11-19 20:36:58', NULL),
(18, 44, 2, 1, 'Techa-1z1hz', 5000, 'Subscription for plan: Monthly', 'cancelled', 'NGN', 'flutterwave', 0, '2024-11-21 08:56:49', '2024-11-21 08:56:49', NULL);

INSERT INTO `user` (`id`, `name`, `username`, `email`, `phone`, `password`, `photo`, `admin`, `gender`, `city`, `about`, `ratings`, `reviews`, `acct_no`, `bank`, `socials`, `src`, `cate`, `online`, `status`, `verified`, `ip`, `created`, `updated`, `deleted`) VALUES
(18, 'Chris James', 'hacker', 'chris@coding.com', '08138958645', '$2b$12$HyaGLaIqMnto6gq63NGQHuJAtmVxcXeoAjdKdPnptm9oCXvp9MEdi', NULL, 0, 'm', 'Lagos', 'Elite software engr with special interests in artificial intelligence, data & hacking.', NULL, NULL, '7026561327', 'opay', '{\"twitter\": \"\", \"facebook\": \"\", \"linkedin\": \"\", \"instagram\": \"\"}', NULL, 'user', 1, 1, 0, '127.0.0.1', '2023-09-15 10:52:52', '2023-09-15 10:52:52', 0);
INSERT INTO `user` (`id`, `name`, `username`, `email`, `phone`, `password`, `photo`, `admin`, `gender`, `city`, `about`, `ratings`, `reviews`, `acct_no`, `bank`, `socials`, `src`, `cate`, `online`, `status`, `verified`, `ip`, `created`, `updated`, `deleted`) VALUES
(38, 'Bayo Oba', 'bayooba60', 'bayooba60@gmail.com', '08036994729', '$2b$12$4PYtQaDDsQnpoPGrakBEH.oF9ermFR5x0IdpRTqnMk/2C6X8AgtrW', NULL, 0, 'male', 'Lagos', '', NULL, NULL, '2591005731', 'ecobank', NULL, NULL, NULL, 0, 1, 0, '102.89.40.74', '2023-09-15 16:33:13', '2023-09-15 16:33:13', 0);
INSERT INTO `user` (`id`, `name`, `username`, `email`, `phone`, `password`, `photo`, `admin`, `gender`, `city`, `about`, `ratings`, `reviews`, `acct_no`, `bank`, `socials`, `src`, `cate`, `online`, `status`, `verified`, `ip`, `created`, `updated`, `deleted`) VALUES
(39, 'Big J', '@hacker2', 'jameschristo962@gmail.com', '090909933', '$2b$12$o8wiAltMC2kpldyiQXI1Iemv0LzUV.UvhlHPjdOIF9LIPSvvvp1YK', NULL, 0, 'male', '', '', NULL, NULL, '5913408010', 'fcmb', NULL, NULL, NULL, 1, 1, 1, '102.88.63.228', '2023-09-27 16:21:01', '2023-09-27 16:21:01', 0);
INSERT INTO `user` (`id`, `name`, `username`, `email`, `phone`, `password`, `photo`, `admin`, `gender`, `city`, `about`, `ratings`, `reviews`, `acct_no`, `bank`, `socials`, `src`, `cate`, `online`, `status`, `verified`, `ip`, `created`, `updated`, `deleted`) VALUES
(41, 'Bunmi', 'bunmishaki', 'bumi_okulalu@yahoo.com', '08122222184', '$2b$12$rdxR6XGpunV3Fa1/NS80JOs1ComtsC75bcZcSfZrEuGJ9OzTD.w0i', NULL, 0, 'female', 'Lagos', '', NULL, NULL, '0011240401', 'gtb', NULL, NULL, NULL, 0, 1, 0, '102.88.34.248', '2023-10-01 12:43:38', '2023-10-01 12:43:38', 0),
(42, 'Christian', 'chrisceejay', 'lazarusceejey@gmail.com', '09135748308', '$2b$12$3jQq1BR1SMqOC3ZUpbmkA..GrbQojG8GP.UZC.93RJopljLDYx/KK', NULL, 0, 'male', 'Lagos', '', NULL, NULL, '9135748308', 'opay', NULL, NULL, NULL, 0, 1, 0, '102.88.63.113', '2023-10-01 13:43:28', '2023-10-01 13:43:28', 0),
(43, NULL, 'jameschristo962@gmail.com', 'joy2@gmail.com', '8123456', '$2b$12$LgrXzOn5p/c1cROn.MQF6OSrD.S7ua.iItuIdVnfnYcLuhJM/HQga', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '{}', NULL, NULL, 0, 0, 0, '127.0.0.1', '2024-11-17 17:51:38', '2024-11-17 17:51:38', 0),
(44, NULL, 'jameschristo962', 'edet@yahoo.com', '0813895864', '$2b$12$k813q5Vkc.bwWcWXnK5UiOyGO6/ht/sQFWodYUCJuqBAh.tCtpV0.', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '{}', NULL, NULL, 1, 0, 0, '127.0.0.1', '2024-11-17 18:06:38', '2024-11-17 18:06:38', 0),
(45, NULL, 'jameschristo96', 'edet@yahoo.co', '081389586', '$2b$12$KuURJ0jPJhME1H9Pjbm/8ehiGUEGWcptTBv/4bPR80CA1RDVJ7uDm', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '{}', NULL, NULL, 0, 0, 0, '127.0.0.1', '2024-11-17 18:21:40', '2024-11-17 18:21:40', 0),
(46, NULL, 'edikanudom2007@gmail.com', 'edikanudom2007@gmail.com', NULL, '$2b$12$dzPuXyKmhfyymv/0/Mf3beuyOoSREG.AP7ur4SRynxaTif1bZwNqO', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '{}', NULL, NULL, 0, 0, 0, NULL, '2024-11-19 08:55:19', '2024-11-19 08:55:19', 0),
(47, NULL, 'edet1@gmail.com', 'edet1@gmail.com', NULL, '$2b$12$vn/MqGdRd1cUaPPyDHG1muKXHEkI63jx9GmULQs0nDZpu8dc8l18i', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '{}', NULL, NULL, 0, 0, 0, NULL, '2024-11-19 20:36:58', '2024-11-19 20:36:58', 0);

INSERT INTO `user_role_association` (`user_id`, `role_id`) VALUES
(18, 1);
INSERT INTO `user_role_association` (`user_id`, `role_id`) VALUES
(38, 1);
INSERT INTO `user_role_association` (`user_id`, `role_id`) VALUES
(39, 7);
INSERT INTO `user_role_association` (`user_id`, `role_id`) VALUES
(41, 1),
(42, 7);


/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;