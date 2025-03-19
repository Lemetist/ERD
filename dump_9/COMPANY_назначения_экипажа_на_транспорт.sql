-- MySQL dump 10.13  Distrib 8.0.36, for Linux (x86_64)
--
-- Host: localhost    Database: COMPANY
-- ------------------------------------------------------
-- Server version	8.0.40

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
-- Table structure for table `назначения_экипажа_на_транспорт`
--

DROP TABLE IF EXISTS `назначения_экипажа_на_транспорт`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `назначения_экипажа_на_транспорт` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `ID_экипажа` int DEFAULT NULL,
  `ID_транспорта` int DEFAULT NULL,
  `ID_обслуживающий_персонал` int DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `ID_экипажа` (`ID_экипажа`),
  KEY `ID_транспорта` (`ID_транспорта`),
  KEY `ID_обслуживающий_персонал` (`ID_обслуживающий_персонал`),
  CONSTRAINT `назначения_экипажа_на_транспорт_ibfk_1` FOREIGN KEY (`ID_экипажа`) REFERENCES `экипаж` (`ID`),
  CONSTRAINT `назначения_экипажа_на_транспорт_ibfk_2` FOREIGN KEY (`ID_транспорта`) REFERENCES `транспорт` (`ID`),
  CONSTRAINT `назначения_экипажа_на_транспорт_ibfk_3` FOREIGN KEY (`ID_обслуживающий_персонал`) REFERENCES `обслуживающий_персонал` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `назначения_экипажа_на_транспорт`
--

LOCK TABLES `назначения_экипажа_на_транспорт` WRITE;
/*!40000 ALTER TABLE `назначения_экипажа_на_транспорт` DISABLE KEYS */;
INSERT INTO `назначения_экипажа_на_транспорт` VALUES (1,1,1,1),(2,2,2,2),(3,3,3,3),(4,1,1,1),(5,1,1,1);
/*!40000 ALTER TABLE `назначения_экипажа_на_транспорт` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-03-19 13:02:26
