-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 11, 2026 at 10:03 AM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `flowershop_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `name`) VALUES
(1, 'Bouquets'),
(2, 'Roses'),
(3, 'Seasonal Flowers'),
(4, 'Fresh Flowers'),
(5, 'Dried Flowers'),
(6, 'Birthday Flowers'),
(7, 'Anniversary'),
(8, 'Valentine’s Day'),
(9, 'Mother’s Day'),
(10, 'Wedding Flowers'),
(11, 'Sympathy'),
(12, 'Congratulations'),
(13, 'Wildflower'),
(14, 'Best Sellers');

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` int(11) NOT NULL,
  `order_number` varchar(100) NOT NULL,
  `total_price` decimal(10,2) NOT NULL,
  `order_date` datetime DEFAULT current_timestamp(),
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`id`, `order_number`, `total_price`, `order_date`, `user_id`) VALUES
(1, 'ORD-1768121990', 710000.00, '2026-01-11 15:29:50', 3);

-- --------------------------------------------------------

--
-- Table structure for table `order_items`
--

CREATE TABLE `order_items` (
  `id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `sub_total` decimal(10,2) NOT NULL,
  `product_id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

--
-- Dumping data for table `order_items`
--

INSERT INTO `order_items` (`id`, `quantity`, `sub_total`, `product_id`, `order_id`) VALUES
(1, 1, 190000.00, 13, 1),
(2, 1, 240000.00, 15, 1),
(3, 1, 240000.00, 15, 1);

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` int(11) NOT NULL,
  `name` varchar(150) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `image` varchar(255) NOT NULL,
  `category_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `name`, `price`, `image`, `category_id`) VALUES
(1, 'Soft Pastel Dream', 45000.00, '/Flower-Shop-Ecommerce-Website-Backend/uploads/products/soft-pastel-dream.png', 1),
(2, 'Golden Hour Blooms', 40000.00, '/Flower-Shop-Ecommerce-Website-Backend/uploads/products/golden-hour-blooms.png', 1),
(3, 'Garden Rose Vintage Style', 65000.00, '/Flower-Shop-Ecommerce-Website-Backend/uploads/products/garden-rose-vintage-style.png', 1),
(4, 'Freesia Spring Bouquet', 55000.00, '/Flower-Shop-Ecommerce-Website-Backend/uploads/products/freesia-spring-bouquet.png', 1),
(5, 'Baby Breath Luxury Dome', 160000.00, '/Flower-Shop-Ecommerce-Website-Backend/uploads/products/baby-breath-luxury-dome.png', 1),
(6, 'Classic Red Rose Bundle', 65000.00, '/Flower-Shop-Ecommerce-Website-Backend/uploads/products/classic-red-rose-bundle.png', 2),
(7, 'Blue Moon Roses', 26000.00, '/Flower-Shop-Ecommerce-Website-Backend/uploads/products/blue-moon-roses.png', 2),
(8, 'Ecuador Giant Red Roses', 250000.00, '/Flower-Shop-Ecommerce-Website-Backend/uploads/products/ecuador-giant-red-roses.png', 2),
(9, 'Cappuccino Roses', 280000.00, '/Flower-Shop-Ecommerce-Website-Backend/uploads/products/cappuccino-roses.png', 2),
(10, 'White Avalanche Roses', 240000.00, '/Flower-Shop-Ecommerce-Website-Backend/uploads/products/white-avalanche-roses.png', 2),
(11, 'Sakura Cherry Blossom', 260000.00, '/Flower-Shop-Ecommerce-Website-Backend/uploads/products/sakura-cherry-blossom.png', 3),
(12, 'Summer Sunflower Luxe', 180000.00, '/Flower-Shop-Ecommerce-Website-Backend/uploads/products/summer-sunflower-luxe.png', 3),
(13, 'Autumn Chrysanthemum', 190000.00, '/Flower-Shop-Ecommerce-Website-Backend/uploads/products/autumn-chrysanthemum.png', 3),
(14, 'Winter Amaryllis', 220000.00, '/Flower-Shop-Ecommerce-Website-Backend/uploads/products/winter-amaryllis.png', 3),
(15, 'Orchid Phalaenopsis', 240000.00, '/Flower-Shop-Ecommerce-Website-Backend/uploads/products/orchid-phalaenopsis.png', 4),
(16, 'Pink Lily', 40000.00, '/Flower-Shop-Ecommerce-Website-Backend/uploads/products/pink-lily.png', 14),
(18, 'Yellow Roses', 35000.00, '/Flower-Shop-Ecommerce-Website-Backend/uploads/products/yellow-roses.png', 14),
(19, 'Mini Cake Flower', 45000.00, '/Flower-Shop-Ecommerce-Website-Backend/uploads/products/mini-cake-flower.png', 14);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `phone` varchar(20) NOT NULL,
  `address` text NOT NULL,
  `role` enum('ROLE_ADMIN','ROLE_CUSTOMER') NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `email`, `password`, `phone`, `address`, `role`, `created_at`) VALUES
(1, 'John Smith', 'johnsmith@gmail.com', '$2y$10$WNWvrm7ZlLGq8BMD.Ukup.LB2xKczw1BQBDl6pZ35bRKfxldNFMrm', '09-250123001', 'No.12, Thazin Street, Sanchaung Township, Yangon', 'ROLE_CUSTOMER', '2026-01-09 07:42:49'),
(2, 'Hnin Phyu', 'hninphyu@gmail.com', '$2y$10$reVWYFfnRHUhSF9CktHlDeHcIr0.wo6HlxomU0ecWbtqXT.QX2NvK', '09-250123002', 'No.7, Dhammazedi Road, Bahan, Yangon', 'ROLE_CUSTOMER', '2026-01-09 07:51:19'),
(3, 'Mary Shelly', 'maryshelly@gmail.com', '$2y$10$MQ27zn4pwza75tY7NNYl2ub.iHxwkLs5y5m9klWNnqvifU8yImury', '09-250123003', 'No.40, University Avenue, Bahan, Yangon', 'ROLE_CUSTOMER', '2026-01-09 07:55:36'),
(4, 'Snow White', 'snow@gmail.com', '$2y$10$ZERiRzx/bF4beeIFsDNmk.drp.ql1Cww14dJ2eC8b6xwR9FkzicR2', '09-250123004', '', 'ROLE_ADMIN', '2026-01-09 07:56:25'),
(5, 'Jennie Kim', 'jenniekim@gmail.com', '$2y$10$7ZoKdiDOy/qlxudHj77ArufzGxZ6Pk0ezXWXx0IW8kba8ic/38.lW', '09-250123005', 'Yangon', 'ROLE_CUSTOMER', '2026-01-10 12:45:39');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `order_items`
--
ALTER TABLE `order_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_id` (`product_id`),
  ADD KEY `order_id` (`order_id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD KEY `category_id` (`category_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `order_items`
--
ALTER TABLE `order_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `order_items`
--
ALTER TABLE `order_items`
  ADD CONSTRAINT `order_items_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`),
  ADD CONSTRAINT `order_items_ibfk_2` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`);

--
-- Constraints for table `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `products_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
