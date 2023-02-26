CREATE DATABASE  IF NOT EXISTS `carloca` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `carloca`;
-- MySQL dump 10.13  Distrib 8.0.32, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: carloca
-- ------------------------------------------------------
-- Server version	8.0.32

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
-- Table structure for table `ALUGUEIS`
--

DROP TABLE IF EXISTS `ALUGUEIS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ALUGUEIS` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `ID_CLIENTE` int NOT NULL,
  `ID_CARRO` int NOT NULL,
  `DT_RETIRADA` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `DT_DEVOLUCAO` datetime NOT NULL DEFAULT ((`DT_RETIRADA` + interval 1 day)),
  `TEM_SEGURO` enum('SIM','NAO') NOT NULL,
  `UNIDADE_RETIRADA` int NOT NULL,
  `UNIDADE_DEVOLUCAO` int NOT NULL,
  `MODALIDADE` enum('DIARIA') NOT NULL,
  `KM_RODADOS` int DEFAULT NULL,
  `STATUS_ALUGUEL` enum('ATIVO','INATIVO') NOT NULL DEFAULT 'ATIVO',
  PRIMARY KEY (`ID`),
  KEY `UNIDADE_RETIRADA_FK_idx` (`UNIDADE_RETIRADA`),
  KEY `UNIDADE_DEVOLUCAO_idx` (`UNIDADE_DEVOLUCAO`),
  KEY `ID_CARRO_FK_idx` (`ID_CARRO`),
  KEY `ID_CLIENTE_FK_idx` (`ID_CLIENTE`),
  CONSTRAINT `CARRO_FK` FOREIGN KEY (`ID_CARRO`) REFERENCES `CARRO` (`ID`),
  CONSTRAINT `CLIENTE_FK` FOREIGN KEY (`ID_CLIENTE`) REFERENCES `CLIENTE` (`ID`),
  CONSTRAINT `UNIDADE_DEVOLUCAO` FOREIGN KEY (`UNIDADE_DEVOLUCAO`) REFERENCES `UNIDADES_FRANQUIA` (`ID`),
  CONSTRAINT `UNIDADE_RETIRADA_FK` FOREIGN KEY (`UNIDADE_RETIRADA`) REFERENCES `UNIDADES_FRANQUIA` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ALUGUEIS`
--

LOCK TABLES `ALUGUEIS` WRITE;
/*!40000 ALTER TABLE `ALUGUEIS` DISABLE KEYS */;
INSERT INTO `ALUGUEIS` VALUES (7,1,1,'2023-02-26 22:20:23','2023-02-27 22:20:23','NAO',1,1,'DIARIA',200,'INATIVO'),(8,2,2,'2023-02-26 22:20:42','2023-02-27 22:20:42','SIM',2,2,'DIARIA',0,'ATIVO'),(9,1,3,'2023-02-26 22:22:19','2023-02-27 22:22:19','SIM',2,2,'DIARIA',0,'ATIVO'),(10,3,1,'2023-02-26 22:25:30','2023-02-27 22:25:30','SIM',1,2,'DIARIA',0,'ATIVO');
/*!40000 ALTER TABLE `ALUGUEIS` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `ALUGUEIS_BEFORE_INSERT` BEFORE INSERT ON `ALUGUEIS` FOR EACH ROW BEGIN
SET @VERIFICA_CLIENTE := (SELECT `STATUS` FROM CLIENTE WHERE ID = NEW.ID_CLIENTE);
SET @VERIFICA_CARRO := (SELECT `STATUS` FROM CARRO WHERE ID = NEW.ID_CARRO);
IF @VERIFICA_CLIENTE = 'INDISPONIVEL' OR @VERIFICA_CARRO = 'INDISPONIVEL' THEN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'CLIENTE E/OU CARRO INDISPONIVEIS';
END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `ALUGUEIS_AFTER_INSERT` AFTER INSERT ON `ALUGUEIS` FOR EACH ROW BEGIN
UPDATE CARRO SET `STATUS` = 'INDISPONIVEL' WHERE ID = NEW.ID_CARRO;
UPDATE CLIENTE SET `STATUS` = 'INDISPONIVEL' WHERE ID = NEW.ID_CLIENTE;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `ALUGUEIS_ATIVOS_AFTER_UPDATE` AFTER UPDATE ON `ALUGUEIS` FOR EACH ROW BEGIN
IF NEW.STATUS_ALUGUEL = 'INATIVO' THEN
INSERT INTO HISTORICO_ALUGUEIS VALUES
(NULL, NEW.ID_CLIENTE, NEW.ID_CARRO, NEW.KM_RODADOS);

UPDATE CARRO SET QUILOMETRAGEM = (QUILOMETRAGEM + NEW.KM_RODADOS) WHERE ID = NEW.ID_CARRO;

UPDATE CARRO SET `STATUS` = 'DISPONIVEL' WHERE ID = NEW.ID_CARRO;

UPDATE CLIENTE SET `STATUS` = 'DISPONIVEL' WHERE ID = NEW.ID_CLIENTE;

END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `CARRO`
--

DROP TABLE IF EXISTS `CARRO`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CARRO` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `PLACA` varchar(7) NOT NULL,
  `ID_CATEGORIA` int NOT NULL,
  `MONTADORA` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `MODELO` varchar(45) NOT NULL,
  `COR` enum('BRANCO','PRETO','PRATA') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `ANO` varchar(4) NOT NULL,
  `QTD_PORTAS` int NOT NULL,
  `VERSAO` varchar(45) NOT NULL,
  `QUILOMETRAGEM` int NOT NULL,
  `STATUS` enum('DISPONIVEL','INDISPONIVEL') NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `PLACA_UNIQUE` (`PLACA`),
  KEY `ID_CATEGORIA_idx` (`ID_CATEGORIA`),
  CONSTRAINT `ID_CATEGORIA` FOREIGN KEY (`ID_CATEGORIA`) REFERENCES `CATEGORIA` (`ID`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CARRO`
--

LOCK TABLES `CARRO` WRITE;
/*!40000 ALTER TABLE `CARRO` DISABLE KEYS */;
INSERT INTO `CARRO` VALUES (1,'PWQ8671',3,'FIAT','CHRONOS','PRETO','2022',5,'1.3',5440,'INDISPONIVEL'),(2,'CTC5678',1,'VOLKSWAGEM','UP','PRATA','2020',3,'1.0',15400,'INDISPONIVEL'),(3,'DFD7485',2,'HYUNDAI','HB20','BRANCO','2021',5,'1.0',8000,'INDISPONIVEL'),(4,'RER9632',4,'HONDA','CIVIC','PRETO','2023',5,'TYPE R 2.0',1000,'DISPONIVEL');
/*!40000 ALTER TABLE `CARRO` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CATEGORIA`
--

DROP TABLE IF EXISTS `CATEGORIA`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CATEGORIA` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `CATEGORIA` enum('HATCH','SEDAN COMPACTO','SUV','SEDAN MEDIO','PICK UP','MINI VAN','SEDAN LUXO') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `PRECO_DIARIA` decimal(10,2) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `CATEGORIA_UNIQUE` (`CATEGORIA`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CATEGORIA`
--

LOCK TABLES `CATEGORIA` WRITE;
/*!40000 ALTER TABLE `CATEGORIA` DISABLE KEYS */;
INSERT INTO `CATEGORIA` VALUES (1,'HATCH',89.90),(2,'SEDAN COMPACTO',99.90),(3,'SEDAN MEDIO',109.90),(4,'SEDAN LUXO',139.90),(5,'SUV',119.90),(6,'PICK UP',129.90),(7,'MINI VAN',149.90);
/*!40000 ALTER TABLE `CATEGORIA` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CLIENTE`
--

DROP TABLE IF EXISTS `CLIENTE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CLIENTE` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `NOME` varchar(255) NOT NULL,
  `CPF` varchar(11) NOT NULL,
  `DT_NASCIMENTO` date NOT NULL,
  `CNH` varchar(11) NOT NULL,
  `TELEFONE` varchar(11) NOT NULL,
  `STATUS` enum('DISPONIVEL','INDISPONIVEL') NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `CPF_UNIQUE` (`CPF`),
  UNIQUE KEY `CNH_UNIQUE` (`CNH`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CLIENTE`
--

LOCK TABLES `CLIENTE` WRITE;
/*!40000 ALTER TABLE `CLIENTE` DISABLE KEYS */;
INSERT INTO `CLIENTE` VALUES (1,'WADSON MANZOLI','99999999999','1992-03-07','99999999999','31999999999','INDISPONIVEL'),(2,'VITOR RIBEIRO','88888888888','1994-10-10','88888888888','31994250977','INDISPONIVEL'),(3,'ANTONIO FREITAS','77777777777','1981-12-12','77777777777','31888888888','INDISPONIVEL'),(4,'KELVIS SANTOS','66666666666','1832-06-05','66666666666','31777777777','DISPONIVEL');
/*!40000 ALTER TABLE `CLIENTE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `HISTORICO_ALUGUEIS`
--

DROP TABLE IF EXISTS `HISTORICO_ALUGUEIS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `HISTORICO_ALUGUEIS` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `ID_CLIENTE` int DEFAULT NULL,
  `ID_CARRO` int DEFAULT NULL,
  `KM_RODADOS` int DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `HISTORICO_ALUGUEIS`
--

LOCK TABLES `HISTORICO_ALUGUEIS` WRITE;
/*!40000 ALTER TABLE `HISTORICO_ALUGUEIS` DISABLE KEYS */;
INSERT INTO `HISTORICO_ALUGUEIS` VALUES (14,1,1,200);
/*!40000 ALTER TABLE `HISTORICO_ALUGUEIS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `UNIDADES_FRANQUIA`
--

DROP TABLE IF EXISTS `UNIDADES_FRANQUIA`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `UNIDADES_FRANQUIA` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `RUA` text NOT NULL,
  `NUMERO` text NOT NULL,
  `BAIRRO` text NOT NULL,
  `CIDADE` text NOT NULL,
  `ESTADO` text NOT NULL,
  `TELEFONE` text NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `UNIDADES_FRANQUIA`
--

LOCK TABLES `UNIDADES_FRANQUIA` WRITE;
/*!40000 ALTER TABLE `UNIDADES_FRANQUIA` DISABLE KEYS */;
INSERT INTO `UNIDADES_FRANQUIA` VALUES (1,'QUINTINO BOCAIUVA','415','SAPUCAIAS','BAIXU GUANDU','ES','27 33532700'),(2,'R BARAO DO RIO BRANCO','339','PETROPOLIS','BETIM','MG','31 35921368');
/*!40000 ALTER TABLE `UNIDADES_FRANQUIA` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'carloca'
--

--
-- Dumping routines for database 'carloca'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-02-26 19:37:39
