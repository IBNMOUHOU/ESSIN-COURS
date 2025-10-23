CREATE DATABASE IF NOT EXISTS `gestion_livres` DEFAULT CHARACTER SET utf8;
USE `gestion_livres`;
-- Table `auteur`
DROP TABLE IF EXISTS `auteur`;
CREATE TABLE `auteur` (
`NUMERO_A` int(10) unsigned NOT NULL AUTO_INCREMENT,
`NOM` varchar(450) DEFAULT NULL,
`PRENOM` varchar(450) DEFAULT NULL,
`DOMICILE` varchar(450) DEFAULT NULL,
PRIMARY KEY (`NUMERO_A`)
) ENGINE=InnoDB AUTO_INCREMENT=8547586 DEFAULT CHARSET=latin1;
-- Données pour table `auteur`
INSERT INTO `auteur` VALUES
(8547,'Chambord','Emilie','Nice'),
(52136,'Fabiere','Sylvie','Bordeaux'),
(78545,'TINTIN','Thierry','Clermont'),
(85478,'Castafiore','Emilie','Paris'),
(542536,'Dupont','Pierre','Avignon'),
(8547585,'Momo','Roland','Toulouse');
-- Table `livre`
DROP TABLE IF EXISTS `livre`;
CREATE TABLE `livre` (
`NUMERO_L` int(10) unsigned NOT NULL AUTO_INCREMENT,
`NUMERO_A` int(10) unsigned NOT NULL,
`TITRE` varchar(128) DEFAULT NULL,
`PRIX` float DEFAULT NULL,
PRIMARY KEY (`NUMERO_L`)
) ENGINE=InnoDB AUTO_INCREMENT=11324 DEFAULT CHARSET=latin1;
-- Données pour table `livre`
INSERT INTO `livre` VALUES
(10101,85478,'aaaaaa',10),
(11111,8547,'eeeee',54),
(11122,52136,'fffff',12),
(11231,542536,'bbbbb',34),
(11321,8547585,'eeefff',29),
(11323,8547585,'cccdddd',45);