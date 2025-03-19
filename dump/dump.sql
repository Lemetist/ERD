-- MySQL dump 10.13  Distrib 8.0.40, for Linux (x86_64)
--
-- Host: localhost    Database: COMPANY
-- ------------------------------------------------------
-- Server version	8.0.40

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Current Database: `COMPANY`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `COMPANY` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `COMPANY`;

--
-- Table structure for table `грузы`
--

DROP TABLE IF EXISTS `грузы`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `грузы` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `описание` text,
  `категория` varchar(100) DEFAULT NULL,
  `вес` decimal(10,2) DEFAULT NULL,
  `условия_хранения` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `грузы`
--

LOCK TABLES `грузы` WRITE;
/*!40000 ALTER TABLE `грузы` DISABLE KEYS */;
INSERT INTO `грузы` VALUES (1,'Электроника','Техника',50.00,'Сухое помещение'),(2,'Химические вещества','Опасные грузы',200.00,'Вентилируемое помещение'),(3,'Продукты питания','Пищевые товары',100.00,'Холодильник'),(4,'Электроника','Техника',2000.00,'Сухое помещение'),(5,'Химические вещества','Опасные грузы',3000.00,'Вентилируемое помещение'),(6,'Электроника','Техника',2000.00,'Сухое помещение'),(7,'Химические вещества','Опасные грузы',3000.00,'Вентилируемое помещение');
/*!40000 ALTER TABLE `грузы` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `маршрут`
--

DROP TABLE IF EXISTS `маршрут`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `маршрут` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `Начальный_узел` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `Конечный_узел` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `уровень_риска` int DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `уровень_риска` (`уровень_риска`),
  CONSTRAINT `маршрут_ibfk_1` FOREIGN KEY (`уровень_риска`) REFERENCES `уровень_риска` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `маршрут`
--

LOCK TABLES `маршрут` WRITE;
/*!40000 ALTER TABLE `маршрут` DISABLE KEYS */;
INSERT INTO `маршрут` VALUES (1,'Москва','Санкт-Петербург',2),(2,'Киев','Одесса',1),(3,'Лондон','Париж',3);
/*!40000 ALTER TABLE `маршрут` ENABLE KEYS */;
UNLOCK TABLES;

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

--
-- Table structure for table `обслуживающий_персонал`
--

DROP TABLE IF EXISTS `обслуживающий_персонал`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `обслуживающий_персонал` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `уровень_квал` varchar(100) DEFAULT NULL,
  `имя` varchar(100) DEFAULT NULL,
  `специализация` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `обслуживающий_персонал`
--

LOCK TABLES `обслуживающий_персонал` WRITE;
/*!40000 ALTER TABLE `обслуживающий_персонал` DISABLE KEYS */;
INSERT INTO `обслуживающий_персонал` VALUES (1,'Высший','Александр Александров','Механик'),(2,'Средний','Елена Еленова','Администратор'),(3,'Высший','Николай Николаев','Электрик');
/*!40000 ALTER TABLE `обслуживающий_персонал` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `транспорт`
--

DROP TABLE IF EXISTS `транспорт`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `транспорт` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `марка` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `тип` varchar(100) DEFAULT NULL,
  `грузоподъемность` decimal(10,2) DEFAULT NULL,
  `статус` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `транспорт`
--

LOCK TABLES `транспорт` WRITE;
/*!40000 ALTER TABLE `транспорт` DISABLE KEYS */;
INSERT INTO `транспорт` VALUES (1,'Mercedes-Benz','Грузовик',5000.00,'Исправен'),(2,'Toyota','Автомобиль',2000.00,'Исправен'),(3,'Scania','Грузовик',8000.00,'В ремонте'),(4,'Mercedes-Benz','Грузовик',5000.00,'Исправен'),(5,'Toyota','Автомобиль',2000.00,'Исправен'),(6,'Scania','Грузовик',8000.00,'В ремонте'),(7,'Mercedes-Benz','Грузовик',5000.00,'Исправен'),(8,'Mercedes-Benz','Грузовик',5000.00,'Исправен');
/*!40000 ALTER TABLE `транспорт` ENABLE KEYS */;
UNLOCK TABLES;

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

--
-- Table structure for table `уровень_риска`
--

DROP TABLE IF EXISTS `уровень_риска`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `уровень_риска` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `название` varchar(100) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `уровень_риска`
--

LOCK TABLES `уровень_риска` WRITE;
/*!40000 ALTER TABLE `уровень_риска` DISABLE KEYS */;
INSERT INTO `уровень_риска` VALUES (1,'Низкий'),(2,'Средний'),(3,'Высокий');
/*!40000 ALTER TABLE `уровень_риска` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `экипаж`
--

DROP TABLE IF EXISTS `экипаж`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `экипаж` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `уровень_квал` varchar(100) DEFAULT NULL,
  `имя` varchar(100) DEFAULT NULL,
  `специализация` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `экипаж`
--

LOCK TABLES `экипаж` WRITE;
/*!40000 ALTER TABLE `экипаж` DISABLE KEYS */;
INSERT INTO `экипаж` VALUES (1,'Высший','Иван Иванов','Водитель'),(2,'Средний','Петр Петров','Помощник водителя'),(3,'Высший','Мария Маркова','Навигатор');
/*!40000 ALTER TABLE `экипаж` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-03-19 13:05:46
