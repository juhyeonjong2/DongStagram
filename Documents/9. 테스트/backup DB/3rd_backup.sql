-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: localhost    Database: dongstagram
-- ------------------------------------------------------
-- Server version	8.0.35

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
-- Table structure for table `account`
--

DROP TABLE IF EXISTS `account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `account` (
  `mno` int unsigned NOT NULL COMMENT '회원번호',
  `intro` varchar(150) DEFAULT NULL COMMENT '소개',
  `openyn` char(1) NOT NULL COMMENT '계정 공개 여부',
  `gender` int DEFAULT NULL COMMENT '성별',
  `blockyn` char(1) NOT NULL COMMENT '관리자에 의한 블럭여부',
  KEY `mno` (`mno`),
  CONSTRAINT `account_ibfk_1` FOREIGN KEY (`mno`) REFERENCES `member` (`mno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account`
--

LOCK TABLES `account` WRITE;
/*!40000 ALTER TABLE `account` DISABLE KEYS */;
INSERT INTO `account` VALUES (1,'','n',0,'n'),(2,'버스 정기권 잃어버렸다 ㅠㅠ','y',1,'n'),(3,'','y',0,'n'),(4,'','y',0,'n'),(5,'','y',0,'n'),(6,'안녕하세요~','y',0,'n'),(7,'전북 천하제일 요리 대회 금상 수상한 요리왕입니다\r\n베트남에서 유학중입니다','y',1,'n'),(8,'전주 사파리 본점입니다\r\n문의는 010-0000-0000','y',0,'n'),(9,'여행중이니 말 걸지 마세요','y',2,'n'),(10,'소개 문구가 없습니다.','y',1,'n'),(11,'반가워~~~~','y',2,'n'),(12,'힘들어','y',0,'n'),(13,'겨울 좋아!','y',0,'n');
/*!40000 ALTER TABLE `account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `blockaccount`
--

