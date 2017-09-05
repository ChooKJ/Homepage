-- MySQL dump 10.13  Distrib 5.6.27, for Win64 (x86_64)
--
-- Host: localhost    Database: 12111684
-- ------------------------------------------------------
-- Server version	5.6.27-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `board`
--

DROP TABLE IF EXISTS `board`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `board` (
  `NUM` int(11) NOT NULL AUTO_INCREMENT COMMENT '번호',
  `SUBJECT` varchar(250) NOT NULL COMMENT '제목',
  `WRITER` varchar(50) NOT NULL COMMENT '작성자',
  `CONTENTS` text COMMENT '내용',
  `HIT` int(11) DEFAULT NULL COMMENT '조회수',
  `IP` varchar(30) NOT NULL COMMENT '아이피',
  `REG_DATE` datetime NOT NULL COMMENT '등록 일시',
  `MOD_DATE` datetime DEFAULT NULL COMMENT '수정 일시',
  `AREA` varchar(50) DEFAULT NULL COMMENT '장소',
  `PERIOD` varchar(50) DEFAULT NULL COMMENT '기간',
  `LATITUDE` varchar(50) DEFAULT NULL COMMENT '위도',
  `LONGTITUDE` varchar(50) DEFAULT NULL COMMENT '경도',
  PRIMARY KEY (`NUM`),
  UNIQUE KEY `NUM` (`NUM`)
) ENGINE=MyISAM AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COMMENT='게시판';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `board`
--

LOCK TABLES `board` WRITE;
/*!40000 ALTER TABLE `board` DISABLE KEYS */;
INSERT INTO `board` VALUES (5,'<축제> 크리스마스 파티','추교정','<p>d</p>',44,'0:0:0:0:0:0:0:1','2015-12-19 04:10:21','2015-12-20 23:51:44','안양','12.25','37.402455','126.928123'),(4,'<맛집> 숯불 닭갈비 맛집','박상민','<p>asd</p>',25,'0:0:0:0:0:0:0:1','2015-12-19 04:10:10','2015-12-20 23:50:17','춘천','365','37.872352','127.735740'),(6,'<관광><축제> 해운대 파티','김민수','<p>ㅁㄴㅇㄹㄹㅇㅁㄴ</p>',21,'0:0:0:0:0:0:0:1','2015-12-19 06:09:11','2015-12-20 23:53:12','부산','12.25 - 12.31','35.160688','129.177373'),(8,'<관광> 모락산 등산 대회','강지호','<p>ff</p>',55,'0:0:0:0:0:0:0:1','2015-12-19 06:11:47','2015-12-20 23:53:42','안양','01.01','37.368620','126.981283'),(9,'<축제> 홍대 클럽 행사중','정찬우','<p>홍대 클럽 새벽 3시까지 무료입장!</p>',6,'0:0:0:0:0:0:0:1','2015-12-20 00:17:57','2015-12-21 00:45:10','홍익대학교','02.01 - 02.15','37.550911','126.925725'),(10,'<맛집><축제> 끌레드쉐프','추교정','<p>크리스마스 기간 50%할인</p>',10,'0:0:0:0:0:0:0:1','2015-12-20 00:18:38','2015-12-21 00:42:42','안양 범계','12.01 - 12.31','37.389039','126.950420'),(11,'<축제><관광> 서울대공원 축제','조현수','<p>서울 대공원에서 해당 기간 동안 축제를 합니다!</p>',10,'0:0:0:0:0:0:0:1','2015-12-20 02:05:38','2015-12-21 00:39:03','서울','12.01 - 01.31','37.427495','127.016993'),(12,'<맛집> 비빔밥','전기훈','<p>맛있는 비빔밥집 입니다!</p>',4,'0:0:0:0:0:0:0:1','2015-12-20 22:07:41','2015-12-20 23:54:10','전주','365','35.819355','127.110655');
/*!40000 ALTER TABLE `board` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `board2`
--

DROP TABLE IF EXISTS `board2`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `board2` (
  `NUM` int(11) NOT NULL AUTO_INCREMENT COMMENT '번호',
  `SUBJECT` varchar(250) NOT NULL COMMENT '제목',
  `WRITER` varchar(50) NOT NULL COMMENT '작성자',
  `CONTENTS` text COMMENT '내용',
  `HIT` int(11) DEFAULT NULL COMMENT '조회수',
  `IP` varchar(30) NOT NULL COMMENT '아이피',
  `REG_DATE` datetime NOT NULL COMMENT '등록 일시',
  `MOD_DATE` datetime DEFAULT NULL COMMENT '수정 일시',
  `AREA` varchar(50) DEFAULT NULL COMMENT '장소',
  `PERIOD` varchar(50) DEFAULT NULL COMMENT '기간',
  `LATITUDE` varchar(50) DEFAULT NULL COMMENT '위도',
  `LONGTITUDE` varchar(50) DEFAULT NULL COMMENT '경도',
  PRIMARY KEY (`NUM`),
  UNIQUE KEY `NUM` (`NUM`)
) ENGINE=MyISAM AUTO_INCREMENT=18 DEFAULT CHARSET=utf8 COMMENT='게시판';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `board2`
--

LOCK TABLES `board2` WRITE;
/*!40000 ALTER TABLE `board2` DISABLE KEYS */;
INSERT INTO `board2` VALUES (13,'<축제리뷰> 인하대학교 축제','추교정','<p>인하대학교 축제 정말 재밌어요!</p><p>컴공술집 짱</p>',29,'0:0:0:0:0:0:0:1','2015-12-21 02:03:22','2015-12-21 02:03:22','인하대학교','09.09 - 09.12','37.449557','126.65317'),(14,'<축제리뷰> 홍익대학교 축제 리뷰해요','김광수','<p>재밌긴한데 인하대학교가 더 재밌네요</p>',2,'0:0:0:0:0:0:0:1','2015-12-21 02:04:36','2015-12-21 02:04:36','홍익대학교','09.09 - 09.12','37.551479','126.925014'),(15,'<맛집리뷰> 인하대학교 봉구스밥버거','정준하','<p>아싸라서 많이 가는데 맛있어서 좋아요</p>',14,'0:0:0:0:0:0:0:1','2015-12-21 02:06:33','2015-12-21 02:06:33','인하대학교','12.20','37.449763','126.653148'),(16,'<관광리뷰> 여수밤바다 좋아요!!','추교정','<p>여수 밤바다 노래 듣고 좋나 왔는데 만족시켜주네요~</p>',0,'0:0:0:0:0:0:0:1','2015-12-21 02:10:05','2015-12-21 02:10:05','여수','12.15','34.756021','127.660564'),(17,'<맛집리뷰> 자갈치시장','추교정','<p>회가 365일 신선하고 맛있네요!</p>',0,'0:0:0:0:0:0:0:1','2015-12-21 02:12:26','2015-12-21 02:12:26','부산','365','35.096705','129.030435');
/*!40000 ALTER TABLE `board2` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2015-12-21  6:26:12
