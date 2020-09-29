-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema `bbizfi645vxrhsytpxjo`
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `bbizfi645vxrhsytpxjo` ;

-- -----------------------------------------------------
-- Schema `bbizfi645vxrhsytpxjo`
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `bbizfi645vxrhsytpxjo` DEFAULT CHARACTER SET utf8 ;
USE `bbizfi645vxrhsytpxjo` ;

-- -----------------------------------------------------
-- Table ``bbizfi645vxrhsytpxjo``.`dispensaimpedimentos`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bbizfi645vxrhsytpxjo`.`dispensaimpedimentos` ;

CREATE TABLE IF NOT EXISTS `bbizfi645vxrhsytpxjo`.`dispensaimpedimentos` (
  `activo` VARCHAR(1) NOT NULL DEFAULT 'S',
  `idDispensaImpedimentos` INT(11) NOT NULL AUTO_INCREMENT,
  `numeroExpediente` VARCHAR(10) NULL DEFAULT NULL,
  `fechaExpediente` DATE NOT NULL,
  `parroquia` VARCHAR(100) NULL DEFAULT NULL,
  `apellidosNovio` VARCHAR(50) NULL DEFAULT NULL,
  `nombresNovio` VARCHAR(50) NULL DEFAULT NULL,
  `apellidosNovia` VARCHAR(50) NULL DEFAULT NULL,
  `nombresNovia` VARCHAR(50) NULL DEFAULT NULL,
  `impedimento1` VARCHAR(50) NULL DEFAULT NULL,
  `impedimento2` VARCHAR(80) NULL DEFAULT NULL,
  `causal` VARCHAR(100) NULL DEFAULT NULL,
  `fechaAutorizacion` DATE NULL DEFAULT NULL,
  `vicario` VARCHAR(50) NULL DEFAULT NULL,
  `observacion1` VARCHAR(100) NULL DEFAULT NULL,
  `observacion2` VARCHAR(100) NULL DEFAULT NULL,
  `creado` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `creado_usuario` VARCHAR(10) NULL DEFAULT NULL,
  `modificado` DATETIME NULL DEFAULT NULL,
  `modificado_usuario` VARCHAR(10) NULL DEFAULT NULL,
  `eliminado` DATETIME NULL DEFAULT NULL,
  `eliminado_usuario` VARCHAR(10) NULL DEFAULT NULL,
  PRIMARY KEY (`idDispensaImpedimentos`))
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table ``bbizfi645vxrhsytpxjo``.`dispensapartidab`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bbizfi645vxrhsytpxjo`.`dispensapartidab` ;

CREATE TABLE IF NOT EXISTS `bbizfi645vxrhsytpxjo`.`dispensapartidab` (
  `activo` VARCHAR(1) NOT NULL DEFAULT 'S',
  `idDispensaPartidaB` INT(11) NOT NULL AUTO_INCREMENT,
  `numeroExpediente` VARCHAR(10) NULL DEFAULT NULL,
  `fechaExpediente` DATE NULL DEFAULT NULL,
  `parroquia` VARCHAR(100) NULL DEFAULT NULL,
  `apellidosDispensado` VARCHAR(50) NULL DEFAULT NULL,
  `nombresDispensado` VARCHAR(50) NULL DEFAULT NULL,
  `sexo` VARCHAR(1) NULL DEFAULT NULL,
  `fechaBauDispensado` DATE NULL DEFAULT NULL,
  `parroquiaBauDispensado` VARCHAR(100) NULL DEFAULT NULL,
  `diocesisDispensado` VARCHAR(100) NULL DEFAULT NULL,
  `apellidosContrayente` VARCHAR(50) NULL DEFAULT NULL,
  `nombresContrayente` VARCHAR(50) NULL DEFAULT NULL,
  `fechaBauContrayente` DATE NULL DEFAULT NULL,
  `parroquiaBauContrayente` VARCHAR(100) NULL DEFAULT NULL,
  `diocesisContrayente` VARCHAR(100) NULL DEFAULT NULL,
  `diligencia1` VARCHAR(100) NULL DEFAULT NULL,
  `diligencia2` VARCHAR(100) NULL DEFAULT NULL,
  `razones1` VARCHAR(100) NULL DEFAULT NULL,
  `razones2` VARCHAR(100) NULL DEFAULT NULL,
  `procedimiento1` VARCHAR(100) NULL DEFAULT NULL,
  `procedimiento2` VARCHAR(100) NULL DEFAULT NULL,
  `fechaAutorizacion` DATE NULL DEFAULT NULL,
  `vicario` VARCHAR(50) NULL DEFAULT NULL,
  `creado` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `creado_usuario` VARCHAR(10) NULL DEFAULT NULL,
  `modificado` DATETIME NULL DEFAULT NULL,
  `modificado_usuario` VARCHAR(10) NULL DEFAULT NULL,
  `eliminado` DATETIME NULL DEFAULT NULL,
  `eliminado_usuario` VARCHAR(10) NULL DEFAULT NULL,
  PRIMARY KEY (`idDispensaPartidaB`))
