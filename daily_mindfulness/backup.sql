-- MySQL dump 10.13  Distrib 8.0.40, for Linux (x86_64)
--
-- Host: localhost    Database: daily_mindfulness
-- ------------------------------------------------------
-- Server version	8.0.40-0ubuntu0.22.04.1

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
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',2,'add_permission'),(6,'Can change permission',2,'change_permission'),(7,'Can delete permission',2,'delete_permission'),(8,'Can view permission',2,'view_permission'),(9,'Can add group',3,'add_group'),(10,'Can change group',3,'change_group'),(11,'Can delete group',3,'delete_group'),(12,'Can view group',3,'view_group'),(13,'Can add user',4,'add_user'),(14,'Can change user',4,'change_user'),(15,'Can delete user',4,'delete_user'),(16,'Can view user',4,'view_user'),(17,'Can add content type',5,'add_contenttype'),(18,'Can change content type',5,'change_contenttype'),(19,'Can delete content type',5,'delete_contenttype'),(20,'Can view content type',5,'view_contenttype'),(21,'Can add session',6,'add_session'),(22,'Can change session',6,'change_session'),(23,'Can delete session',6,'delete_session'),(24,'Can view session',6,'view_session'),(25,'Can add meditation',7,'add_meditation'),(26,'Can change meditation',7,'change_meditation'),(27,'Can delete meditation',7,'delete_meditation'),(28,'Can view meditation',7,'view_meditation'),(29,'Can add quote',8,'add_quote'),(30,'Can change quote',8,'change_quote'),(31,'Can delete quote',8,'delete_quote'),(32,'Can view quote',8,'view_quote'),(33,'Can add tracker',9,'add_tracker'),(34,'Can change tracker',9,'change_tracker'),(35,'Can delete tracker',9,'delete_tracker'),(36,'Can view tracker',9,'view_tracker');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES (1,'pbkdf2_sha256$720000$vEUGcoEex1DX4kJmgt0Nqp$rST+0MDvEXKak9HkMQYLo/LUtHyP7XYmoH6kt805qsg=','2024-12-12 18:48:36.676598',1,'heran','','','herany119@gmail.com',1,1,'2024-12-12 18:38:05.935680');
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_groups` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_groups`
--

LOCK TABLES `auth_user_groups` WRITE;
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_user_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `authtoken_token`
--

DROP TABLE IF EXISTS `authtoken_token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `authtoken_token` (
  `key` varchar(40) NOT NULL,
  `created` datetime(6) NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`key`),
  UNIQUE KEY `user_id` (`user_id`),
  CONSTRAINT `authtoken_token_user_id_35299eff_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `authtoken_token`
--

