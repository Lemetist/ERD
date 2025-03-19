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
-- Table structure for table `транспортные_рейсы`
--

DROP TABLE IF EXISTS `транспортные_рейсы`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `транспортные_рейсы` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `ID_груза` int DEFAULT NULL,
  `ID_назначение_на_транспорт` int DEFAULT NULL,
  `ID_маршрута` int DEFAULT NULL,
  `статус` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `ID_груза` (`ID_груза`),
  KEY `ID_назначение_на_транспорт` (`ID_назначение_на_транспорт`),
  KEY `ID_маршрута` (`ID_маршрута`),
  CONSTRAINT `транспортные_рейсы_ibfk_1` FOREIGN KEY (`ID_груза`) REFERENCES `грузы` (`ID`),
  CONSTRAINT `транспортные_рейсы_ibfk_2` FOREIGN KEY (`ID_назначение_на_транспорт`) REFERENCES `назначения_экипажа_на_транспорт` (`ID`),
  CONSTRAINT `транспортные_рейсы_ibfk_3` FOREIGN KEY (`ID_маршрута`) REFERENCES `маршрут` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `транспортные_рейсы`
--

LOCK TABLES `транспортные_рейсы` WRITE;
/*!40000 ALTER TABLE `транспортные_рейсы` DISABLE KEYS */;
INSERT INTO `транспортные_рейсы` VALUES (1,1,1,1,1),(2,2,2,2,1),(3,3,3,3,0),(4,2,1,1,1),(5,1,1,1,1),(6,2,1,1,1),(7,1,1,1,1),(8,2,1,1,1);
/*!40000 ALTER TABLE `транспортные_рейсы` ENABLE KEYS */;
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `check_cargo_capacity` BEFORE INSERT ON `транспортные_рейсы` FOR EACH ROW BEGIN
    DECLARE total_weight DECIMAL(10,2);
    DECLARE transport_capacity DECIMAL(10,2);

    -- Получаем грузоподъемность транспорта
    SELECT т.грузоподъемность INTO transport_capacity
    FROM назначения_экипажа_на_транспорт н
    JOIN транспорт т ON н.ID_транспорта = т.ID
    WHERE н.ID = NEW.ID_назначение_на_транспорт;

    -- Считаем текущую загрузку
    SELECT SUM(г.вес) INTO total_weight
    FROM транспортные_рейсы тр
    JOIN грузы г ON тр.ID_груза = г.ID
    WHERE тр.ID_назначение_на_транспорт = NEW.ID_назначение_на_транспорт
      AND тр.статус = TRUE;

    -- Добавляем вес нового груза
    SET total_weight = COALESCE(total_weight, 0) + (SELECT вес FROM грузы WHERE ID = NEW.ID_груза);

    -- Проверяем превышение
    IF transport_capacity IS NULL OR total_weight > transport_capacity THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Ошибка: превышена грузоподъемность транспортного средства';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-03-19 13:02:26
