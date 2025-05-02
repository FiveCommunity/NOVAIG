-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               11.6.2-MariaDB - mariadb.org binary distribution
-- Server OS:                    Win64
-- HeidiSQL Version:             12.10.0.7000
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dumping database structure for novarp
CREATE DATABASE IF NOT EXISTS `novarp` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;
USE `novarp`;

-- Dumping structure for table novarp.bench_items
CREATE TABLE IF NOT EXISTS `bench_items` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `item` varchar(50) NOT NULL DEFAULT '0',
  `user_id` int(11) NOT NULL DEFAULT 0,
  `machine` varchar(50) NOT NULL DEFAULT '0',
  `amount` int(10) unsigned NOT NULL DEFAULT 0,
  `value` int(10) unsigned NOT NULL DEFAULT 0,
  `createdAt` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table novarp.bench_logs
CREATE TABLE IF NOT EXISTS `bench_logs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `machine` varchar(50) DEFAULT NULL,
  `log` varchar(255) DEFAULT NULL,
  `createdAt` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table novarp.blocked_users
CREATE TABLE IF NOT EXISTS `blocked_users` (
  `user_id` int(11) NOT NULL,
  `expireAt` int(11) NOT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table novarp.bm_chamados
CREATE TABLE IF NOT EXISTS `bm_chamados` (
  `user_id` int(11) NOT NULL,
  `qtd` int(11) NOT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table novarp.bm_daily
CREATE TABLE IF NOT EXISTS `bm_daily` (
  `user_id` int(11) NOT NULL DEFAULT 0,
  `time` int(11) DEFAULT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Data exporting was unselected.

-- Dumping structure for table novarp.bm_dealership
CREATE TABLE IF NOT EXISTS `bm_dealership` (
  `vehicle` varchar(50) NOT NULL,
  `stock` int(11) DEFAULT 0,
  PRIMARY KEY (`vehicle`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table novarp.bm_orgs
CREATE TABLE IF NOT EXISTS `bm_orgs` (
  `org` varchar(50) DEFAULT NULL,
  `bank` int(11) DEFAULT 0,
  `bank_transactions` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`bank_transactions`)),
  `permissions` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`permissions`)),
  `config_goals` longtext DEFAULT NULL,
  `description` varchar(50) DEFAULT NULL,
  `pix` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table novarp.bm_orgs_farms
CREATE TABLE IF NOT EXISTS `bm_orgs_farms` (
  `org` varchar(50) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `item` varchar(50) DEFAULT NULL,
  `amount` varchar(50) DEFAULT NULL,
  `day` varchar(50) DEFAULT NULL,
  `month` varchar(50) DEFAULT NULL,
  `reward` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table novarp.bm_promoveh
CREATE TABLE IF NOT EXISTS `bm_promoveh` (
  `user_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table novarp.bm_registration
