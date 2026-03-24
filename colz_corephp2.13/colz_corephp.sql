-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Feb 12, 2026 at 10:15 AM
-- Server version: 8.0.37
-- PHP Version: 8.5.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `colz_corephp`
--

-- --------------------------------------------------------

--
-- Table structure for table `cards`
--

CREATE TABLE `cards` (
  `id` int NOT NULL,
  `name` varchar(222) COLLATE utf8mb4_general_ci NOT NULL,
  `profession` varchar(222) COLLATE utf8mb4_general_ci NOT NULL,
  `image` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `cards`
--

INSERT INTO `cards` (`id`, `name`, `profession`, `image`) VALUES
(1, 'Sujal', 'CEO', ''),
(4, 'Puskar Koirala', 'BM', NULL),
(25, 'fgdfg', 'fgdfg', ''),
(26, 'ffgh', 'fghfgh', ''),
(27, 'fghfgh', 'fghfgh', '13231770888196_christmas2.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int NOT NULL,
  `name` varchar(111) COLLATE utf8mb4_general_ci NOT NULL,
  `username` varchar(111) COLLATE utf8mb4_general_ci NOT NULL,
  `password` varchar(111) COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `username`, `password`) VALUES
(23, '555', '555', '$2y$10$ahgzNSlTFYukMlnOZ0R90eJ4NkoHBSHUKoH9NQK3BbTmql3qy6.Hq'),
(24, '999', '999', '$2y$10$1xb4r23P6N76umGkbESMaeXYQ08JhmUbdI0okDZYDptOthdvoRU12'),
(25, 'Tester Kumar', 'asdf', '$2y$10$tRQag6OqhNlKkAYhB/xjQephbeqWcU.Ja4JLXHMAQVnU65eGpuydu');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cards`
--
ALTER TABLE `cards`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `cards`
--
ALTER TABLE `cards`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