ENGINE = InnoDB
AUTO_INCREMENT = 5
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table ``bbizfi645vxrhsytpxjo``.`dispensaproclamas`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bbizfi645vxrhsytpxjo`.`dispensaproclamas` ;

CREATE TABLE IF NOT EXISTS `bbizfi645vxrhsytpxjo`.`dispensaproclamas` (
  `activo` VARCHAR(1) NOT NULL DEFAULT 'S',
  `idDispensaProclamas` INT(11) NOT NULL AUTO_INCREMENT,
  `numeroExpediente` VARCHAR(10) NULL DEFAULT NULL,
  `fechaExpediente` DATE NULL DEFAULT NULL,
  `parroquia` VARCHAR(100) NULL DEFAULT NULL,
  `apellidosNovio` VARCHAR(50) NULL DEFAULT NULL,
  `nombresNovio` VARCHAR(50) NULL DEFAULT NULL,
  `apellidosNovia` VARCHAR(50) NULL DEFAULT NULL,
  `nombresNovia` VARCHAR(50) NULL DEFAULT NULL,
  `numeroDispensa` VARCHAR(10) NULL DEFAULT NULL,
  `fechaAutorizacion` DATE NULL DEFAULT NULL,
  `vicario` VARCHAR(50) NULL DEFAULT NULL,
  `observacion1` VARCHAR(100) NULL DEFAULT NULL,
  `observacion2` VARCHAR(100) NULL DEFAULT NULL,
  `creado` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `creado_usuario` VARCHAR(10) NULL DEFAULT NULL,
  `modificado` DATETIME NULL DEFAULT NULL,
  `modificado_usuario` VARCHAR(10) NULL DEFAULT NULL,
  `eliminado` DATETIME NULL DEFAULT NULL,
  `eliminado_usuario` VARCHAR(10) NULL DEFAULT NULL,
  PRIMARY KEY (`idDispensaProclamas`))
ENGINE = InnoDB
AUTO_INCREMENT = 5
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table ``bbizfi645vxrhsytpxjo``.`licenciabautismo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bbizfi645vxrhsytpxjo`.`licenciabautismo` ;

CREATE TABLE IF NOT EXISTS `bbizfi645vxrhsytpxjo`.`licenciabautismo` (
  `activo` VARCHAR(1) NOT NULL DEFAULT 'S',
  `idLicenciaBautismo` INT(11) NOT NULL AUTO_INCREMENT,
  `numeroExpediente` VARCHAR(10) NULL DEFAULT NULL,
  `fechaExpediente` DATE NULL DEFAULT NULL,
  `parroquiaBautizo` VARCHAR(100) NOT NULL,
  `apellidos` VARCHAR(50) NULL DEFAULT NULL,
  `nombres` VARCHAR(50) NULL DEFAULT NULL,
  `edad` INT(3) NULL DEFAULT '0',
  `lugarNacimiento` VARCHAR(50) NULL DEFAULT NULL,
  `direccion` VARCHAR(100) NULL DEFAULT NULL,
  `documentoAcredita` VARCHAR(50) NULL DEFAULT NULL,
  `tiempoIns` VARCHAR(100) NULL DEFAULT NULL,
  `testigo1` VARCHAR(50) NULL DEFAULT NULL,
  `parentesco1` VARCHAR(30) NULL DEFAULT NULL,
  `testigo2` VARCHAR(50) NULL DEFAULT NULL,
  `parentesco2` VARCHAR(30) NULL DEFAULT NULL,
  `fechaAutorizacion` DATE NULL DEFAULT NULL,
  `vicario` VARCHAR(50) NULL DEFAULT NULL,
  `observaciones1` VARCHAR(100) NULL DEFAULT NULL,
  `observaciones2` VARCHAR(100) NULL DEFAULT NULL,
  `creado` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `creado_usuario` VARCHAR(10) NULL DEFAULT NULL,
  `modificado` DATETIME NULL DEFAULT NULL,
  `modificado_usuario` VARCHAR(10) NULL DEFAULT NULL,
  `eliminado` DATETIME NULL DEFAULT NULL,
  `eliminado_usuario` VARCHAR(10) NULL DEFAULT NULL,
  PRIMARY KEY (`idLicenciaBautismo`))
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table ``bbizfi645vxrhsytpxjo``.`licenciatraslado`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bbizfi645vxrhsytpxjo`.`licenciatraslado` ;