CREATE TABLE IF NOT EXISTS `bm_registration` (
  `user_id` int(11) DEFAULT NULL,
  `nome` varchar(100) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `telefone` varchar(50) DEFAULT NULL,
  `nascimento` varchar(50) DEFAULT NULL,
  `sexo` varchar(50) DEFAULT NULL,
  `social` varchar(50) DEFAULT NULL,
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Data exporting was unselected.

-- Dumping structure for table novarp.clothes
CREATE TABLE IF NOT EXISTS `clothes` (
  `name` varchar(50) DEFAULT NULL,
  `permiss` varchar(50) DEFAULT NULL,
  `service` varchar(50) DEFAULT NULL,
  `custom` text DEFAULT NULL,
  `sexo` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Data exporting was unselected.

-- Dumping structure for table novarp.crafting_ranking
CREATE TABLE IF NOT EXISTS `crafting_ranking` (
  `user_id` int(11) NOT NULL,
  `organization` varchar(50) NOT NULL,
  `daily` int(11) DEFAULT 0,
  `week` int(11) DEFAULT 0,
  `monthly` int(11) DEFAULT 0,
  `dailyTime` int(11) DEFAULT 0,
  `weekTime` int(11) DEFAULT 0,
  `monthlyTime` int(11) DEFAULT 0,
  PRIMARY KEY (`user_id`,`organization`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- Data exporting was unselected.

-- Dumping structure for table novarp.dismantle_vehicles
CREATE TABLE IF NOT EXISTS `dismantle_vehicles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `vehicle` varchar(255) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table novarp.dm_ranks
CREATE TABLE IF NOT EXISTS `dm_ranks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `wins` int(11) DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table novarp.dm_ranks_geral
CREATE TABLE IF NOT EXISTS `dm_ranks_geral` (
  `org` varchar(100) DEFAULT NULL,
  `points` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table novarp.dm_ranks_pistol
CREATE TABLE IF NOT EXISTS `dm_ranks_pistol` (
  `org` varchar(100) NOT NULL,
  `orgType` varchar(100) DEFAULT NULL,
  `boostFarmTS` varchar(100) DEFAULT '0',
  `points` int(11) DEFAULT 0,
  `wins` int(11) DEFAULT 0,
  PRIMARY KEY (`org`),
  UNIQUE KEY `org` (`org`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table novarp.drg_warrant
CREATE TABLE IF NOT EXISTS `drg_warrant` (
  `user_id` int(11) NOT NULL,
  `reason` longtext DEFAULT NULL,
  `timeCreated` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table novarp.early_access
CREATE TABLE IF NOT EXISTS `early_access` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(255) NOT NULL,
  `access_granted` tinyint(1) DEFAULT 0,
  `timestamp` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table novarp.hooka_credits
CREATE TABLE IF NOT EXISTS `hooka_credits` (
  `player_id` int(11) NOT NULL,
  `credits` int(11) NOT NULL,
  PRIMARY KEY (`player_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table novarp.hydrus_credits
CREATE TABLE IF NOT EXISTS `hydrus_credits` (
  `player_id` varchar(100) NOT NULL,
  `name` varchar(100) NOT NULL,
  `amount` int(11) DEFAULT 0,
  `updated_at` int(11) DEFAULT unix_timestamp(),
  PRIMARY KEY (`player_id`,`name`),
  KEY `player_id` (`player_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table novarp.hydrus_scheduler
CREATE TABLE IF NOT EXISTS `hydrus_scheduler` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `player_id` varchar(100) NOT NULL,
  `command` varchar(255) NOT NULL,
  `args` varchar(4096) NOT NULL,
  `execute_at` bigint(20) DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `player_id` (`player_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table novarp.items_seized
CREATE TABLE IF NOT EXISTS `items_seized` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `org` tinytext NOT NULL,
  `amount` bigint(20) NOT NULL DEFAULT 0,
  `createdAt` datetime NOT NULL DEFAULT curdate(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table novarp.leads_new
CREATE TABLE IF NOT EXISTS `leads_new` (
  `user_id` int(11) DEFAULT NULL,
  `created_at` varchar(50) DEFAULT NULL,
  `type` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table novarp.lotusbox_hours
CREATE TABLE IF NOT EXISTS `lotusbox_hours` (
  `user_id` int(11) NOT NULL,
  `time` int(11) NOT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table novarp.lotus_access
CREATE TABLE IF NOT EXISTS `lotus_access` (
  `discord` varchar(255) NOT NULL,
  `admin` int(11) DEFAULT NULL,
  PRIMARY KEY (`discord`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table novarp.lotus_banks
CREATE TABLE IF NOT EXISTS `lotus_banks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `coords` varchar(255) NOT NULL,
  `isBank` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table novarp.lotus_barbershop
CREATE TABLE IF NOT EXISTS `lotus_barbershop` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `coords` varchar(255) NOT NULL,
  `blip` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table novarp.lotus_chests
CREATE TABLE IF NOT EXISTS `lotus_chests` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `weight` int(11) NOT NULL,
  `coords` varchar(255) NOT NULL,
  `permission` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table novarp.lotus_hub
CREATE TABLE IF NOT EXISTS `lotus_hub` (
  `user_id` int(11) NOT NULL,
  `service` varchar(150) NOT NULL DEFAULT '',
  `name` varchar(150) NOT NULL DEFAULT '',
  `calls` int(11) NOT NULL DEFAULT 0,
  `hours` float NOT NULL DEFAULT 0,
  `stars` float NOT NULL DEFAULT 0,
  `totalstars` float DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table novarp.lotus_loot
CREATE TABLE IF NOT EXISTS `lotus_loot` (
  `user_id` int(11) DEFAULT NULL,
  `time` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table novarp.lotus_pass_v2
CREATE TABLE IF NOT EXISTS `lotus_pass_v2` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `pass_type` varchar(50) NOT NULL,
  `redeemed_levels` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table novarp.lotus_ponto
CREATE TABLE IF NOT EXISTS `lotus_ponto` (
  `user_id` int(11) NOT NULL,
  `identity` varchar(100) NOT NULL,
  `service_time` int(11) NOT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table novarp.lotus_races
CREATE TABLE IF NOT EXISTS `lotus_races` (
  `raceid` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `vehicle` varchar(50) NOT NULL,
  `points` int(11) NOT NULL,
  PRIMARY KEY (`raceid`,`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- Data exporting was unselected.

-- Dumping structure for table novarp.lotus_raffle
CREATE TABLE IF NOT EXISTS `lotus_raffle` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `item` text NOT NULL,
  `initial_number` int(11) NOT NULL,
  `final_number` int(11) NOT NULL,
  `prices` text NOT NULL,
  `end_at` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table novarp.lotus_raffle_buyed
CREATE TABLE IF NOT EXISTS `lotus_raffle_buyed` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `number` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table novarp.lotus_robbery_history
CREATE TABLE IF NOT EXISTS `lotus_robbery_history` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `winner` varchar(50) NOT NULL,
  `duration` int(11) NOT NULL,
  `killfeed` text NOT NULL,
  `time` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- Data exporting was unselected.

-- Dumping structure for table novarp.lotus_robbery_presets
CREATE TABLE IF NOT EXISTS `lotus_robbery_presets` (
  `name` varchar(50) NOT NULL,
  `awarddarkmoney` int(11) NOT NULL,
  `awardmin` int(11) NOT NULL,
  `awardmax` int(11) NOT NULL,
  `minigame` varchar(50) NOT NULL,
  `animation` varchar(50) NOT NULL,
  `animationtime` int(11) NOT NULL,
  `projection` varchar(50) NOT NULL,
  `permission` varchar(50) NOT NULL,
  `items` text NOT NULL,
  `iswanted` tinyint(1) NOT NULL DEFAULT 0,
  `cooldown` int(11) NOT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- Data exporting was unselected.

-- Dumping structure for table novarp.lotus_roberry_points
CREATE TABLE IF NOT EXISTS `lotus_roberry_points` (
  `user_id` int(11) DEFAULT NULL,
  `points` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table novarp.lotus_shops
CREATE TABLE IF NOT EXISTS `lotus_shops` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `coords` varchar(255) NOT NULL,
  `blip` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=73 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table novarp.lotus_skinshops
CREATE TABLE IF NOT EXISTS `lotus_skinshops` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `coords` varchar(255) NOT NULL,
  `blip` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=80 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table novarp.lotus_tattooshops
CREATE TABLE IF NOT EXISTS `lotus_tattooshops` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `coords` varchar(255) NOT NULL,
  `blip` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table novarp.mdt_criminal_records
CREATE TABLE IF NOT EXISTS `mdt_criminal_records` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `officer_id` int(11) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `date` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table novarp.mdt_incidents_reports
CREATE TABLE IF NOT EXISTS `mdt_incidents_reports` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `involved` int(11) DEFAULT NULL,
  `officer_id` int(11) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `date` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table novarp.mdt_logs
CREATE TABLE IF NOT EXISTS `mdt_logs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `organization` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `date` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table novarp.mdt_organizations
CREATE TABLE IF NOT EXISTS `mdt_organizations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `organization` varchar(255) DEFAULT NULL,
  `permissions` text DEFAULT '{}',
  `image` varchar(255) DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `organization` (`organization`)
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table novarp.mdt_staff_criminal_records
CREATE TABLE IF NOT EXISTS `mdt_staff_criminal_records` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `officer_id` int(11) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `date` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table novarp.mdt_users_rewards
CREATE TABLE IF NOT EXISTS `mdt_users_rewards` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `organization` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table novarp.mdt_vehicle_apprehensions
CREATE TABLE IF NOT EXISTS `mdt_vehicle_apprehensions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `officer_id` int(11) DEFAULT NULL,
  `vehicle` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `date` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table novarp.mirtin_bans
CREATE TABLE IF NOT EXISTS `mirtin_bans` (
  `user_id` int(11) NOT NULL,
  `motivo` text NOT NULL,
  `banimento` tinytext NOT NULL,
  `desbanimento` tinytext NOT NULL,
  `time` int(11) NOT NULL,
  `hwid` int(11) NOT NULL DEFAULT 0,
  `owner` int(11) DEFAULT 0,
  `staff` int(11) DEFAULT 0,
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Data exporting was unselected.

-- Dumping structure for table novarp.mirtin_bans_hwid
CREATE TABLE IF NOT EXISTS `mirtin_bans_hwid` (
  `token` varchar(120) NOT NULL,
  `id` int(11) NOT NULL,
  PRIMARY KEY (`token`),
  KEY `user_id` (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Data exporting was unselected.

-- Dumping structure for table novarp.mirtin_bans_ip
CREATE TABLE IF NOT EXISTS `mirtin_bans_ip` (
  `user_id` int(11) NOT NULL,
  `ip` varchar(45) NOT NULL,
  PRIMARY KEY (`user_id`,`ip`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table novarp.mirtin_chamados
CREATE TABLE IF NOT EXISTS `mirtin_chamados` (
  `user_id` int(11) NOT NULL,
  `total` int(11) NOT NULL,
  `historico` text NOT NULL DEFAULT '{}',
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Data exporting was unselected.

-- Dumping structure for table novarp.mirtin_homes
CREATE TABLE IF NOT EXISTS `mirtin_homes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tipo` varchar(15) NOT NULL,
  `price` int(11) NOT NULL,
  `coords` varchar(50) NOT NULL,
  `garagem` text DEFAULT '{}',
  `chaves` int(11) DEFAULT NULL,
  `minBau` int(11) NOT NULL,
  `maxMoradores` int(11) DEFAULT 3,
  `permissao` varchar(50) NOT NULL,
  `interior` int(11) DEFAULT 1,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Data exporting was unselected.

-- Dumping structure for table novarp.mirtin_organization_members
CREATE TABLE IF NOT EXISTS `mirtin_organization_members` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_type` varchar(50) NOT NULL,
  `member_data` varchar(244) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `item` varchar(50) NOT NULL,
  `amount` int(11) NOT NULL,
  `day` varchar(2) NOT NULL,
  `month` varchar(2) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table novarp.mirtin_orgs_chat
CREATE TABLE IF NOT EXISTS `mirtin_orgs_chat` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `organization` varchar(100) NOT NULL,
  `user_id` int(11) NOT NULL,
  `message` text NOT NULL,
  `author` varchar(100) NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table novarp.mirtin_orgs_goals
CREATE TABLE IF NOT EXISTS `mirtin_orgs_goals` (
  `user_id` int(11) NOT NULL,
  `organization` varchar(50) NOT NULL,
  `item` varchar(100) NOT NULL,
  `amount` int(11) NOT NULL DEFAULT 0,
  `day` int(11) NOT NULL,
  `month` int(11) NOT NULL,
  `step` int(11) DEFAULT 1,
  `reward_step` int(11) DEFAULT 0,
  UNIQUE KEY `user_id_organization_item_day` (`user_id`,`organization`,`item`,`day`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table novarp.mirtin_orgs_info
CREATE TABLE IF NOT EXISTS `mirtin_orgs_info` (
  `organization` varchar(50) NOT NULL,
  `alerts` text DEFAULT '{}',
  `logo` text DEFAULT NULL,
  `discord` varchar(150) DEFAULT '',
  `radio` int(11) DEFAULT 0,
  `salary` int(11) DEFAULT 1000,
  `bank` int(11) DEFAULT 0,
  `bank_historic` text DEFAULT '{}',
  `permissions` text DEFAULT '{}',
  `config_goals` text DEFAULT '{}',
  `presets` text DEFAULT '{}',
  PRIMARY KEY (`organization`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Data exporting was unselected.

-- Dumping structure for table novarp.mirtin_orgs_logs
CREATE TABLE IF NOT EXISTS `mirtin_orgs_logs` (
  `organization` varchar(50) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `role` varchar(50) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `description` varchar(200) DEFAULT NULL,
  `date` varchar(50) DEFAULT NULL,
  `expire_at` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table novarp.mirtin_orgs_player_infos
CREATE TABLE IF NOT EXISTS `mirtin_orgs_player_infos` (
  `user_id` int(11) NOT NULL,
  `organization` varchar(50) DEFAULT NULL,
  `joindate` int(11) DEFAULT 0,
  `lastlogin` int(11) DEFAULT 0,
  `timeplayed` int(11) DEFAULT 0,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Data exporting was unselected.

-- Dumping structure for table novarp.mirtin_partners
CREATE TABLE IF NOT EXISTS `mirtin_partners` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cds` text DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `note` int(11) DEFAULT 0,
  `description` text DEFAULT NULL,
  `icon` text DEFAULT NULL,
  `groups` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table novarp.mirtin_survival
CREATE TABLE IF NOT EXISTS `mirtin_survival` (
  `user_id` int(11) DEFAULT NULL,
  `historico` longtext DEFAULT '{}',
  `data` varchar(50) DEFAULT '{}'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table novarp.mirtin_users_homes
CREATE TABLE IF NOT EXISTS `mirtin_users_homes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tipo` varchar(50) NOT NULL,
  `houseID` int(11) NOT NULL,
  `proprietario` int(11) NOT NULL,
  `moradores` text DEFAULT '{}',
  `bau` text DEFAULT '{}',
  `armario` text DEFAULT '{}',
  `interior` int(11) NOT NULL,
  `iptu` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Data exporting was unselected.

-- Dumping structure for table novarp.nxgroup_box
CREATE TABLE IF NOT EXISTS `nxgroup_box` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `nome` varchar(50) DEFAULT NULL,
  `sobrenome` varchar(50) DEFAULT NULL,
  `reward` varchar(50) DEFAULT NULL,
  `raridade` varchar(50) DEFAULT NULL,
  `hora` varchar(50) DEFAULT curtime(),
  `data` varchar(50) DEFAULT curdate(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Data exporting was unselected.

-- Dumping structure for table novarp.player_playtime
CREATE TABLE IF NOT EXISTS `player_playtime` (
  `user_id` int(11) DEFAULT NULL,
  `playtime` int(11) NOT NULL DEFAULT 0,
  UNIQUE KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table novarp.ponto_presets
CREATE TABLE IF NOT EXISTS `ponto_presets` (
  `org` varchar(100) NOT NULL,
  `group` varchar(100) NOT NULL,
  `preset` text NOT NULL,
  PRIMARY KEY (`org`,`group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table novarp.smartphone_bank_invoices
CREATE TABLE IF NOT EXISTS `smartphone_bank_invoices` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `payee_id` int(11) NOT NULL,
  `payer_id` int(11) NOT NULL,
  `reason` varchar(255) NOT NULL DEFAULT '',
  `value` int(11) NOT NULL,
  `paid` tinyint(4) NOT NULL DEFAULT 0,
  `created_at` int(11) NOT NULL,
  `updated_at` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- Data exporting was unselected.

-- Dumping structure for table novarp.smartphone_blocks
CREATE TABLE IF NOT EXISTS `smartphone_blocks` (
  `user_id` int(11) NOT NULL,
  `phone` varchar(32) NOT NULL,
  PRIMARY KEY (`user_id`,`phone`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- Data exporting was unselected.

-- Dumping structure for table novarp.smartphone_calls
CREATE TABLE IF NOT EXISTS `smartphone_calls` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `initiator` varchar(50) NOT NULL,
  `target` varchar(50) NOT NULL,
  `duration` int(11) NOT NULL DEFAULT 0,
  `status` varchar(255) NOT NULL,
  `video` tinyint(4) NOT NULL DEFAULT 0,
  `anonymous` tinyint(4) NOT NULL DEFAULT 0,
  `created_at` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `initiator_index` (`initiator`),
  KEY `target_index` (`target`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- Data exporting was unselected.

-- Dumping structure for table novarp.smartphone_casino
CREATE TABLE IF NOT EXISTS `smartphone_casino` (
  `user_id` int(11) NOT NULL,
  `balance` bigint(20) NOT NULL DEFAULT 0,
  `double` bigint(20) NOT NULL DEFAULT 0,
  `crash` bigint(20) NOT NULL DEFAULT 0,
  `mine` bigint(20) NOT NULL DEFAULT 0,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- Data exporting was unselected.

-- Dumping structure for table novarp.smartphone_contacts
CREATE TABLE IF NOT EXISTS `smartphone_contacts` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `owner` varchar(50) NOT NULL,
  `phone` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `owner_index` (`owner`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- Data exporting was unselected.

-- Dumping structure for table novarp.smartphone_gallery
CREATE TABLE IF NOT EXISTS `smartphone_gallery` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `folder` varchar(255) NOT NULL DEFAULT '/',
  `url` varchar(255) NOT NULL,
  `created_at` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id_index` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- Data exporting was unselected.

-- Dumping structure for table novarp.smartphone_instagram
CREATE TABLE IF NOT EXISTS `smartphone_instagram` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `username` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `bio` varchar(255) NOT NULL,
  `avatarURL` varchar(255) DEFAULT NULL,
  `verified` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `user_id_index` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- Data exporting was unselected.

-- Dumping structure for table novarp.smartphone_instagram_followers
CREATE TABLE IF NOT EXISTS `smartphone_instagram_followers` (
  `follower_id` bigint(20) NOT NULL,
  `profile_id` bigint(20) NOT NULL,
  PRIMARY KEY (`follower_id`,`profile_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- Data exporting was unselected.

-- Dumping structure for table novarp.smartphone_instagram_likes
CREATE TABLE IF NOT EXISTS `smartphone_instagram_likes` (
  `post_id` bigint(20) NOT NULL,
  `profile_id` bigint(20) NOT NULL,
  PRIMARY KEY (`post_id`,`profile_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- Data exporting was unselected.

-- Dumping structure for table novarp.smartphone_instagram_notifications
CREATE TABLE IF NOT EXISTS `smartphone_instagram_notifications` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `profile_id` int(11) NOT NULL,
  `author_id` int(11) NOT NULL,
  `content` varchar(512) NOT NULL,
  `saw` tinyint(4) NOT NULL DEFAULT 0,
  `created_at` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `profile_id_index` (`profile_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- Data exporting was unselected.

-- Dumping structure for table novarp.smartphone_instagram_posts
CREATE TABLE IF NOT EXISTS `smartphone_instagram_posts` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `profile_id` bigint(20) NOT NULL,
  `post_id` bigint(20) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `content` varchar(255) DEFAULT NULL,
  `created_at` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `profile_id_index` (`profile_id`),
  KEY `post_id_index` (`post_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- Data exporting was unselected.

-- Dumping structure for table novarp.smartphone_olx
CREATE TABLE IF NOT EXISTS `smartphone_olx` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `category` varchar(255) NOT NULL,
  `price` int(11) NOT NULL,
  `description` varchar(1024) NOT NULL,
  `images` varchar(1024) NOT NULL,
  `created_at` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id_index` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- Data exporting was unselected.

-- Dumping structure for table novarp.smartphone_paypal_transactions
CREATE TABLE IF NOT EXISTS `smartphone_paypal_transactions` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL,
  `target` bigint(20) NOT NULL,
  `type` varchar(255) NOT NULL DEFAULT 'payment',
  `description` varchar(255) DEFAULT NULL,
  `value` bigint(20) NOT NULL,
  `created_at` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id_index` (`user_id`),
  KEY `target_index` (`target`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- Data exporting was unselected.

-- Dumping structure for table novarp.smartphone_tinder
CREATE TABLE IF NOT EXISTS `smartphone_tinder` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `image` varchar(255) NOT NULL,
  `bio` varchar(1024) NOT NULL,
  `age` tinyint(4) NOT NULL,
  `gender` varchar(50) NOT NULL,
  `show_gender` tinyint(4) NOT NULL,
  `tags` varchar(255) NOT NULL,
  `show_tags` tinyint(4) NOT NULL,
  `target` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id_index` (`user_id`),
  KEY `gender_index` (`gender`),
  KEY `target_index` (`target`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- Data exporting was unselected.

-- Dumping structure for table novarp.smartphone_tinder_messages
CREATE TABLE IF NOT EXISTS `smartphone_tinder_messages` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `sender` int(11) NOT NULL,
  `target` int(11) NOT NULL,
  `content` varchar(255) NOT NULL,
  `liked` tinyint(4) NOT NULL DEFAULT 0,
  `created_at` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sender_index` (`sender`),
  KEY `target_index` (`target`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- Data exporting was unselected.

-- Dumping structure for table novarp.smartphone_tinder_rating
CREATE TABLE IF NOT EXISTS `smartphone_tinder_rating` (
  `profile_id` int(11) NOT NULL,
  `rated_id` int(11) NOT NULL,
  `rating` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`profile_id`,`rated_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- Data exporting was unselected.

-- Dumping structure for table novarp.smartphone_tor_messages
CREATE TABLE IF NOT EXISTS `smartphone_tor_messages` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `channel` varchar(24) NOT NULL DEFAULT 'geral',
  `sender` varchar(50) NOT NULL,
  `image` varchar(512) DEFAULT NULL,
  `location` varchar(255) DEFAULT NULL,
  `content` varchar(500) DEFAULT NULL,
  `created_at` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `channel_index` (`channel`),
  KEY `sender_index` (`sender`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- Data exporting was unselected.

-- Dumping structure for table novarp.smartphone_tor_payments
CREATE TABLE IF NOT EXISTS `smartphone_tor_payments` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `sender` bigint(20) NOT NULL,
  `target` bigint(20) NOT NULL,
  `amount` int(11) NOT NULL,
  `created_at` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sender_index` (`sender`),
  KEY `target_index` (`target`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- Data exporting was unselected.

-- Dumping structure for table novarp.smartphone_twitter_followers
CREATE TABLE IF NOT EXISTS `smartphone_twitter_followers` (
  `follower_id` bigint(20) NOT NULL,
  `profile_id` bigint(20) NOT NULL,
  KEY `profile_id_index` (`profile_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- Data exporting was unselected.

-- Dumping structure for table novarp.smartphone_twitter_likes
CREATE TABLE IF NOT EXISTS `smartphone_twitter_likes` (
  `tweet_id` bigint(20) NOT NULL,
  `profile_id` bigint(20) NOT NULL,
  KEY `tweet_id_index` (`tweet_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- Data exporting was unselected.

-- Dumping structure for table novarp.smartphone_twitter_profiles
CREATE TABLE IF NOT EXISTS `smartphone_twitter_profiles` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `username` varchar(255) NOT NULL,
  `avatarURL` varchar(255) NOT NULL,
  `bannerURL` varchar(255) NOT NULL,
  `bio` varchar(255) DEFAULT NULL,
  `verified` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `user_id_index` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- Data exporting was unselected.

-- Dumping structure for table novarp.smartphone_twitter_tweets
CREATE TABLE IF NOT EXISTS `smartphone_twitter_tweets` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `profile_id` int(11) NOT NULL,
  `tweet_id` bigint(20) DEFAULT NULL,
  `content` varchar(280) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `created_at` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `profile_id_index` (`profile_id`),
  KEY `tweet_id_index` (`tweet_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- Data exporting was unselected.

-- Dumping structure for table novarp.smartphone_uber_trips
CREATE TABLE IF NOT EXISTS `smartphone_uber_trips` (
  `id` varchar(10) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `driver_id` int(11) DEFAULT NULL,
  `total` int(11) DEFAULT NULL,
  `from` varchar(255) DEFAULT NULL,
  `to` varchar(255) DEFAULT NULL,
  `user_rate` tinyint(4) DEFAULT 0,
  `driver_rate` tinyint(4) DEFAULT 0,
  `created_at` int(11) DEFAULT NULL,
  `finished_at` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table novarp.smartphone_weazel
CREATE TABLE IF NOT EXISTS `smartphone_weazel` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `author` varchar(255) NOT NULL,
  `tag` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` varchar(4096) NOT NULL,
  `imageURL` varchar(255) DEFAULT NULL,
  `videoURL` varchar(255) DEFAULT NULL,
  `views` int(11) NOT NULL DEFAULT 0,
  `created_at` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- Data exporting was unselected.

-- Dumping structure for table novarp.smartphone_whatsapp
CREATE TABLE IF NOT EXISTS `smartphone_whatsapp` (
  `owner` varchar(32) NOT NULL,
  `avatarURL` varchar(255) DEFAULT NULL,
  `read_receipts` tinyint(4) NOT NULL DEFAULT 1,
  PRIMARY KEY (`owner`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- Data exporting was unselected.

-- Dumping structure for table novarp.smartphone_whatsapp_channels
CREATE TABLE IF NOT EXISTS `smartphone_whatsapp_channels` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `sender` varchar(50) NOT NULL,
  `target` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sender_index` (`sender`),
  KEY `target_index` (`target`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- Data exporting was unselected.

-- Dumping structure for table novarp.smartphone_whatsapp_groups
CREATE TABLE IF NOT EXISTS `smartphone_whatsapp_groups` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `avatarURL` varchar(255) NOT NULL,
  `owner` varchar(255) NOT NULL,
  `members` varchar(2048) NOT NULL,
  `created_at` bigint(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- Data exporting was unselected.

-- Dumping structure for table novarp.smartphone_whatsapp_messages
CREATE TABLE IF NOT EXISTS `smartphone_whatsapp_messages` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `channel_id` bigint(20) unsigned NOT NULL,
  `sender` varchar(50) NOT NULL,
  `image` varchar(512) DEFAULT NULL,
  `location` varchar(255) DEFAULT NULL,
  `content` varchar(500) DEFAULT NULL,
  `deleted_by` varchar(255) DEFAULT NULL,
  `readed` tinyint(4) NOT NULL DEFAULT 0,
  `saw_at` bigint(20) NOT NULL DEFAULT 0,
  `created_at` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sender_index` (`sender`),
  KEY `channel_id_index` (`channel_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- Data exporting was unselected.

-- Dumping structure for table novarp.stancetuning
CREATE TABLE IF NOT EXISTS `stancetuning` (
  `stance` varchar(100) NOT NULL,
  `tuning` text DEFAULT NULL,
  `car` varchar(100) NOT NULL DEFAULT 'stance',
  `name` varchar(100) NOT NULL DEFAULT 'stance',
  `type` varchar(10) NOT NULL DEFAULT 'stance',
  PRIMARY KEY (`stance`),
  KEY `stance` (`stance`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Data exporting was unselected.

-- Dumping structure for table novarp.user_clothes
CREATE TABLE IF NOT EXISTS `user_clothes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `custom` text NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_user_clothes` (`user_id`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table novarp.vrp_srv_data
CREATE TABLE IF NOT EXISTS `vrp_srv_data` (
  `dkey` varchar(100) NOT NULL,
  `dvalue` text DEFAULT NULL,
  PRIMARY KEY (`dkey`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Data exporting was unselected.

-- Dumping structure for table novarp.vrp_users
CREATE TABLE IF NOT EXISTS `vrp_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ultimo_login` varchar(255) DEFAULT NULL,
  `ip` varchar(255) DEFAULT NULL,
  `whitelist` int(11) DEFAULT NULL,
  `paypal` int(11) DEFAULT 0,
  `Motivo_BAN` varchar(255) DEFAULT NULL,
  `Motivo_UNBAN` varchar(255) DEFAULT NULL,
  `discord` varchar(255) DEFAULT NULL,
  `userDiscord` int(2) DEFAULT 0,
  `coins` int(11) DEFAULT 0,
  `tempoTotal` int(11) DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Data exporting was unselected.

-- Dumping structure for table novarp.vrp_users_infos
CREATE TABLE IF NOT EXISTS `vrp_users_infos` (
  `user_id` int(11) NOT NULL,
  `controller` int(11) DEFAULT 0,
  `rosto` text DEFAULT '{}',
  `roupas` text DEFAULT '{}',
  `tattos` text DEFAULT '{}',
  `garagem` int(11) DEFAULT 3,
  `vip` text DEFAULT '{}',
  `bonus` text DEFAULT '{}',
  `coins` int(11) DEFAULT 3,
  `tempo_jogado` int(11) DEFAULT 0,
  `prioridade` int(11) DEFAULT 0,
  `license` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Data exporting was unselected.

-- Dumping structure for table novarp.vrp_user_data
CREATE TABLE IF NOT EXISTS `vrp_user_data` (
  `user_id` int(11) NOT NULL,
  `dkey` varchar(255) NOT NULL,
  `dvalue` text DEFAULT NULL,
  PRIMARY KEY (`user_id`,`dkey`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table novarp.vrp_user_identities
CREATE TABLE IF NOT EXISTS `vrp_user_identities` (
  `user_id` int(11) NOT NULL,
  `registro` varchar(50) DEFAULT NULL,
  `telefone` varchar(20) DEFAULT NULL,
  `nome` varchar(50) DEFAULT NULL,
  `sobrenome` varchar(50) DEFAULT NULL,
  `idade` int(11) DEFAULT NULL,
  `banco` int(11) DEFAULT 25000,
  `multas` int(11) DEFAULT 0,
  `criminal` text DEFAULT '{}',
  `signo` varchar(50) DEFAULT 'Nenhum',
  `data_nascimento` varchar(50) DEFAULT '17/03/2001',
  `relacionamento` varchar(255) DEFAULT '{}',
  `total_hour` int(11) DEFAULT 0,
  `chavePix` varchar(255) DEFAULT NULL,
  `makapoints` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  KEY `registro` (`registro`),
  KEY `telefone` (`telefone`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Data exporting was unselected.

-- Dumping structure for table novarp.vrp_user_ids
CREATE TABLE IF NOT EXISTS `vrp_user_ids` (
  `identifier` varchar(150) NOT NULL,
  `user_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Data exporting was unselected.

-- Dumping structure for table novarp.vrp_user_veiculos
CREATE TABLE IF NOT EXISTS `vrp_user_veiculos` (
  `user_id` int(11) NOT NULL,
  `veiculo` varchar(50) NOT NULL,
  `placa` varchar(50) DEFAULT NULL,
  `status` int(11) DEFAULT 0,
  `motor` int(11) DEFAULT 1000,
  `lataria` int(11) DEFAULT 1000,
  `gasolina` int(11) DEFAULT 15,
  `ipva` int(11) DEFAULT 7,
  `portamalas` text DEFAULT '{}',
  `tunagem` text DEFAULT '{}',
  `favorite` int(11) DEFAULT 0,
  `alugado` tinyint(4) NOT NULL DEFAULT 0,
  `data_alugado` text DEFAULT NULL,
  `expired` text DEFAULT NULL,
  `nitro` int(11) DEFAULT 0,
  PRIMARY KEY (`user_id`,`veiculo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Data exporting was unselected.

-- Dumping structure for table novarp.warehouses
CREATE TABLE IF NOT EXISTS `warehouses` (
  `name` varchar(255) DEFAULT NULL,
  `tax` int(11) DEFAULT NULL,
  `owner` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table novarp.wngroups_anuncios
CREATE TABLE IF NOT EXISTS `wngroups_anuncios` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `empresa` text DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `data` text DEFAULT NULL,
  `mensagem` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table novarp.wngroups_chat
CREATE TABLE IF NOT EXISTS `wngroups_chat` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `empresa` text DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `data` text DEFAULT NULL,
  `mensagem` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table novarp.wngroups_paineis
CREATE TABLE IF NOT EXISTS `wngroups_paineis` (
  `empresa` longtext DEFAULT NULL,
  `banco` int(11) DEFAULT NULL,
  `grafico` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table novarp.wngroups_players
CREATE TABLE IF NOT EXISTS `wngroups_players` (
  `user_id` int(11) NOT NULL,
  `login` int(11) DEFAULT NULL,
  `blacklist` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table novarp.wngroups_setagens
CREATE TABLE IF NOT EXISTS `wngroups_setagens` (
  `user_id` int(11) DEFAULT NULL,
  `emprego` longtext DEFAULT NULL,
  `tipo` longtext DEFAULT NULL,
  `cargo` longtext DEFAULT NULL,
  `permissao` longtext DEFAULT NULL,
  `contratante` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

-- Dumping structure for table novarp.zo_attachs
CREATE TABLE IF NOT EXISTS `zo_attachs` (
  `user_id` int(11) NOT NULL,
  `attachs` text DEFAULT NULL,
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Data exporting was unselected.

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
