-- MySQL dump 10.13  Distrib 8.0.26, for Win64 (x86_64)
--
-- Host: localhost    Database: MyPizzeria
-- ------------------------------------------------------
-- Server version	8.0.26

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
-- Temporary view structure for view `active_orders`
--

DROP TABLE IF EXISTS `active_orders`;
/*!50001 DROP VIEW IF EXISTS `active_orders`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `active_orders` AS SELECT 
 1 AS `Имя`,
 1 AS `Фамилия`,
 1 AS `Телефон`,
 1 AS `Статус заказа`,
 1 AS `Сумма к оплате`,
 1 AS `Скидка`,
 1 AS `Сумма к оплате со скидкой`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `cities`
--

DROP TABLE IF EXISTS `cities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cities` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Таблица городов с сетью пиццерий';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cities`
--

LOCK TABLES `cities` WRITE;
/*!40000 ALTER TABLE `cities` DISABLE KEYS */;
INSERT INTO `cities` VALUES (1,'Abbotthaven'),(2,'Jaceberg'),(3,'Freedaland');
/*!40000 ALTER TABLE `cities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `discounts`
--

DROP TABLE IF EXISTS `discounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `discounts` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL COMMENT 'Ключ на пользователя',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Название скидки',
  `discount` int unsigned NOT NULL COMMENT 'Скидка',
  `started_at` datetime DEFAULT NULL,
  `finished_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `discounts_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Таблица городов с сетью пиццерий';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `discounts`
--

LOCK TABLES `discounts` WRITE;
/*!40000 ALTER TABLE `discounts` DISABLE KEYS */;
INSERT INTO `discounts` VALUES (1,1,'aut',3,'1973-03-19 10:02:52','2021-08-13 13:33:48'),(2,2,'eaque',9,'2014-10-19 21:07:45','1986-06-29 09:13:58'),(3,3,'provident',8,'2018-04-29 14:34:09','1992-09-26 22:49:29'),(4,4,'facere',10,'1997-11-03 02:06:28','2003-11-01 22:38:21'),(5,5,'quia',1,'2015-07-10 18:18:57','1990-07-24 14:23:07');
/*!40000 ALTER TABLE `discounts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `names_pizzas_toppings`
--

DROP TABLE IF EXISTS `names_pizzas_toppings`;
/*!50001 DROP VIEW IF EXISTS `names_pizzas_toppings`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `names_pizzas_toppings` AS SELECT 
 1 AS `Название пиццы`,
 1 AS `Название топпинга`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL COMMENT 'Ключ на пользователя',
  `status` enum('Обрабатывается','Готовится','Передан курьеру','Отменен') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Статус заказа',
  `payment` enum('Наличными','Картой') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Способ оплаты',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания заказа',
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Таблица заказов';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (1,1,'Обрабатывается','Картой','1989-06-16 20:35:36'),(2,2,'Обрабатывается','Наличными','2000-09-20 12:09:39'),(3,3,'Передан курьеру','Картой','1985-04-07 11:45:51'),(4,4,'Отменен','Картой','2008-05-04 00:30:37'),(5,5,'Отменен','Картой','1990-08-23 10:11:58'),(6,6,'Передан курьеру','Картой','1977-08-21 05:10:17'),(7,7,'Отменен','Картой','1986-08-30 01:21:54'),(8,8,'Готовится','Наличными','1979-05-17 05:44:56'),(9,9,'Отменен','Наличными','1993-09-19 17:56:15'),(10,10,'Обрабатывается','Картой','2006-05-28 03:08:59'),(11,11,'Готовится','Картой','2021-02-07 13:32:46'),(12,12,'Отменен','Картой','2008-02-14 03:28:49'),(13,13,'Отменен','Картой','1987-01-26 19:36:26'),(14,14,'Готовится','Наличными','1973-11-16 13:55:29'),(15,15,'Готовится','Картой','1977-11-08 07:12:20'),(16,16,'Обрабатывается','Наличными','2000-06-09 02:27:08'),(17,17,'Обрабатывается','Картой','1998-03-21 04:38:56'),(18,18,'Передан курьеру','Картой','1972-05-16 16:45:00'),(19,19,'Готовится','Наличными','1988-12-12 01:41:35'),(20,20,'Передан курьеру','Наличными','1983-06-12 17:27:53'),(21,21,'Передан курьеру','Картой','2016-04-07 15:03:03'),(22,22,'Готовится','Наличными','1985-03-17 03:57:12'),(23,23,'Обрабатывается','Наличными','1995-07-18 07:35:10'),(24,24,'Отменен','Наличными','1978-07-25 10:05:43'),(25,25,'Обрабатывается','Наличными','1974-01-28 07:47:01'),(26,26,'Передан курьеру','Картой','2015-12-17 18:01:21'),(27,27,'Передан курьеру','Наличными','1982-01-28 01:39:06'),(28,28,'Обрабатывается','Картой','2010-01-30 18:46:44');
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders_pizzas`
--

DROP TABLE IF EXISTS `orders_pizzas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders_pizzas` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `order_id` bigint unsigned NOT NULL COMMENT 'Ключ на заказ',
  `pizza_id` bigint unsigned NOT NULL COMMENT 'Ключ на пиццу',
  `count` int unsigned NOT NULL COMMENT 'Количество заказа',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`),
  KEY `pizza_id` (`pizza_id`),
  CONSTRAINT `orders_pizzas_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `orders_pizzas_ibfk_2` FOREIGN KEY (`pizza_id`) REFERENCES `pizzas` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Таблица пицц в заказе';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders_pizzas`
--

LOCK TABLES `orders_pizzas` WRITE;
/*!40000 ALTER TABLE `orders_pizzas` DISABLE KEYS */;
INSERT INTO `orders_pizzas` VALUES (1,1,1,3),(2,2,2,5),(3,3,3,1),(4,4,4,3),(5,5,5,1),(6,6,6,3),(7,7,7,2),(8,8,8,1),(9,9,9,5),(10,10,10,2),(11,11,1,5),(12,12,2,5),(13,13,3,1),(14,14,4,2),(15,15,5,2),(16,16,6,2),(17,17,7,5),(18,18,8,5),(19,19,9,4),(20,20,10,2);
/*!40000 ALTER TABLE `orders_pizzas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pizzas`
--

DROP TABLE IF EXISTS `pizzas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pizzas` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Название пиццы',
  `composition` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Состав пиццы',
  `price` int unsigned NOT NULL COMMENT 'Цена пиццы',
  `size` enum('Большая','Средняя','Маленькая') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Таблица видов пицц';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pizzas`
--

LOCK TABLES `pizzas` WRITE;
/*!40000 ALTER TABLE `pizzas` DISABLE KEYS */;
INSERT INTO `pizzas` VALUES (1,'error','Facere sint eum quos nam aut deserunt. Voluptas cum voluptas ex tenetur. Quo voluptas maiores molestias et.',883,'Большая'),(2,'optio','Nihil qui itaque dolor eum odit aliquid architecto. Rerum rerum sunt dolores labore. Nihil ad sint aut ut dolore minima hic.',591,'Средняя'),(3,'quis','Maiores eos dolorem expedita est molestiae totam quia quidem. Qui molestiae repudiandae recusandae magnam tenetur blanditiis fugiat. Aut iure labore libero eos.',343,'Большая'),(4,'magni','Aliquam beatae corrupti consequatur unde eos eum et temporibus. Itaque pariatur dignissimos atque placeat non minus nihil. Cum occaecati id neque molestiae et.',356,'Маленькая'),(5,'architecto','Vero ut laborum voluptatem voluptatum atque. Saepe et ducimus corrupti quia qui. Cum quo accusantium rerum sint et saepe natus. Ut eaque et aut consequatur facilis dolores possimus voluptates.',479,'Большая'),(6,'facere','Qui corporis ut aut assumenda tenetur nobis ut cupiditate. Ipsa voluptas eum ullam ab. Voluptas quia in eum omnis velit quo.',313,'Маленькая'),(7,'ipsum','Minima quam ducimus aliquid nihil occaecati architecto. Veritatis est fugiat et voluptas. Itaque eos ut consequatur totam. Architecto ipsum et aspernatur quidem et repellendus labore excepturi.',821,'Средняя'),(8,'aut','Explicabo nostrum et quis quas perspiciatis. Reiciendis deleniti consequuntur animi ipsa labore deserunt earum. Laudantium officia maxime mollitia mollitia ad consequatur.',522,'Средняя'),(9,'expedita','Maiores facere aut libero suscipit fugiat. Qui hic voluptas praesentium et. Eum hic ut aut eius. Expedita voluptatem eum consequatur corrupti fugit voluptatum repellat ut.',538,'Маленькая'),(10,'perferendis','Ipsa non sit voluptatem quisquam qui aliquam. Sed ea provident dolorem natus. Eum rem incidunt blanditiis.',316,'Большая');
/*!40000 ALTER TABLE `pizzas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pizzas_toppings`
--

DROP TABLE IF EXISTS `pizzas_toppings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pizzas_toppings` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `pizza_id` bigint unsigned NOT NULL,
  `topping_id` bigint unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `pizza_id` (`pizza_id`),
  KEY `topping_id` (`topping_id`),
  CONSTRAINT `pizzas_toppings_ibfk_1` FOREIGN KEY (`pizza_id`) REFERENCES `pizzas` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `pizzas_toppings_ibfk_2` FOREIGN KEY (`topping_id`) REFERENCES `toppings` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Таблица топпингов для конкретной пиццы';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pizzas_toppings`
--

LOCK TABLES `pizzas_toppings` WRITE;
/*!40000 ALTER TABLE `pizzas_toppings` DISABLE KEYS */;
INSERT INTO `pizzas_toppings` VALUES (1,1,1),(2,2,2),(3,3,3),(4,4,4),(5,5,5),(6,6,6),(7,7,7),(8,8,8),(9,9,9),(10,10,10),(11,1,2);
/*!40000 ALTER TABLE `pizzas_toppings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pizzerias`
--

DROP TABLE IF EXISTS `pizzerias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pizzerias` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `address` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` bigint unsigned NOT NULL,
  `city_id` bigint unsigned NOT NULL COMMENT 'Ключ на город',
  PRIMARY KEY (`id`),
  KEY `city_id` (`city_id`),
  CONSTRAINT `pizzerias_ibfk_1` FOREIGN KEY (`city_id`) REFERENCES `cities` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Таблица точек пиццерий';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pizzerias`
--

LOCK TABLES `pizzerias` WRITE;
/*!40000 ALTER TABLE `pizzerias` DISABLE KEYS */;
INSERT INTO `pizzerias` VALUES (1,'714 Russell Plaza\nDereckberg, NY 16131',1,1),(2,'7836 Albertha Ridges\nLake Cordellland, MA 25246',79,2),(3,'746 Amiya Rest\nSouth Pathaven, DC 06134-4897',1,3),(4,'40912 Ron Cove Suite 596\nCorkeryborough, MI 45522-0481',20,1),(5,'9574 Gaylord Stream\nAishabury, MD 49468',588,2);
/*!40000 ALTER TABLE `pizzerias` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `profiles`
--

DROP TABLE IF EXISTS `profiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `profiles` (
  `user_id` bigint unsigned NOT NULL,
  `password` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Пароль пользователя',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата создания профиля',
  `updated_at` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'Дата обновления профиля',
  PRIMARY KEY (`user_id`),
  CONSTRAINT `profiles_FK` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `profiles_FK_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `profiles_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Таблица профилей пользователей сервиса';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `profiles`
--

LOCK TABLES `profiles` WRITE;
/*!40000 ALTER TABLE `profiles` DISABLE KEYS */;
INSERT INTO `profiles` VALUES (1,'02ff42d1b3fe845c21c77c04182ef5','1976-07-09 05:16:52','2015-01-24 23:20:44'),(2,'3016f3a8d834c98ded6420bdd5d7a2','2019-10-17 14:07:31','2020-05-21 03:49:57'),(3,'822d5ac728330e23183c1a3b01a7fc','1973-06-04 11:17:34','2001-03-07 02:07:50'),(4,'32962d0ed0b562071e9157fafeb729','2014-05-01 20:25:24','1972-01-17 05:00:21'),(5,'581e7894c0a29d6c3360eddb1cb9a9','1988-08-15 11:19:41','1988-05-09 04:31:09'),(6,'ebb88a77b222fb83f7906e1a709afd','1987-10-18 05:37:53','1995-01-05 03:03:02'),(7,'faf77628c459ff0f81edfdd47b689a','1979-08-07 16:32:08','1997-05-09 01:02:35'),(8,'c084e3de1f945398fd10b7c6632875','2019-01-16 16:55:14','2015-06-30 11:12:06'),(9,'2865638304aebba20dfa3cc213d7ee','1980-10-15 17:55:27','2009-09-01 14:00:54'),(10,'a8e2b96df58a2b463f684c6961bcd0','2018-08-29 20:50:59','1982-03-15 16:21:43'),(11,'d8daf0a131336b677a792666af8b8e','1981-06-28 04:42:52','1976-11-07 02:28:31'),(12,'07d0d298fb6c07a1bbfc87fe49230c','2008-06-13 10:38:47','2009-05-21 00:40:46'),(13,'bfcc80c79133028611f0e15dce89b3','2019-03-31 22:28:58','2000-06-19 19:51:52'),(14,'643dcca9ae22d8975dd016ae5417f3','1998-04-05 12:15:03','1974-01-04 10:22:32'),(15,'04cc4bacffaad890a07655cae14e08','1978-03-25 11:46:36','2012-10-19 16:45:02'),(16,'0b2902e92a3aae2e1e995e1ae38ae6','2015-11-02 05:49:38','2008-11-10 06:40:00'),(17,'df876d26e7410c3e1b1c05b6d2dba9','1995-12-05 05:13:29','2018-10-29 05:20:07'),(18,'090393c055c74741dbe57182d15b7c','2003-02-11 18:54:48','1998-03-15 20:56:14'),(19,'cce88c63500c02a573ed538076e37b','2009-09-13 18:27:46','2014-07-26 00:58:54'),(20,'c06f725ea0aabd748f99b4c6dcd50e','1983-01-30 17:29:57','1981-12-19 21:14:40'),(21,'a91c839fcf1e68578e21779e8a5a0d','1987-06-28 04:15:42','2000-01-29 01:58:08'),(22,'c7ca635761762870188aa995a2719c','2021-01-17 04:18:39','2008-03-29 14:13:39'),(23,'7498647a6c5fab86c986a66f0b11e7','2003-12-14 12:02:39','2007-04-10 09:05:13'),(24,'6d2f19265f81e5b0dad1cda68fd582','1984-03-01 20:46:41','1981-02-06 23:54:56'),(25,'ca08f1d3c4b775bdeb1526882f59bb','1972-01-12 14:28:21','2006-08-01 18:00:41'),(26,'583a60695412ca2c36c3d0d9888e22','2007-08-28 01:25:52','2001-01-10 08:37:01'),(27,'f1db43e82260bf11f39da4cf389ce6','1981-02-22 20:07:46','1989-12-03 22:47:07'),(28,'38fe07c825d9a3793008270a379838','2002-05-23 20:07:46','1978-05-18 05:11:32'),(29,'bd423a971b96a6a0872d7aa5ca39d4','2007-09-27 15:37:29','1999-10-30 13:25:14'),(30,'4cd638cb2d8ed5f4b9f839d1577a2c','1976-11-04 05:14:45','1987-06-10 20:44:30');
/*!40000 ALTER TABLE `profiles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `toppings`
--

DROP TABLE IF EXISTS `toppings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `toppings` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Название топпинга',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Таблица топпингов для пиццы';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `toppings`
--

LOCK TABLES `toppings` WRITE;
/*!40000 ALTER TABLE `toppings` DISABLE KEYS */;
INSERT INTO `toppings` VALUES (1,'Майонез'),(2,'Кетчуп'),(3,'Шампиньоны'),(4,'Шашлык'),(5,'Сыр'),(6,'Огурцы'),(7,'Маслины'),(8,'Ананасы'),(9,'Горчица'),(10,'Помидоры');
/*!40000 ALTER TABLE `toppings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT 'Идентификатор пользователя',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Имя пользователя',
  `lastname` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Фамилия пользователя',
  `surname` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Отчество пользователя (заполнение необязательно)',
  `address` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Адрес пользователя',
  `phone` bigint unsigned NOT NULL COMMENT 'Телефон пользователя',
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'почта пользователя (заполнение необязательно)',
  PRIMARY KEY (`id`),
  KEY `users_lastname` (`lastname`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Таблица пользователей сервиса';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Isac','Mohr','','56511 Bode Route Apt. 190\nCarolynechester, ND 04129-3674',89633809882,'reinger.emilio@schaefer.com'),(2,'Ansley','Anderson','Victoria','7902 Hayes Harbors\nLake Warren, NY 54917',89634825604,'hills.giovani@runolfsdottir.net'),(3,'Owen','D\'Amore','','56626 Charlotte Dam Suite 241\nLake Davionborough, VA 83986',89637282810,'abshire.irma@weissnat.info'),(4,'Onie','Ledner','','958 Legros Union\nTheaview, AK 40842-4799',89638601684,'welch.karine@kihn.org'),(5,'Stefanie','Koepp','Vickie','135 Xander Loop\nLake Uriah, IN 00473-9321',89632512922,'doris.wilderman@yahoo.com'),(6,'Loma','Greenholt','','1086 Emmerich Fork\nPort Terence, OH 74101-6652',89632171961,'juwan.lakin@grimes.net'),(7,'Anibal','Stracke','','6304 Rempel Crossroad\nWest Kaceyburgh, RI 72464',89633067061,'cruickshank.mabelle@yahoo.com'),(8,'Oren','Gutkowski','Maximilian','07353 Pauline Green Apt. 329\nWest Lesterfort, CO 91384',89631435815,'jhaag@yahoo.com'),(9,'Francesca','Roob','','792 Stehr Trail\nLabadietown, MI 66421',89637566982,'mittie.spinka@yahoo.com'),(10,'Pat','Bauch','Pearlie','27014 Schultz Stream\nLibbymouth, OH 30067-4246',89637190967,'mackenzie.hayes@oberbrunner.com'),(11,'Destany','Howe','','330 Jerome Island Apt. 192\nJaimefurt, PA 67057',89632374899,'oma.bins@hotmail.com'),(12,'Brent','Beahan','','5187 Malachi Orchard\nAntonettachester, VA 63498-8008',89638018995,'cecile47@douglaslebsack.com'),(13,'Theron','Schinner','Kyle','7744 Stroman Trace\nNorth Justynstad, WI 43365',89636061479,'okuneva.domingo@stiedemann.com'),(14,'Margarette','Fay','','881 Bogisich Harbor\nEast Scarlettmouth, IN 54115',89630351484,'zita34@yahoo.com'),(15,'Gerda','Lakin','Herminia','6802 Wintheiser Street\nNorth Vivianfurt, ID 51042-8482',89632045013,'wrolfson@oconnell.org'),(16,'Josefa','Gusikowski','','626 Bailey Ford\nWest Elmore, NV 95632-4443',89639587513,'ikeeling@yahoo.com'),(17,'Isai','Emmerich','Rubye','280 Chaim Mills Suite 466\nEast Estell, OH 77071-6710',89638798487,'prohaska.erick@yahoo.com'),(18,'Aliya','Johnston','Sarai','49202 Oberbrunner Drives\nWileyton, MI 03212',89634823628,'boyle.brenda@harber.com'),(19,'Michaela','Morissette','','23627 Wilkinson Extension Apt. 007\nEast Grover, MO 26779',89639005679,'lowell98@hotmail.com'),(20,'Mckenzie','Muller','','37126 Markus Roads Apt. 512\nLake Kirstenhaven, NJ 35814',89638598891,'kward@gmail.com'),(21,'Felix','Wisoky','','883 Kennedy Port\nSchambergerborough, CA 25782',89633258696,'ghartmann@powlowskimckenzie.net'),(22,'Rhianna','Lueilwitz','Friedrich','2529 Hegmann Club Suite 254\nSouth Tatetown, VT 04592',89634104596,'harvey.maggio@gulgowski.biz'),(23,'Harmon','Lesch','Clarabelle','777 Smith Club Apt. 777\nAdamsside, WV 63178',89631830303,'larson.tatum@lindjohnston.com'),(24,'Anabel','Kunze','','6750 Casper Tunnel Apt. 514\nEast Rasheedtown, MN 88986-6636',89639085233,'jeramy.reinger@schowalter.com'),(25,'Giuseppe','Stoltenberg','Clemens','816 Watsica Pike\nNorth Abbyton, NM 70031-1946',89638861237,'davion35@kuvalis.com'),(26,'Danny','Huel','','6630 Stehr Walks Suite 679\nHellerbury, TN 59426-5237',89631711084,'vilma30@quitzon.info'),(27,'Monroe','Conroy','Glennie','32533 Maci Junctions Suite 587\nNew Monroe, CA 71276-0392',89637244540,'erling38@konopelski.biz'),(28,'Maia','Gleichner','','1771 Bonnie Brook Apt. 752\nWest Theo, IL 34958-7876',89633886912,'treva.murray@pagac.org'),(29,'Sharon','Funk','','393 Arlene Run\nLake Vivianmouth, AR 96602',89639269129,'arutherford@hotmail.com'),(30,'Trudie','Stiedemann','Perry','614 Moore Hills Apt. 518\nSouth Sid, NJ 83574',89630973771,'wintheiser.brad@gmail.com'),(31,'Иван','Иванов','Иванович','Ленина 1',89000000000,'mail@gmail.com');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Final view structure for view `active_orders`
--

/*!50001 DROP VIEW IF EXISTS `active_orders`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `active_orders` AS select `u`.`name` AS `Имя`,`u`.`lastname` AS `Фамилия`,`u`.`phone` AS `Телефон`,`o`.`status` AS `Статус заказа`,(`op`.`count` * `p`.`price`) AS `Сумма к оплате`,`d`.`discount` AS `Скидка`,floor(((`op`.`count` * `p`.`price`) - (((`op`.`count` * `p`.`price`) * `d`.`discount`) / 100))) AS `Сумма к оплате со скидкой` from ((((`users` `u` join `orders` `o` on((`o`.`user_id` = `u`.`id`))) join `orders_pizzas` `op` on((`op`.`order_id` = `o`.`id`))) left join `pizzas` `p` on((`p`.`id` = `op`.`pizza_id`))) left join `discounts` `d` on((`d`.`user_id` = `u`.`id`))) where (`o`.`status` <> 'Отменен') */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `names_pizzas_toppings`
--

/*!50001 DROP VIEW IF EXISTS `names_pizzas_toppings`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `names_pizzas_toppings` AS select `p`.`name` AS `Название пиццы`,`t`.`name` AS `Название топпинга` from ((`toppings` `t` join `pizzas_toppings` `pt` on((`t`.`id` = `pt`.`topping_id`))) join `pizzas` `p` on((`p`.`id` = `pt`.`pizza_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-09-21 17:53:43