CREATE TABLE IF NOT EXISTS `bbizfi645vxrhsytpxjo`.`licenciatraslado` (
  `activo` VARCHAR(1) NOT NULL DEFAULT 'S',
  `idLicenciaTraslado` INT(11) NOT NULL AUTO_INCREMENT,
  `numeroExpediente` VARCHAR(10) NOT NULL,
  `fechaExpediente` DATE NOT NULL,
  `diocesisOrigen` VARCHAR(100) NULL DEFAULT NULL,
  `parroquiaOrigen` VARCHAR(100) NULL DEFAULT NULL,
  `parroquiaDestino` VARCHAR(100) NULL DEFAULT NULL,
  `parroquiaMatrimonio` VARCHAR(100) NULL DEFAULT NULL,
  `apellidosNovia` VARCHAR(50) NULL DEFAULT NULL,
  `nombresNovia` VARCHAR(50) NULL DEFAULT NULL,
  `direccionNovia` VARCHAR(100) NULL DEFAULT NULL,
  `padreNovia` VARCHAR(50) NULL DEFAULT NULL,
  `madreNovia` VARCHAR(50) NULL DEFAULT NULL,
  `fechaBauNovia` DATE NULL DEFAULT NULL,
  `parroquiaBauNovia` VARCHAR(100) NULL DEFAULT NULL,
  `apellidosNovio` VARCHAR(50) NULL DEFAULT NULL,
  `nombresNovio` VARCHAR(50) NULL DEFAULT NULL,
  `direccionNovio` VARCHAR(100) NULL DEFAULT NULL,
  `padreNovio` VARCHAR(50) NULL DEFAULT NULL,
  `madreNovio` VARCHAR(50) NULL DEFAULT NULL,
  `fechaBauNovio` DATE NULL DEFAULT NULL,
  `parroquiaBauNovio` VARCHAR(100) NULL DEFAULT NULL,
  `fechaMatCivil` DATE NULL DEFAULT NULL,
  `fechaMatReligioso` DATE NULL DEFAULT NULL,
  `fechaAutorizacion` DATE NULL DEFAULT NULL,
  `vicario` VARCHAR(50) NULL DEFAULT NULL,
  `cabecera1` VARCHAR(100) NULL DEFAULT NULL,
  `cabecera2` VARCHAR(100) NULL DEFAULT NULL,
  `creado` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `creado_usuario` VARCHAR(10) NULL DEFAULT NULL,
  `modificado` DATETIME NULL DEFAULT NULL,
  `modificado_usuario` VARCHAR(10) NULL DEFAULT NULL,
  `eliminado` DATETIME NULL DEFAULT NULL,
  `eliminado_usuario` VARCHAR(10) NULL DEFAULT NULL,
  PRIMARY KEY (`idLicenciaTraslado`))
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table ``bbizfi645vxrhsytpxjo``.`mediopliego`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bbizfi645vxrhsytpxjo`.`mediopliego` ;

CREATE TABLE IF NOT EXISTS `bbizfi645vxrhsytpxjo`.`mediopliego` (
  `activo` VARCHAR(1) NOT NULL DEFAULT 'S',
  `idMedioPliego` INT(11) NOT NULL AUTO_INCREMENT,
  `numeroExpediente` VARCHAR(10) NULL DEFAULT NULL,
  `fechaExpediente` DATE NOT NULL,
  `diocesisOrigen` VARCHAR(100) NULL DEFAULT NULL,
  `parroquiaOrigen` VARCHAR(100) NULL DEFAULT NULL,
  `diocesisDestino` VARCHAR(100) NULL DEFAULT NULL,
  `parroquiaMatrimonio` VARCHAR(100) NULL DEFAULT NULL,
  `apellidosNovia` VARCHAR(50) NULL DEFAULT NULL,
  `nombresNovia` VARCHAR(50) NULL DEFAULT NULL,
  `direccionNovia` VARCHAR(100) NULL DEFAULT NULL,
  `padreNovia` VARCHAR(50) NULL DEFAULT NULL,
  `madreNovia` VARCHAR(50) NULL DEFAULT NULL,
  `fechaBauNovia` DATE NULL DEFAULT NULL,
  `parroquiaBauNovia` VARCHAR(100) NULL DEFAULT NULL,
  `apellidosNovio` VARCHAR(50) NULL DEFAULT NULL,
  `nombresNovio` VARCHAR(50) NULL DEFAULT NULL,
  `direccionNovio` VARCHAR(100) NULL DEFAULT NULL,
  `padreNovio` VARCHAR(50) NULL DEFAULT NULL,
  `madreNovio` VARCHAR(50) NULL DEFAULT NULL,
  `fechaBauNovio` DATE NULL DEFAULT NULL,
  `parroquiaBauNovio` VARCHAR(100) NULL DEFAULT NULL,
  `fechaMatCivil` DATE NULL DEFAULT NULL,
  `fechaMatReligioso` DATE NULL DEFAULT NULL,
  `fechaAutorizacion` DATE NULL DEFAULT NULL,
  `vicario` VARCHAR(50) NULL DEFAULT NULL,
  `cabecera` VARCHAR(100) NULL DEFAULT NULL,
  `observacion1` VARCHAR(100) NULL DEFAULT NULL,
  `observacion2` VARCHAR(100) NULL DEFAULT NULL,
  `creado` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `creado_usuario` VARCHAR(10) NULL DEFAULT NULL,
  `modificado` DATETIME NULL DEFAULT NULL,
  `modificado_usuario` VARCHAR(10) NULL DEFAULT NULL,
  `eliminado` DATETIME NULL DEFAULT NULL,
  `eliminado_usuario` VARCHAR(10) NULL DEFAULT NULL,
  PRIMARY KEY (`idMedioPliego`))
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table ``bbizfi645vxrhsytpxjo``.`pliegomatrimonial`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bbizfi645vxrhsytpxjo`.`pliegomatrimonial` ;

