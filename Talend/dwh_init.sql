CREATE DATABASE IF NOT EXISTS `dwh_bookdb` DEFAULT CHARACTER SET utf8;
USE `dwh_bookdb`;

-- Table `auteur_DIM` pour le Data Warehouse
DROP TABLE IF EXISTS `auteur_DIM`;
CREATE TABLE `auteur_DIM` (
    `NUMERO_A` INT(10) UNSIGNED NOT NULL,
    `NOM` VARCHAR(450) DEFAULT NULL,
    `PRENOM` VARCHAR(450) DEFAULT NULL,
    `DOMICILE` VARCHAR(450) DEFAULT NULL,
    `ETAT` VARCHAR(450) DEFAULT NULL, -- Colonne pour la donnée transformée
    PRIMARY KEY (`NUMERO_A`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
-- 2. Table de Dimension Abonne (Abonne_DIM)
DROP TABLE IF EXISTS `Abonne_DIM`;
CREATE TABLE `Abonne_DIM` (
    -- La clé primaire du DWH (ID_ABONNE)
    `ID_ABONNE` INT NOT NULL, 
    `NOM` VARCHAR(450),
    `PRENOM` VARCHAR(450),
    `DATE_NAISSANCE` DATE,
    -- ... Ajoutez ici d'autres attributs de l'abonné si nécessaires
    PRIMARY KEY (`ID_ABONNE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 3. Table de Dimension Calendar (Dim_Calendar)
-- Contient les attributs de temps pour la jointure avec la table de fait
DROP TABLE IF EXISTS `Dim_Calendar`;
CREATE TABLE `Dim_Calendar` (
    `ID_DATE` INT NOT NULL, -- Clé (ex: format AAAAMMJJ)
    `DATE_COMPLETE` DATE NOT NULL,
    `ANNEE` INT,
    `MOIS` INT,
    `JOUR` INT,
    -- ... autres attributs (Semaine, Jour_de_semaine, etc.)
    PRIMARY KEY (`ID_DATE`),
    UNIQUE KEY `DATE_COMPLETE` (`DATE_COMPLETE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 4. Table de Fait Emprunt (Emprunt_FACT)
-- Stocke les mesures et les clés étrangères
DROP TABLE IF EXISTS `Emprunt_FACT`;
CREATE TABLE `Emprunt_FACT` (
    `ID_FAIT` INT NOT NULL AUTO_INCREMENT,
    `ID_ABONNE` INT NOT NULL,
    `ID_DATE_EMPRUNT` INT NOT NULL,
    `NOMBRE_EMPRUNT` INT DEFAULT 1, -- La mesure (métrique)
    PRIMARY KEY (`ID_FAIT`),
    -- Définition des clés étrangères (liens vers les dimensions)
    FOREIGN KEY (`ID_ABONNE`) REFERENCES `Abonne_DIM`(`ID_ABONNE`),
    FOREIGN KEY (`ID_DATE_EMPRUNT`) REFERENCES `Dim_Calendar`(`ID_DATE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;