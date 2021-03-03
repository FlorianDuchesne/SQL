-- phpMyAdmin SQL Dump
-- version 3.2.0.1
-- http://www.phpmyadmin.net
--
-- Serveur: localhost
-- Généré le : Mar 01 Février 2011 �  13:37
-- Version du serveur: 5.1.51
-- Version de PHP: 5.3.0

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de données: `lesgaulois`
--

-- --------------------------------------------------------

--
-- Structure de la table `bataille`
--

CREATE TABLE IF NOT EXISTS `bataille` (
  `ID_BATAILLE` int(11) NOT NULL,
  `ID_LIEU` int(11) NOT NULL,
  `NOM_BATAILLE` varchar(32) DEFAULT NULL,
  `DATE_BATAILLE` date DEFAULT NULL,
  PRIMARY KEY (`ID_BATAILLE`),
  KEY `FK_SE_DEROULE` (`ID_LIEU`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Contenu de la table `bataille`
--

INSERT INTO `bataille` (`ID_BATAILLE`, `ID_LIEU`, `NOM_BATAILLE`, `DATE_BATAILLE`) VALUES
(0, 4, 'Bataille gauloise', '0050-07-09'),
(1, 2, 'Babaorum', '0050-09-15'),
(2, 1, 'Laudanum', '0050-12-05'),
(3, 6, 'Booldechwingum', '0050-12-02'),
(4, 4, 'Cohorte III', '0050-09-01'),
(5, 0, 'Cohorte VI', '0050-06-03'),
(6, 7, 'Legion XII', '0050-10-08'),
(7, 1, 'Mercenaires', '0050-05-31'),
(8, 5, 'Vikings', '0050-07-29'),
(9, 5, 'Gladiateurs', '0050-01-01');

-- --------------------------------------------------------

--
-- Structure de la table `boit`
--

CREATE TABLE IF NOT EXISTS `boit` (
  `ID_POTION` int(11) NOT NULL,
  `ID_VILLAGEOIS` int(11) NOT NULL,
  `DATE_BU` date NOT NULL DEFAULT '0000-00-00',
  `DOSE` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID_POTION`,`ID_VILLAGEOIS`,`DATE_BU`),
  KEY `FK_BOIT2` (`ID_VILLAGEOIS`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Contenu de la table `boit`
--

INSERT INTO `boit` (`ID_POTION`, `ID_VILLAGEOIS`, `DATE_BU`, `DOSE`) VALUES
(0, 16, '0050-06-27', 35),
(1, 13, '0050-12-31', 9),
(2, 24, '0050-08-19', 49),
(3, 15, '0050-07-04', 6),
(4, 2, '0050-04-12', 36),
(5, 10, '0050-10-29', 20),
(6, 19, '0050-05-19', 48),
(7, 4, '0050-12-13', 47),
(8, 17, '0050-05-29', 40),
(9, 8, '0050-09-02', 8),
(10, 32, '0050-07-20', 33),
(11, 33, '0050-01-01', 25),
(12, 34, '0050-01-10', 43),
(13, 26, '0050-04-27', 28),
(14, 14, '0050-01-02', 37),
(15, 31, '0050-02-01', 10),
(16, 11, '0050-10-15', 21),
(17, 3, '0050-06-04', 1),
(18, 21, '0050-12-03', 29),
(19, 6, '0050-04-10', 30),
(8, 3, '0050-02-01', 50),
(7, 2, '0050-01-01', 20),
(7, 2, '0050-02-01', 21),
(7, 3, '0050-01-10', 25),
(7, 5, '0050-07-01', 40),
(7, 8, '0050-07-23', 30);

-- --------------------------------------------------------

--
-- Structure de la table `casque`
--

CREATE TABLE IF NOT EXISTS `casque` (
  `ID_CASQUE` int(11) NOT NULL,
  `ID_TYPE_CASQUE` int(11) NOT NULL,
  `NOM_CASQUE` varchar(32) DEFAULT NULL,
  `COUT_CASQUE` float DEFAULT NULL,
  PRIMARY KEY (`ID_CASQUE`),
  KEY `FK_APPARTIENT` (`ID_TYPE_CASQUE`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Contenu de la table `casque`
--

INSERT INTO `casque` (`ID_CASQUE`, `ID_TYPE_CASQUE`, `NOM_CASQUE`, `COUT_CASQUE`) VALUES
(0, 0, 'Maximum', 865),
(1, 0, 'Centurion', 498),
(2, 2, 'Spartacus', 2110),
(3, 2, 'Corinthien ', 765),
(4, 0, 'Imperial Gallic', 895),
(5, 1, 'Troyen', 795),
(6, 2, 'Elendil', 3128),
(7, 1, 'Spartiate', 1187),
(8, 0, 'Centurion officier', 1098),
(9, 0, 'Romain', 660);

-- --------------------------------------------------------

--
-- Structure de la table `compose`
--

CREATE TABLE IF NOT EXISTS `compose` (
  `ID_POTION` int(11) NOT NULL,
  `ID_INGREDIENT` int(11) NOT NULL,
  `QTE` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID_POTION`,`ID_INGREDIENT`),
  KEY `FK_COMPOSE2` (`ID_INGREDIENT`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Contenu de la table `compose`
--

INSERT INTO `compose` (`ID_POTION`, `ID_INGREDIENT`, `QTE`) VALUES
(0, 0, 23),
(0, 1, 40),
(0, 2, 68),
(0, 3, 18),
(0, 5, 63),
(0, 7, 13),
(0, 8, 50),
(0, 11, 64),
(0, 12, 7),
(0, 14, 38),
(0, 16, 2),
(0, 18, 17),
(0, 21, 11),
(0, 23, 21),
(0, 27, 51),
(0, 28, 77),
(1, 8, 98),
(1, 12, 7),
(1, 23, 1),
(2, 14, 49),
(2, 19, 4),
(2, 27, 51),
(3, 0, 95),
(3, 5, 3),
(3, 28, 77),
(4, 20, 34),
(4, 24, 86),
(4, 26, 5),
(5, 7, 2),
(5, 9, 25),
(6, 7, 13),
(6, 8, 2),
(6, 27, 57),
(7, 2, 68),
(7, 25, 48),
(7, 28, 5),
(8, 1, 33),
(8, 3, 18),
(8, 10, 3),
(9, 4, 52),
(9, 22, 2),
(10, 10, 68),
(10, 24, 1),
(11, 1, 3),
(11, 18, 77),
(12, 0, 23),
(12, 3, 65),
(12, 25, 5),
(13, 6, 23),
(13, 14, 38),
(13, 29, 2),
(14, 6, 2),
(14, 7, 17),
(14, 23, 21),
(15, 11, 97),
(15, 14, 1),
(15, 21, 11),
(16, 1, 40),
(16, 11, 3),
(16, 29, 10),
(17, 8, 50),
(17, 12, 1),
(17, 17, 70),
(18, 5, 92),
(18, 19, 15),
(18, 27, 4),
(19, 11, 64),
(19, 13, 43),
(19, 21, 4);

-- --------------------------------------------------------

--
-- Structure de la table `ingredient`
--

CREATE TABLE IF NOT EXISTS `ingredient` (
  `ID_INGREDIENT` int(11) NOT NULL,
  `NOM_INGREDIENT` varchar(32) DEFAULT NULL,
  `COUT_INGREDIENT` float DEFAULT NULL,
  PRIMARY KEY (`ID_INGREDIENT`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Contenu de la table `ingredient`
--

INSERT INTO `ingredient` (`ID_INGREDIENT`, `NOM_INGREDIENT`, `COUT_INGREDIENT`) VALUES
(0, 'petits pois', 0.5),
(1, 'Haricots verts', 1),
(2, 'Queue de crevette', 7),
(3, 'Brin d''herbe', 0.5),
(4, 'Ecrevisse', 10),
(5, 'Feuille épinard', 9),
(6, 'Oeuf de caviar', 6),
(7, 'Oeil de boeuf', 4),
(8, 'Huitre', 9),
(9, 'Ver de terre', 1),
(10, 'Cl d''eau distilléeI', 2),
(11, 'Noix St Jacques', 12),
(12, 'Grenouille', 7),
(13, 'Carotte', 5),
(14, 'Courgette', 3),
(15, 'Prune', 3),
(16, 'Cl d''eau férigineuse', 6),
(17, 'Joue de truite', 12),
(18, 'Cl D''alcool', 3),
(19, 'Feuille de vigne', 4),
(20, 'Pomme', 11),
(21, 'Salamandre', 10),
(22, 'Homard', 12),
(23, 'Queue de cochon', 6),
(24, 'Myrtille', 5),
(25, 'Escargot', 6),
(26, 'Feuille de salade', 8),
(27, 'Cerise', 2),
(28, 'Citron vert', 4),
(29, 'Navet', 1);

-- --------------------------------------------------------

--
-- Structure de la table `lieu`
--

CREATE TABLE IF NOT EXISTS `lieu` (
  `ID_LIEU` int(11) NOT NULL,
  `NOM_LIEU` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`ID_LIEU`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Contenu de la table `lieu`
--

INSERT INTO `lieu` (`ID_LIEU`, `NOM_LIEU`) VALUES
(0, 'Village gaulois'),
(1, 'Babaorum'),
(2, 'Laudanum'),
(3, 'Oposum'),
(4, 'Champs de Nioutechnologix'),
(5, '3e chene a droite de la carriere'),
(6, 'En mer'),
(7, 'Grottes');

-- --------------------------------------------------------

--
-- Structure de la table `peut`
--

CREATE TABLE IF NOT EXISTS `peut` (
  `ID_POTION` int(11) NOT NULL,
  `ID_VILLAGEOIS` int(11) NOT NULL,
  `A_LE_DROIT` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`ID_POTION`,`ID_VILLAGEOIS`),
  KEY `FK_PEUT2` (`ID_VILLAGEOIS`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Contenu de la table `peut`
--

INSERT INTO `peut` (`ID_POTION`, `ID_VILLAGEOIS`, `A_LE_DROIT`) VALUES
(1, 1, 0),
(2, 1, 1);

-- --------------------------------------------------------

--
-- Structure de la table `potion`
--

CREATE TABLE IF NOT EXISTS `potion` (
  `ID_POTION` int(11) NOT NULL,
  `NOM_POTION` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`ID_POTION`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Contenu de la table `potion`
--

INSERT INTO `potion` (`ID_POTION`, `NOM_POTION`) VALUES
(0, 'Magique'),
(1, 'Rajeunissement II'),
(2, 'Santé'),
(3, 'Rajeunissement'),
(4, 'Soupe'),
(5, 'Vitesse'),
(6, 'Invisibilité'),
(7, 'Assouplissement'),
(8, 'Force'),
(9, 'Intelligence'),
(10, 'Assouplissement II'),
(11, 'Potion I'),
(12, 'Potion II'),
(13, 'Potion III'),
(14, 'Potion IV'),
(15, 'Potion V'),
(16, 'Potion VI'),
(17, 'Potion VII'),
(18, 'Potion VIII'),
(19, 'Potion IX');

-- --------------------------------------------------------

--
-- Structure de la table `prise_casque`
--

CREATE TABLE IF NOT EXISTS `prise_casque` (
  `ID_CASQUE` int(11) NOT NULL,
  `ID_VILLAGEOIS` int(11) NOT NULL,
  `ID_BATAILLE` int(11) NOT NULL,
  `QTE` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID_CASQUE`,`ID_VILLAGEOIS`,`ID_BATAILLE`),
  KEY `FK_PRISE_CASQUE2` (`ID_VILLAGEOIS`),
  KEY `FK_PRISE_CASQUE3` (`ID_BATAILLE`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Contenu de la table `prise_casque`
--

INSERT INTO `prise_casque` (`ID_CASQUE`, `ID_VILLAGEOIS`, `ID_BATAILLE`, `QTE`) VALUES
(0, 5, 5, 8),
(0, 14, 5, 15),
(0, 19, 2, 5),
(0, 38, 1, 8),
(1, 4, 6, 12),
(1, 11, 0, 16),
(1, 18, 9, 5),
(1, 31, 1, 5),
(2, 2, 1, 4),
(2, 2, 7, 3),
(2, 13, 5, 7),
(2, 30, 8, 3),
(3, 0, 7, 5),
(3, 11, 1, 7),
(3, 16, 7, 8),
(3, 32, 3, 3),
(4, 6, 9, 8),
(4, 22, 0, 4),
(4, 25, 5, 8),
(4, 37, 4, 4),
(5, 9, 3, 3),
(5, 10, 8, 10),
(5, 24, 0, 5),
(5, 34, 8, 7),
(6, 8, 4, 3),
(6, 21, 2, 9),
(6, 22, 6, 12),
(6, 35, 6, 1),
(7, 9, 3, 6),
(7, 10, 2, 7),
(7, 13, 6, 11),
(7, 33, 4, 9),
(8, 7, 9, 12),
(8, 10, 4, 8),
(8, 19, 8, 7),
(8, 27, 9, 11),
(9, 20, 0, 6),
(9, 23, 3, 10),
(9, 24, 7, 11),
(9, 38, 2, 7),
(1, 2, 1, 3),
(1, 40, 1, 4),
(1, 1, 1, 30),
(3, 6, 4, 0),
(8, 2, 1, 1);

-- --------------------------------------------------------

--
-- Structure de la table `specialite`
--

CREATE TABLE IF NOT EXISTS `specialite` (
  `ID_SPECIALITE` int(11) NOT NULL,
  `NOM_SPECIALITE` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`ID_SPECIALITE`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Contenu de la table `specialite`
--

INSERT INTO `specialite` (`ID_SPECIALITE`, `NOM_SPECIALITE`) VALUES
(0, 'Guerrier'),
(1, 'Porteur de Mehnir'),
(2, 'Barde'),
(3, 'Druide'),
(4, 'Espion'),
(5, 'Villageois'),
(6, 'Artisan'),
(7, 'Marchand');

-- --------------------------------------------------------

--
-- Structure de la table `type_casque`
--

CREATE TABLE IF NOT EXISTS `type_casque` (
  `ID_TYPE_CASQUE` int(11) NOT NULL,
  `NOM_TYPE_CASQUE` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`ID_TYPE_CASQUE`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Contenu de la table `type_casque`
--

INSERT INTO `type_casque` (`ID_TYPE_CASQUE`, `NOM_TYPE_CASQUE`) VALUES
(0, 'Romain'),
(1, 'Grec'),
(2, 'Autre');

-- --------------------------------------------------------

--
-- Structure de la table `villageois`
--

CREATE TABLE IF NOT EXISTS `villageois` (
  `ID_VILLAGEOIS` int(11) NOT NULL AUTO_INCREMENT,
  `ID_LIEU` int(11) NOT NULL,
  `ID_SPECIALITE` int(11) NOT NULL,
  `NOM` varchar(32) DEFAULT NULL,
  `ADRESSE` varchar(32) DEFAULT NULL,
  `IMAGE` varchar(255) NOT NULL,
  PRIMARY KEY (`ID_VILLAGEOIS`),
  KEY `FK_HABITE` (`ID_LIEU`),
  KEY `FK_SPECIALISE` (`ID_SPECIALITE`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=61 ;

--
-- Contenu de la table `villageois`
--

INSERT INTO `villageois` (`ID_VILLAGEOIS`, `ID_LIEU`, `ID_SPECIALITE`, `NOM`, `ADRESSE`, `IMAGE`) VALUES
(1, 0, 1, 'Obelix', '', 'Obelix.jpg'),
(2, 0, 0, 'Abraracourcix', '', 'Abraracourcix.jpg'),
(4, 0, 5, 'Agecanonix', '', 'Agecanonix.gif'),
(9, 0, 3, 'Panoramix', '', 'Panoramix.jpg'),
(12, 0, 2, 'Assurancetourix', '', 'Assurancetourix.jpg'),
(21, 0, 6, 'Cetautomatix', '', 'Cetautomatix.jpg'),
(40, 0, 0, 'Asterix', 'cote carrieres', 'Asterix.jpg'),
(3, 6, 4, 'Acidenitrix', '', 'Acidenitrix.jpg'),
(5, 4, 7, 'Alambix', '', 'Alambix.jpg'),
(6, 1, 0, 'Allegorix', '', 'indisponible.jpg'),
(7, 1, 6, 'Amerix', '', 'Amerix.jpg'),
(8, 1, 3, 'Amnesix', '', 'Amnesix.jpg'),
(10, 6, 0, 'Analgesix', '', 'Analgesix.jpg'),
(11, 5, 7, 'Antibiotix', '', 'Antibiotix.jpg'),
(13, 1, 0, 'Aplusbegalix', '', 'Aplusbegalix.jpg'),
(14, 5, 5, 'Appatix', '', 'indisponible.jpg'),
(15, 5, 7, 'Arrierboutix', '', 'indisponible.jpg'),
(16, 6, 5, 'Asthmatix', '', 'indisponible.jpg'),
(17, 2, 0, 'Astronomix', '', 'Astronomix.jpg'),
(18, 2, 0, 'Aventurepix', '', 'indisponible.jpg'),
(19, 4, 6, 'Carferrix', '', 'Carferrix.jpg'),
(20, 1, 5, 'Catedralgotix', '', 'Catedralgotix.jpg'),
(22, 6, 5, 'Choucroutgarnix', '', 'indisponible.jpg'),
(23, 4, 0, 'Tournedix', '', 'Tournedix.jpg'),
(24, 2, 3, 'Diagnostix', '', 'Diagnostix.jpg'),
(25, 1, 5, 'Dithyrambix', '', 'indisponible.jpg'),
(26, 6, 0, 'Herettix', '', 'indisponible.jpg'),
(27, 4, 0, 'Industrichimix', '', 'indisponible.jpg'),
(28, 7, 6, 'Mineralogix', '', 'indisponible.jpg'),
(29, 6, 4, 'Zerozerosix', '', 'Zerozerosix.jpg'),
(30, 2, 7, 'Ordralfabetix', '', 'Ordralfabetix.jpg'),
(31, 1, 7, 'Orthopedix', '', 'Orthopedix.jpg'),
(32, 1, 6, 'Petisuix', '', 'Petisuix.jpg'),
(33, 5, 0, 'Plantaquatix', '', 'Plantaquatix.jpg'),
(34, 1, 0, 'Pneumatix', '', 'Pneumatix.jpg'),
(35, 7, 0, 'Porquepix', '', 'indisponible.jpg'),
(36, 6, 7, 'Pronostix', '', 'indisponible.jpg'),
(37, 3, 0, 'Quatredeuxsix', '', 'Quatredeuxsix.jpg'),
(38, 6, 5, 'Salamix', '', 'Salamix.jpg'),
(39, 4, 7, 'Selfservix', '', 'indisponible.jpg'),
(53, 0, 6, 'Lentix', 'Lutece', 'lentix.gif'),
(50, 0, 5, 'Goudurix', 'Bord de la plage', 'Goudurix.jpg'),
(52, 0, 7, 'Plaintcontrix', 'Lutece', 'Plaintcontrix.jpg'),
(51, 0, 3, 'Barometrix', 'Foret', 'Barometrix.jpg'),
(54, 0, 7, 'Taxesurleprix', 'Lutece', 'taxesurleprix.jpg'),
(55, 0, 0, 'Tragicomix', 'Lutece', 'Tragicomix.gif');