CREATE TABLE IF NOT EXISTS `bbizfi645vxrhsytpxjo`.`pliegomatrimonial` (
  `activo` VARCHAR(1) NOT NULL DEFAULT 'S',
  `idPMatrimonial` INT(11) NOT NULL AUTO_INCREMENT,
  `numeroExpediente` VARCHAR(10) NULL DEFAULT NULL,
  `fechaExpediente` DATE NOT NULL,
  `diocesisOrigen` VARCHAR(100) NULL DEFAULT NULL,
  `parroquiaCelebracion` VARCHAR(100) NULL DEFAULT NULL,
  `apellidosNovia` VARCHAR(50) NULL DEFAULT NULL,
  `nombresNovia` VARCHAR(50) NULL DEFAULT NULL,
  `direccionNovia` VARCHAR(100) NULL DEFAULT NULL,
  `padreNovia` VARCHAR(50) NULL DEFAULT NULL,
  `madreNovia` VARCHAR(50) NULL DEFAULT NULL,
  `fechaBauNovia` DATE NULL DEFAULT NULL,
  `parroquiaBauNovia` VARCHAR(100) NULL DEFAULT NULL,
  `apellidosNovio` VARCHAR(50) NULL DEFAULT NULL,
  `nombresNovio` VARCHAR(50) NULL DEFAULT NULL,
  `direccionNovio` VARCHAR(100) NULL DEFAULT NULL,
  `padreNovio` VARCHAR(50) NULL DEFAULT NULL,
  `madreNovio` VARCHAR(50) NULL DEFAULT NULL,
  `fechaBauNovio` DATE NULL DEFAULT NULL,
  `parroquiaBauNovio` VARCHAR(100) NULL DEFAULT NULL,
  `fechaMatCivil` DATE NULL DEFAULT NULL,
  `fechaMatReligioso` DATE NULL DEFAULT NULL,
  `fechaAutorizacion` DATE NULL DEFAULT NULL,
  `vicario` VARCHAR(50) NULL DEFAULT NULL,
  `cabecera1` VARCHAR(100) NULL DEFAULT NULL,
  `cabecera2` VARCHAR(100) NULL DEFAULT NULL,
  `observaciones1` VARCHAR(100) NULL DEFAULT NULL,
  `observaciones2` VARCHAR(100) NULL DEFAULT NULL,
  `creado` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `creado_usuario` VARCHAR(10) NULL DEFAULT NULL,
  `modificado` DATETIME NULL DEFAULT NULL,
  `modificado_usuario` VARCHAR(10) NULL DEFAULT NULL,
  `eliminado` DATETIME NULL DEFAULT NULL,
  `eliminado_usuario` VARCHAR(10) NULL DEFAULT NULL,
  PRIMARY KEY (`idPMatrimonial`))