LOCK TABLES `authtoken_token` WRITE;
/*!40000 ALTER TABLE `authtoken_token` DISABLE KEYS */;
/*!40000 ALTER TABLE `authtoken_token` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_meditation`
--

DROP TABLE IF EXISTS `core_meditation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `core_meditation` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `title` varchar(100) NOT NULL,
  `duration` int NOT NULL,
  `theme` varchar(50) NOT NULL,
  `url` varchar(200) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_meditation`
--

LOCK TABLES `core_meditation` WRITE;
/*!40000 ALTER TABLE `core_meditation` DISABLE KEYS */;
/*!40000 ALTER TABLE `core_meditation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_quote`
--

DROP TABLE IF EXISTS `core_quote`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `core_quote` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `text` longtext NOT NULL,
  `source` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_quote`
--

LOCK TABLES `core_quote` WRITE;
/*!40000 ALTER TABLE `core_quote` DISABLE KEYS */;
INSERT INTO `core_quote` VALUES (1,'Peace comes from within. Do not seek it without.','Buddha'),(2,'The mind is everything. What you think, you become.','Buddha'),(3,'You only lose what you cling to.','Buddha'),(4,'Be where you are; otherwise, you will miss your life.','Thich Nhat Hanh'),(5,'Awareness is the greatest agent for change.','Eckhart Tolle'),(6,'Radiate boundless love towards the entire world.','Buddha'),(7,'If you want others to be happy, practice compassion. If you want to be happy, practice compassion.','Dalai Lama'),(8,'Hatred does not cease by hatred, but only by love; this is the eternal rule.','Buddha'),(9,'Our prime purpose in this life is to help others. And if you can\'t help them, at least don\'t hurt them.','Dalai Lama'),(10,'An idea that is developed and put into action is more important than an idea that exists only as an idea.','Buddha'),(11,'Do not dwell in the past, do not dream of the future, concentrate the mind on the present moment.','Buddha'),(12,'The root of suffering is attachment.','Buddha'),(13,'In the end, these things matter most: How well did you love? How fully did you live? How deeply did you let go?','Buddha'),(14,'Thousands of candles can be lit from a single candle, and the life of the candle will not be shortened. Happiness never decreases by being shared.','Buddha'),(15,'It is better to conquer yourself than to win a thousand battles.','Buddha'),(16,'No matter how hard the past, you can always begin again.','Buddha'),(17,'To understand everything is to forgive everything.','Buddha'),(18,'Mindfulness is the path to freedom. When you let go of distractions, you find yourself at peace.','Seon Master Jinje'),(19,'Do not try to control the river; let it flow, and you will find clarity in its motion.','Seung Sahn (Korean Zen Master)'),(20,'Be still like a mountain; move like a great river. This is the way of true balance.','Korean Buddhist Proverb'),(21,'When your mind is quiet, the universe speaks.','Seon Master Daehaeng'),(22,'Your practice is not separate from your life. Every step is the path.','Hyecho (an ancient Korean monk)'),(23,'When you see others suffer, do not turn away. Compassion is the mirror of enlightenment.','Seung Sahn'),(24,'A kind heart is more valuable than any treasure. It is the seed of happiness.','Korean Buddhist Proverb'),(25,'We are not separate beings; we are waves of the same ocean.','Seon Master Beopjeong'),(26,'The path to enlightenment begins with helping another person take a step forward.','Seon Master Jinje'),(27,'Happiness comes not from taking but from giving. Offer yourself to the world.','Seung Sahn'),(28,'If the mind is clear, even in chaos, you will see the truth.','Korean Buddhist Proverb'),(29,'To find yourself, lose yourself in the service of others.','Beopjeong'),(30,'Failure is not the end. It is a chance to understand the lesson hidden within.','Korean Zen Teaching'),(31,'Do not fight the storm; learn to dance in the rain.','Seon Master Daehaeng'),(32,'Enlightenment is not in distant lands. It is in the cup of tea you hold.','Seung Sahn');
/*!40000 ALTER TABLE `core_quote` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_tracker`
--

DROP TABLE IF EXISTS `core_tracker`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `core_tracker` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` varchar(50) NOT NULL,
  `activity_type` varchar(50) NOT NULL,
  `timestamp` datetime(6) NOT NULL,
  `duration` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_tracker`
--

LOCK TABLES `core_tracker` WRITE;
/*!40000 ALTER TABLE `core_tracker` DISABLE KEYS */;
INSERT INTO `core_tracker` VALUES (1,'john_doe','meditation','2024-12-12 19:13:21.906513',30);
/*!40000 ALTER TABLE `core_tracker` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_admin_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `django_admin_log_chk_1` CHECK ((`action_flag` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (1,'2024-12-12 18:50:18.462348','1','Peace comes from within. Do not seek it without.',1,'[{\"added\": {}}]',8,1),(2,'2024-12-12 18:50:25.382242','2','The mind is everything. What you think, you become',1,'[{\"added\": {}}]',8,1),(3,'2024-12-12 18:50:38.953325','3','You only lose what you cling to.',1,'[{\"added\": {}}]',8,1),(4,'2024-12-12 18:50:50.267803','4','Be where you are; otherwise, you will miss your li',1,'[{\"added\": {}}]',8,1),(5,'2024-12-12 18:50:59.577443','5','Awareness is the greatest agent for change.',1,'[{\"added\": {}}]',8,1),(6,'2024-12-12 18:51:05.719287','6','Radiate boundless love towards the entire world.',1,'[{\"added\": {}}]',8,1),(7,'2024-12-12 18:51:16.069892','7','If you want others to be happy, practice compassio',1,'[{\"added\": {}}]',8,1),(8,'2024-12-12 18:51:23.068928','8','Hatred does not cease by hatred, but only by love;',1,'[{\"added\": {}}]',8,1),(9,'2024-12-12 18:51:30.728625','9','Our prime purpose in this life is to help others. ',1,'[{\"added\": {}}]',8,1),(10,'2024-12-12 18:51:51.104405','10','An idea that is developed and put into action is m',1,'[{\"added\": {}}]',8,1),(11,'2024-12-12 18:51:56.474869','11','Do not dwell in the past, do not dream of the futu',1,'[{\"added\": {}}]',8,1),(12,'2024-12-12 18:52:07.691074','12','The root of suffering is attachment.',1,'[{\"added\": {}}]',8,1),(13,'2024-12-12 18:52:19.858603','13','In the end, these things matter most: How well did',1,'[{\"added\": {}}]',8,1),(14,'2024-12-12 18:52:30.641022','14','Thousands of candles can be lit from a single cand',1,'[{\"added\": {}}]',8,1),(15,'2024-12-12 18:52:41.203505','15','It is better to conquer yourself than to win a tho',1,'[{\"added\": {}}]',8,1),(16,'2024-12-12 18:52:48.606304','16','No matter how hard the past, you can always begin ',1,'[{\"added\": {}}]',8,1),(17,'2024-12-12 18:53:01.496183','17','To understand everything is to forgive everything.',1,'[{\"added\": {}}]',8,1),(18,'2024-12-12 18:54:16.865427','18','Mindfulness is the path to freedom. When you let g',1,'[{\"added\": {}}]',8,1),(19,'2024-12-12 18:54:31.712518','19','Do not try to control the river; let it flow, and ',1,'[{\"added\": {}}]',8,1),(20,'2024-12-12 18:54:41.916054','20','Be still like a mountain; move like a great river.',1,'[{\"added\": {}}]',8,1),(21,'2024-12-12 18:54:54.187507','21','When your mind is quiet, the universe speaks.',1,'[{\"added\": {}}]',8,1),(22,'2024-12-12 18:55:03.209385','22','Your practice is not separate from your life. Ever',1,'[{\"added\": {}}]',8,1),(23,'2024-12-12 18:55:09.920494','23','When you see others suffer, do not turn away. Comp',1,'[{\"added\": {}}]',8,1),(24,'2024-12-12 18:55:26.822257','24','A kind heart is more valuable than any treasure. I',1,'[{\"added\": {}}]',8,1),(25,'2024-12-12 18:55:35.008092','25','We are not separate beings; we are waves of the sa',1,'[{\"added\": {}}]',8,1),(26,'2024-12-12 18:55:42.473447','26','The path to enlightenment begins with helping anot',1,'[{\"added\": {}}]',8,1),(27,'2024-12-12 18:55:49.408741','27','Happiness comes not from taking but from giving. O',1,'[{\"added\": {}}]',8,1),(28,'2024-12-12 18:56:06.124192','28','If the mind is clear, even in chaos, you will see ',1,'[{\"added\": {}}]',8,1),(29,'2024-12-12 18:56:14.611124','29','To find yourself, lose yourself in the service of ',1,'[{\"added\": {}}]',8,1),(30,'2024-12-12 18:56:21.444644','30','Failure is not the end. It is a chance to understa',1,'[{\"added\": {}}]',8,1),(31,'2024-12-12 18:56:35.023090','31','Do not fight the storm; learn to dance in the rain',1,'[{\"added\": {}}]',8,1),(32,'2024-12-12 18:56:42.044770','32','Enlightenment is not in distant lands. It is in th',1,'[{\"added\": {}}]',8,1);
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(3,'auth','group'),(2,'auth','permission'),(4,'auth','user'),(5,'contenttypes','contenttype'),(7,'core','meditation'),(8,'core','quote'),(9,'core','tracker'),(6,'sessions','session');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_migrations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2024-12-12 18:34:54.721643'),(2,'auth','0001_initial','2024-12-12 18:34:55.865579'),(3,'admin','0001_initial','2024-12-12 18:34:56.113713'),(4,'admin','0002_logentry_remove_auto_add','2024-12-12 18:34:56.123117'),(5,'admin','0003_logentry_add_action_flag_choices','2024-12-12 18:34:56.130427'),(6,'contenttypes','0002_remove_content_type_name','2024-12-12 18:34:56.237837'),(7,'auth','0002_alter_permission_name_max_length','2024-12-12 18:34:56.336676'),(8,'auth','0003_alter_user_email_max_length','2024-12-12 18:34:56.363380'),(9,'auth','0004_alter_user_username_opts','2024-12-12 18:34:56.371230'),(10,'auth','0005_alter_user_last_login_null','2024-12-12 18:34:56.444764'),(11,'auth','0006_require_contenttypes_0002','2024-12-12 18:34:56.452836'),(12,'auth','0007_alter_validators_add_error_messages','2024-12-12 18:34:56.462835'),(13,'auth','0008_alter_user_username_max_length','2024-12-12 18:34:56.563179'),(14,'auth','0009_alter_user_last_name_max_length','2024-12-12 18:34:56.668014'),(15,'auth','0010_alter_group_name_max_length','2024-12-12 18:34:56.690586'),(16,'auth','0011_update_proxy_permissions','2024-12-12 18:34:56.699202'),(17,'auth','0012_alter_user_first_name_max_length','2024-12-12 18:34:56.804038'),(18,'core','0001_initial','2024-12-12 18:34:56.916468'),(19,'sessions','0001_initial','2024-12-12 18:34:56.982216'),(20,'core','0002_tracker_duration','2024-12-12 19:03:29.475718'),(21,'authtoken','0001_initial','2024-12-12 19:34:33.310446'),(22,'authtoken','0002_auto_20160226_1747','2024-12-12 19:34:33.329287'),(23,'authtoken','0003_tokenproxy','2024-12-12 19:34:33.334270'),(24,'authtoken','0004_alter_tokenproxy_options','2024-12-12 19:34:33.341811');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('bvkqhubza1lfekjem3saiae1az25wrpr','.eJxVjMsOwiAQRf-FtSG8Cy7d-w1khgGpGkhKuzL-uzbpQrf3nHNfLMK21riNvMSZ2JlJdvrdENIjtx3QHdqt89TbuszId4UfdPBrp_y8HO7fQYVRv7UAp7UG74SdsJBFYclqL6WB4JLVAQMqCFjQEEEwzhqv9EQimFQgKfb-AM0FN54:1tLoEm:BI9vGrYOAR6kYbCFLd11JPsnnScFplMKDSoPoUP59Yg','2024-12-26 18:48:36.682194');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-12-12 21:42:43
