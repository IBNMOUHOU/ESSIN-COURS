Projet ETL Talend : Flux de Données Auteurs & Livres
Ce projet contient les fichiers nécessaires pour configurer un environnement de base de données MySQL via Docker et exécuter deux Jobs ETL (Extraction, Transformation, Chargement) avec Talend Open Studio.

🛠️ Configuration de l'Environnement (Docker)
Le fichier docker-compose.yml crée le service MySQL, expose le port 3306, et exécute trois scripts SQL pour initialiser toutes les bases de données requises.

Fichier : docker-compose.yml
YAML

version: '3.8'
services:
  mysql_db:
    image: mysql:8.0 
    container_name: mysql_db 
    ports:
      - "3306:3306"
    environment:
      MYSQL_ROOT_PASSWORD: mysecret
    volumes:
      # Scripts d'initialisation pour créer les bases et tables
      - ./gestion_livres_init.sql:/docker-entrypoint-initdb.d/gestion_livres_init.sql
      - ./bookdb_init.sql:/docker-entrypoint-initdb.d/bookdb_init.sql
      - ./dwh_init.sql:/docker-entrypoint-initdb.d/dwh_init.sql # Ajout du script DWH
    restart: unless-stopped
🚀 Lancement
Pour démarrer le conteneur et créer toutes les bases (bookdb, gestion_livres, dwh_bookdb), exécutez dans votre terminal :

Bash

docker compose up -d
📄 Scripts SQL d'Initialisation
1. Source OLTP (bookdb)
Le fichier bookdb_init.sql crée la base de données source contenant les tables auteur et livre.

SQL

-- Création de la base de données bookdb
CREATE DATABASE IF NOT EXISTS `bookdb`;
USE `bookdb`;

-- Définition de la table auteur...
-- Définition de la table livre...
-- Insertion de données...
2. Cible DWH (dwh_bookdb)
Le fichier dwh_init.sql crée l'entrepôt de données et la table de dimension auteur_DIM utilisée pour le Chargement (L).

SQL

-- Création de la base de données DWH
CREATE DATABASE IF NOT EXISTS `dwh_bookdb`;
USE `dwh_bookdb`;

-- Table auteur_DIM incluant la future colonne enrichie 'ETAT'
CREATE TABLE `auteur_DIM` (
    `NUMERO_A` INT(10) UNSIGNED NOT NULL,
    `NOM` VARCHAR(450) DEFAULT NULL,
    -- ... autres colonnes
    `ETAT` VARCHAR(450) DEFAULT NULL, -- Colonne pour la donnée transformée
    PRIMARY KEY (`NUMERO_A`)
);
💻 Logique ETL (Talend)
Deux Jobs principaux ont été construits pour le projet :

Job 1 : Fusion et Export CSV
Ce Job effectue une jointure des données de bookdb et les exporte :

Composants : tMysqlInput (livre) -> tMap -> tFileOutputDelimited.

Transformation (tMap) : Jointure (Inner Join) entre la table livre (Main) et la table auteur (Lookup) sur NUMERO_A.

Calcul du Nom Complet : La colonne de sortie est calculée via l'expression :

Java

row2.PRENOM + " " + row2.NOM 
// row2 fait référence au flux de données de la table auteur (Lookup)
Job 2 : Enrichissement et Chargement DWH
Ce Job lit les auteurs, les enrichit, et charge le résultat dans le Data Warehouse dwh_bookdb.

Composants : tMysqlInput (bookdb.auteur) -> tMap -> tMysqlOutput (dwh_bookdb.auteur_DIM).

Enrichissement (tMap) : Création de la colonne ETAT via une expression conditionnelle :

Java

row1.NUMERO_A > 5 ? "Auteur récent" : "Auteur ancien"
// Si l'ID est supérieur à 5, l'auteur est marqué comme "récent".
Chargement (tMysqlOutput) : Configuré pour Drop table if exists and create (supprimer et recréer la table) afin de garantir une structure propre dans le DWH avant l'insertion des données enrichies (Insert).