-- --------------------------------------------------------
-- Hôte:                         127.0.0.1
-- Version du serveur:           10.4.24-MariaDB - mariadb.org binary distribution
-- SE du serveur:                Win64
-- HeidiSQL Version:             11.3.0.6295
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

-- Listage de la structure de la table avals. crashes
CREATE TABLE IF NOT EXISTS `crashes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `license` varchar(500) DEFAULT 0,
  `name` varchar(500) COLLATE utf8_bin NOT NULL,
  `message` varchar(500) COLLATE utf8_bin NOT NULL,
  `position` varchar(150) COLLATE utf8_bin NOT NULL,
  `time` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `FK_crashes_users` (`discord`),
  CONSTRAINT `FK_crashes_users` FOREIGN KEY (`discord`) REFERENCES `users` (`discord`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `json_position` CHECK (json_valid(`position`)),
  CONSTRAINT `velocity` CHECK (json_valid(`velocity`))
) ENGINE=InnoDB AUTO_INCREMENT=7707 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- Les données exportées n'étaient pas sélectionnées.

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
