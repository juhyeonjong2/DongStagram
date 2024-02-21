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
INSERT INTO `account` VALUES (1,'','n',0,'n'),(2,'','y',0,'n'),(3,'','y',0,'n'),(4,'','y',0,'n'),(5,'','y',0,'n');
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `board`
--

LOCK TABLES `board` WRITE;
/*!40000 ALTER TABLE `board` DISABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `boardattach`
--

LOCK TABLES `boardattach` WRITE;
/*!40000 ALTER TABLE `boardattach` DISABLE KEYS */;
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
INSERT INTO `cert` VALUES ('e537bf4d0d8c091463e76c959fd816eb20124a55293229183e16d2007291a206','2024-02-21 09:11:44',2),('553a8d82b4c851ac86d91f4f1b9ac723114a8d6ae706f47e630f36a9db873ad5','2024-02-21 09:12:53',4);
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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `member`
--

LOCK TABLES `member` WRITE;
/*!40000 ALTER TABLE `member` DISABLE KEYS */;
INSERT INTO `member` VALUES (1,'admin','관리자','administrator','admin@dongstagram.com',2,'2024-02-21 07:02:19','n','81dc9bdb52d04dc20036dbd8313ed055'),(2,'vhahaha','주현종','vag366','vkdlfjfxm2@naver.com',1,'2024-02-21 07:10:55','n','08266f81b52d69980f7612861e27db60'),(3,'neblasta','전우성','neblasta','neblasta85@gmail.com',1,'2024-02-21 07:11:42','n','08266f81b52d69980f7612861e27db60'),(4,'mustwin','김건승','mustwiner','rjstmd369@naver.com',1,'2024-02-21 07:12:40','n','08266f81b52d69980f7612861e27db60'),(5,'lifreed','테스터','tester','lifreed85@gmail.com',1,'2024-02-21 07:13:03','n','08266f81b52d69980f7612861e27db60');
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `memberattach`
--

LOCK TABLES `memberattach` WRITE;
/*!40000 ALTER TABLE `memberattach` DISABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notification`
--

LOCK TABLES `notification` WRITE;
/*!40000 ALTER TABLE `notification` DISABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reply`
--

LOCK TABLES `reply` WRITE;
/*!40000 ALTER TABLE `reply` DISABLE KEYS */;
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

-- Dump completed on 2024-02-21 16:15:21
