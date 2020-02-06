-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1:3306
-- Tiempo de generación: 06-02-2020 a las 23:28:33
-- Versión del servidor: 5.7.26
-- Versión de PHP: 7.2.18

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `class`
--

DELIMITER $$
--
-- Procedimientos
--
DROP PROCEDURE IF EXISTS `countStudents`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `countStudents` ()  NO SQL
BEGIN

SELECT count(*) as counting FROM students;

END$$

DROP PROCEDURE IF EXISTS `getStudents`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `getStudents` (IN `fromIndex` INT, IN `toIndex` INT)  NO SQL
BEGIN

SELECT st.id,st.name,s.name as status_id FROM `students` as st inner JOIN status as s on st.status_id=s.id  limit fromIndex,toIndex;



END$$

DROP PROCEDURE IF EXISTS `login`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `login` (IN `user` VARCHAR(60), IN `password` VARCHAR(60))  NO SQL
BEGIN

SELECT uid FROM api_users where email= user and password= password limit 1;

END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `api_users`
--

DROP TABLE IF EXISTS `api_users`;
CREATE TABLE IF NOT EXISTS `api_users` (
  `uid` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(70) DEFAULT NULL,
  `PASSWORD` varchar(70) DEFAULT NULL,
  `role_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`uid`),
  KEY `role_id` (`role_id`)
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `api_users`
--

INSERT INTO `api_users` (`uid`, `email`, `PASSWORD`, `role_id`) VALUES
(1, 'erick@gmail.com', '81dc9bdb52d04dc20036dbd8313ed055', 2),
(2, 'user@mail.com', '81dc9bdb52d04dc20036dbd8313ed055', 1),
(3, 'user2@mail.com', '81dc9bdb52d04dc20036dbd8313ed055', 1),
(4, 'user3@gmail.com', '81dc9bdb52d04dc20036dbd8313ed055', 1),
(5, 'user4@mail.com', '81dc9bdb52d04dc20036dbd8313ed055', 1),
(6, 'user5@mail.com', '81dc9bdb52d04dc20036dbd8313ed055', 1),
(7, 'user6@mail.com', '81dc9bdb52d04dc20036dbd8313ed055', 1),
(8, 'user7@mail.com', '81dc9bdb52d04dc20036dbd8313ed055', 1),
(9, 'user8@gmail.com', '81dc9bdb52d04dc20036dbd8313ed055', 1),
(10, 'user9@gmail.com', '81dc9bdb52d04dc20036dbd8313ed055', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `instructors`
--

DROP TABLE IF EXISTS `instructors`;
CREATE TABLE IF NOT EXISTS `instructors` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `status_id` int(11) DEFAULT NULL,
  `name` varchar(60) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `status_id` (`status_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `instructors`
--

INSERT INTO `instructors` (`id`, `user_id`, `status_id`, `name`) VALUES
(1, 1, 1, 'erick');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `status`
--

DROP TABLE IF EXISTS `status`;
CREATE TABLE IF NOT EXISTS `status` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `status`
--

INSERT INTO `status` (`id`, `name`) VALUES
(1, 'active'),
(2, 'inactive');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `students`
--

DROP TABLE IF EXISTS `students`;
CREATE TABLE IF NOT EXISTS `students` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `name` varchar(70) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `status_id` (`status_id`),
  KEY `user_id` (`user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `students`
--

INSERT INTO `students` (`id`, `status_id`, `user_id`, `name`) VALUES
(1, 1, 2, 'user1'),
(2, 1, 3, 'user2'),
(3, 1, 4, 'user3'),
(4, 1, 5, 'user4'),
(5, 1, 6, 'user5'),
(6, 1, 7, 'user6'),
(7, 1, 8, 'user7'),
(8, 1, 9, 'user8'),
(9, 1, 10, 'user9');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tests`
--

DROP TABLE IF EXISTS `tests`;
CREATE TABLE IF NOT EXISTS `tests` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `instructor_id` int(11) DEFAULT NULL,
  `student_id` int(11) DEFAULT NULL,
  `status_id` int(11) DEFAULT NULL,
  `begin` datetime(6) DEFAULT NULL,
  `end` datetime(6) DEFAULT NULL,
  `name` varchar(60) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `instructor_id` (`instructor_id`),
  KEY `student_id` (`student_id`),
  KEY `status_id` (`status_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `user_roles`
--

DROP TABLE IF EXISTS `user_roles`;
CREATE TABLE IF NOT EXISTS `user_roles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) DEFAULT NULL,
  `description` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `user_roles`
--

INSERT INTO `user_roles` (`id`, `name`, `description`) VALUES
(1, 'student', 'receives the classes'),
(2, 'instructor', 'gives the classes');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
