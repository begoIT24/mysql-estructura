-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Pizzeria
-- -----------------------------------------------------
-- Base de dades de gestió d'una cadena de pizzeries

-- -----------------------------------------------------
-- Schema Pizzeria
--
-- Base de dades de gestió d'una cadena de pizzeries
-- -----------------------------------------------------
DROP DATABASE IF EXISTS `Pizzeria`;
CREATE SCHEMA IF NOT EXISTS `Pizzeria` DEFAULT CHARACTER SET utf8 COLLATE utf8_bin ;
USE `Pizzeria` ;

-- -----------------------------------------------------
-- Table `Pizzeria`.`clients`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`clients` (
  `idClient` INT NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NOT NULL,
  `cognom` VARCHAR(45) NOT NULL,
  `adreça` VARCHAR(45) NOT NULL,
  `codi postal` VARCHAR(5) NOT NULL,
  `localitat` VARCHAR(45) NOT NULL,
  `província` VARCHAR(45) NOT NULL,
  `telf` VARCHAR(9) NOT NULL,
  PRIMARY KEY (`idClient`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzeria`.`botigues`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`botigues` (
  `idBotiga` INT NOT NULL AUTO_INCREMENT,
  `adreça` VARCHAR(45) NOT NULL,
  `codi postal` VARCHAR(5) NOT NULL,
  `localitat` VARCHAR(45) NOT NULL,
  `província` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idBotiga`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzeria`.`empleats`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`empleats` (
  `idEmpleat` INT NOT NULL AUTO_INCREMENT,
  `tipus empleat` ENUM('cuiner', 'repartidor') NOT NULL,
  `nom` VARCHAR(45) NOT NULL,
  `cognom` VARCHAR(45) NOT NULL,
  `nif` VARCHAR(9) NOT NULL,
  `telf` VARCHAR(9) NOT NULL,
  `idBotiga` INT NOT NULL,
  PRIMARY KEY (`idEmpleat`),
  INDEX `idBotiga_idx` (`idBotiga`),
  CONSTRAINT `idBotiga1`
    FOREIGN KEY (`idBotiga`)
    REFERENCES `Pizzeria`.`botigues` (`idBotiga`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzeria`.`comandes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`comandes` (
  `idComanda` INT NOT NULL AUTO_INCREMENT,
  `data/hora` TIMESTAMP NOT NULL,
  `entrega` ENUM('a domicili', 'recollir') NOT NULL,
  `preu final €` DECIMAL(5,2) NOT NULL,
  `idClient` INT NOT NULL,
  `idEmpleat` INT NULL,
  `idBotiga` INT NOT NULL,
  PRIMARY KEY (`idComanda`),
  INDEX `idClient_idx` (`idClient`),
  INDEX `idEmpleat_idx` (`idEmpleat`),
  INDEX `idBotiga_idx` (`idBotiga`),
  CONSTRAINT `idClient`
    FOREIGN KEY (`idClient`)
    REFERENCES `Pizzeria`.`clients` (`idClient`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `idEmpleat`
    FOREIGN KEY (`idEmpleat`)
    REFERENCES `Pizzeria`.`empleats` (`idEmpleat`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `idBotiga2`
    FOREIGN KEY (`idBotiga`)
    REFERENCES `Pizzeria`.`botigues` (`idBotiga`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'Registre de comandes';


-- -----------------------------------------------------
-- Table `Pizzeria`.`categories pizzes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`categories pizzes` (
  `idPizza` INT NOT NULL,
  `nom` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idPizza`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzeria`.`productes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`productes` (
  `idProducte` INT NOT NULL AUTO_INCREMENT,
  `tipus` ENUM('pizza', 'hamburguesa', 'beguda') NOT NULL,
  `nom` VARCHAR(45) NOT NULL,
  `descripció` VARCHAR(100) NOT NULL,
  `imatge` BLOB(0) NOT NULL,
  `preu €` DECIMAL(5,2) NOT NULL,
  `idPizza` INT NULL,
  PRIMARY KEY (`idProducte`),
  INDEX `idPizza_idx` (`idPizza`),
  CONSTRAINT `idPizza`
    FOREIGN KEY (`idPizza`)
    REFERENCES `Pizzeria`.`categories pizzes` (`idPizza`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzeria`.`productes comanda`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`productes comanda` (
  `idProducte` INT NOT NULL,
  `quantitat` INT NOT NULL,
  `idComanda` INT NOT NULL,
  `preu total €` DECIMAL(5,2) NOT NULL,
  INDEX `quantitat_idx` (`quantitat`),
  INDEX `idComanda_idx` (`idComanda`),
  CONSTRAINT `prod1`
    FOREIGN KEY (`idProducte`)
    REFERENCES `Pizzeria`.`productes` (`idProducte`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `idComanda`
    FOREIGN KEY (`idComanda`)
    REFERENCES `Pizzeria`.`comandes` (`idComanda`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'Quantitat i preu total de cada tipus de producte d\'una comanda';


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

/* clients */
INSERT INTO `Pizzeria`.`clients` (`nom`, `cognom`, `adreça`, `codi postal`, `localitat`, `província`, `telf`)
VALUES
('Pep', 'García', 'Carrer Provença 56', 08015, 'Barcelona', 'Barcelona', 612345678),
('Anna', 'Martínez', 'Plaça del Vi 2', 17002, 'Girona', 'Girona', 612345679),
('David', 'López', 'Av. Roma 34', 43003, 'Tarragona', 'Tarragona', 612345680),
('Sara', 'Martínez', 'Carrer Gran Via 89', 08020, 'Barcelona', 'Barcelona', 612345690),
('Jordi', 'López', 'Rambla Catalunya 45', 17003, 'Girona', 'Girona', 612345691),
('Lucía', 'García', 'Plaça Reial 12', 43005, 'Tarragona', 'Tarragona', 612345692),
('Juan', 'Pérez', 'Gran Via, 345, 5º-2ª', 08011, 'Barcelona', 'Barcelona', 663670220),
('Laia', 'Boronat', 'Passeig Maragall, 180, 1º', 08029, 'Barcelona', 'Barcelona', 654058268),
('Jordi', 'Albertí', 'Campoamor, 20',  43005, 'Tarragona', 'Tarragona', 663378367),
('Albert', 'Gil', 'Lisboa, 15, 2º-1ª', 08032, 'Barcelona', 'Barcelona', 663378367),
('Sara', 'López', 'Muntaner, 86, 4º-4ª', 08026, 'Barcelona', 'Barcelona', 663378367),
('Quim', 'González', 'Barcelona, 50, 2º-1ª', 17001, 'Girona', 'Girona', 673578310),
('Rosa', 'Puignou', 'Migdia, 40, 3º-1ª', 17002, 'Girona', 'Girona', 689578193);

/* botigues */
INSERT INTO `Pizzeria`.`botigues` (`adreça`, `codi postal`, `localitat`, `província`)
VALUES
('Av Sant Francesc, 4', 17001, 'Girona', 'Girona'),
('Dr Antic Roca, 14', 17003, 'Girona', 'Girona'),
('Via Laietana, 41',08003, 'Barcelona', 'Barcelona'),
('Passeig Maragall, 300',08029, 'Barcelona', 'Barcelona'),
('Rambla Nova 45', 43001, 'Tarragona', 'Tarragona');

/* empleats */
INSERT INTO `Pizzeria`.`empleats` (`tipus empleat`, `nom`, `cognom`, `nif`, `telf`, `idBotiga`)
VALUES
('cuiner', 'Anna', 'Garcia', '12345678A', 612345678, 1),
('repartidor', 'David', 'Martínez', '98765431B', 612345679, 1),
('cuiner', 'Eva', 'López', '45678923C', 612345680, 2),
('repartidor', 'Marc', 'Rodríguez', '32165487D', 612345681, 2),
('cuiner', 'Laura', 'Sánchez', '78912356E', 612345682, 3),
('repartidor', 'Javier', 'Fernández', '65498721F', 612345683, 3),
('cuiner', 'Cristina', 'Pérez', '23456789G', 612345684, 4),
('repartidor', 'Carlos', 'Gómez', '78901235H', 612345685, 4),
('cuiner', 'María', 'Ruiz', '56789123I', 612345686, 5),
('repartidor', 'Alberto', 'Hernández', '01245678J', 612345687, 5),
('repartidor', 'Antonio', 'Hernández', '23456780A', 612345684, 1),
('repartidor', 'Marta', 'Fernández', '78902345B', 612345685, 2);

/* comandes */
INSERT INTO `Pizzeria`.`comandes` (`data/hora`, `entrega`, `preu final €`, `idClient`, `idEmpleat`, `idBotiga`)
VALUES
('2024-02-15 12:30:00', 'a domicili', 25.50, 1, 2, 1),
('2024-02-15 13:45:00', 'recollir', 18.75, 2, NULL, 2),
('2024-02-15 14:30:00', 'a domicili', 30.00, 3, 6, 3),
('2024-02-15 15:15:00', 'recollir', 22.80, 4, NULL, 1),
('2024-02-15 16:00:00', 'recollir', 27.90, 5, NULL, 2),
('2024-02-15 17:30:00', 'recollir', 19.95, 6, NULL, 3),
('2024-02-15 18:15:00', 'a domicili', 35.25, 7, 11, 1),
('2024-02-15 19:00:00', 'recollir', 24.60, 8, NULL, 2),
('2024-02-15 20:15:00', 'a domicili', 29.75, 9, 8, 3),
('2024-02-15 21:00:00', 'recollir', 32.40, 10, NULL, 5),
('2024-02-16 12:30:00', 'a domicili', 26.50, 11, 10, 5),
('2024-02-16 13:45:00', 'recollir', 21.75, 12, NULL, 4),
('2024-02-16 14:30:00', 'a domicili', 28.00, 13, 3, 1),
('2024-02-16 15:15:00', 'recollir', 23.80, 13, NULL, 2),
('2024-02-16 16:00:00', 'recollir', 26.90, 2, NULL, 3),
('2024-02-16 17:30:00', 'recollir', 20.95, 3, NULL, 2),
('2024-02-16 18:15:00', 'a domicili', 34.25, 5, 10, 5),
('2024-02-16 19:00:00', 'recollir', 25.60, 10, NULL, 3),
('2024-02-16 20:15:00', 'a domicili', 28.75, 1, 10, 5),
('2024-02-16 21:00:00', 'recollir', 30.40, 8, NULL, 2),
('2024-02-17 12:30:00', 'a domicili', 24.50, 7, 6, 4),
('2024-02-17 13:45:00', 'recollir', 20.75, 13, NULL, 1),
('2024-02-17 14:30:00', 'a domicili', 27.00, 12, 11, 2),
('2024-02-17 15:15:00', 'recollir', 22.80, 4, NULL, 3),
('2024-02-17 16:00:00', 'a domicili', 25.90, 11, 12, 1);

/* categories de pizzes */
INSERT INTO `Pizzeria`.`categories pizzes` (`idPizza`, `nom`)
VALUES
(1, 'Clàssiques'),
(2, 'Especialitats'),
(3, 'Sense gluten');

/* productes */
INSERT INTO `Pizzeria`.`productes` (`tipus`, `nom`, `descripció`,  `imatge`, `preu €`, `idPizza`)
VALUES
('pizza', 'Margarita', 'Tomate, mozzarella, albahaca', 'img01.png', 10.50, 1),
('pizza', 'Pepperoni', 'Tomate, mozzarella, pepperoni', 'img02.png', 12.00, 1),
('pizza', 'Vegetariana', 'Tomate, mozzarella, verduras', 'img03.png', 11.00, 3),
('pizza', 'Barbacoa', 'Tomate, mozzarella, carne, barbacoa', 'img04.png', 13.50, 2),
('pizza', 'Hawaiana', 'Tomate, mozzarella, piña, jamón', 'img05.png', 12.50, 1),
('pizza', 'Cuatro Quesos', 'Tomate, mozzarella, gorgonzola, parmesano, emmental', 'img06.png', 14.00, 1),
('pizza', 'Mexicana', 'Tomate, mozzarella, carne, chiles, jalapeños', 'img07.png', 13.00, 2),
('pizza', 'Napolitana', 'Tomate, mozzarella, anchoas, aceitunas, alcaparras', 'img08.png', 13.50, 2),
('beguda', 'Coca-Cola', 'Refresco de cola', 'img09.png', 2.50, NULL),
('beguda', 'Fanta', 'Refresco de naranja', 'img10.png', 2.50, NULL),
('beguda', 'Agua Mineral', 'Agua sin gas', 'img11.png', 1.50, NULL),
('beguda', 'Cerveza', 'Cerveza clara','img12.png', 3.00,  NULL),
('beguda', 'Zumo de Naranja', 'Zumo natural de naranja', 'img13.png', 2.00, NULL),
('hamburguesa', 'Hamburguesa Clásica', 'Carne, lechuga, tomate, queso', 'img14.png', 5.00, NULL),
('hamburguesa', 'Hamburguesa BBQ', 'Carne, bacon, queso cheddar, salsa barbacoa', 'img15.png', 6.50, NULL),
('hamburguesa', 'Hamburguesa Vegetariana', 'Hamburguesa de garbanzos con verduras', 'img16.png', 4.50, NULL),
('hamburguesa', 'Hamburguesa con Queso Azul', 'Carne, queso azul, cebolla caramelizada', 'img17.png', 7.00, NULL),
('hamburguesa', 'Hamburguesa de Pollo', 'Pechuga de pollo, lechuga, tomate', 'img18.png', 5.50, NULL);

/* productes comanda */
INSERT INTO `Pizzeria`.`productes comanda` (`idProducte`, `quantitat`, `idComanda`, `preu total €`)
VALUES
(1, 2, 1, 21.00),
(2, 1, 2, 12.00),
(3, 3, 3, 33.00),
(4, 2, 1, 21.00),
(5, 1, 2, 12.00),
(6, 3, 3, 33.00),
(7, 2, 4, 27.00),
(8, 1, 5, 13.50),
(1, 3, 6, 31.50),
(2, 1, 7, 14.00),
(3, 2, 8, 22.00),
(4, 3, 9, 40.50),
(5, 2, 10, 25.00),
(9, 2, 10, 5.00),
(14, 2, 10, 10.00);



