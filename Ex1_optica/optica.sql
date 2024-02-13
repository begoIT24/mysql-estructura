-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Optica
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Optica
-- -----------------------------------------------------
DROP DATABASE IF EXISTS `Optica`;
CREATE SCHEMA IF NOT EXISTS `Optica` DEFAULT CHARACTER SET utf8 ;
USE `Optica` ;

-- -----------------------------------------------------
-- Table `Optica`.`proveIdors`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Optica`.`proveIdors` (
  `id_prov` INT NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NOT NULL,
  `carrer` VARCHAR(45) NOT NULL,
  `nº` INT NOT NULL,
  `pis` INT NULL,
  `porta` INT NULL,
  `ciutat` VARCHAR(45) NOT NULL,
  `país` VARCHAR(45) NOT NULL,
  `telèfon` INT NOT NULL,
  `fax` INT NULL,
  `nif` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_prov`))
ENGINE = InnoDB
COMMENT = 'Dades dels proveIdors de les ulleres';


-- -----------------------------------------------------
-- Table `Optica`.`clients`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Optica`.`clients` (
  `id_client` INT NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NOT NULL,
  `cognom` VARCHAR(45) NOT NULL,
  `adreça` VARCHAR(45) NOT NULL,
  `telf` INT NOT NULL,
  `e-mail` VARCHAR(45) NOT NULL,
  `data_registre` DATE NOT NULL,
  `recomana` INT NULL,
  PRIMARY KEY (`id_client`),
  INDEX `recomana_idx` (`recomana`),
  CONSTRAINT `recomana`
    FOREIGN KEY (`recomana`)
    REFERENCES `Optica`.`clients` (`id_client`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'Dades dels clients de l\'òptica';


-- -----------------------------------------------------
-- Table `Optica`.`ulleres`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Optica`.`ulleres` (
  `id_ulleres` INT NOT NULL AUTO_INCREMENT,
  `marca` VARCHAR(45) NOT NULL,
  `grad_esquerra` FLOAT NOT NULL,
  `grad_dret` FLOAT NOT NULL,
  `muntura` ENUM("a l'aire", "pasta", "metall") NOT NULL,
  `color_munt` VARCHAR(45) NOT NULL,
  `color_esquerre` VARCHAR(45) NOT NULL,
  `color_dret` VARCHAR(45) NOT NULL,
  `id_prov` INT NOT NULL,
  PRIMARY KEY (`id_ulleres`),
  INDEX `id_prov_idx` (`id_prov`),
  CONSTRAINT `id_prov`
    FOREIGN KEY (`id_prov`)
    REFERENCES `Optica`.`proveIdors` (`id_prov`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB
COMMENT = 'Dades de les unitats d\'ulleres disponibles';


-- -----------------------------------------------------
-- Table `Optica`.`empleats`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Optica`.`empleats` (
  `id_empleat` INT NOT NULL,
  `nom` VARCHAR(45) NULL,
  PRIMARY KEY (`id_empleat`))
ENGINE = InnoDB
COMMENT = 'Dades dels empleats de l\'optica';


-- -----------------------------------------------------
-- Table `Optica`.`periode_vendes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Optica`.`periode_vendes` (
  `id_periode` INT NOT NULL AUTO_INCREMENT,
  `mes inici` VARCHAR(45) NOT NULL,
  `mes final` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_periode`))
ENGINE = InnoDB
COMMENT = 'Periode de vendes trimestral';


