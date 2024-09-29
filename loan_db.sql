-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : dim. 29 sep. 2024 à 03:36
-- Version du serveur : 10.4.32-MariaDB
-- Version de PHP : 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `loan_db`
--

-- --------------------------------------------------------

--
-- Structure de la table `loan_applications`
--

CREATE TABLE `loan_applications` (
  `id` int(11) NOT NULL,
  `gender` varchar(10) DEFAULT NULL,
  `married` varchar(10) DEFAULT NULL,
  `dependents` int(11) DEFAULT NULL,
  `education` varchar(20) DEFAULT NULL,
  `self_employed` varchar(10) DEFAULT NULL,
  `applicant_income` float DEFAULT NULL,
  `coapplicant_income` float DEFAULT NULL,
  `loan_amount` float DEFAULT NULL,
  `loan_amount_term` float DEFAULT NULL,
  `credit_history` float DEFAULT NULL,
  `property_area` varchar(20) DEFAULT NULL,
  `loan_status` varchar(20) DEFAULT NULL,
  `submission_date` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `loan_applications`
--

INSERT INTO `loan_applications` (`id`, `gender`, `married`, `dependents`, `education`, `self_employed`, `applicant_income`, `coapplicant_income`, `loan_amount`, `loan_amount_term`, `credit_history`, `property_area`, `loan_status`, `submission_date`) VALUES
(5, 'Female', 'Yes', 0, 'Not Graduate', 'No', 1500, 350, 321000, 120, 1, 'Urban', 'Rejected', '2024-09-29 02:02:16'),
(6, 'Female', 'No', 2, 'Graduate', 'Yes', 3000, 3000, 3000, 300, 0, 'Semiurban', 'Approved', '2024-09-29 02:24:01'),
(7, 'Male', 'Yes', 1, 'Graduate', 'Yes', 1000000, 10000000, 2000000, 120, 1, 'Urban', 'Rejected', '2024-09-29 03:31:59');

-- --------------------------------------------------------

--
-- Structure de la table `loan_products`
--

CREATE TABLE `loan_products` (
  `id` int(11) NOT NULL,
  `product_name` varchar(255) NOT NULL,
  `interest_rate` decimal(5,2) NOT NULL,
  `loan_term_months` int(11) NOT NULL,
  `min_income_requirement` decimal(10,2) NOT NULL,
  `max_income_limit` decimal(10,2) NOT NULL,
  `property_area` enum('Urban','Semiurban','Rural') NOT NULL,
  `eligibility_criteria` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `loan_products`
--

INSERT INTO `loan_products` (`id`, `product_name`, `interest_rate`, `loan_term_months`, `min_income_requirement`, `max_income_limit`, `property_area`, `eligibility_criteria`) VALUES
(61, 'Urban Home Saver', 3.00, 120, 25000.00, 85000.00, 'Urban', 'Good credit history and urban property'),
(62, 'Semiurban Growth Plan', 3.50, 132, 30000.00, 95000.00, 'Semiurban', 'Graduate education and semiurban property'),
(63, 'Rural Advantage', 4.00, 144, 35000.00, 105000.00, 'Rural', 'Rural property and stable income'),
(64, 'City Dweller Flexi Loan', 4.50, 156, 40000.00, 115000.00, 'Urban', 'Good credit history and urban property'),
(65, 'Suburban Home Builder', 5.00, 168, 45000.00, 125000.00, 'Semiurban', 'Graduate education and semiurban property'),
(66, 'Rural Prosperity Loan', 3.25, 120, 50000.00, 135000.00, 'Rural', 'Rural property and stable income'),
(67, 'Urban Wealth Builder', 3.75, 132, 55000.00, 145000.00, 'Urban', 'Good credit history and urban property'),
(68, 'Semiurban Family Loan', 4.25, 144, 60000.00, 155000.00, 'Semiurban', 'Graduate education and semiurban property'),
(69, 'Rural Growth Initiative', 4.75, 156, 65000.00, 165000.00, 'Rural', 'Rural property and stable income'),
(70, 'City First Home Loan', 5.25, 168, 70000.00, 175000.00, 'Urban', 'Good credit history and urban property'),
(71, 'Suburban Success Loan', 3.10, 120, 75000.00, 185000.00, 'Semiurban', 'Graduate education and semiurban property'),
(72, 'Rural Home Boost', 3.60, 132, 80000.00, 195000.00, 'Rural', 'Rural property and stable income'),
(73, 'Urban Elite Home Plan', 4.10, 144, 85000.00, 205000.00, 'Urban', 'Good credit history and urban property'),
(74, 'Suburban Achiever Loan', 4.60, 156, 90000.00, 215000.00, 'Semiurban', 'Graduate education and semiurban property'),
(75, 'Rural Dream Home', 5.10, 168, 95000.00, 225000.00, 'Rural', 'Rural property and stable income'),
(76, 'City Premier Loan', 3.20, 120, 100000.00, 235000.00, 'Urban', 'Good credit history and urban property'),
(77, 'Semiurban Prime Loan', 3.70, 132, 105000.00, 245000.00, 'Semiurban', 'Graduate education and semiurban property'),
(78, 'Rural Pioneer Loan', 4.20, 144, 110000.00, 255000.00, 'Rural', 'Rural property and stable income'),
(79, 'City Luxury Loan', 4.70, 156, 115000.00, 265000.00, 'Urban', 'Good credit history and urban property'),
(80, 'Suburban Star Loan', 5.20, 168, 120000.00, 275000.00, 'Semiurban', 'Graduate education and semiurban property'),
(81, 'Rural Prestige Loan', 3.30, 120, 125000.00, 285000.00, 'Rural', 'Rural property and stable income'),
(82, 'Urban Future Loan', 3.80, 132, 130000.00, 295000.00, 'Urban', 'Good credit history and urban property'),
(83, 'Suburban Heritage Plan', 4.30, 144, 135000.00, 305000.00, 'Semiurban', 'Graduate education and semiurban property'),
(84, 'Rural Essential Loan', 4.80, 156, 140000.00, 315000.00, 'Rural', 'Rural property and stable income'),
(85, 'City Signature Loan', 5.30, 168, 145000.00, 325000.00, 'Urban', 'Good credit history and urban property'),
(86, 'Suburban Flexi Choice', 3.40, 120, 150000.00, 335000.00, 'Semiurban', 'Graduate education and semiurban property'),
(87, 'Rural Empowerment Loan', 3.90, 132, 155000.00, 345000.00, 'Rural', 'Rural property and stable income'),
(88, 'Urban Golden Opportunity', 4.40, 144, 160000.00, 355000.00, 'Urban', 'Good credit history and urban property'),
(89, 'Suburban Advantage Loan', 4.90, 156, 165000.00, 365000.00, 'Semiurban', 'Graduate education and semiurban property'),
(90, 'Rural Opportunity Loan', 5.40, 168, 170000.00, 375000.00, 'Rural', 'Rural property and stable income'),
(91, 'City Flexi Saver', 3.10, 120, 25000.00, 85000.00, 'Urban', 'Good credit history and urban property'),
(92, 'Semiurban Dream Builder', 3.50, 132, 30000.00, 95000.00, 'Semiurban', 'Graduate education and semiurban property'),
(93, 'Rural Home Starter', 4.00, 144, 35000.00, 105000.00, 'Rural', 'Rural property and stable income'),
(94, 'Metro Lifestyle Loan', 4.50, 156, 40000.00, 115000.00, 'Urban', 'Good credit history and urban property'),
(95, 'Suburban Living Plan', 5.00, 168, 45000.00, 125000.00, 'Semiurban', 'Graduate education and semiurban property'),
(96, 'Country Home Advantage', 3.25, 120, 50000.00, 135000.00, 'Rural', 'Rural property and stable income'),
(97, 'Urban Success Loan', 3.75, 132, 55000.00, 145000.00, 'Urban', 'Good credit history and urban property'),
(98, 'Semiurban Family Builder', 4.25, 144, 60000.00, 155000.00, 'Semiurban', 'Graduate education and semiurban property'),
(99, 'Rural Progress Loan', 4.75, 156, 65000.00, 165000.00, 'Rural', 'Rural property and stable income'),
(100, 'City First Time Buyer', 5.25, 168, 70000.00, 175000.00, 'Urban', 'Good credit history and urban property'),
(101, 'Suburban Wealth Grower', 3.10, 120, 75000.00, 185000.00, 'Semiurban', 'Graduate education and semiurban property'),
(102, 'Rural Future Plan', 3.60, 132, 80000.00, 195000.00, 'Rural', 'Rural property and stable income'),
(103, 'Urban Premium Loan', 4.10, 144, 85000.00, 205000.00, 'Urban', 'Good credit history and urban property'),
(104, 'Suburban Success Builder', 4.60, 156, 90000.00, 215000.00, 'Semiurban', 'Graduate education and semiurban property'),
(105, 'Rural Elite Loan', 5.10, 168, 95000.00, 225000.00, 'Rural', 'Rural property and stable income'),
(106, 'City Home Choice', 3.20, 120, 100000.00, 235000.00, 'Urban', 'Good credit history and urban property'),
(107, 'Semiurban Elite Saver', 3.70, 132, 105000.00, 245000.00, 'Semiurban', 'Graduate education and semiurban property'),
(108, 'Rural Saver Loan', 4.20, 144, 110000.00, 255000.00, 'Rural', 'Rural property and stable income'),
(109, 'City Luxury Saver', 4.70, 156, 115000.00, 265000.00, 'Urban', 'Good credit history and urban property'),
(110, 'Suburban Saver Loan', 5.20, 168, 120000.00, 275000.00, 'Semiurban', 'Graduate education and semiurban property'),
(111, 'Rural Prestige Saver', 3.30, 120, 125000.00, 285000.00, 'Rural', 'Rural property and stable income'),
(112, 'Urban Growth Plan', 3.80, 132, 130000.00, 295000.00, 'Urban', 'Good credit history and urban property'),
(113, 'Suburban Achiever Saver', 4.30, 144, 135000.00, 305000.00, 'Semiurban', 'Graduate education and semiurban property'),
(114, 'Rural Prosperity Saver', 4.80, 156, 140000.00, 315000.00, 'Rural', 'Rural property and stable income'),
(115, 'City Signature Saver', 5.30, 168, 145000.00, 325000.00, 'Urban', 'Good credit history and urban property'),
(116, 'Suburban Flexi Plan', 3.40, 120, 150000.00, 335000.00, 'Semiurban', 'Graduate education and semiurban property'),
(117, 'Rural Empowerment Plan', 3.90, 132, 155000.00, 345000.00, 'Rural', 'Rural property and stable income'),
(118, 'Urban Golden Saver', 4.40, 144, 160000.00, 355000.00, 'Urban', 'Good credit history and urban property'),
(119, 'Suburban Advantage Saver', 4.90, 156, 165000.00, 365000.00, 'Semiurban', 'Graduate education and semiurban property'),
(120, 'Rural Growth Saver', 5.40, 168, 170000.00, 375000.00, 'Rural', 'Rural property and stable income'),
(121, 'Starter Home Loan Basic', 2.50, 120, 1000.00, 3000.00, 'Urban', 'Good credit history and urban property'),
(122, 'Semiurban Family Loan', 2.75, 120, 1500.00, 3000.00, 'Semiurban', 'Graduate education and semiurban property'),
(123, 'Rural Entry Loan', 2.90, 120, 2000.00, 3000.00, 'Rural', 'Rural property and stable income'),
(124, 'Urban Flexible Starter', 3.10, 180, 2000.00, 3000.00, 'Urban', 'Good credit history and urban property'),
(125, 'Suburban Dream Loan', 3.25, 180, 1500.00, 3000.00, 'Semiurban', 'Graduate education and semiurban property'),
(126, 'Rural Growth Loan', 2.80, 240, 1000.00, 3000.00, 'Rural', 'Rural property and stable income'),
(127, 'Urban Home Starter', 3.00, 240, 2000.00, 3000.00, 'Urban', 'Good credit history and urban property'),
(128, 'Semiurban Entry Plan', 3.20, 240, 1500.00, 3000.00, 'Semiurban', 'Graduate education and semiurban property'),
(129, 'Rural Settler Loan', 3.15, 300, 1500.00, 3000.00, 'Rural', 'Rural property and stable income'),
(130, 'Basic Living Loan', 3.00, 360, 1000.00, 3000.00, 'Urban', 'Good credit history and urban property'),
(131, 'Growth Opportunity Loan', 3.50, 120, 3000.00, 10000.00, 'Urban', 'Good credit history and urban property'),
(132, 'Semiurban Expansion Plan', 3.60, 120, 3000.00, 10000.00, 'Semiurban', 'Graduate education and semiurban property'),
(133, 'Rural Estate Loan', 3.75, 120, 3500.00, 10000.00, 'Rural', 'Rural property and stable income'),
(134, 'Urban Future Loan', 3.85, 180, 3000.00, 10000.00, 'Urban', 'Good credit history and urban property'),
(135, 'Suburban Expansion Plan', 3.90, 180, 3500.00, 10000.00, 'Semiurban', 'Graduate education and semiurban property'),
(136, 'Rural Growth Plus', 4.00, 240, 3000.00, 10000.00, 'Rural', 'Rural property and stable income'),
(137, 'Urban Lifestyle Loan', 3.95, 240, 4000.00, 10000.00, 'Urban', 'Good credit history and urban property'),
(138, 'Semiurban Future Loan', 4.10, 240, 3500.00, 10000.00, 'Semiurban', 'Graduate education and semiurban property'),
(139, 'Rural Growth Secure', 4.15, 300, 3500.00, 10000.00, 'Rural', 'Rural property and stable income'),
(140, 'Mid-Budget City Loan', 4.00, 360, 3000.00, 10000.00, 'Urban', 'Good credit history and urban property'),
(141, 'Advanced Urban Loan', 4.50, 120, 10000.00, 25000.00, 'Urban', 'Good credit history and urban property'),
(142, 'Semiurban Growth Elite', 4.60, 120, 11000.00, 25000.00, 'Semiurban', 'Graduate education and semiurban property'),
(143, 'Rural Elite Loan', 4.75, 120, 12000.00, 25000.00, 'Rural', 'Rural property and stable income'),
(144, 'Urban Executive Loan', 4.85, 180, 10000.00, 25000.00, 'Urban', 'Good credit history and urban property'),
(145, 'Suburban Executive Loan', 4.90, 180, 12000.00, 25000.00, 'Semiurban', 'Graduate education and semiurban property'),
(146, 'Rural Growth Executive', 5.00, 240, 12000.00, 25000.00, 'Rural', 'Rural property and stable income'),
(147, 'Urban Elite Lifestyle', 4.95, 240, 15000.00, 25000.00, 'Urban', 'Good credit history and urban property'),
(148, 'Semiurban Elite Loan', 5.10, 240, 15000.00, 25000.00, 'Semiurban', 'Graduate education and semiurban property'),
(149, 'Rural Elite Secure', 5.15, 300, 12000.00, 25000.00, 'Rural', 'Rural property and stable income'),
(150, 'Premium City Loan', 5.00, 360, 10000.00, 25000.00, 'Urban', 'Good credit history and urban property');

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `loan_applications`
--
ALTER TABLE `loan_applications`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `loan_products`
--
ALTER TABLE `loan_products`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `loan_applications`
--
ALTER TABLE `loan_applications`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT pour la table `loan_products`
--
ALTER TABLE `loan_products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=151;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