ENGINE = InnoDB
AUTO_INCREMENT = 10
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table ``bbizfi645vxrhsytpxjo``.`usuarios`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bbizfi645vxrhsytpxjo`.`usuarios` ;

CREATE TABLE IF NOT EXISTS `bbizfi645vxrhsytpxjo`.`usuarios` (
  `activo` VARCHAR(1) NOT NULL DEFAULT 'S',
  `usuario` VARCHAR(10) NOT NULL,
  `nombreUsuario` VARCHAR(40) NOT NULL,
  `clave` VARCHAR(10) NOT NULL,
  `rolUsuario` VARCHAR(15) NOT NULL,
  `codInstitucion` VARCHAR(5) NULL DEFAULT NULL,
  `email` VARCHAR(30) NULL DEFAULT NULL,
  `movil` VARCHAR(10) NULL DEFAULT NULL,
  `creado` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `creado_usuario` VARCHAR(10) NULL DEFAULT NULL,
  `modificado` DATETIME NULL DEFAULT NULL,
  `modificado_usuario` VARCHAR(10) NULL DEFAULT NULL,
  `eliminado` DATETIME NULL DEFAULT NULL,
  `eliminado_usuario` VARCHAR(10) NULL DEFAULT NULL,
  PRIMARY KEY (`usuario`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