-- -----------------------------------------------------
-- Table `Optica`.`vendes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Optica`.`vendes` (
  `id_venda` INT NOT NULL AUTO_INCREMENT,
  `id_client` INT NOT NULL,
  `id_ulleres` INT NOT NULL,
  `id_empleat` INT NOT NULL,
  `periode` INT NOT NULL,
  PRIMARY KEY (`id_venda`),
  INDEX `id_client_idx` (`id_client`),
  INDEX `id_ulleres_idx` (`id_ulleres`),
  INDEX `id_empleat_idx` (`id_empleat`),
  INDEX `periode_idx` (`periode`),
  CONSTRAINT `id_client`
    FOREIGN KEY (`id_client`)
    REFERENCES `Optica`.`clients` (`id_client`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `id_ulleres`
    FOREIGN KEY (`id_ulleres`)
    REFERENCES `Optica`.`ulleres` (`id_ulleres`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `id_empleat`
    FOREIGN KEY (`id_empleat`)
    REFERENCES `Optica`.`empleats` (`id_empleat`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `periode`
    FOREIGN KEY (`periode`)
    REFERENCES `Optica`.`periode_vendes` (`id_periode`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'Dades de la venda de cada parell d\'ulleres';


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

/* proveïdors */
INSERT INTO proveIdors VALUES (1, 'VISTAOPTICA', 'Rambla Catalunya', 10, 3, 1, 'Barcelona', 'Espanya', 93555555, 93555556, 'R4577894A');
INSERT INTO proveIdors VALUES (2, 'MACROSTOCKS', 'Garrotxa', 42, 2, NULL, 'Castellar del Vallès', 'Espanya', 935046033, 935046034, 'H31307861');
INSERT INTO proveIdors VALUES (3, 'PROSUN', 'Pallars', 73, 1, NULL, 'Barcelona', 'Espanya', 930625988, 935046034, 'V70059183');

/* clients */
INSERT INTO clients VALUES (1, 'Juan', 'Pérez', 'Gran Via, 345, 5º-2ª, Barcelona', 663670220, 'jperez@mail.com', '2023-02-02', NULL);
INSERT INTO clients VALUES (2, 'Laia', 'Boronat', 'Passeig Maragall, 180, 1º, Barcelona', 654058268, 'laiab@mail.com', '2023-02-20', 1);
INSERT INTO clients VALUES (3, 'Jordi', 'Albertí', 'Campoamor, 20, Barcelona', 663378367, 'jordalb@mail.com', '2023-05-04', NULL);
INSERT INTO clients VALUES (4, 'Albert', 'Gil', 'Lisboa, 15, 2º-1ª, Barcelona', 663378367, 'albert_gil@mail.com', '2023-07-17', 2);
INSERT INTO clients VALUES (5, 'Sara', 'López', 'Muntaner, 86, 4º-4ª, Barcelona', 663378367, 'saralop@mail.com', '2023-10-23', 4);

/* ulleres */
INSERT INTO ulleres VALUES (1, 'Zadig', 2.5, 2.0, "pasta", 'granat', 'incolor', 'incolor', 1);
INSERT INTO ulleres VALUES (2, 'Ray Ban', 1.5, 1.2, "metall", 'platejada', 'blau', 'blau', 3);
INSERT INTO ulleres VALUES (3, 'Prada', 0, 0, "pasta", 'marró', 'negre', 'negre', 3);
INSERT INTO ulleres VALUES (4, 'Oakley', 3.5, 3.5, "a l'aire", 'negra', 'incolor', 'incolor', 2);
INSERT INTO ulleres VALUES (5, 'Oakley', 1.8, 2.2, 'pasta', 'blava', 'rosa', 'rosa', 2);

/* empleats */
INSERT INTO empleats VALUES (1, 'Maria');
INSERT INTO empleats VALUES (2, 'Laura');
INSERT INTO empleats VALUES (3, 'Toni');

/* periode_vendes */
INSERT INTO periode_vendes VALUES (1, 'gener', 'març');
INSERT INTO periode_vendes VALUES (2, 'abril', 'juny');
INSERT INTO periode_vendes VALUES (3, 'juliol', 'setembre');
INSERT INTO periode_vendes VALUES (4, 'octubre', 'desembre');

/* vendes */
INSERT INTO vendes VALUES (1, 1, 5, 1, 1);
INSERT INTO vendes VALUES (2, 2, 2, 2, 1);
INSERT INTO vendes VALUES (3, 3, 3, 1, 2);
INSERT INTO vendes VALUES (4, 4, 1, 2, 3);
INSERT INTO vendes VALUES (5, 5, 4, 3, 4);





