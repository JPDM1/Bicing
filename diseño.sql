-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Bicing
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `Bicing` ;

-- -----------------------------------------------------
-- Schema Bicing
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Bicing` DEFAULT CHARACTER SET utf8 ;
USE `Bicing` ;

-- -----------------------------------------------------
-- Table `Bicing`.`USUARIOS`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Bicing`.`USUARIOS` ;

CREATE TABLE IF NOT EXISTS `Bicing`.`USUARIOS` (
  `Codigo` VARCHAR(10) NOT NULL,
  `Fecha de alta` DATE NULL DEFAULT Current_timestamp,
  `DNI` CHAR(9) NULL,
  `Nombre` VARCHAR(45) NULL,
  `Apellidos` VARCHAR(45) NULL,
  `Direccion` VARCHAR(45) NULL,
  `Numero_cta_cte` CHAR(15) NULL,
  PRIMARY KEY (`Codigo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Bicing`.`Tarifa_fija`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Bicing`.`Tarifa_fija` ;

CREATE TABLE IF NOT EXISTS `Bicing`.`Tarifa_fija` (
  `Id` CHAR(4) NOT NULL,
  `Nombre` VARCHAR(45) NULL,
  `Precio` FLOAT NULL,
  PRIMARY KEY (`Id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Bicing`.`FACTURACION_ANUAL`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Bicing`.`FACTURACION_ANUAL` ;

CREATE TABLE IF NOT EXISTS `Bicing`.`FACTURACION_ANUAL` (
  `Id_factura` CHAR(5) NOT NULL,
  `Codigo_usuario` VARCHAR(10) NOT NULL,
  `Fecha abono` DATE NULL,
  `Id_tarifa_fija` CHAR(4) NOT NULL,
  PRIMARY KEY (`Id_factura`),
  CONSTRAINT `fk_FACTURACION_USUARIOS`
    FOREIGN KEY (`Codigo_usuario`)
    REFERENCES `Bicing`.`USUARIOS` (`Codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_FACTURACIÓN_Tarifa-fija1`
    FOREIGN KEY (`Id_tarifa_fija`)
    REFERENCES `Bicing`.`Tarifa_fija` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `Bicing`.`Tipo_bicicleta`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Bicing`.`Tipo_bicicleta` ;

CREATE TABLE IF NOT EXISTS `Bicing`.`Tipo_bicicleta` (
  `Id` CHAR(3) NOT NULL,
  `Tipo_bicicleta` VARCHAR(45) NULL,
  PRIMARY KEY (`Id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Bicing`.`BICICLETAS`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Bicing`.`BICICLETAS` ;

CREATE TABLE IF NOT EXISTS `Bicing`.`BICICLETAS` (
  `Id` CHAR(3) NOT NULL,
  `Año` YEAR NULL,
  `Id_tipo_bicicleta` CHAR(3) NOT NULL,
  `Operativa` TINYINT NULL,
  `Codigo_estacion` CHAR(3) NULL,
  `En_uso` TINYINT NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `fk_BICICLETA_tipo_bicicleta1`
    FOREIGN KEY (`Id_tipo_bicicleta`)
    REFERENCES `Bicing`.`Tipo_bicicleta` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `Bicing`.`ESTACIONES`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Bicing`.`ESTACIONES` ;

CREATE TABLE IF NOT EXISTS `Bicing`.`ESTACIONES` (
  `Codigo_estacion` CHAR(3) NOT NULL,
  `Nombre` VARCHAR(45) NULL,
  `Direccion` VARCHAR(45) NULL,
  `Capacidad` INT NULL,
  PRIMARY KEY (`Codigo_estacion`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Bicing`.`MANTENIMIENTO`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Bicing`.`MANTENIMIENTO` ;

CREATE TABLE IF NOT EXISTS `Bicing`.`MANTENIMIENTO` (
  `Id` CHAR(4) NOT NULL,
  `Id_bicicleta` CHAR(3) NOT NULL,
  `Fecha recepcion` DATE NULL,
  `Codigo_estacion_recogida` CHAR(3) NOT NULL,
  `Defecto` TEXT NULL,
  `Fecha de alta` DATE NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `fk_MANTENIMIENTO_BICICLETA1`
    FOREIGN KEY (`Id_bicicleta`)
    REFERENCES `Bicing`.`BICICLETAS` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_MANTENIMIENTO_ESTACIONES1`
    FOREIGN KEY (`Codigo_estacion_recogida`)
    REFERENCES `Bicing`.`ESTACIONES` (`Codigo_estacion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `Bicing`.`DESPLAZAMIENTOS`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Bicing`.`DESPLAZAMIENTOS` ;

CREATE TABLE IF NOT EXISTS `Bicing`.`DESPLAZAMIENTOS` (
  `Codigo_referencia` CHAR(3) NOT NULL,
  `Codigo_usuario` VARCHAR(12) NOT NULL,
  `Id_bicicleta` CHAR(3) NOT NULL,
  `Fecha inicio` DATETIME NULL,
  `Cod_estacion_ inicio` CHAR(3) NOT NULL,
  `Fecha final` DATETIME NULL DEFAULT current_timestamp,
  `Cod_estacion_final` CHAR(3) NOT NULL,
  `Tiempo_trancurrido` FLOAT NULL,
  `Importe` FLOAT NULL,
  PRIMARY KEY (`Codigo_referencia`),
  CONSTRAINT `fk_ALQUILER_ESTACIONES2`
    FOREIGN KEY (`Cod_estacion_ inicio`)
    REFERENCES `Bicing`.`ESTACIONES` (`Codigo_estacion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ALQUILER_BICICLETA1`
    FOREIGN KEY (`Id_bicicleta`)
    REFERENCES `Bicing`.`BICICLETAS` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_HISTORIAL_SERVICIO_USUARIOS1`
    FOREIGN KEY (`Codigo_usuario`)
    REFERENCES `Bicing`.`USUARIOS` (`Codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_VIAJES_ESTACIONES1`
    FOREIGN KEY (`Cod_estacion_final`)
    REFERENCES `Bicing`.`ESTACIONES` (`Codigo_estacion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `Bicing`.`Oferta_tiempo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Bicing`.`Oferta_tiempo` ;

CREATE TABLE IF NOT EXISTS `Bicing`.`Oferta_tiempo` (
  `Id` CHAR(3) NOT NULL,
  `Descripcion` VARCHAR(45) NULL,
  PRIMARY KEY (`Id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Bicing`.`Tarifa_variable`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Bicing`.`Tarifa_variable` ;

CREATE TABLE IF NOT EXISTS `Bicing`.`Tarifa_variable` (
  `Id` CHAR(4) NOT NULL,
  `Id_uso_variable` CHAR(3) NOT NULL,
  `Id_tipo_bicicleta` CHAR(3) NOT NULL,
  `Id_tarifa_fija` CHAR(4) NOT NULL,
  `Precio` FLOAT NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `fk_tipo_bicicleta_has_uso_variable_uso_variable1`
    FOREIGN KEY (`Id_uso_variable`)
    REFERENCES `Bicing`.`Oferta_tiempo` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tarifa-variable_tipo_bicicleta1`
    FOREIGN KEY (`Id_tipo_bicicleta`)
    REFERENCES `Bicing`.`Tipo_bicicleta` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tarifa-variable_Tarifa-fija1`
    FOREIGN KEY (`Id_tarifa_fija`)
    REFERENCES `Bicing`.`Tarifa_fija` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `Bicing`.`USUARIOS`
-- -----------------------------------------------------
START TRANSACTION;
USE `Bicing`;
INSERT INTO `Bicing`.`USUARIOS` (`Codigo`, `Fecha de alta`, `DNI`, `Nombre`, `Apellidos`, `Direccion`, `Numero_cta_cte`) VALUES ('C1', '2014-05-19', '23878647A', 'Juan Carlos ', 'Ramirez Ortiz', 'Av. El Tibidago 123', '124-123-147-147');
INSERT INTO `Bicing`.`USUARIOS` (`Codigo`, `Fecha de alta`, `DNI`, `Nombre`, `Apellidos`, `Direccion`, `Numero_cta_cte`) VALUES ('C2', '2013-10-29', '78541256B', 'Raquel ', 'Martinez Melgarejo', 'Calle Roma 55', '147-852-753-148');
INSERT INTO `Bicing`.`USUARIOS` (`Codigo`, `Fecha de alta`, `DNI`, `Nombre`, `Apellidos`, `Direccion`, `Numero_cta_cte`) VALUES ('C3', '2010-08-30', '14785214X', 'Miguel Angel', 'Melgarejo Manrique', 'Calle De Los Tulipanes 4', '951-753-852-471');
INSERT INTO `Bicing`.`USUARIOS` (`Codigo`, `Fecha de alta`, `DNI`, `Nombre`, `Apellidos`, `Direccion`, `Numero_cta_cte`) VALUES ('C4', '2020-01-01', '95122354D', 'Cristina Rocio', 'Salgado Sanchez', 'Calle Entença 147', '357-951-874-966');
INSERT INTO `Bicing`.`USUARIOS` (`Codigo`, `Fecha de alta`, `DNI`, `Nombre`, `Apellidos`, `Direccion`, `Numero_cta_cte`) VALUES ('C5', '2019-04-01', '98756562Q', 'Faustino Alberto', 'Muños Torres', 'Av. de los Ingenieros 84', '987-547-989-747');
INSERT INTO `Bicing`.`USUARIOS` (`Codigo`, `Fecha de alta`, `DNI`, `Nombre`, `Apellidos`, `Direccion`, `Numero_cta_cte`) VALUES ('C6', '2011-06-15', '85674566A', 'Fortunato Ezequiel', 'Torres Aguirre', 'Calle Londres 475', '988-741-877-899');
INSERT INTO `Bicing`.`USUARIOS` (`Codigo`, `Fecha de alta`, `DNI`, `Nombre`, `Apellidos`, `Direccion`, `Numero_cta_cte`) VALUES ('C7', '2022-14-15', '87454122W', 'Romulo', 'Olona Manrique', 'Travesera de Gracia', '223-475-741-888');
INSERT INTO `Bicing`.`USUARIOS` (`Codigo`, `Fecha de alta`, `DNI`, `Nombre`, `Apellidos`, `Direccion`, `Numero_cta_cte`) VALUES ('C8', '2023-01-02', '98745255S', 'Alberto Juan', 'Puigpelat Ubillus', 'Calle Urquinaona 12', '357-884-889-988');
INSERT INTO `Bicing`.`USUARIOS` (`Codigo`, `Fecha de alta`, `DNI`, `Nombre`, `Apellidos`, `Direccion`, `Numero_cta_cte`) VALUES ('C9', '2020-11-12', '98875666Y', 'Joan Pau', 'Albreda Nadal', 'Calle Segle XXI', '365-471-442-874');
INSERT INTO `Bicing`.`USUARIOS` (`Codigo`, `Fecha de alta`, `DNI`, `Nombre`, `Apellidos`, `Direccion`, `Numero_cta_cte`) VALUES ('C10', '2021-12-11', '87896545O', 'Carlota Maria', 'Mistral Santamaria', 'Calle de la Revolución', '258-758-885-987');
INSERT INTO `Bicing`.`USUARIOS` (`Codigo`, `Fecha de alta`, `DNI`, `Nombre`, `Apellidos`, `Direccion`, `Numero_cta_cte`) VALUES ('C11', '2022-12-01', '22589652Q', 'Francisca Dolores', 'Ortiz Bravo', 'Calle Madrid 101', '124-888-745-969');
INSERT INTO `Bicing`.`USUARIOS` (`Codigo`, `Fecha de alta`, `DNI`, `Nombre`, `Apellidos`, `Direccion`, `Numero_cta_cte`) VALUES ('C12', '2018-10-10', '36875547J', 'Jokin ', 'Ugarte Portillo', 'Av. de Los Corts Catalans', '668-741-855-777');
INSERT INTO `Bicing`.`USUARIOS` (`Codigo`, `Fecha de alta`, `DNI`, `Nombre`, `Apellidos`, `Direccion`, `Numero_cta_cte`) VALUES ('C13', '2022-05-04', '36875144H', 'Roque ', 'Santa Cruz', 'Calle Londres 147', '888-744-866-048');
INSERT INTO `Bicing`.`USUARIOS` (`Codigo`, `Fecha de alta`, `DNI`, `Nombre`, `Apellidos`, `Direccion`, `Numero_cta_cte`) VALUES ('C14', '2023-10-20', '21485558Y', 'Ana Maria', 'Melgarejo Pastrana', 'Calle Sepulveda 12', '325-874-697-129');

COMMIT;


-- -----------------------------------------------------
-- Data for table `Bicing`.`Tarifa_fija`
-- -----------------------------------------------------
START TRANSACTION;
USE `Bicing`;
INSERT INTO `Bicing`.`Tarifa_fija` (`Id`, `Nombre`, `Precio`) VALUES ('tf1', 'tarifa plana', 50);
INSERT INTO `Bicing`.`Tarifa_fija` (`Id`, `Nombre`, `Precio`) VALUES ('tf2', 'tarifa uso', 35);
INSERT INTO `Bicing`.`Tarifa_fija` (`Id`, `Nombre`, `Precio`) VALUES ('tf3', 'tarifa plana1', 65);
INSERT INTO `Bicing`.`Tarifa_fija` (`Id`, `Nombre`, `Precio`) VALUES ('tf4', 'tarifa uso1', 53);

COMMIT;


-- -----------------------------------------------------
-- Data for table `Bicing`.`Tipo_bicicleta`
-- -----------------------------------------------------
START TRANSACTION;
USE `Bicing`;
INSERT INTO `Bicing`.`Tipo_bicicleta` (`Id`, `Tipo_bicicleta`) VALUES ('tb1', 'bicicleta mecanica');
INSERT INTO `Bicing`.`Tipo_bicicleta` (`Id`, `Tipo_bicicleta`) VALUES ('tb2', 'bicicleta electrica');

COMMIT;


-- -----------------------------------------------------
-- Data for table `Bicing`.`BICICLETAS`
-- -----------------------------------------------------
START TRANSACTION;
USE `Bicing`;
INSERT INTO `Bicing`.`BICICLETAS` (`Id`, `Año`, `Id_tipo_bicicleta`, `Operativa`, `Codigo_estacion`, `En_uso`) VALUES ('i1', 2020, 'tb2', 1, NULL, 1);
INSERT INTO `Bicing`.`BICICLETAS` (`Id`, `Año`, `Id_tipo_bicicleta`, `Operativa`, `Codigo_estacion`, `En_uso`) VALUES ('i2', 2015, 'tb1', 0, 'E1', 0);
INSERT INTO `Bicing`.`BICICLETAS` (`Id`, `Año`, `Id_tipo_bicicleta`, `Operativa`, `Codigo_estacion`, `En_uso`) VALUES ('i3', 2022, 'tb2', 1, 'E2', 0);
INSERT INTO `Bicing`.`BICICLETAS` (`Id`, `Año`, `Id_tipo_bicicleta`, `Operativa`, `Codigo_estacion`, `En_uso`) VALUES ('i4', 2020, 'tb1', 1, 'E3', 0);
INSERT INTO `Bicing`.`BICICLETAS` (`Id`, `Año`, `Id_tipo_bicicleta`, `Operativa`, `Codigo_estacion`, `En_uso`) VALUES ('i5', 2022, 'tb2', 0, NULL, 1);
INSERT INTO `Bicing`.`BICICLETAS` (`Id`, `Año`, `Id_tipo_bicicleta`, `Operativa`, `Codigo_estacion`, `En_uso`) VALUES ('i6', 2010, 'tb1', 1, 'E4', 0);
INSERT INTO `Bicing`.`BICICLETAS` (`Id`, `Año`, `Id_tipo_bicicleta`, `Operativa`, `Codigo_estacion`, `En_uso`) VALUES ('i7', 2023, 'tb2', 1, 'E5', 0);
INSERT INTO `Bicing`.`BICICLETAS` (`Id`, `Año`, `Id_tipo_bicicleta`, `Operativa`, `Codigo_estacion`, `En_uso`) VALUES ('i8', 2020, 'tb1', 1, NULL, 1);
INSERT INTO `Bicing`.`BICICLETAS` (`Id`, `Año`, `Id_tipo_bicicleta`, `Operativa`, `Codigo_estacion`, `En_uso`) VALUES ('i9', 2010, 'tb2', 1, NULL, 1);
INSERT INTO `Bicing`.`BICICLETAS` (`Id`, `Año`, `Id_tipo_bicicleta`, `Operativa`, `Codigo_estacion`, `En_uso`) VALUES ('i10', 2019, 'tb1', 0, NULL, NULL);
INSERT INTO `Bicing`.`BICICLETAS` (`Id`, `Año`, `Id_tipo_bicicleta`, `Operativa`, `Codigo_estacion`, `En_uso`) VALUES ('i11', 2018, 'tb2', 0, NULL, NULL);
INSERT INTO `Bicing`.`BICICLETAS` (`Id`, `Año`, `Id_tipo_bicicleta`, `Operativa`, `Codigo_estacion`, `En_uso`) VALUES ('i13', 2020, 'tb1', 0, NULL, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `Bicing`.`ESTACIONES`
-- -----------------------------------------------------
START TRANSACTION;
USE `Bicing`;
INSERT INTO `Bicing`.`ESTACIONES` (`Codigo_estacion`, `Nombre`, `Direccion`, `Capacidad`) VALUES ('E1', 'Navas de Tolosa', 'Av. Republica Argentina 131', 20);
INSERT INTO `Bicing`.`ESTACIONES` (`Codigo_estacion`, `Nombre`, `Direccion`, `Capacidad`) VALUES ('E2 ', 'El Bruc', 'Calle Paralel 250', 23);
INSERT INTO `Bicing`.`ESTACIONES` (`Codigo_estacion`, `Nombre`, `Direccion`, `Capacidad`) VALUES ('E3', 'Sarría', 'Av. La Bonanova 211', 12);
INSERT INTO `Bicing`.`ESTACIONES` (`Codigo_estacion`, `Nombre`, `Direccion`, `Capacidad`) VALUES ('E4', 'Les Corts', 'Calle Berlin 123', 19);
INSERT INTO `Bicing`.`ESTACIONES` (`Codigo_estacion`, `Nombre`, `Direccion`, `Capacidad`) VALUES ('E5', 'Sant Gervacio', 'Calle Balmes 389', 29);
INSERT INTO `Bicing`.`ESTACIONES` (`Codigo_estacion`, `Nombre`, `Direccion`, `Capacidad`) VALUES ('E6', 'Sant Andreu', 'Av. La Merdidiana', 30);
INSERT INTO `Bicing`.`ESTACIONES` (`Codigo_estacion`, `Nombre`, `Direccion`, `Capacidad`) VALUES ('E7', 'Poble Nou', 'Calle Tamarit 101', 28);
INSERT INTO `Bicing`.`ESTACIONES` (`Codigo_estacion`, `Nombre`, `Direccion`, `Capacidad`) VALUES ('E8', 'L\' Eixample de L\'Esquerra', 'Av. Diagonal 584', 45);
INSERT INTO `Bicing`.`ESTACIONES` (`Codigo_estacion`, `Nombre`, `Direccion`, `Capacidad`) VALUES ('E9', 'El Clot', 'Calle Bilbao 187', 23);

COMMIT;


-- -----------------------------------------------------
-- Data for table `Bicing`.`Oferta_tiempo`
-- -----------------------------------------------------
START TRANSACTION;
USE `Bicing`;
INSERT INTO `Bicing`.`Oferta_tiempo` (`Id`, `Descripcion`) VALUES ('ot1', 'Primeros 30 min');
INSERT INTO `Bicing`.`Oferta_tiempo` (`Id`, `Descripcion`) VALUES ('ot2', '30 min - 2 horas');
INSERT INTO `Bicing`.`Oferta_tiempo` (`Id`, `Descripcion`) VALUES ('ot3', 'mas de 2 horas');

COMMIT;


-- -----------------------------------------------------
-- Data for table `Bicing`.`Tarifa_variable`
-- -----------------------------------------------------
START TRANSACTION;
USE `Bicing`;
INSERT INTO `Bicing`.`Tarifa_variable` (`Id`, `Id_uso_variable`, `Id_tipo_bicicleta`, `Id_tarifa_fija`, `Precio`) VALUES ('tv1', 'ot1', 'tb1', 'tf1', 0);
INSERT INTO `Bicing`.`Tarifa_variable` (`Id`, `Id_uso_variable`, `Id_tipo_bicicleta`, `Id_tarifa_fija`, `Precio`) VALUES ('tv2', 'ot1', 'tb2', 'tf1', 0.35);
INSERT INTO `Bicing`.`Tarifa_variable` (`Id`, `Id_uso_variable`, `Id_tipo_bicicleta`, `Id_tarifa_fija`, `Precio`) VALUES ('tv3', 'ot1', 'tb1', 'tf2', 0.35);
INSERT INTO `Bicing`.`Tarifa_variable` (`Id`, `Id_uso_variable`, `Id_tipo_bicicleta`, `Id_tarifa_fija`, `Precio`) VALUES ('tv4', 'ot1', 'tb2', 'tf2', 0.55);
INSERT INTO `Bicing`.`Tarifa_variable` (`Id`, `Id_uso_variable`, `Id_tipo_bicicleta`, `Id_tarifa_fija`, `Precio`) VALUES ('tv5', 'ot1', 'tb1', 'tf3', 0);
INSERT INTO `Bicing`.`Tarifa_variable` (`Id`, `Id_uso_variable`, `Id_tipo_bicicleta`, `Id_tarifa_fija`, `Precio`) VALUES ('tv6', 'ot1', 'tb2', 'tf3', 0.35);
INSERT INTO `Bicing`.`Tarifa_variable` (`Id`, `Id_uso_variable`, `Id_tipo_bicicleta`, `Id_tarifa_fija`, `Precio`) VALUES ('tv7', 'ot1', 'tb1', 'tf4', 0.35);
INSERT INTO `Bicing`.`Tarifa_variable` (`Id`, `Id_uso_variable`, `Id_tipo_bicicleta`, `Id_tarifa_fija`, `Precio`) VALUES ('tv8', 'ot1', 'tb2', 'tf4', 0.55);
INSERT INTO `Bicing`.`Tarifa_variable` (`Id`, `Id_uso_variable`, `Id_tipo_bicicleta`, `Id_tarifa_fija`, `Precio`) VALUES ('tv9', 'ot2', 'tb1', 'tf1', 0.70);
INSERT INTO `Bicing`.`Tarifa_variable` (`Id`, `Id_uso_variable`, `Id_tipo_bicicleta`, `Id_tarifa_fija`, `Precio`) VALUES ('tv10', 'ot2', 'tb2', 'tf1', 0.90);
INSERT INTO `Bicing`.`Tarifa_variable` (`Id`, `Id_uso_variable`, `Id_tipo_bicicleta`, `Id_tarifa_fija`, `Precio`) VALUES ('tv11', 'ot2', 'tb1', 'tf2', 0.70);
INSERT INTO `Bicing`.`Tarifa_variable` (`Id`, `Id_uso_variable`, `Id_tipo_bicicleta`, `Id_tarifa_fija`, `Precio`) VALUES ('tv12', 'ot2', 'tb2', 'tf2', 0.90);
INSERT INTO `Bicing`.`Tarifa_variable` (`Id`, `Id_uso_variable`, `Id_tipo_bicicleta`, `Id_tarifa_fija`, `Precio`) VALUES ('tv13', 'ot2', 'tb1', 'tf3', 0.70);
INSERT INTO `Bicing`.`Tarifa_variable` (`Id`, `Id_uso_variable`, `Id_tipo_bicicleta`, `Id_tarifa_fija`, `Precio`) VALUES ('tv14', 'ot2', 'tb2', 'tf3', 0.90);
INSERT INTO `Bicing`.`Tarifa_variable` (`Id`, `Id_uso_variable`, `Id_tipo_bicicleta`, `Id_tarifa_fija`, `Precio`) VALUES ('tv15', 'ot2', 'tb1', 'tf4', 0.70);
INSERT INTO `Bicing`.`Tarifa_variable` (`Id`, `Id_uso_variable`, `Id_tipo_bicicleta`, `Id_tarifa_fija`, `Precio`) VALUES ('tv16', 'ot2', 'tb2', 'tf4', 0.90);
INSERT INTO `Bicing`.`Tarifa_variable` (`Id`, `Id_uso_variable`, `Id_tipo_bicicleta`, `Id_tarifa_fija`, `Precio`) VALUES ('tv17', 'ot3', 'tb1', 'tf1', 5);
INSERT INTO `Bicing`.`Tarifa_variable` (`Id`, `Id_uso_variable`, `Id_tipo_bicicleta`, `Id_tarifa_fija`, `Precio`) VALUES ('tv18', 'ot3', 'tb2', 'tf1', 5);
INSERT INTO `Bicing`.`Tarifa_variable` (`Id`, `Id_uso_variable`, `Id_tipo_bicicleta`, `Id_tarifa_fija`, `Precio`) VALUES ('tv19', 'ot3', 'tb1', 'tf2', 5);
INSERT INTO `Bicing`.`Tarifa_variable` (`Id`, `Id_uso_variable`, `Id_tipo_bicicleta`, `Id_tarifa_fija`, `Precio`) VALUES ('tv20', 'ot3', 'tb2', 'tf2', 5);
INSERT INTO `Bicing`.`Tarifa_variable` (`Id`, `Id_uso_variable`, `Id_tipo_bicicleta`, `Id_tarifa_fija`, `Precio`) VALUES ('tv21', 'ot3', 'tb1', 'tf3', 5);
INSERT INTO `Bicing`.`Tarifa_variable` (`Id`, `Id_uso_variable`, `Id_tipo_bicicleta`, `Id_tarifa_fija`, `Precio`) VALUES ('tv22', 'ot3', 'tb2', 'tf3', 5);
INSERT INTO `Bicing`.`Tarifa_variable` (`Id`, `Id_uso_variable`, `Id_tipo_bicicleta`, `Id_tarifa_fija`, `Precio`) VALUES ('tv23', 'ot3', 'tb1', 'tf4', 5);
INSERT INTO `Bicing`.`Tarifa_variable` (`Id`, `Id_uso_variable`, `Id_tipo_bicicleta`, `Id_tarifa_fija`, `Precio`) VALUES ('tv24', 'ot3', 'tb2', 'tf4', 5);

COMMIT;

