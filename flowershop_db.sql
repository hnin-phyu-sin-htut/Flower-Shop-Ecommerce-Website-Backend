-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 10, 2026 at 10:17 PM
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
(13, 'Wildflower');

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` int(11) NOT NULL,
  `order_number` varchar(50) NOT NULL,
  `total_price` decimal(10,2) NOT NULL,
  `order_date` datetime DEFAULT current_timestamp(),
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`id`, `order_number`, `total_price`, `order_date`, `user_id`) VALUES
(1, 'ORD-1768079415', 40000.00, '2026-01-11 03:40:15', 7),
(2, 'ORD-1768079548', 70000.00, '2026-01-11 03:42:28', 7),
(3, 'ORD-1768079706', 40000.00, '2026-01-11 03:45:06', 7),
(4, 'ORD-1768079750', 118000.00, '2026-01-11 03:45:50', 9);

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
(1, 2, 40000.00, 21, 1),
(2, 2, 70000.00, 16, 2),
(3, 2, 40000.00, 21, 3),
(4, 2, 90000.00, 3, 4),
(5, 2, 90000.00, 3, 4);

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
(1, 'Rose Bouquet', 35000.00, '/Flower-Shop-Ecommerce-Website-Backend/uploads/products/no-image.png', 1),
(2, 'Mixed Flower Bouquet', 30000.00, '/Flower-Shop-Ecommerce-Website-Backend/uploads/products/no-image.png', 1),
(3, 'Tulip Bouquet', 45000.00, '/Flower-Shop-Ecommerce-Website-Backend/uploads/products/no-image.png', 1),
(4, 'Sunflower Bouquet', 28000.00, '/Flower-Shop-Ecommerce-Website-Backend/uploads/products/no-image.png', 1),
(5, 'Lily Bouquet', 40000.00, '/Flower-Shop-Ecommerce-Website-Backend/uploads/products/no-image.png', 1),
(6, 'Carnation Bouquet', 25000.00, '/Flower-Shop-Ecommerce-Website-Backend/uploads/products/no-image.png', 1),
(7, 'Baby Breath Bouquet', 22000.00, '/Flower-Shop-Ecommerce-Website-Backend/uploads/products/no-image.png', 1),
(8, 'Gerbera Bouquet', 26000.00, '/Flower-Shop-Ecommerce-Website-Backend/uploads/products/no-image.png', 1),
(9, 'Orchid Bouquet', 50000.00, '/Flower-Shop-Ecommerce-Website-Backend/uploads/products/no-image.png', 1),
(10, 'Peony Bouquet', 60000.00, '/Flower-Shop-Ecommerce-Website-Backend/uploads/products/no-image.png', 1),
(11, 'Red Rose', 30000.00, '/Flower-Shop-Ecommerce-Website-Backend/uploads/products/no-image.png', 2),
(12, 'White Rose', 28000.00, '/Flower-Shop-Ecommerce-Website-Backend/uploads/products/no-image.png', 2),
(13, 'Pink Rose', 28000.00, '/Flower-Shop-Ecommerce-Website-Backend/uploads/products/no-image.png', 2),
(14, 'Yellow Rose', 25000.00, '/Flower-Shop-Ecommerce-Website-Backend/uploads/products/no-image.png', 2),
(15, 'Orange Rose', 32000.00, '/Flower-Shop-Ecommerce-Website-Backend/uploads/products/no-image.png', 2),
(16, 'Lavender Rose', 35000.00, '/Flower-Shop-Ecommerce-Website-Backend/uploads/products/no-image.png', 2),
(17, 'Spray Rose', 40000.00, '/Flower-Shop-Ecommerce-Website-Backend/uploads/products/no-image.png', 2),
(18, 'Garden Rose', 50000.00, '/Flower-Shop-Ecommerce-Website-Backend/uploads/products/no-image.png', 2),
(19, 'Blue Rose (dyed)', 60000.00, '/Flower-Shop-Ecommerce-Website-Backend/uploads/products/no-image.png', 2),
(20, 'Black Rose (dyed)', 65000.00, '/Flower-Shop-Ecommerce-Website-Backend/uploads/products/no-image.png', 2),
(21, 'Dahlia', 20000.00, '/Flower-Shop-Ecommerce-Website-Backend/uploads/products/no-image.png', 3);

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
(1, 'John Smith', 'johnsmith@gmail.com', '$2y$10$WNWvrm7ZlLGq8BMD.Ukup.LB2xKczw1BQBDl6pZ35bRKfxldNFMrm', '09978654657', 'No.12, Thazin Street, Sanchaung Township, Yangon', 'ROLE_CUSTOMER', '2026-01-09 14:12:49'),
(2, 'Kyaw Min', 'kyawmin@gmail.com', '$2y$10$9ZeyU5bg1aL7Uu/PgyoRo.0SlhUIqo3QvYz2pooRhJ64VH7thRQQm', '09-250123001', 'No.12, 34th Street, Latha Township, Yangon', 'ROLE_CUSTOMER', '2026-01-09 14:18:07'),
(3, 'Zin Mar', 'zinmar@gmail.com', '$2y$10$20jmT.MLuyqU2.y5KnrswOgZluCPBRcK8keZEO3O9523tQTnSW2bi', '09-250123008', 'No.16, Bo Gyoke Road, Sanchaung, Yangon', 'ROLE_CUSTOMER', '2026-01-09 14:19:32'),
(4, 'Hnin Phyu', 'hninphyu@gmail.com', '$2y$10$reVWYFfnRHUhSF9CktHlDeHcIr0.wo6HlxomU0ecWbtqXT.QX2NvK', '09-250123020', 'No.7, Dhammazedi Road, Bahan, Yangon', 'ROLE_CUSTOMER', '2026-01-09 14:21:19'),
(5, 'Min Thant', 'minthant@gmail.com', '$2y$10$QkEzGStMIHRn9dEaS9h2TuJ3m5WK70I2o9xOlRwkAuFu4gHZUriMS', '09-250123011', '', 'ROLE_ADMIN', '2026-01-09 14:22:36'),
(6, 'A Win', 'winwin@gmail.com', '$2y$10$G0oMtj5gV/pksGU/vFkyLO60CCY/oo4CbssqZ5ovPpqeBedfRTol.', '09-250123030', 'No.5, Bayint Naung Road, Mayangone, Yangon', 'ROLE_ADMIN', '2026-01-09 14:24:01'),
(7, 'Mary Shelly', 'maryshelly@gmail.com', '$2y$10$MQ27zn4pwza75tY7NNYl2ub.iHxwkLs5y5m9klWNnqvifU8yImury', '09-123456789', 'No.40, University Avenue, Bahan, Yangon', 'ROLE_CUSTOMER', '2026-01-09 14:25:36'),
(8, 'Snow', 'snow@gmail.com', '$2y$10$ZERiRzx/bF4beeIFsDNmk.drp.ql1Cww14dJ2eC8b6xwR9FkzicR2', '09987654321', '', 'ROLE_ADMIN', '2026-01-09 14:26:25'),
(9, 'Jennie Kim', 'jenniekim@gmail.com', '$2y$10$7ZoKdiDOy/qlxudHj77ArufzGxZ6Pk0ezXWXx0IW8kba8ic/38.lW', '09978675868', 'Yangon', 'ROLE_CUSTOMER', '2026-01-10 19:15:39');

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
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `order_items`
--
ALTER TABLE `order_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

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