DROP TABLE IF EXISTS `blockaccount`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `blockaccount` (
  `mno` int unsigned NOT NULL COMMENT '회원번호',
  `rdate` timestamp NOT NULL COMMENT '차단일',
  `blockmno` int unsigned NOT NULL COMMENT '차단한 회원번호',
  KEY `mno` (`mno`),
  CONSTRAINT `blockaccount_ibfk_1` FOREIGN KEY (`mno`) REFERENCES `member` (`mno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blockaccount`
--

LOCK TABLES `blockaccount` WRITE;
/*!40000 ALTER TABLE `blockaccount` DISABLE KEYS */;
/*!40000 ALTER TABLE `blockaccount` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `blockboard`
--

DROP TABLE IF EXISTS `blockboard`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `blockboard` (
  `mno` int unsigned NOT NULL COMMENT '회원번호',
  `bno` int unsigned NOT NULL COMMENT '글번호',
  `rdate` timestamp NULL DEFAULT NULL COMMENT '차단일',
  KEY `mno` (`mno`),
  KEY `bno` (`bno`),
  CONSTRAINT `blockboard_ibfk_1` FOREIGN KEY (`mno`) REFERENCES `member` (`mno`),
  CONSTRAINT `blockboard_ibfk_2` FOREIGN KEY (`bno`) REFERENCES `board` (`bno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blockboard`
--

LOCK TABLES `blockboard` WRITE;
/*!40000 ALTER TABLE `blockboard` DISABLE KEYS */;
/*!40000 ALTER TABLE `blockboard` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `board`
--

DROP TABLE IF EXISTS `board`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `board` (
  `bno` int unsigned NOT NULL AUTO_INCREMENT COMMENT '글번호',
  `blockyn` char(1) DEFAULT NULL COMMENT '관리자에 의한 블럭 여부',
  `shorturi` varchar(50) DEFAULT NULL COMMENT '짧은경로',
  `bhit` int NOT NULL COMMENT '조회수',
  `bfavorite` int NOT NULL COMMENT '좋아요',
  `wdate` timestamp NOT NULL COMMENT '작성일',
  `mno` int unsigned NOT NULL COMMENT '회원번호',
  `bopen` char(1) NOT NULL COMMENT '게시물 공개',
  `fopen` char(1) NOT NULL COMMENT '좋아요 공개',
  `rallow` char(1) NOT NULL COMMENT '댓글기능허용',
  PRIMARY KEY (`bno`),
  KEY `mno` (`mno`),
  CONSTRAINT `board_ibfk_1` FOREIGN KEY (`mno`) REFERENCES `member` (`mno`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `board`
--

LOCK TABLES `board` WRITE;
/*!40000 ALTER TABLE `board` DISABLE KEYS */;
INSERT INTO `board` VALUES (1,NULL,'B',0,3,'2024-02-22 14:49:42',6,'y','y','y'),(2,NULL,'C',0,1,'2024-02-22 14:59:34',6,'y','y','y'),(3,NULL,'D',0,3,'2024-02-22 15:01:51',2,'y','y','y'),(4,NULL,'E',0,3,'2024-02-22 15:10:16',2,'y','y','y'),(5,NULL,'F',0,3,'2024-02-22 15:11:55',2,'y','y','y'),(6,NULL,'G',0,3,'2024-02-22 15:12:58',2,'y','y','y'),(7,NULL,'H',0,0,'2024-02-22 15:19:10',7,'y','y','y'),(8,NULL,'I',0,0,'2024-02-22 15:20:18',7,'y','y','y'),(9,NULL,'J',0,0,'2024-02-22 15:21:51',7,'y','y','y'),(10,NULL,'K',0,0,'2024-02-22 15:23:20',7,'y','y','y'),(11,NULL,'L',0,0,'2024-02-22 15:23:37',7,'y','y','y'),(12,NULL,'M',0,0,'2024-02-22 15:24:09',7,'y','y','y'),(13,NULL,'N',0,0,'2024-02-22 15:24:42',7,'y','y','y'),(14,NULL,'O',0,2,'2024-02-22 15:33:45',8,'y','y','y'),(15,NULL,'P',0,0,'2024-02-22 15:35:31',8,'y','y','y'),(16,NULL,'Q',0,1,'2024-02-22 15:36:01',8,'y','y','y'),(17,NULL,'R',0,1,'2024-02-22 15:36:41',8,'y','y','y'),(18,NULL,'S',0,1,'2024-02-22 15:37:30',8,'y','y','y'),(19,NULL,'T',0,3,'2024-02-22 15:41:03',9,'y','y','y'),(20,NULL,'U',0,2,'2024-02-22 15:42:03',9,'y','y','y'),(21,NULL,'V',0,2,'2024-02-22 15:43:08',9,'y','y','y'),(22,NULL,'W',0,1,'2024-02-22 15:46:34',10,'y','y','y'),(23,NULL,'X',0,0,'2024-02-22 15:47:28',10,'y','y','y'),(24,NULL,'Y',0,0,'2024-02-22 15:47:59',10,'y','y','y'),(25,NULL,'Z',0,0,'2024-02-22 15:49:05',10,'y','y','y'),(26,NULL,'a',0,1,'2024-02-22 15:55:43',12,'y','y','y'),(27,NULL,'b',0,2,'2024-02-22 15:56:33',12,'y','y','y'),(28,NULL,'c',0,1,'2024-02-22 16:00:58',13,'y','y','y'),(29,NULL,'d',0,0,'2024-02-22 16:01:18',13,'y','y','y'),(30,NULL,'e',0,0,'2024-02-22 16:01:39',13,'y','y','y'),(31,NULL,'f',0,0,'2024-02-22 16:09:45',6,'y','y','y'),(32,NULL,'g',0,0,'2024-02-22 16:11:07',2,'y','y','y');
/*!40000 ALTER TABLE `board` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `boardattach`
--

DROP TABLE IF EXISTS `boardattach`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `boardattach` (
  `mfno` int unsigned NOT NULL AUTO_INCREMENT COMMENT '미디어 파일 번호',
  `bfidx` int unsigned NOT NULL COMMENT '관리번호',
  `bfrealname` varchar(100) NOT NULL COMMENT '실제이름',
  `bforeignname` varchar(100) NOT NULL COMMENT '외부이름',
  `rdate` timestamp NOT NULL COMMENT '등록일',
  `bno` int unsigned NOT NULL COMMENT '게시글번호',
  PRIMARY KEY (`mfno`),
  KEY `bno` (`bno`),
  CONSTRAINT `boardattach_ibfk_1` FOREIGN KEY (`bno`) REFERENCES `board` (`bno`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `boardattach`
--

LOCK TABLES `boardattach` WRITE;
/*!40000 ALTER TABLE `boardattach` DISABLE KEYS */;
INSERT INTO `boardattach` VALUES (1,2,'penguin-1867414_1280.jpg','penguin-1867414_1280.jpg','2024-02-22 14:49:42',1),(2,1,'humboldt-penguin-7711121_1280.jpg','humboldt-penguin-7711121_1280.jpg','2024-02-22 14:49:42',1),(3,0,'cape-town-5741110_1280.jpg','cape-town-5741110_1280.jpg','2024-02-22 14:49:42',1),(4,0,'gentoo-penguin-7073391_12807.jpg','gentoo-penguin-7073391_1280.jpg','2024-02-22 14:59:34',2),(5,0,'cats-8105667_1280.jpg','cats-8105667_1280.jpg','2024-02-22 15:01:51',3),(6,1,'gibbon-8573117_1280.jpg','gibbon-8573117_1280.jpg','2024-02-22 15:10:16',4),(7,0,'mountain-8310076_1280.jpg','mountain-8310076_1280.jpg','2024-02-22 15:10:16',4),(8,0,'cat-8446390_1280.jpg','cat-8446390_1280.jpg','2024-02-22 15:11:55',5),(9,0,'dog-8179668_1280.jpg','dog-8179668_1280.jpg','2024-02-22 15:12:58',6),(10,0,'mandarins-8437425_1280.jpg','mandarins-8437425_1280.jpg','2024-02-22 15:19:10',7),(11,0,'strawberries-8177601_1280.jpg','strawberries-8177601_1280.jpg','2024-02-22 15:20:18',8),(12,2,'chocolate-8455786_12801.jpg','chocolate-8455786_1280.jpg','2024-02-22 15:21:51',9),(13,1,'sweet-potatoes-8295778_1280.jpg','sweet-potatoes-8295778_1280.jpg','2024-02-22 15:21:51',9),(14,0,'potatoes-8474361_1280.jpg','potatoes-8474361_1280.jpg','2024-02-22 15:21:51',9),(15,0,'backpack-8029117_1280.png','backpack-8029117_1280.png','2024-02-22 15:23:20',10),(16,0,'ai-generated-8578423_1280.jpg','ai-generated-8578423_1280.jpg','2024-02-22 15:23:37',11),(17,0,'chocolate-8455786_12802.jpg','chocolate-8455786_1280.jpg','2024-02-22 15:24:09',12),(18,0,'books-8405721_1280.jpg','books-8405721_1280.jpg','2024-02-22 15:24:42',13),(19,1,'gibbon-8573117_1280.jpg','gibbon-8573117_1280.jpg','2024-02-22 15:33:45',14),(20,0,'european-shorthair-8142967_1280.jpg','european-shorthair-8142967_1280.jpg','2024-02-22 15:33:45',14),(21,0,'mongoose-7844724_1280.jpg','mongoose-7844724_1280.jpg','2024-02-22 15:35:31',15),(22,0,'dog-8179668_1280.jpg','dog-8179668_1280.jpg','2024-02-22 15:36:01',16),(23,0,'sheep-7943526_1280.jpg','sheep-7943526_1280.jpg','2024-02-22 15:36:41',17),(24,1,'squirrel-8473819_1280.jpg','squirrel-8473819_1280.jpg','2024-02-22 15:37:30',18),(25,0,'building-8373618_1280.jpg','building-8373618_1280.jpg','2024-02-22 15:37:30',18),(26,0,'backpack-7832746_12801.jpg','backpack-7832746_1280.jpg','2024-02-22 15:41:03',19),(27,0,'port-8431044_1280.jpg','port-8431044_1280.jpg','2024-02-22 15:42:03',20),(28,0,'vietnam-8420600_1280.jpg','vietnam-8420600_1280.jpg','2024-02-22 15:43:08',21),(29,0,'cat-8415620_1280.jpg','cat-8415620_1280.jpg','2024-02-22 15:46:34',22),(30,0,'clover-8108105_1280.jpg','clover-8108105_1280.jpg','2024-02-22 15:47:28',23),(31,1,'flowers-8564949_1280.png','flowers-8564949_1280.png','2024-02-22 15:47:59',24),(32,0,'cosmos-8546570_1280.jpg','cosmos-8546570_1280.jpg','2024-02-22 15:47:59',24),(33,0,'nature-8280318_1280.png','nature-8280318_1280.png','2024-02-22 15:49:05',25),(34,0,'cat-8282097_1280.jpg','cat-8282097_1280.jpg','2024-02-22 15:55:43',26),(35,0,'laundry-8424501_1280.jpg','laundry-8424501_1280.jpg','2024-02-22 15:56:33',27),(36,0,'trees-8512979_1280.jpg','trees-8512979_1280.jpg','2024-02-22 16:00:58',28),(37,0,'surfboard-7976219_1280.jpg','surfboard-7976219_1280.jpg','2024-02-22 16:01:18',29),(38,0,'winter-8456170_1280.png','winter-8456170_1280.png','2024-02-22 16:01:39',30),(39,0,'christmas-8380345_12801.png','christmas-8380345_1280.png','2024-02-22 16:09:45',31),(40,0,'backpack-8029117_1280.png','backpack-8029117_1280.png','2024-02-22 16:11:07',32);
/*!40000 ALTER TABLE `boardattach` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `boardview`
--

DROP TABLE IF EXISTS `boardview`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `boardview` (
  `bno` int unsigned NOT NULL COMMENT '글번호',
  `mno` int unsigned NOT NULL COMMENT '회원번호',
  `rdate` timestamp NOT NULL COMMENT '확인일',
  KEY `bno` (`bno`),
  KEY `mno` (`mno`),
  CONSTRAINT `boardview_ibfk_1` FOREIGN KEY (`bno`) REFERENCES `board` (`bno`),
  CONSTRAINT `boardview_ibfk_2` FOREIGN KEY (`mno`) REFERENCES `member` (`mno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `boardview`
--

LOCK TABLES `boardview` WRITE;
/*!40000 ALTER TABLE `boardview` DISABLE KEYS */;
/*!40000 ALTER TABLE `boardview` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cert`
--

DROP TABLE IF EXISTS `cert`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cert` (
  `hash` char(64) NOT NULL,
  `expiretime` timestamp NOT NULL COMMENT '만료기간',
  `mno` int unsigned NOT NULL COMMENT '회원번호',
  KEY `mno` (`mno`),
  CONSTRAINT `cert_ibfk_1` FOREIGN KEY (`mno`) REFERENCES `member` (`mno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cert`
--

LOCK TABLES `cert` WRITE;
/*!40000 ALTER TABLE `cert` DISABLE KEYS */;
INSERT INTO `cert` VALUES ('553a8d82b4c851ac86d91f4f1b9ac723114a8d6ae706f47e630f36a9db873ad5','2024-02-21 09:12:53',4),('2b83c2e032454bfb20bc228cfba0d169c530d343d242d6e0da5b3e65faee2113','2024-02-22 18:03:57',8),('9778da3c1b593c9b170a2e8c69f800aaebaa41fd3eae2761b1203d32a769a914','2024-02-22 18:11:29',2);
/*!40000 ALTER TABLE `cert` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `favorite`
--

DROP TABLE IF EXISTS `favorite`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `favorite` (
  `mno` int unsigned NOT NULL COMMENT '회원번호',
  `bno` int unsigned NOT NULL COMMENT '글번호',
  KEY `mno` (`mno`),
  KEY `bno` (`bno`),
  CONSTRAINT `favorite_ibfk_1` FOREIGN KEY (`mno`) REFERENCES `member` (`mno`),
  CONSTRAINT `favorite_ibfk_2` FOREIGN KEY (`bno`) REFERENCES `board` (`bno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `favorite`
--

LOCK TABLES `favorite` WRITE;
/*!40000 ALTER TABLE `favorite` DISABLE KEYS */;
INSERT INTO `favorite` VALUES (6,1),(7,1),(7,2),(9,14),(9,16),(9,19),(9,20),(9,21),(10,22),(10,5),(10,3),(10,6),(10,4),(12,17),(12,26),(12,27),(12,3),(12,4),(12,5),(12,6),(12,14),(12,19),(12,20),(12,21),(13,27),(13,3),(13,4),(13,5),(13,6),(13,18),(8,19),(8,28),(2,1);
/*!40000 ALTER TABLE `favorite` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `follow`
--

DROP TABLE IF EXISTS `follow`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `follow` (
  `frommno` int unsigned NOT NULL COMMENT '요청한 회원번호',
  `tommo` int unsigned NOT NULL COMMENT '요청받은 회원번호',
  `state` char(3) NOT NULL COMMENT '상태',
  `rdate` timestamp NULL DEFAULT NULL COMMENT '갱신일자',
  KEY `frommno` (`frommno`),
  CONSTRAINT `follow_ibfk_1` FOREIGN KEY (`frommno`) REFERENCES `member` (`mno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `follow`
--

LOCK TABLES `follow` WRITE;
/*!40000 ALTER TABLE `follow` DISABLE KEYS */;
INSERT INTO `follow` VALUES (2,6,'ACK','2024-02-22 15:07:03'),(7,2,'ACK','2024-02-22 15:16:30'),(7,6,'ACK','2024-02-22 15:27:53'),(10,6,'ACK','2024-02-22 15:50:03'),(12,2,'ACK','2024-02-22 15:56:51'),(12,11,'ACK','2024-02-22 15:57:55'),(12,10,'ACK','2024-02-22 15:58:47'),(13,2,'ACK','2024-02-22 16:01:53'),(13,8,'ACK','2024-02-22 16:02:17'),(8,13,'ACK','2024-02-22 16:03:49');
/*!40000 ALTER TABLE `follow` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `joincert`
--

DROP TABLE IF EXISTS `joincert`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `joincert` (
  `email` varchar(100) NOT NULL COMMENT '이메일',
  `cert` char(8) NOT NULL COMMENT '인증번호',
  `expiretime` timestamp NOT NULL COMMENT '만료일',
  `verifyyn` char(1) DEFAULT NULL COMMENT '인증유무',
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `joincert`
--

LOCK TABLES `joincert` WRITE;
/*!40000 ALTER TABLE `joincert` DISABLE KEYS */;
/*!40000 ALTER TABLE `joincert` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `member`
--

DROP TABLE IF EXISTS `member`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `member` (
  `mno` int unsigned NOT NULL AUTO_INCREMENT COMMENT '회원번호',
  `mid` varchar(50) NOT NULL COMMENT '아이디',
  `mname` text COMMENT '이름',
  `mnick` varchar(50) NOT NULL COMMENT '닉네임',
  `email` varchar(50) NOT NULL COMMENT '이메일',
  `mlevel` int unsigned DEFAULT NULL COMMENT '권한',
  `joindate` timestamp NULL DEFAULT NULL COMMENT '가입일',
  `delyn` char(1) DEFAULT NULL COMMENT '탈퇴 여부',
  `mpassword` varchar(32) NOT NULL COMMENT '패스워드',
  PRIMARY KEY (`mno`),
  UNIQUE KEY `mnick` (`mnick`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `mid` (`mid`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `member`
--

LOCK TABLES `member` WRITE;
/*!40000 ALTER TABLE `member` DISABLE KEYS */;
INSERT INTO `member` VALUES (1,'admin','관리자','administrator','admin@dongstagram.com',2,'2024-02-21 07:02:19','n','81dc9bdb52d04dc20036dbd8313ed055'),(2,'vhahaha','주현종','vag366','vkdlfjfxm2@naver.com',1,'2024-02-21 07:10:55','n','08266f81b52d69980f7612861e27db60'),(3,'neblasta','전우성','neblasta','neblasta85@gmail.com',1,'2024-02-21 07:11:42','n','08266f81b52d69980f7612861e27db60'),(4,'mustwin','김건승','mustwiner','rjstmd369@naver.com',1,'2024-02-21 07:12:40','n','08266f81b52d69980f7612861e27db60'),(5,'lifreed','테스터','tester','lifreed85@gmail.com',1,'2024-02-21 07:13:03','n','08266f81b52d69980f7612861e27db60'),(6,'aaaa1','팽귄','Penguin','aaaa@dongstrgram.com',1,'2024-02-21 07:02:20','n','08266f81b52d69980f7612861e27db60'),(7,'aaaa2','요리왕','cookman','aaaa2@dongstrgram.com',1,'2024-02-21 07:02:20','n','08266f81b52d69980f7612861e27db60'),(8,'aaaa3','전주사파리','animal','aaaa3@dongstrgram.com',1,'2024-02-21 07:02:20','n','08266f81b52d69980f7612861e27db60'),(9,'aaaa4','여행자','traveller','aaaa4@dongstrgram.com',1,'2024-02-21 07:02:20','n','08266f81b52d69980f7612861e27db60'),(10,'aaaa5','그림맨','pictureman','aaaa5@dongstrgram.com',1,'2024-02-21 07:02:20','n','08266f81b52d69980f7612861e27db60'),(11,'aaaa6','이수','alert','aaaa6@dongstrgram.com',1,'2024-02-21 07:02:20','n','08266f81b52d69980f7612861e27db60'),(12,'aaaa7','행복해','happy','aaaa7@dongstrgram.com',1,'2024-02-21 07:02:20','n','08266f81b52d69980f7612861e27db60'),(13,'aaaa8','모기','mosquito','aaaa8@dongstrgram.com',1,'2024-02-21 07:02:20','n','08266f81b52d69980f7612861e27db60');
/*!40000 ALTER TABLE `member` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `memberattach`
--

DROP TABLE IF EXISTS `memberattach`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `memberattach` (
  `mfno` int unsigned NOT NULL AUTO_INCREMENT COMMENT '미디어 파일번호',
  `mfrealname` varchar(100) NOT NULL COMMENT '실제이름',
  `mforeignname` varchar(100) NOT NULL COMMENT '외부이름',
  `rdate` timestamp NOT NULL COMMENT '등록일',
  `mno` int unsigned NOT NULL COMMENT '회원번호',
  PRIMARY KEY (`mfno`),
  KEY `mno` (`mno`),
  CONSTRAINT `memberattach_ibfk_1` FOREIGN KEY (`mno`) REFERENCES `member` (`mno`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `memberattach`
--

LOCK TABLES `memberattach` WRITE;
/*!40000 ALTER TABLE `memberattach` DISABLE KEYS */;
INSERT INTO `memberattach` VALUES (1,'gentoo-penguin-7073391_12806.jpg','gentoo-penguin-7073391_1280.jpg','2024-02-22 14:57:31',6),(2,'robot-8449206_1280.jpg','robot-8449206_1280.jpg','2024-02-22 15:06:15',2),(3,'chocolate-8455786_1280.jpg','chocolate-8455786_1280.jpg','2024-02-22 15:18:16',7),(4,'christmas-8380345_1280.png','christmas-8380345_1280.png','2024-02-22 15:35:01',8),(5,'backpack-7832746_1280.jpg','backpack-7832746_1280.jpg','2024-02-22 15:40:29',9),(6,'woman-8402067_1280.jpg','woman-8402067_1280.jpg','2024-02-22 15:46:54',10),(7,'girls-8458409_1280.jpg','girls-8458409_1280.jpg','2024-02-22 15:53:20',11),(8,'bridge-7989080_1280.jpg','bridge-7989080_1280.jpg','2024-02-22 15:55:14',12),(9,'snowman-8413769_1280.jpg','snowman-8413769_1280.jpg','2024-02-22 16:00:37',13);
/*!40000 ALTER TABLE `memberattach` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notification`
--

DROP TABLE IF EXISTS `notification`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notification` (
  `mno` int unsigned NOT NULL COMMENT '회원번호',
  `code` char(2) NOT NULL COMMENT '알람 코드',
  `targetmno` int unsigned NOT NULL COMMENT '대상 회원번호',
  `nno` int unsigned NOT NULL AUTO_INCREMENT COMMENT '알림번호',
  PRIMARY KEY (`nno`),
  KEY `mno` (`mno`),
  CONSTRAINT `notification_ibfk_1` FOREIGN KEY (`mno`) REFERENCES `member` (`mno`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notification`
--

LOCK TABLES `notification` WRITE;
/*!40000 ALTER TABLE `notification` DISABLE KEYS */;
INSERT INTO `notification` VALUES (6,'FW',2,1),(2,'FW',7,2),(6,'FW',7,3),(6,'FW',10,4),(2,'FW',12,5),(11,'FW',12,6),(10,'FW',12,7),(2,'FW',13,8),(8,'FW',13,9),(13,'FW',8,10);
/*!40000 ALTER TABLE `notification` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notificationview`
--

DROP TABLE IF EXISTS `notificationview`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notificationview` (
  `nno` int unsigned NOT NULL COMMENT '알림번호',
  `mno` int unsigned NOT NULL COMMENT '회원번호',
  `rdate` timestamp NOT NULL COMMENT '확인일',
  KEY `notificationview_ibfk_1` (`nno`),
  KEY `notificationview_ibfk_2` (`mno`),
  CONSTRAINT `notificationview_ibfk_1` FOREIGN KEY (`nno`) REFERENCES `notification` (`nno`) ON DELETE CASCADE,
  CONSTRAINT `notificationview_ibfk_2` FOREIGN KEY (`mno`) REFERENCES `member` (`mno`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notificationview`
--

LOCK TABLES `notificationview` WRITE;
/*!40000 ALTER TABLE `notificationview` DISABLE KEYS */;
/*!40000 ALTER TABLE `notificationview` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reply`
--

DROP TABLE IF EXISTS `reply`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reply` (
  `rno` int unsigned NOT NULL AUTO_INCREMENT COMMENT '댓글 번호',
  `ridx` int unsigned NOT NULL COMMENT '관리인덱스',
  `rdate` timestamp NOT NULL COMMENT '작성일',
  `rmdate` timestamp NULL DEFAULT NULL COMMENT '수정일',
  `rpno` int unsigned DEFAULT NULL COMMENT '부모 댓글',
  `mno` int unsigned NOT NULL COMMENT '회원번호',
  `bno` int unsigned NOT NULL COMMENT '글번호',
  `rcontent` varchar(2200) NOT NULL COMMENT '내용',
  PRIMARY KEY (`rno`),
  KEY `mno` (`mno`),
  KEY `bno` (`bno`),
  CONSTRAINT `reply_ibfk_1` FOREIGN KEY (`mno`) REFERENCES `member` (`mno`),
  CONSTRAINT `reply_ibfk_2` FOREIGN KEY (`bno`) REFERENCES `board` (`bno`)
) ENGINE=InnoDB AUTO_INCREMENT=66 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reply`
--

LOCK TABLES `reply` WRITE;
/*!40000 ALTER TABLE `reply` DISABLE KEYS */;
INSERT INTO `reply` VALUES (1,0,'2024-02-22 14:49:42',NULL,0,6,1,'우리 아들 성장과정@@@'),(2,0,'2024-02-22 14:59:34',NULL,0,6,2,'아이 밥주는 시간은 너무 행복해요!'),(3,0,'2024-02-22 15:01:51',NULL,0,2,3,'나도 고양이 키운다!!'),(4,1,'2024-02-22 15:03:22',NULL,4,2,1,'정말 보기 좋네요'),(5,1,'2024-02-22 15:06:50',NULL,5,2,2,' 뭘 주는 건가요?'),(6,0,'2024-02-22 15:10:16',NULL,0,2,4,'뒷산에 놀러갔더니 원숭이를 봤어요! 이건 무슨 원숭이인가요?'),(7,0,'2024-02-22 15:11:55',NULL,0,2,5,'우리집 고양이 키운지 1년... 벌써 이렇게 성장했네요 ㅠㅠ'),(8,0,'2024-02-22 15:12:58',NULL,0,2,6,'제가 그림을 그려봤는데 어떤가요? 솔직한 평가 부탁드립니다'),(9,1,'2024-02-22 15:16:52',NULL,9,7,4,'그 원숭이 제가 키우는 원숭이에요 돌려주세요'),(10,0,'2024-02-22 15:19:10',NULL,0,7,7,'직접 재배한 귤입니다. 한박스당 35000원에 판매중이고 물물교환도 가능합니다'),(11,0,'2024-02-22 15:20:18',NULL,0,7,8,'옆집에서 딸기 훔쳐왔는데 혹시 저 처벌되나요?'),(12,0,'2024-02-22 15:21:51',NULL,0,7,9,'감자초콜릿 만드는 방법\r\n1. 감자를 씻는다\r\n2. 감자를 볶는다\r\n3. 볶은 감자를 녹여 초콜릿을 만든다\r\n정말 쉬우니 여러분들도 만들어 보세요~'),(13,0,'2024-02-22 15:23:20',NULL,0,7,10,'가방 새로 샀어요'),(14,0,'2024-02-22 15:23:37',NULL,0,7,11,'제가 그린 그림입니다'),(15,0,'2024-02-22 15:24:09',NULL,0,7,12,'역시 사먹는 초콜릿이 제일 맛있네요'),(16,0,'2024-02-22 15:24:42',NULL,0,7,13,'요즘 한식자격증 준비중입니다'),(17,1,'2024-02-22 15:25:17',NULL,17,7,6,'솔직히 별로입니다'),(18,1,'2024-02-22 15:25:39',NULL,18,7,5,'사진 짤렸어요'),(19,1,'2024-02-22 15:26:02',NULL,19,7,1,'저도 같이 키워도 될까요?'),(20,1,'2024-02-22 15:27:48',NULL,20,7,2,'제가 만든 요리는 안먹이나요?'),(21,1,'2024-02-22 15:28:54',NULL,21,7,11,'왜 아무도 댓글 안달지?'),(22,0,'2024-02-22 15:33:45',NULL,0,8,14,'전주사파리입니다 무료로 운영하니 모두 놀러와 주세요~'),(23,0,'2024-02-22 15:35:31',NULL,0,8,15,'새로들어온 여우!'),(24,0,'2024-02-22 15:36:01',NULL,0,8,16,'제 친구가 그려준 저희 강아지 사진인 너무 좋네요!'),(25,0,'2024-02-22 15:36:41',NULL,0,8,17,'염소 좋아!'),(26,0,'2024-02-22 15:37:30',NULL,0,8,18,'새로 다람쥐 우리를 건설중이니 조금만 기다려주세요!!!!'),(27,1,'2024-02-22 15:39:22',NULL,27,9,14,'역시 고양이는 좋네요'),(28,1,'2024-02-22 15:39:40',NULL,28,9,17,'지금 가도 염소 있나요?'),(29,1,'2024-02-22 15:40:00',NULL,29,9,16,'저도 그림 잘그리는데 제가 그려줘도 될까요?'),(30,0,'2024-02-22 15:41:03',NULL,0,9,19,'백두산 여행왔는데 별거없네\r\n평점 : 10/5'),(31,0,'2024-02-22 15:42:03',NULL,0,9,20,'부산 놀러갔는데 ㄱㅊ네\r\n평점 : 10/8'),(32,0,'2024-02-22 15:43:08',NULL,0,9,21,'태국 불상에서 공부중\r\n평점 : 10/8'),(33,0,'2024-02-22 15:46:34',NULL,0,10,22,'고양이 그림을 그려봤는데 어때?'),(34,0,'2024-02-22 15:47:28',NULL,0,10,23,'오늘 그림은 네잎클로버'),(35,0,'2024-02-22 15:47:59',NULL,0,10,24,'오늘 본 코스모스를 그려봤어'),(36,0,'2024-02-22 15:49:05',NULL,0,10,25,'작품명 : 추억안의 소리'),(37,1,'2024-02-22 15:49:47',NULL,37,10,21,'나도 같이 여행가도 될까?'),(38,1,'2024-02-22 15:50:16',NULL,38,10,1,'반가워 난 그림맨이야'),(39,1,'2024-02-22 15:51:33',NULL,39,10,6,'잘그렸어 '),(40,1,'2024-02-22 15:51:44',NULL,40,10,5,'정말 귀여워'),(41,0,'2024-02-22 15:55:43',NULL,0,12,26,'고양이가 날 째려봐ㅜㅜ'),(42,0,'2024-02-22 15:56:33',NULL,0,12,27,'집안일 하기 힘드네'),(43,1,'2024-02-22 15:57:10',NULL,43,12,6,'음....'),(44,1,'2024-02-22 15:57:34',NULL,44,12,14,'사진 더 주세요'),(45,1,'2024-02-22 15:57:42',NULL,45,12,17,'염소 좋네요'),(46,1,'2024-02-22 15:58:12',NULL,46,12,19,'ㅋㅋㅋ'),(47,1,'2024-02-22 15:58:22',NULL,47,12,20,'거기 부산 아닌데...'),(48,1,'2024-02-22 15:58:35',NULL,48,12,21,'?'),(49,1,'2024-02-22 15:58:54',NULL,49,12,22,'good'),(50,1,'2024-02-22 15:59:03',NULL,50,12,25,'설명좀'),(51,1,'2024-02-22 16:00:06',NULL,51,13,27,'너가 하니?'),(52,0,'2024-02-22 16:00:58',NULL,0,13,28,'겨울 좋아!'),(53,0,'2024-02-22 16:01:18',NULL,0,13,29,'우리 아빠ㅋㅋㅋ'),(54,0,'2024-02-22 16:01:39',NULL,0,13,30,'그림맨 님이 그려주셨어!'),(55,1,'2024-02-22 16:02:09',NULL,55,13,6,'ㅎㅎㅎㅎ'),(56,1,'2024-02-22 16:02:23',NULL,56,13,14,'어디에요?'),(57,1,'2024-02-22 16:02:30',NULL,57,13,15,'오!'),(58,1,'2024-02-22 16:02:39',NULL,58,13,18,'시급이 얼마죠?'),(59,1,'2024-02-22 16:02:54',NULL,59,13,17,'겨울에도 염소 볼 수 있죠?'),(60,1,'2024-02-22 16:03:28',NULL,60,8,19,'좋던데'),(61,1,'2024-02-22 16:03:45',NULL,61,8,28,'그래서?'),(62,0,'2024-02-22 16:09:45',NULL,0,6,31,'루돌프 만나고 싶다..'),(63,0,'2024-02-22 16:11:07',NULL,0,2,32,'이 가방 어디서 사나요?'),(64,1,'2024-02-22 16:11:18',NULL,64,2,31,'저도요'),(65,1,'2024-02-22 16:11:29',NULL,65,2,1,'ㅋㅋㅋㅋㅋ');
/*!40000 ALTER TABLE `reply` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reportaccount`
--

DROP TABLE IF EXISTS `reportaccount`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reportaccount` (
  `mno` int unsigned NOT NULL COMMENT '회원번호',
  `reason` text COMMENT '신고사유',
  `rdate` timestamp NOT NULL COMMENT '신고일',
  `reportmno` int unsigned NOT NULL COMMENT '신고한 회원번호',
  KEY `mno` (`mno`),
  CONSTRAINT `reportaccount_ibfk_1` FOREIGN KEY (`mno`) REFERENCES `member` (`mno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reportaccount`
--

LOCK TABLES `reportaccount` WRITE;
/*!40000 ALTER TABLE `reportaccount` DISABLE KEYS */;
/*!40000 ALTER TABLE `reportaccount` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reportboard`
--

DROP TABLE IF EXISTS `reportboard`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reportboard` (
  `mno` int unsigned NOT NULL COMMENT '회원번호',
  `bno` int unsigned NOT NULL COMMENT '글번호',
  `rdate` timestamp NOT NULL COMMENT '신고일',
  `reason` text COMMENT '신고사요',
  KEY `mno` (`mno`),
  KEY `bno` (`bno`),
  CONSTRAINT `reportboard_ibfk_1` FOREIGN KEY (`mno`) REFERENCES `member` (`mno`),
  CONSTRAINT `reportboard_ibfk_2` FOREIGN KEY (`bno`) REFERENCES `board` (`bno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reportboard`
--

LOCK TABLES `reportboard` WRITE;
/*!40000 ALTER TABLE `reportboard` DISABLE KEYS */;
/*!40000 ALTER TABLE `reportboard` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `searchhistory`
--

DROP TABLE IF EXISTS `searchhistory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `searchhistory` (
  `mno` int unsigned NOT NULL COMMENT '회원번호',
  `type` varchar(10) NOT NULL COMMENT '타입',
  `words` text NOT NULL COMMENT '검색어',
  KEY `mno` (`mno`),
  CONSTRAINT `searchhistory_ibfk_1` FOREIGN KEY (`mno`) REFERENCES `member` (`mno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `searchhistory`
--

LOCK TABLES `searchhistory` WRITE;
/*!40000 ALTER TABLE `searchhistory` DISABLE KEYS */;
INSERT INTO `searchhistory` VALUES (10,'nick','Penguin'),(10,'nick','vag366'),(12,'nick','vag366'),(12,'nick','animal'),(12,'nick','alert'),(12,'nick','traveller'),(12,'nick','pictureman'),(13,'nick','vag366'),(13,'nick','animal'),(8,'nick','animal'),(8,'nick','traveller'),(8,'nick','mosquito');
/*!40000 ALTER TABLE `searchhistory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `temppassword`
--

DROP TABLE IF EXISTS `temppassword`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `temppassword` (
  `tpassword` char(32) NOT NULL COMMENT '임시비밀번호 해시값',
  `expiretime` timestamp NOT NULL COMMENT '만료기간',
  `mno` int unsigned NOT NULL COMMENT '회원번호',
  UNIQUE KEY `mno` (`mno`),
  CONSTRAINT `temppassword_ibfk_1` FOREIGN KEY (`mno`) REFERENCES `member` (`mno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `temppassword`
--

LOCK TABLES `temppassword` WRITE;
/*!40000 ALTER TABLE `temppassword` DISABLE KEYS */;
/*!40000 ALTER TABLE `temppassword` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-02-23  1:13:22
