-- Création de la base de données bookdb
CREATE DATABASE IF NOT EXISTS `bookdb` DEFAULT CHARACTER SET utf8;
USE `bookdb`;

-- Table `auteur`
DROP TABLE IF EXISTS `auteur`;
CREATE TABLE `auteur` (
    `NUMERO_A` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
    `NOM` VARCHAR(450) DEFAULT NULL,
    `PRENOM` VARCHAR(450) DEFAULT NULL,
    `DOMICILE` VARCHAR(450) DEFAULT NULL,
    PRIMARY KEY (`NUMERO_A`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;

-- Insert sample authors
INSERT INTO `auteur` (`NOM`, `PRENOM`, `DOMICILE`) VALUES
('Smith', 'John', 'New York'),
('Johnson', 'Emily', 'San Francisco'),
('Garcia', 'Miguel', 'Madrid'),
('Brown', 'Jessica', 'London'),
('Chen', 'Wei', 'Beijing'),
('Dubois', 'Marie', 'Paris'),
('Kim', 'Seong', 'Seoul'),
('Müller', 'Hans', 'Berlin'),
('Rossi', 'Marco', 'Rome'),
('Sato', 'Takashi', 'Tokyo');

-- Table `livre`
DROP TABLE IF EXISTS `livre`;
CREATE TABLE `livre` (
    `NUMERO_L` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
    `NUMERO_A` INT(10) UNSIGNED NOT NULL,
    `TITRE` VARCHAR(128) DEFAULT NULL,
    `PRIX` FLOAT DEFAULT NULL,
    PRIMARY KEY (`NUMERO_L`),
    CONSTRAINT `fk_auteur_numero` FOREIGN KEY (`NUMERO_A`) REFERENCES `auteur` (`NUMERO_A`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;

-- Insert sample books
INSERT INTO `livre` (`NUMERO_A`, `TITRE`, `PRIX`) VALUES
(1, 'Data Engineering for Dummies', 19.99),
(2, 'Practical Data Engineering', 29.99),
(3, 'Mastering Data Engineering', 34.99),
(4, 'Advanced Techniques in Data Engineering', 39.99),
(5, 'Big Data Infrastructure', 49.99),
(6, 'Data Pipelines and ETL Processing', 24.99),
(7, 'Data Science Essentials', 29.99),
(8, 'Machine Learning in Practice', 39.99),
(9, 'Cloud Data Solutions', 44.99),
(10, 'Data Governance and Compliance', 34.99),
(1, 'Data Warehousing Fundamentals', 29.99),
(2, 'Real-time Analytics', 49.99),
(3, 'Data Quality Management', 39.99),
(4, 'Data Mining Techniques', 34.99),
(5, 'Introduction to Hadoop', 29.99),
(6, 'Spark in Action', 49.99),
(7, 'Python for Data Analysis', 39.99),
(8, 'R Programming for Data Science', 34.99),
(9, 'SQL Mastery', 29.99),
(10, 'NoSQL Databases', 49.99);