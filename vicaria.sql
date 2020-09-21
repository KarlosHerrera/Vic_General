-- MySQL dump 10.13  Distrib 8.0.17, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: vicaria
-- ------------------------------------------------------
-- Server version	8.0.17

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `dispensaimpedimentos`
--

DROP TABLE IF EXISTS `dispensaimpedimentos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dispensaimpedimentos` (
  `activo` varchar(1) NOT NULL DEFAULT 'S',
  `idDispensaImpedimentos` int(11) NOT NULL AUTO_INCREMENT,
  `numeroExpediente` varchar(10) DEFAULT NULL,
  `fechaExpediente` date DEFAULT NULL,
  `parroquia` varchar(100) DEFAULT NULL,
  `apellidosNovio` varchar(50) DEFAULT NULL,
  `nombresNovio` varchar(50) DEFAULT NULL,
  `apellidosNovia` varchar(50) DEFAULT NULL,
  `nombresNovia` varchar(50) DEFAULT NULL,
  `impedimento1` varchar(50) DEFAULT NULL,
  `impedimento2` varchar(50) DEFAULT NULL,
  `causal` varchar(100) DEFAULT NULL,
  `fechaAutorizacion` date DEFAULT NULL,
  `vicario` varchar(50) DEFAULT NULL,
  `observacion` varchar(100) DEFAULT NULL,
  `creado` datetime DEFAULT CURRENT_TIMESTAMP,
  `creado_usuario` varchar(10) DEFAULT NULL,
  `modificado` datetime DEFAULT NULL,
  `modificado_usuario` varchar(10) DEFAULT NULL,
  `eliminado` datetime DEFAULT NULL,
  `eliminado_usuario` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`idDispensaImpedimentos`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dispensapartidab`
--

DROP TABLE IF EXISTS `dispensapartidab`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dispensapartidab` (
  `activo` varchar(1) NOT NULL DEFAULT 'S',
  `idDispensaPartidaB` int(11) NOT NULL AUTO_INCREMENT,
  `numeroExpediente` varchar(10) DEFAULT NULL,
  `fechaExpediente` date DEFAULT NULL,
  `parroquia` varchar(100) DEFAULT NULL,
  `apellidoDispensado` varchar(50) DEFAULT NULL,
  `nombreDispensado` varchar(50) DEFAULT NULL,
  `sexo` varchar(1) DEFAULT NULL,
  `fechaBauDispensado` date DEFAULT NULL,
  `parroquiaBauDispensado` varchar(100) DEFAULT NULL,
  `diocesisDispensado` varchar(100) DEFAULT NULL,
  `apellidoContrayente` varchar(50) DEFAULT NULL,
  `nombreContrayente` varchar(50) DEFAULT NULL,
  `fechaBauContrayente` date DEFAULT NULL,
  `parroquiaBauContrayente` varchar(100) DEFAULT NULL,
  `diocesisContrayente` varchar(100) DEFAULT NULL,
  `diligencia1` varchar(100) DEFAULT NULL,
  `diligencia2` varchar(100) DEFAULT NULL,
  `razones1` varchar(100) DEFAULT NULL,
  `razones2` varchar(100) DEFAULT NULL,
  `procedimiento1` varchar(100) DEFAULT NULL,
  `procedimiento2` varchar(100) DEFAULT NULL,
  `fechaAutoriza` date DEFAULT NULL,
  `vicario` varchar(50) DEFAULT NULL,
  `creado` datetime DEFAULT CURRENT_TIMESTAMP,
  `creado_usuario` varchar(10) DEFAULT NULL,
  `modificado` datetime DEFAULT NULL,
  `modificado_usuario` varchar(10) DEFAULT NULL,
  `eliminado` datetime DEFAULT NULL,
  `eliminado_usuario` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`idDispensaPartidaB`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dispensaproclamas`
--

DROP TABLE IF EXISTS `dispensaproclamas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dispensaproclamas` (
  `activo` varchar(1) NOT NULL DEFAULT 'S',
  `idDispensaProclamas` int(11) NOT NULL AUTO_INCREMENT,
  `numeroExpediente` varchar(10) DEFAULT NULL,
  `fechaExpediente` date DEFAULT NULL,
  `parroquia` varchar(100) DEFAULT NULL,
  `apellidosNovio` varchar(50) DEFAULT NULL,
  `nombresNovio` varchar(50) DEFAULT NULL,
  `apellidosNovia` varchar(50) DEFAULT NULL,
  `nombresNovia` varchar(50) DEFAULT NULL,
  `numeroDispensas` varchar(10) DEFAULT NULL,
  `fechaAutorizacion` date DEFAULT NULL,
  `vicario` varchar(50) DEFAULT NULL,
  `observaciones1` varchar(100) DEFAULT NULL,
  `observaciones2` varchar(100) DEFAULT NULL,
  `creado` datetime DEFAULT CURRENT_TIMESTAMP,
  `creado_usuario` varchar(10) DEFAULT NULL,
  `modificado` datetime DEFAULT NULL,
  `modificado_usuario` varchar(10) DEFAULT NULL,
  `eliminado` datetime DEFAULT NULL,
  `eliminado_usuario` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`idDispensaProclamas`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `licenciabautismo`
--

DROP TABLE IF EXISTS `licenciabautismo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `licenciabautismo` (
  `activo` varchar(1) NOT NULL DEFAULT 'S',
  `idLicenciaBautismo` int(11) NOT NULL AUTO_INCREMENT,
  `numeroExpediente` varchar(10) DEFAULT NULL,
  `fechaExpediente` date DEFAULT NULL,
  `parroquia` varchar(100) DEFAULT NULL,
  `apellidos` varchar(50) DEFAULT NULL,
  `nombres` varchar(50) DEFAULT NULL,
  `edad` int(3) DEFAULT NULL,
  `lugarNacimiento` varchar(50) DEFAULT NULL,
  `direccion` varchar(100) DEFAULT NULL,
  `documentoAcredita` varchar(50) DEFAULT NULL,
  `tiempoIns` varchar(100) DEFAULT NULL,
  `testigo1` varchar(50) DEFAULT NULL,
  `parentesco1` varchar(50) DEFAULT NULL,
  `testigo2` varchar(50) DEFAULT NULL,
  `parentesco2` varchar(50) DEFAULT NULL,
  `fechaAutoriza` date DEFAULT NULL,
  `vicario` varchar(50) DEFAULT NULL,
  `observaciones1` varchar(100) DEFAULT NULL,
  `observaciones2` varchar(100) DEFAULT NULL,
  `creado` datetime DEFAULT CURRENT_TIMESTAMP,
  `creado_usuario` varchar(10) DEFAULT NULL,
  `modificado` datetime DEFAULT NULL,
  `modificado_usuario` varchar(45) DEFAULT NULL,
  `eliminado` datetime DEFAULT NULL,
  `eliminado_usuario` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`idLicenciaBautismo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `licenciatraslado`
--

DROP TABLE IF EXISTS `licenciatraslado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `licenciatraslado` (
  `activo` varchar(1) NOT NULL DEFAULT 'S',
  `idMedioPliego` int(11) NOT NULL AUTO_INCREMENT,
  `numeroExpediente` varchar(10) DEFAULT NULL,
  `diocesisOrigen` varchar(100) DEFAULT NULL,
  `parroquiaOrigen` varchar(100) DEFAULT NULL,
  `diocesisDestino` varchar(100) DEFAULT NULL,
  `parroquiaMatrimonio` varchar(100) DEFAULT NULL,
  `apellidosNovia` varchar(50) DEFAULT NULL,
  `nombresNovia` varchar(50) DEFAULT NULL,
  `direccionNovia` varchar(100) DEFAULT NULL,
  `padreNovia` varchar(50) DEFAULT NULL,
  `madreNovia` varchar(50) DEFAULT NULL,
  `fecBauNovia` date DEFAULT NULL,
  `parrBauNovia` varchar(100) DEFAULT NULL,
  `apellidosNovio` varchar(50) DEFAULT NULL,
  `nombresNovio` varchar(50) DEFAULT NULL,
  `direccionNovio` varchar(100) DEFAULT NULL,
  `padreNovio` varchar(50) DEFAULT NULL,
  `madreNovio` varchar(50) DEFAULT NULL,
  `fechaBauNovio` date DEFAULT NULL,
  `parrBauNovio` varchar(100) DEFAULT NULL,
  `fechaMatCivil` date DEFAULT NULL,
  `fechaMatReligioso` date DEFAULT NULL,
  `fechaAutoriza` date DEFAULT NULL,
  `vicario` varchar(50) DEFAULT NULL,
  `cabecera1` varchar(100) DEFAULT NULL,
  `cabecera2` varchar(100) DEFAULT NULL,
  `creado` datetime DEFAULT CURRENT_TIMESTAMP,
  `creado_usuario` varchar(10) DEFAULT NULL,
  `modificado` datetime DEFAULT NULL,
  `modificado_usuario` varchar(10) DEFAULT NULL,
  `eliminado` datetime DEFAULT NULL,
  `eliminado_usuario` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`idMedioPliego`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mediopliego`
--

DROP TABLE IF EXISTS `mediopliego`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mediopliego` (
  `activo` varchar(1) NOT NULL DEFAULT 'S',
  `idMedioPliego` int(11) NOT NULL AUTO_INCREMENT,
  `numeroExpediente` varchar(10) DEFAULT NULL,
  `diocesisOrigen` varchar(100) DEFAULT NULL,
  `parroquiaOrigen` varchar(100) DEFAULT NULL,
  `diocesisDestino` varchar(100) DEFAULT NULL,
  `parroquiaMatrimonio` varchar(100) DEFAULT NULL,
  `apellidosNovia` varchar(50) DEFAULT NULL,
  `nombresNovia` varchar(50) DEFAULT NULL,
  `direccionNovia` varchar(100) DEFAULT NULL,
  `padreNovia` varchar(50) DEFAULT NULL,
  `madreNovia` varchar(50) DEFAULT NULL,
  `fechaBauNovia` date DEFAULT NULL,
  `parroquiaBauNovia` varchar(100) DEFAULT NULL,
  `apellidosNovio` varchar(50) DEFAULT NULL,
  `nombresNovio` varchar(50) DEFAULT NULL,
  `direccionNovio` varchar(100) DEFAULT NULL,
  `padreNovio` varchar(50) DEFAULT NULL,
  `madreNovio` varchar(50) DEFAULT NULL,
  `fechaBauNovio` date DEFAULT NULL,
  `fechaMatCivil` date DEFAULT NULL,
  `fechaMatReligioso` date DEFAULT NULL,
  `fechaAutoriza` date DEFAULT NULL,
  `vicario` varchar(50) DEFAULT NULL,
  `cabecera` varchar(100) DEFAULT NULL,
  `observacion1` varchar(100) DEFAULT NULL,
  `observacion2` varchar(100) DEFAULT NULL,
  `creado` datetime DEFAULT CURRENT_TIMESTAMP,
  `creado_usuario` varchar(10) DEFAULT NULL,
  `modificado` datetime DEFAULT NULL,
  `modificado_usuario` varchar(10) DEFAULT NULL,
  `eliminado` datetime DEFAULT NULL,
  `eliminado_usuario` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`idMedioPliego`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pliegomatrimonial`
--

DROP TABLE IF EXISTS `pliegomatrimonial`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pliegomatrimonial` (
  `activo` varchar(1) NOT NULL DEFAULT 'S',
  `idPMatrimonial` int(11) NOT NULL AUTO_INCREMENT,
  `numeroExpediente` varchar(10) DEFAULT NULL,
  `fechaExpediente` date DEFAULT NULL,
  `diocesisOrigen` varchar(100) DEFAULT NULL,
  `parroquiaCelebracion` varchar(100) DEFAULT NULL,
  `apellidosNovia` varchar(50) DEFAULT NULL,
  `nombresNovia` varchar(50) DEFAULT NULL,
  `direccionNovia` varchar(100) DEFAULT NULL,
  `padreNovia` varchar(50) DEFAULT NULL,
  `madreNovia` varchar(50) DEFAULT NULL,
  `fechaBauNovia` date DEFAULT NULL,
  `parroquiaBauNovia` varchar(100) DEFAULT NULL,
  `apellidosNovio` varchar(50) DEFAULT NULL,
  `nombresNovio` varchar(50) DEFAULT NULL,
  `direccionNovio` varchar(100) DEFAULT NULL,
  `padreNovio` varchar(50) DEFAULT NULL,
  `madreNovio` varchar(50) DEFAULT NULL,
  `fechaBauNovio` date DEFAULT NULL,
  `fechaMatCivil` date DEFAULT NULL,
  `fechaMatReligioso` date DEFAULT NULL,
  `fechaAutorizacion` date DEFAULT NULL,
  `vicario` varchar(50) DEFAULT NULL,
  `cabecera1` varchar(100) DEFAULT NULL,
  `cabecera2` varchar(100) DEFAULT NULL,
  `observaciones1` varchar(100) DEFAULT NULL,
  `observaciones2` varchar(100) DEFAULT NULL,
  `creado` datetime DEFAULT CURRENT_TIMESTAMP,
  `creado_usuario` varchar(10) DEFAULT NULL,
  `modificado` datetime DEFAULT NULL,
  `modificado_usuario` varchar(10) DEFAULT NULL,
  `eliminado` datetime DEFAULT NULL,
  `eliminado_usuario` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`idPMatrimonial`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuarios` (
  `activo` varchar(1) NOT NULL DEFAULT 'S',
  `usuario` varchar(10) NOT NULL,
  `nombreUsuario` varchar(40) NOT NULL,
  `clave` varchar(10) NOT NULL,
  `rolUsuario` varchar(15) NOT NULL,
  `codInstitucion` varchar(5) DEFAULT NULL,
  `email` varchar(30) DEFAULT NULL,
  `movil` varchar(10) DEFAULT NULL,
  `creado` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `creado_usuario` varchar(10) DEFAULT NULL,
  `modificado` datetime DEFAULT NULL,
  `modificado_usuario` varchar(10) DEFAULT NULL,
  `eliminado` datetime DEFAULT NULL,
  `eliminado_usuario` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-09-18 16:37:28
