-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 10, 2026 at 04:35 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `konekta`
--

-- --------------------------------------------------------

--
-- Table structure for table `brands`
--

CREATE TABLE `brands` (
  `id` int(11) NOT NULL,
  `name` varchar(150) NOT NULL,
  `category` varchar(100) NOT NULL,
  `logo_url` varchar(500) DEFAULT NULL,
  `verified` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `brands`
--

INSERT INTO `brands` (`id`, `name`, `category`, `logo_url`, `verified`, `created_at`) VALUES
(1, 'NutriBox', 'Food & Health', NULL, 1, '2026-04-30 14:31:33'),
(2, 'Glow Skincare', 'Beauty', NULL, 1, '2026-04-30 14:31:33'),
(3, 'TechGear ID', 'Technology', NULL, 0, '2026-04-30 14:31:33'),
(4, 'UrbanWear', 'Fashion', NULL, 1, '2026-04-30 14:31:33'),
(5, 'Kopi Nusantara', 'F&B', NULL, 1, '2026-04-30 14:31:33');

-- --------------------------------------------------------

--
-- Table structure for table `campaigns`
--

CREATE TABLE `campaigns` (
  `id` int(11) NOT NULL,
  `title` varchar(200) NOT NULL,
  `progress` tinyint(4) DEFAULT 0,
  `target_views` int(11) DEFAULT 0,
  `target_engagement` int(11) DEFAULT 0,
  `status` enum('IN PROGRESS','PENDING','COMPLETED') DEFAULT 'IN PROGRESS',
  `end_date` date NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `brand_id` int(11) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `budget` decimal(15,2) DEFAULT 0.00,
  `deadline_days` int(11) DEFAULT 0,
  `min_followers` int(11) DEFAULT 0,
  `content_type` varchar(100) DEFAULT 'Video',
  `target_audience` varchar(200) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `campaigns`
--

INSERT INTO `campaigns` (`id`, `title`, `progress`, `target_views`, `target_engagement`, `status`, `end_date`, `created_at`, `brand_id`, `description`, `budget`, `deadline_days`, `min_followers`, `content_type`, `target_audience`) VALUES
(1, 'Kopi Susu', 75, 50000, 5000, 'IN PROGRESS', '2026-05-05', '2026-04-30 12:34:42', 1, 'Create an authentic unboxing video of our weekly meal kit. Show the ingredients, preparation steps, and your honest reaction. We want real, relatable content that resonates with health-conscious audiences.', 1800000.00, 10, 15000, 'Video', 'Food / Lifestyle'),
(2, 'Skincare Glow', 40, 30000, 3000, 'IN PROGRESS', '2026-05-10', '2026-04-30 12:34:42', 2, 'Review our new vitamin C serum line. Share your skincare routine and honest before/after results. Target Gen Z audience who care about clean beauty.', 1500000.00, 7, 5000, 'Video + Photo', 'Beauty / Skincare');

-- --------------------------------------------------------

--
-- Table structure for table `campaign_applications`
--

CREATE TABLE `campaign_applications` (
  `id` int(11) NOT NULL,
  `campaign_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `status` enum('pending','accepted','rejected') DEFAULT 'pending',
  `applied_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `campaign_applications`
--

INSERT INTO `campaign_applications` (`id`, `campaign_id`, `user_id`, `status`, `applied_at`) VALUES
(1, 1, 1, 'pending', '2026-04-30 14:49:35'),
(5, 2, 1, 'pending', '2026-05-02 11:21:54');

-- --------------------------------------------------------

--
-- Table structure for table `campaign_deliverables`
--

CREATE TABLE `campaign_deliverables` (
  `id` int(11) NOT NULL,
  `campaign_id` int(11) NOT NULL,
  `description` varchar(300) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `campaign_deliverables`
--

INSERT INTO `campaign_deliverables` (`id`, `campaign_id`, `description`) VALUES
(1, 1, '1 TikTok video (min. 60 seconds)'),
(2, 1, '1 Instagram Reel'),
(3, 1, '3 Instagram Stories with swipe-up link'),
(4, 2, '1 Instagram Reel (before/after)'),
(5, 2, '1 TikTok review video'),
(6, 2, '5 Instagram Stories');

-- --------------------------------------------------------

--
-- Table structure for table `campaign_influencers`
--

CREATE TABLE `campaign_influencers` (
  `campaign_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `campaign_influencers`
--

INSERT INTO `campaign_influencers` (`campaign_id`, `user_id`) VALUES
(1, 1),
(2, 1);

-- --------------------------------------------------------

--
-- Table structure for table `campaign_platforms`
--

CREATE TABLE `campaign_platforms` (
  `campaign_id` int(11) NOT NULL,
  `platform` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `campaign_platforms`
--

INSERT INTO `campaign_platforms` (`campaign_id`, `platform`) VALUES
(1, 'Instagram'),
(1, 'TikTok'),
(2, 'Instagram');

-- --------------------------------------------------------

--
-- Table structure for table `payments`
--

CREATE TABLE `payments` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `amount` decimal(15,2) NOT NULL DEFAULT 0.00,
  `status` enum('paid','pending') DEFAULT 'pending',
  `month` tinyint(4) NOT NULL,
  `year` smallint(6) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `payments`
--

INSERT INTO `payments` (`id`, `user_id`, `amount`, `status`, `month`, `year`, `created_at`) VALUES
(1, 1, 3467420.00, 'paid', 4, 2026, '2026-04-30 12:34:41'),
(2, 1, 1250000.00, 'pending', 4, 2026, '2026-04-30 12:34:41');

-- --------------------------------------------------------

--
-- Table structure for table `stats`
--

CREATE TABLE `stats` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `views` int(11) DEFAULT 0,
  `engagement` int(11) DEFAULT 0,
  `recorded_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `stats`
--

INSERT INTO `stats` (`id`, `user_id`, `views`, `engagement`, `recorded_at`) VALUES
(1, 1, 24800, 2300, '2026-04-30 12:34:41');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(100) NOT NULL,
  `email` varchar(150) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `email`, `created_at`) VALUES
(1, 'Amna', 'amna@konekta.id', '2026-04-30 12:34:41');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `brands`
--
ALTER TABLE `brands`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `campaigns`
--
ALTER TABLE `campaigns`
  ADD PRIMARY KEY (`id`),
  ADD KEY `brand_id` (`brand_id`);

--
-- Indexes for table `campaign_applications`
--
ALTER TABLE `campaign_applications`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_application` (`campaign_id`,`user_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `campaign_deliverables`
--
ALTER TABLE `campaign_deliverables`
  ADD PRIMARY KEY (`id`),
  ADD KEY `campaign_id` (`campaign_id`);

--
-- Indexes for table `campaign_influencers`
--
ALTER TABLE `campaign_influencers`
  ADD PRIMARY KEY (`campaign_id`,`user_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `campaign_platforms`
--
ALTER TABLE `campaign_platforms`
  ADD PRIMARY KEY (`campaign_id`,`platform`);

--
-- Indexes for table `payments`
--
ALTER TABLE `payments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `stats`
--
ALTER TABLE `stats`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `brands`
--
ALTER TABLE `brands`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `campaigns`
--
ALTER TABLE `campaigns`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `campaign_applications`
--
ALTER TABLE `campaign_applications`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `campaign_deliverables`
--
ALTER TABLE `campaign_deliverables`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `payments`
--
ALTER TABLE `payments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `stats`
--
ALTER TABLE `stats`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `campaigns`
--
ALTER TABLE `campaigns`
  ADD CONSTRAINT `campaigns_ibfk_1` FOREIGN KEY (`brand_id`) REFERENCES `brands` (`id`);

--
-- Constraints for table `campaign_applications`
--
ALTER TABLE `campaign_applications`
  ADD CONSTRAINT `campaign_applications_ibfk_1` FOREIGN KEY (`campaign_id`) REFERENCES `campaigns` (`id`),
  ADD CONSTRAINT `campaign_applications_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `campaign_deliverables`
--
ALTER TABLE `campaign_deliverables`
  ADD CONSTRAINT `campaign_deliverables_ibfk_1` FOREIGN KEY (`campaign_id`) REFERENCES `campaigns` (`id`);

--
-- Constraints for table `campaign_influencers`
--
ALTER TABLE `campaign_influencers`
  ADD CONSTRAINT `campaign_influencers_ibfk_1` FOREIGN KEY (`campaign_id`) REFERENCES `campaigns` (`id`),
  ADD CONSTRAINT `campaign_influencers_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `campaign_platforms`
--
ALTER TABLE `campaign_platforms`
  ADD CONSTRAINT `campaign_platforms_ibfk_1` FOREIGN KEY (`campaign_id`) REFERENCES `campaigns` (`id`);

--
-- Constraints for table `payments`
--
ALTER TABLE `payments`
  ADD CONSTRAINT `payments_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `stats`
--
ALTER TABLE `stats`
  ADD CONSTRAINT `stats_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
