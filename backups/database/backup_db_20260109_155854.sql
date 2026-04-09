/*M!999999\- enable the sandbox mode */ 
-- MariaDB dump 10.19  Distrib 10.11.13-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: 77piaui7
-- ------------------------------------------------------
-- Server version	10.11.10-MariaDB-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `adicao_saldo`
--

DROP TABLE IF EXISTS `adicao_saldo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `adicao_saldo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_user` int(11) NOT NULL,
  `valor` int(11) NOT NULL DEFAULT 0,
  `tipo` varchar(255) DEFAULT NULL,
  `data_registro` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=278 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `adicao_saldo`
--

LOCK TABLES `adicao_saldo` WRITE;
/*!40000 ALTER TABLE `adicao_saldo` DISABLE KEYS */;
INSERT INTO `adicao_saldo` VALUES
(272,376421720,10,'deposito_pix','2025-12-22 01:38:53'),
(273,435780174,600,'comissao_cpa_nivel_1','2025-12-22 01:38:53'),
(274,474629937,130,'comissao_cpa_nivel_2','2025-12-22 01:38:53'),
(275,954635750,50,'comissao_cpa_nivel_3','2025-12-22 01:38:53'),
(276,954635750,10,'adicao','2026-01-01 20:52:07'),
(277,983452589,20,'adicao','2026-01-02 02:19:10');
/*!40000 ALTER TABLE `adicao_saldo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `admin_users`
--

DROP TABLE IF EXISTS `admin_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `admin_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nome` text NOT NULL,
  `email` text NOT NULL,
  `contato` text DEFAULT NULL,
  `senha` text NOT NULL,
  `nivel` int(11) NOT NULL DEFAULT 0,
  `status` int(11) NOT NULL DEFAULT 0,
  `token_recover` text DEFAULT NULL,
  `avatar` text DEFAULT NULL,
  `2fa` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin_users`
--

LOCK TABLES `admin_users` WRITE;
/*!40000 ALTER TABLE `admin_users` DISABLE KEYS */;
INSERT INTO `admin_users` VALUES
(15,'m7','m7sistemas@gmail.com','','$2y$10$MpIuBqJg9dnlLd964k9JeO3CTQTO9vHhbHu3QqoHCY/dEn5X8xgDu',0,1,NULL,'','$2y$10$SSCA9eESxyYC.qANZSBTouQAm2VT60HL/1qz7HBwfADAs/qIzzV6C');
/*!40000 ALTER TABLE `admin_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `afiliados_config`
--

DROP TABLE IF EXISTS `afiliados_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `afiliados_config` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cpaLvl1` decimal(10,2) DEFAULT NULL,
  `cpaLvl2` decimal(10,2) DEFAULT NULL,
  `cpaLvl3` decimal(10,2) DEFAULT NULL,
  `chanceCpa` decimal(5,2) DEFAULT NULL,
  `revShareFalso` decimal(5,2) DEFAULT NULL,
  `revShareLvl1` decimal(5,2) DEFAULT NULL,
  `revShareLvl2` decimal(5,2) DEFAULT NULL,
  `revShareLvl3` decimal(5,2) DEFAULT NULL,
  `minDepForCpa` decimal(10,2) DEFAULT NULL,
  `minResgate` decimal(10,2) DEFAULT NULL,
  `pagar_baus` tinyint(1) DEFAULT 1,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `afiliados_config`
--

LOCK TABLES `afiliados_config` WRITE;
/*!40000 ALTER TABLE `afiliados_config` DISABLE KEYS */;
INSERT INTO `afiliados_config` VALUES
(1,60.00,13.00,5.00,100.00,0.00,0.00,0.00,0.00,10.00,100.00,0);
/*!40000 ALTER TABLE `afiliados_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `aurenpay`
--

DROP TABLE IF EXISTS `aurenpay`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `aurenpay` (
  `id` int(11) NOT NULL,
  `url` varchar(255) DEFAULT NULL,
  `client_id` text DEFAULT NULL,
  `client_secret` text DEFAULT NULL,
  `atualizado` varchar(45) DEFAULT NULL,
  `ativo` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aurenpay`
--

LOCK TABLES `aurenpay` WRITE;
/*!40000 ALTER TABLE `aurenpay` DISABLE KEYS */;
INSERT INTO `aurenpay` VALUES
(1,'https://api.aurenpay.com','jh','hg',NULL,0);
/*!40000 ALTER TABLE `aurenpay` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `banner`
--

DROP TABLE IF EXISTS `banner`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `banner` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `titulo` varchar(255) NOT NULL,
  `criado_em` timestamp NOT NULL DEFAULT current_timestamp(),
  `img` text NOT NULL,
  `status` int(11) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `banner`
--

LOCK TABLES `banner` WRITE;
/*!40000 ALTER TABLE `banner` DISABLE KEYS */;
INSERT INTO `banner` VALUES
(1,'Banner 1','2024-06-28 21:10:47','1765223614_1992364286665105410 (2).jpeg',1),
(2,'Banner 2','2024-06-28 21:08:02','1765223619_1992368887643783169.jpeg',1),
(3,'Banner 3','2024-06-28 21:08:02','1765223624_1992364087962222593.jpeg',1),
(4,'Banner 4','2024-06-28 21:08:02','1765223630_1992364177287438338.jpeg',1),
(5,'Banner 5','2024-06-28 21:08:02','1765223636_1992364374808023041.jpeg',1);
/*!40000 ALTER TABLE `banner` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bau`
--

DROP TABLE IF EXISTS `bau`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `bau` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_user` int(11) DEFAULT NULL,
  `num` text DEFAULT NULL,
  `status` varchar(20) DEFAULT NULL,
  `token` varchar(255) DEFAULT NULL,
  `is_get` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=260 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bau`
--

LOCK TABLES `bau` WRITE;
/*!40000 ALTER TABLE `bau` DISABLE KEYS */;
INSERT INTO `bau` VALUES
(250,NULL,'','user novo','93574d45c2288294a0a562514b83514c',0),
(251,NULL,'','user novo','57e78b36f47923599db18bef0fc05100',0),
(252,NULL,'','user novo','959c312dde426c33194b42b37c27d235',0),
(253,NULL,'','user novo','9de0fd6ac95d4a441a88f04a0ccf7cbc',0),
(254,NULL,'','user novo','8edfc3e7015c3bbe9e6099db7151cca1',0),
(255,NULL,'','user novo','a05232f7363e685655645e4ceed61dad',0),
(256,NULL,'','user novo','9f038752a49f51173fec47e507292c72',0),
(257,NULL,'','user novo','412d9db7c7ebbfbcf73485aeaf459b4c',0),
(258,NULL,'','user novo','3195f76b47fec5e295de2413de40e761',0),
(259,NULL,'','user novo','7e7791067e5ce14a8e596e93c1e3d80c',0);
/*!40000 ALTER TABLE `bau` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bspay`
--

DROP TABLE IF EXISTS `bspay`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `bspay` (
  `id` int(11) NOT NULL,
  `url` varchar(255) DEFAULT NULL,
  `client_id` text DEFAULT NULL,
  `client_secret` text DEFAULT NULL,
  `atualizado` varchar(45) DEFAULT NULL,
  `ativo` int(11) DEFAULT NULL,
  `invite_code` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bspay`
--

LOCK TABLES `bspay` WRITE;
/*!40000 ALTER TABLE `bspay` DISABLE KEYS */;
INSERT INTO `bspay` VALUES
(1,'https://api.bspay.co','kh','kj',NULL,0,NULL);
/*!40000 ALTER TABLE `bspay` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `config`
--

DROP TABLE IF EXISTS `config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `config` (
  `id` int(11) NOT NULL,
  `nome` varchar(255) DEFAULT NULL,
  `nome_site` text DEFAULT NULL,
  `descricao` text DEFAULT NULL,
  `grupoplataforma` varchar(255) DEFAULT NULL,
  `logo` text DEFAULT NULL,
  `avatar` text DEFAULT NULL,
  `download` varchar(255) DEFAULT NULL,
  `icone_download` varchar(255) DEFAULT NULL,
  `telegram` text DEFAULT NULL,
  `instagram` text DEFAULT NULL,
  `whatsapp` text DEFAULT NULL,
  `suporte` text DEFAULT NULL,
  `email` varchar(45) DEFAULT NULL,
  `sublogo` text DEFAULT NULL,
  `facebookads` text DEFAULT NULL,
  `rodapelogo` text DEFAULT NULL,
  `favicon` text DEFAULT NULL,
  `googleAnalytics` text DEFAULT NULL,
  `minplay` int(11) DEFAULT NULL,
  `minsaque` double DEFAULT NULL,
  `maxsaque` int(11) DEFAULT 1000,
  `saque_automatico` int(11) NOT NULL,
  `rollover` int(11) DEFAULT NULL,
  `mindep` text DEFAULT NULL,
  `jackpot` int(11) DEFAULT NULL,
  `navbar` int(11) DEFAULT NULL,
  `numero_jackpot` int(11) DEFAULT NULL,
  `jackpot_custom` text DEFAULT NULL,
  `cor_padrao` varchar(45) NOT NULL,
  `background_padrao` varchar(50) DEFAULT NULL,
  `custom_css` longtext NOT NULL,
  `texto` varchar(45) NOT NULL,
  `img_seo` text DEFAULT NULL,
  `keyword` text DEFAULT NULL,
  `marquee` text DEFAULT NULL,
  `status_topheader` int(11) NOT NULL DEFAULT 0,
  `cor_topheader` varchar(48) DEFAULT '#ed1c24',
  `niveisbau` text DEFAULT NULL,
  `qntsbaus` int(11) DEFAULT NULL,
  `nvlbau` int(11) DEFAULT NULL,
  `pessoasbau` int(11) DEFAULT NULL,
  `tema` int(11) DEFAULT NULL,
  `versao_app_android` text DEFAULT NULL,
  `versao_app_ios` text DEFAULT NULL,
  `mensagem_app` text DEFAULT NULL,
  `link_app_android` text DEFAULT NULL,
  `link_app_ios` text DEFAULT NULL,
  `broadcast` text DEFAULT NULL,
  `limite_saque` int(11) DEFAULT 0,
  `sort_jackpot` int(11) DEFAULT 1,
  `carregamento_img` varchar(255) DEFAULT NULL,
  `imagem_fundo` text DEFAULT NULL,
  `snow_flakes` text DEFAULT NULL,
  `painel_rolante` text DEFAULT NULL,
  `atendimento` text DEFAULT NULL,
  `jackpot_ativado` int(11) NOT NULL DEFAULT 1,
  `limite_de_chaves` int(11) NOT NULL DEFAULT 1,
  `facebook` varchar(255) DEFAULT NULL,
  `baixar_ativado` int(11) DEFAULT NULL,
  `topIconColor` varchar(255) DEFAULT NULL,
  `topBgColor` varchar(255) DEFAULT NULL,
  `tema_popup_inicio` int(11) NOT NULL DEFAULT 1,
  `slogan` text DEFAULT NULL,
  `comissao_gerente` varchar(255) DEFAULT NULL,
  `google_client_id` varchar(255) DEFAULT NULL,
  `google_client_secret` varchar(255) DEFAULT NULL,
  `google_login_status` int(1) DEFAULT 0,
  `menu_navbar_ativo` tinyint(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `config`
--

LOCK TABLES `config` WRITE;
/*!40000 ALTER TABLE `config` DISABLE KEYS */;
INSERT INTO `config` VALUES
(1,'777piaui','','Plataforma de entretenimento digital com sistema de sorteios e prêmios regulamentados.','Maiksuporte','img_69372ca419c9f9.12156170.png','img_69372ca419fa85.57822272.png','img_69372ca419e6a9.57088469.webp','img_69372ca419ed77.38810338.png','maiksuporte','https://instagram.com/','https://wa.me/5551981866679?=Blogueiros',NULL,'','','ID AQUI',NULL,'img_69372ca419df97.45028027.png','ID AQUI',1,10,1000,0,2,'10',0,1,2,'jackpot_69372e80232bd.png','#0096DD','#010e24','','','154504365733.png','tigrinho pagante, jogo estilo tigrinho, jogo tipo tigrinho que paga, chinesa pagante, slot pagante, slots online pagantes, plataforma pagante, plataforma que paga no pix, jogo pagante 2025, caça-níquel pagante, jogo de prêmio online, jogo que paga via pix, jogo que paga de verdade, site que paga no pix, jogos online que pagam, plataforma de prêmios, slots brasileiros pagantes, slots confiáveis, jogo parecido com tigrinho, tigrinho alternativo, jogo de prêmios instantâneos, jogo de celular que paga, app que paga via pix, jogo rápido que paga, ganhar dinheiro jogando, jogo de prêmios reais, plataforma de slots pagantes, slot da chinesa, chinesinha pagante, site de prêmios via pix, plataforma pix pagante, saque rápido pix, depósito via pix instantâneo, jogos virais que pagam, plataforma pixsorte, pixsorte pagante, pixsorte confiável, pixsorte funciona','Prezado membro -Recomendamos o plano A/B para voce, que lhe permitira ganhar R$100.000,00 por mes facilmente em casa. Acesse nosso suporte para mais informacoes.',0,'#0096dd','10,15,20,25,30,35,40,45,50',0,5,1,21,'1.0.0.1','1.0.0.2','MENSAGEM POPUP','https://google.com/','https://google.com/','PHILLYPS LINDO',10,4,'img_69372ca419f426.04345901.png','img_67e3328b16f8f2.80383522.png','img_68f6ca9661a404.35196359.png','','https://t.me/maiksuporte',1,3,'https://facebook.com/',0,'','',1,'<p><span style=\\\"color: #e03e2d;\\\">Cadastre-se e ganhe R$8.888</span><br><span style=\\\"color: #e03e2d;\\\">Convide outras pessoas e ganhe R$ 1 milh&atilde;o!</span></p>','2',NULL,NULL,0,1);
/*!40000 ALTER TABLE `config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cupom`
--

DROP TABLE IF EXISTS `cupom`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `cupom` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  `valor` int(11) NOT NULL,
  `qtd_insert` int(11) NOT NULL DEFAULT 0 COMMENT 'Quantidade inicial de cupons criados',
  `status` tinyint(1) NOT NULL DEFAULT 0 COMMENT '0: inativo / 1: ativo',
  PRIMARY KEY (`id`),
  UNIQUE KEY `nome` (`nome`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cupom`
--

LOCK TABLES `cupom` WRITE;
/*!40000 ALTER TABLE `cupom` DISABLE KEYS */;
INSERT INTO `cupom` VALUES
(1,'DEPÓSITO DE 20',500,50,1),
(2,'DEPÓSITO DE 50',200,30,1),
(3,'DEPÓSITO DE 80',150,20,1),
(4,'DEPÓSITO DE 100',100,10,1);
/*!40000 ALTER TABLE `cupom` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cupom_usados`
--

DROP TABLE IF EXISTS `cupom_usados`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `cupom_usados` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_user` int(11) NOT NULL,
  `valor` int(11) NOT NULL COMMENT 'Valor do depósito que gerou o bônus',
  `bonus` int(11) NOT NULL DEFAULT 0 COMMENT 'Valor do bônus recebido',
  `data_registro` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `id_user` (`id_user`),
  KEY `valor` (`valor`)
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cupom_usados`
--

LOCK TABLES `cupom_usados` WRITE;
/*!40000 ALTER TABLE `cupom_usados` DISABLE KEYS */;
/*!40000 ALTER TABLE `cupom_usados` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer_feedback`
--

DROP TABLE IF EXISTS `customer_feedback`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer_feedback` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `type` tinyint(4) NOT NULL,
  `content` text NOT NULL,
  `file_link` varchar(255) DEFAULT NULL,
  `source` varchar(50) NOT NULL,
  `status` varchar(20) DEFAULT 'pending',
  `reply` text DEFAULT NULL,
  `reply_time` datetime DEFAULT NULL,
  `reply_read` tinyint(1) DEFAULT 0,
  `reply_by` int(11) DEFAULT NULL,
  `bonus_amount` decimal(10,2) DEFAULT 0.00,
  `bonus_received` tinyint(1) DEFAULT 0,
  `bonus_received_at` datetime DEFAULT NULL,
  `client_time` bigint(20) NOT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_type` (`type`),
  KEY `idx_status` (`status`),
  KEY `idx_created_at` (`created_at`),
  CONSTRAINT `customer_feedback_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `usuarios` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer_feedback`
--

LOCK TABLES `customer_feedback` WRITE;
/*!40000 ALTER TABLE `customer_feedback` DISABLE KEYS */;
/*!40000 ALTER TABLE `customer_feedback` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `drakon`
--

DROP TABLE IF EXISTS `drakon`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `drakon` (
  `id` int(11) NOT NULL,
  `agent_code` varchar(64) NOT NULL,
  `agent_token` varchar(128) NOT NULL,
  `agent_secret_key` varchar(128) NOT NULL,
  `api_base` varchar(255) NOT NULL DEFAULT 'https://gator.drakon.casino/api/v1',
  `ativo` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `drakon`
--

LOCK TABLES `drakon` WRITE;
/*!40000 ALTER TABLE `drakon` DISABLE KEYS */;
INSERT INTO `drakon` VALUES
(1,'Agent Code','Agent Token','Agent Secret','https://gator.drakon.casino/api/v1',1,'2025-11-13 16:19:19','2025-11-15 19:44:09');
/*!40000 ALTER TABLE `drakon` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `expfypay`
--

DROP TABLE IF EXISTS `expfypay`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `expfypay` (
  `id` int(11) NOT NULL,
  `url` varchar(255) DEFAULT NULL,
  `client_id` text DEFAULT NULL,
  `client_secret` text DEFAULT NULL,
  `atualizado` varchar(45) DEFAULT NULL,
  `ativo` int(11) DEFAULT NULL,
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `expfypay`
--

LOCK TABLES `expfypay` WRITE;
/*!40000 ALTER TABLE `expfypay` DISABLE KEYS */;
INSERT INTO `expfypay` VALUES
(1,'https://pro.expfypay.com','pk_a8807b6d305897e27a1ad465123ab9092f925c85cfe1a32a','sk_267b38fa4141d51dbdd24d91c3cc6e836bbc27428b486aeb82a10d8e7a2b864f','0',1);
/*!40000 ALTER TABLE `expfypay` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `festival`
--

DROP TABLE IF EXISTS `festival`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `festival` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `titulo` varchar(255) NOT NULL,
  `criado_em` timestamp NOT NULL DEFAULT current_timestamp(),
  `img` text NOT NULL,
  `status` int(11) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `festival`
--

LOCK TABLES `festival` WRITE;
/*!40000 ALTER TABLE `festival` DISABLE KEYS */;
INSERT INTO `festival` VALUES
(1,'Festival 1','2025-03-25 20:58:37','/holiday/14/apng_top_jr.png',1),
(2,'Festival 2','2025-03-25 20:58:37','/holiday/14/btn_zc1_jr.avif',0),
(3,'Festival 3','2025-03-25 20:58:54','/holiday/14/btn_zc1_jr2.avif',1),
(4,'Festival 4','2025-03-25 20:59:06','/holiday/14/h5_zs_jr.avif',1),
(5,'Festival 5','2025-03-25 20:59:16','/holiday/14/h5_zs_jr2.avif',1),
(6,'Festival 6','2025-03-25 20:59:25','/holiday/14/h5_zs_jr3.avif',1),
(7,'Festival 7','2025-03-25 20:59:34','/holiday/14/icon_btm_jr.avif',1),
(8,'Festival 8','2025-03-25 20:59:47','/holiday/14/icon_btm_jr2.avif',1),
(9,'Festival 9','2025-03-25 20:59:59','/holiday/14/icon_btm_jr3.avif',1);
/*!40000 ALTER TABLE `festival` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `financeiro`
--

DROP TABLE IF EXISTS `financeiro`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `financeiro` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `usuario` int(11) DEFAULT NULL,
  `saldo` decimal(10,2) DEFAULT NULL,
  `bonus` decimal(10,2) DEFAULT NULL,
  `saldo_afiliados` decimal(10,2) NOT NULL DEFAULT 0.00,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `financeiro`
--

LOCK TABLES `financeiro` WRITE;
/*!40000 ALTER TABLE `financeiro` DISABLE KEYS */;
/*!40000 ALTER TABLE `financeiro` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `floats`
--

DROP TABLE IF EXISTS `floats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `floats` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `titulo` varchar(255) NOT NULL,
  `redirect` text DEFAULT NULL,
  `tipo` int(11) NOT NULL DEFAULT 0,
  `criado_em` timestamp NOT NULL DEFAULT current_timestamp(),
  `img` text NOT NULL,
  `status` int(11) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `floats`
--

LOCK TABLES `floats` WRITE;
/*!40000 ALTER TABLE `floats` DISABLE KEYS */;
INSERT INTO `floats` VALUES
(1,'telegram','https://t.me/maiksuporte',0,'2024-06-28 21:10:47','1751754375_1748553603_31699a44-b7df-45c3-af88-67a8470823a6.gif',1),
(2,'Recomend....','https://',0,'2024-06-28 21:08:02','1747774137_ActiveImg8075480511658811.gif',1),
(3,'Float 3',NULL,0,'2024-06-28 21:08:02','1747774181_ActiveImg8087241140451735.png',0),
(4,'Recomend ami....','https://',0,'2024-06-28 21:08:02','1751754330_1747774137_ActiveImg8075480511658811 (1).gif',0);
/*!40000 ALTER TABLE `floats` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `games`
--

DROP TABLE IF EXISTS `games`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `games` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `game_code` text NOT NULL,
  `game_name` text NOT NULL,
  `banner` text DEFAULT NULL,
  `status` int(11) NOT NULL,
  `provider` text DEFAULT NULL,
  `popular` int(11) NOT NULL DEFAULT 0,
  `type` text DEFAULT NULL,
  `game_type` varchar(255) DEFAULT NULL,
  `api` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3020447 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `games`
--

LOCK TABLES `games` WRITE;
/*!40000 ALTER TABLE `games` DISABLE KEYS */;
INSERT INTO `games` VALUES
(1,'fortune-tiger','Fortune Tiger','https://igamewin.com/storage/igamewin/1.webp',1,'PGSOFT',1,'slot','3','iGameWin'),
(2,'fortune-mouse','Fortune Mouse','https://igamewin.com/storage/igamewin/2.webp',1,'PGSOFT',1,'slot','3','iGameWin'),
(3,'fortune-ox','Fortune Ox','https://igamewin.com/storage/igamewin/3.webp',1,'PGSOFT',1,'slot','3','iGameWin'),
(4,'dragon-hatch','Dragon Hatch','https://igamewin.com/storage/igamewin/6.webp',1,'PGSOFT',1,'slot','3','iGameWin'),
(5,'ganesha-gold','Ganesha Gold','https://igamewin.com/storage/igamewin/7.webp',1,'PGSOFT',1,'slot','3','iGameWin'),
(6,'double-fortune','Double Fortune','https://igamewin.com/storage/igamewin/8.webp',1,'PGSOFT',1,'slot','3','iGameWin'),
(7,'the-great-icescape','The Great Icescape','https://igamewin.com/storage/igamewin/9.webp',1,'PGSOFT',1,'slot','3','iGameWin'),
(8,'piggy-gold','Piggy Gold','https://igamewin.com/storage/igamewin/10.webp',1,'PGSOFT',1,'slot','3','iGameWin'),
(9,'jungle-delight','Jungle Delight','https://igamewin.com/storage/igamewin/11.webp',1,'PGSOFT',1,'slot','3','iGameWin'),
(10,'captains-bounty','Captain’s Bounty','https://igamewin.com/storage/igamewin/12.webp',1,'PGSOFT',1,'slot','3','iGameWin'),
(11,'mahjong-ways','Mahjong Ways','https://igamewin.com/storage/igamewin/14.webp',1,'PGSOFT',1,'slot','3','iGameWin'),
(12,'gem-saviour-conquest','Gem Saviour Conquest','https://igamewin.com/storage/igamewin/15.webp',1,'PGSOFT',1,'slot','3','iGameWin'),
(13,'bikini-paradise','Bikini Paradise','https://igamewin.com/storage/igamewin/17.webp',1,'PGSOFT',1,'slot','3','iGameWin'),
(14,'ganesha-fortune','Ganesha Fortune','https://igamewin.com/storage/igamewin/20.webp',1,'PGSOFT',1,'slot','3','iGameWin'),
(15,'phoenix-rises','Phoenix Rises','https://igamewin.com/storage/igamewin/21.webp',1,'PGSOFT',1,'slot','3','iGameWin'),
(16,'wild-fireworks','Wild Fireworks','https://igamewin.com/storage/igamewin/22.webp',1,'PGSOFT',1,'slot','3','iGameWin'),
(17,'jewels-prosper','Jewels of Prosperity','https://igamewin.com/storage/igamewin/26.webp',1,'PGSOFT',1,'slot','3','iGameWin'),
(18,'galactic-gems','Galactic Gems','https://igamewin.com/storage/igamewin/27.webp',1,'PGSOFT',1,'slot','3','iGameWin'),
(19,'gdn-ice-fire','Guardians of Ice & Fire','https://igamewin.com/storage/igamewin/28.webp',1,'PGSOFT',1,'slot','3','iGameWin'),
(20,'wild-bandito','Wild Bandito','https://igamewin.com/storage/igamewin/29.webp',1,'PGSOFT',1,'slot','3','iGameWin'),
(21,'candy-bonanza','Candy Bonanza','https://igamewin.com/storage/igamewin/30.webp',1,'PGSOFT',1,'slot','3','iGameWin'),
(22,'majestic-ts','Majestic Treasures','https://igamewin.com/storage/igamewin/31.webp',1,'PGSOFT',1,'slot','3','iGameWin'),
(23,'crypt-fortune','Raider Jane\'s Crypt of Fortune','https://igamewin.com/storage/igamewin/32.webp',1,'PGSOFT',1,'slot','3','iGameWin'),
(24,'sprmkt-spree','Supermarket Spree','https://igamewin.com/storage/igamewin/33.webp',1,'PGSOFT',1,'slot','3','iGameWin'),
(25,'lgd-monkey-kg','Legendary Monkey King','https://igamewin.com/storage/igamewin/34.webp',1,'PGSOFT',1,'slot','3','iGameWin'),
(26,'spirit-wonder','Spirit of Wonder','https://igamewin.com/storage/igamewin/35.webp',1,'PGSOFT',1,'slot','3','iGameWin'),
(27,'emoji-riches','Emoji Riches','https://igamewin.com/storage/igamewin/36.webp',1,'PGSOFT',1,'slot','3','iGameWin'),
(28,'garuda-gems','Garuda Gems','https://igamewin.com/storage/igamewin/37.webp',1,'PGSOFT',1,'slot','3','iGameWin'),
(29,'dest-sun-moon','Destiny of Sun & Moon','https://igamewin.com/storage/igamewin/38.webp',1,'PGSOFT',1,'slot','3','iGameWin'),
(30,'btrfly-blossom','Butterfly Blossom','https://igamewin.com/storage/igamewin/39.webp',1,'PGSOFT',1,'slot','3','iGameWin'),
(31,'rooster-rbl','Rooster Rumble','https://igamewin.com/storage/igamewin/40.webp',1,'PGSOFT',1,'slot','3','iGameWin'),
(32,'battleground','Battleground Royale','https://igamewin.com/storage/igamewin/41.webp',1,'PGSOFT',1,'slot','3','iGameWin'),
(33,'fortune-rabbit','Fortune Rabbit','https://igamewin.com/storage/igamewin/42.webp',1,'PGSOFT',1,'slot','3','iGameWin'),
(34,'midas-fortune','Midas Fortune','https://igamewin.com/storage/igamewin/44.webp',1,'PGSOFT',1,'slot','3','iGameWin'),
(35,'dreams-of-macau','Dreams of Macau','https://igamewin.com/storage/igamewin/75.webp',1,'PGSOFT',1,'slot','3','iGameWin'),
(36,'lucky-neko','Lucky Neko','https://igamewin.com/storage/igamewin/77.webp',1,'PGSOFT',1,'slot','3','iGameWin'),
(37,'sct-cleopatra','Secrets of Cleopatra','https://igamewin.com/storage/igamewin/78.webp',1,'PGSOFT',1,'slot','3','iGameWin'),
(38,'thai-river','Thai River Wonders','https://igamewin.com/storage/igamewin/79.webp',1,'PGSOFT',1,'slot','3','iGameWin'),
(39,'opera-dynasty','Opera Dynasty','https://igamewin.com/storage/igamewin/80.webp',1,'PGSOFT',1,'slot','3','iGameWin'),
(40,'bali-vacation','Bali Vacation','https://igamewin.com/storage/igamewin/81.webp',1,'PGSOFT',1,'slot','3','iGameWin'),
(41,'jack-frosts','Jack Frost\'s Winter','https://igamewin.com/storage/igamewin/82.webp',1,'PGSOFT',1,'slot','3','iGameWin'),
(42,'rise-of-apollo','Rise of Apollo','https://igamewin.com/storage/igamewin/83.webp',1,'PGSOFT',1,'slot','3','iGameWin'),
(43,'mermaid-riches','Mermaid Riches','https://igamewin.com/storage/igamewin/84.webp',1,'PGSOFT',1,'slot','3','iGameWin'),
(44,'crypto-gold','Crypto Gold','https://igamewin.com/storage/igamewin/85.webp',1,'PGSOFT',1,'slot','3','iGameWin'),
(45,'heist-stakes','Heist Stakes','https://igamewin.com/storage/igamewin/86.webp',1,'PGSOFT',1,'slot','3','iGameWin'),
(46,'ways-of-qilin','Ways of the Qilin','https://igamewin.com/storage/igamewin/87.webp',1,'PGSOFT',1,'slot','3','iGameWin'),
(47,'buffalo-win','Buffalo Win','https://igamewin.com/storage/igamewin/88.webp',1,'PGSOFT',1,'slot','3','iGameWin'),
(48,'jurassic-kdm','Jurassic Kingdom','https://igamewin.com/storage/igamewin/90.webp',1,'PGSOFT',1,'slot','3','iGameWin'),
(49,'cocktail-nite','Cocktail Nights','https://igamewin.com/storage/igamewin/94.webp',1,'PGSOFT',1,'slot','3','iGameWin'),
(50,'mask-carnival','Mask Carnival','https://igamewin.com/storage/igamewin/95.webp',1,'PGSOFT',1,'slot','3','iGameWin'),
(51,'queen-banquet','The Queen\'s Banquet','https://igamewin.com/storage/igamewin/96.webp',1,'PGSOFT',1,'slot','3','iGameWin'),
(52,'speed-winner','Speed Winner','https://igamewin.com/storage/igamewin/97.webp',1,'PGSOFT',1,'slot','3','iGameWin'),
(53,'win-win-fpc','Win Win Fish Prawn Crab','https://igamewin.com/storage/igamewin/98.webp',1,'PGSOFT',1,'slot','3','iGameWin'),
(54,'lucky-piggy','Lucky Piggy','https://igamewin.com/storage/igamewin/99.webp',1,'PGSOFT',1,'slot','3','iGameWin'),
(55,'fortune-dragon','Fortune Dragon','https://igamewin.com/storage/igamewin/135.webp',1,'PGSOFT',1,'slot','3','iGameWin'),
(56,'cash-mania','Cash Mania','https://igamewin.com/storage/igamewin/136.webp',1,'PGSOFT',1,'slot','3','iGameWin'),
(57,'gemstones-gold','Gemstones Gold','https://igamewin.com/storage/igamewin/137.webp',1,'PGSOFT',1,'slot','3','iGameWin'),
(58,'dragon-hatch2','Dragon Hatch 2','https://igamewin.com/storage/igamewin/138.webp',1,'PGSOFT',1,'slot','3','iGameWin'),
(59,'werewolf-hunt','Werewolf\'s Hunt','https://igamewin.com/storage/igamewin/139.webp',1,'PGSOFT',1,'slot','3','iGameWin'),
(60,'wild-ape-3258','Wild Ape #3258','https://igamewin.com/storage/igamewin/140.webp',1,'PGSOFT',1,'slot','3','iGameWin'),
(61,'mafia-mayhem','Mafia Mayhem','https://igamewin.com/storage/igamewin/142.webp',1,'PGSOFT',1,'slot','3','iGameWin'),
(62,'forge-wealth','Forge of Wealth','https://igamewin.com/storage/igamewin/143.webp',1,'PGSOFT',1,'slot','3','iGameWin'),
(63,'wild-heist-co','Wild Heist Cashout','https://igamewin.com/storage/igamewin/144.webp',1,'PGSOFT',1,'slot','3','iGameWin'),
(64,'ninja-raccoon','Ninja Raccoon Frenzy','https://igamewin.com/storage/igamewin/145.webp',1,'PGSOFT',1,'slot','3','iGameWin'),
(65,'gladi-glory','Gladiator\'s Glory','https://igamewin.com/storage/igamewin/146.webp',1,'PGSOFT',1,'slot','3','iGameWin'),
(66,'cruise-royale','Cruise Royale','https://igamewin.com/storage/igamewin/148.webp',1,'PGSOFT',1,'slot','3','iGameWin'),
(67,'fruity-candy','Fruity Candy','https://igamewin.com/storage/igamewin/149.webp',1,'PGSOFT',1,'slot','3','iGameWin'),
(68,'lucky-clover','Lucky Clover Lady','https://igamewin.com/storage/igamewin/150.webp',1,'PGSOFT',1,'slot','3','iGameWin'),
(69,'spr-golf-drive','Super Golf Drive','https://igamewin.com/storage/igamewin/151.webp',1,'PGSOFT',1,'slot','3','iGameWin'),
(70,'myst-spirits','Mystical Spirits','https://igamewin.com/storage/igamewin/152.webp',1,'PGSOFT',1,'slot','3','iGameWin'),
(71,'songkran-spl','Songkran Splash','https://igamewin.com/storage/igamewin/153.webp',1,'PGSOFT',1,'slot','3','iGameWin'),
(72,'hawaiian-tiki','Hawaiian Tiki','https://igamewin.com/storage/igamewin/154.webp',1,'PGSOFT',1,'slot','3','iGameWin'),
(73,'rave-party-fvr','Rave Party Fever','https://igamewin.com/storage/igamewin/155.webp',1,'PGSOFT',1,'slot','3','iGameWin'),
(74,'alchemy-gold','Alchemy Gold','https://igamewin.com/storage/igamewin/157.webp',1,'PGSOFT',1,'slot','3','iGameWin'),
(75,'totem-wonders','Totem Wonders','https://igamewin.com/storage/igamewin/158.webp',1,'PGSOFT',1,'slot','3','iGameWin'),
(76,'legend-perseus','Legend of Perseus','https://igamewin.com/storage/igamewin/159.webp',1,'PGSOFT',1,'slot','3','iGameWin'),
(77,'wild-bounty-sd','Wild Bounty Showdown','https://igamewin.com/storage/igamewin/160.webp',1,'PGSOFT',1,'slot','3','iGameWin'),
(78,'wild-coaster','Wild Coaster','https://igamewin.com/storage/igamewin/161.webp',1,'PGSOFT',1,'slot','3','iGameWin'),
(79,'pinata-wins','Pinata Wins','https://igamewin.com/storage/igamewin/328.webp',1,'PGSOFT',1,'slot','3','iGameWin'),
(80,'mystic-potions','Mystic Potion','https://igamewin.com/storage/igamewin/329.webp',1,'PGSOFT',1,'slot','3','iGameWin'),
(81,'anubis-wrath','Anubis Wrath','https://igamewin.com/storage/igamewin/330.webp',1,'PGSOFT',1,'slot','3','iGameWin'),
(82,'zombie-outbrk','Zombie Outbreak','https://igamewin.com/storage/igamewin/331.webp',1,'PGSOFT',1,'slot','3','iGameWin'),
(83,'chicky-run','Chicky Run','https://igamewin.com/storage/igamewin/332.webp',1,'PGSOFT',1,'slot','3','iGameWin'),
(84,'shark-hunter','Shark Hunter','https://igamewin.com/storage/igamewin/334.webp',1,'PGSOFT',1,'slot','3','iGameWin'),
(85,'yakuza-honor','Yakuza Honor','https://igamewin.com/storage/igamewin/335.webp',1,'PGSOFT',1,'slot','3','iGameWin'),
(86,'wings-iguazu','Wings of Iguazu','https://igamewin.com/storage/igamewin/336.webp',1,'PGSOFT',1,'slot','3','iGameWin'),
(87,'three-cz-pigs','Three Crazy Piggies','https://igamewin.com/storage/igamewin/337.webp',1,'PGSOFT',1,'slot','3','iGameWin'),
(88,'oishi-delights','Oishi Delights','https://igamewin.com/storage/igamewin/338.webp',1,'PGSOFT',1,'slot','3','iGameWin'),
(89,'museum-mystery','Museum Mystery','https://igamewin.com/storage/igamewin/339.webp',1,'PGSOFT',1,'slot','3','iGameWin'),
(90,'rio-fantasia','Rio Fantasia','https://igamewin.com/storage/igamewin/340.webp',1,'PGSOFT',1,'slot','3','iGameWin'),
(91,'choc-deluxe','Chocolate Deluxe','https://igamewin.com/storage/igamewin/341.webp',1,'PGSOFT',1,'slot','3','iGameWin'),
(92,'fortune-snake','Fortune Snake','https://igamewin.com/storage/igamewin/344.webp',1,'PGSOFT',1,'slot','3','iGameWin'),
(93,'mr-treas-fort','Mr. Treasure\'s Fortune','https://igamewin.com/storage/igamewin/10584.webp',1,'PGSOFT',1,'slot','3','iGameWin'),
(94,'incan-wonders','Incan Wonders','https://igamewin.com/storage/igamewin/10585.webp',1,'PGSOFT',1,'slot','3','iGameWin'),
(95,'graffiti-rush','Graffiti Rush','https://igamewin.com/storage/igamewin/10589.webp',1,'PGSOFT',1,'slot','3','iGameWin'),
(96,'hip-hop-panda','Hip Hop Panda','https://igamewin.com/storage/igamewin/112.webp',1,'PGSOFT',1,'slot','3','iGameWin'),
(97,'candy-burst','Candy Burst','https://igamewin.com/storage/igamewin/16.webp',1,'PGSOFT',1,'slot','3','iGameWin'),
(98,'dragon-tiger-luck','Dragon Tiger Luck','https://igamewin.com/storage/igamewin/104.webp',1,'PGSOFT',1,'slot','3','iGameWin'),
(99,'fortune-gods','Fortune Gods','https://igamewin.com/storage/igamewin/10858.webp',1,'PGSOFT',1,'slot','3','iGameWin'),
(100,'santas-gift-rush','Santa\'s Gift Rush','https://igamewin.com/storage/igamewin/10859.webp',1,'PGSOFT',1,'slot','3','iGameWin'),
(101,'emperors-favour','Emperor\'s Favour','https://igamewin.com/storage/igamewin/10860.webp',1,'PGSOFT',1,'slot','3','iGameWin'),
(102,'ninja-vs-samurai','Ninja vs Samurai','https://igamewin.com/storage/igamewin/10861.webp',1,'PGSOFT',1,'slot','3','iGameWin'),
(103,'medusa','Medusa','https://igamewin.com/storage/igamewin/10863.webp',1,'PGSOFT',1,'slot','3','iGameWin'),
(104,'mr-hallow-win','Mr. Hallow-Win','https://igamewin.com/storage/igamewin/10865.webp',1,'PGSOFT',1,'slot','3','iGameWin'),
(105,'honey-trap-of-diao-chan','Honey Trap of Diao Chan','https://igamewin.com/storage/igamewin/10866.webp',1,'PGSOFT',1,'slot','3','iGameWin'),
(106,'plushie-frenzy','Plushie Frenzy','https://igamewin.com/storage/igamewin/10867.webp',1,'PGSOFT',1,'slot','3','iGameWin'),
(107,'journey-to-the-wealth','Journey to the Wealth','https://igamewin.com/storage/igamewin/10869.webp',1,'PGSOFT',1,'slot','3','iGameWin'),
(108,'legend-of-hou-yi','Legend of Hou Yi','https://igamewin.com/storage/igamewin/10870.webp',1,'PGSOFT',1,'slot','3','iGameWin'),
(109,'muay-thai-champion','Muay Thai Champion','https://igamewin.com/storage/igamewin/10871.webp',1,'PGSOFT',1,'slot','3','iGameWin'),
(110,'prosperity-lion','Prosperity Lion','https://igamewin.com/storage/igamewin/10872.webp',1,'PGSOFT',1,'slot','3','iGameWin'),
(111,'reel-love','Reel Love','https://igamewin.com/storage/igamewin/10874.webp',1,'PGSOFT',1,'slot','3','iGameWin'),
(112,'shaolin-soccer','Shaolin Soccer','https://igamewin.com/storage/igamewin/10875.webp',1,'PGSOFT',1,'slot','3','iGameWin'),
(113,'flirting-scholar','Flirting Scholar','https://igamewin.com/storage/igamewin/10880.webp',1,'PGSOFT',1,'slot','3','iGameWin'),
(114,'circus-delight','Circus Delight','https://igamewin.com/storage/igamewin/10881.webp',1,'PGSOFT',1,'slot','3','iGameWin'),
(115,'dragon-legend','Dragon Legend','https://igamewin.com/storage/igamewin/10890.webp',1,'PGSOFT',1,'slot','3','iGameWin'),
(116,'leprechaun-riches','Leprechaun Riches','https://igamewin.com/storage/igamewin/10892.webp',1,'PGSOFT',1,'slot','3','iGameWin'),
(117,'doomsday-rampg','Doomsday Rampage','https://igamewin.com/storage/igamewin/10931.webp',1,'PGSOFT',1,'slot','3','iGameWin'),
(118,'asgardian-rs','Asgardian Rising','https://igamewin.com/storage/igamewin/11983.jpg',1,'PGSOFT',1,'slot','3','iGameWin'),
(119,'bakery-bonanza','Bakery Bonanza','https://igamewin.com/storage/igamewin/11984.jfif',1,'PGSOFT',1,'slot','3','iGameWin'),
(120,'gem-saviour-sword','Gem Saviour Sword','https://igamewin.com/storage/igamewin/11985.png',1,'PGSOFT',1,'slot','3','iGameWin'),
(121,'diner-delights','Diner Delights','https://igamewin.com/storage/igamewin/11986.png',1,'PGSOFT',1,'slot','3','iGameWin'),
(122,'geisha-revenge','Geisha\'s Revenge','https://igamewin.com/storage/igamewin/11987.png',1,'PGSOFT',1,'slot','3','iGameWin'),
(123,'mahjong-ways2','Mahjong Ways 2','https://igamewin.com/storage/igamewin/11988.png',1,'PGSOFT',1,'slot','3','iGameWin'),
(124,'oriental-pros','Oriental Prosperity','https://igamewin.com/storage/igamewin/11989.webp',1,'PGSOFT',1,'slot','3','iGameWin'),
(125,'prosper-ftree','Prosperity Fortune Tree','https://igamewin.com/storage/igamewin/11990.jfif',1,'PGSOFT',1,'slot','3','iGameWin'),
(126,'tree-of-fortune','Tree of Fortune','https://igamewin.com/storage/igamewin/11991.jpg',1,'PGSOFT',1,'slot','3','iGameWin'),
(127,'ult-striker','Ultimate Striker','https://igamewin.com/storage/igamewin/11992.jpeg',1,'PGSOFT',1,'slot','3','iGameWin'),
(128,'win-win-won','Win Win Won','https://igamewin.com/storage/igamewin/11993.webp',1,'PGSOFT',1,'slot','3','iGameWin'),
(129,'hood-vs-wolf','Hood vs Wolf','https://igamewin.com/storage/igamewin/10891.webp',1,'PGSOFT',1,'slot','3','iGameWin'),
(130,'safari-wilds','Safari Wilds','https://igamewin.com/storage/igamewin/11995.png',1,'PGSOFT',1,'slot','3','iGameWin'),
(131,'treasures-aztec','Treasures of Aztec','https://igamewin.com/storage/igamewin/11996.webp',1,'PGSOFT',1,'slot','3','iGameWin'),
(132,'tsar-treasures','Tsar Treasures','https://igamewin.com/storage/igamewin/11997.jfif',1,'PGSOFT',1,'slot','3','iGameWin'),
(133,'vampires-charm','Vampire\'s Charm','https://igamewin.com/storage/igamewin/11998.webp',1,'PGSOFT',1,'slot','3','iGameWin'),
(134,'egypts-book-mystery','Egypt\'s Book Mystery','https://igamewin.com/storage/igamewin/11999.webp',1,'PGSOFT',1,'slot','3','iGameWin'),
(135,'genies-wishes','Genie\'s 3 Wishes','https://igamewin.com/storage/igamewin/12000.jfif',1,'PGSOFT',1,'slot','3','iGameWin'),
(136,'queen-bounty','Queen of Bounty','https://igamewin.com/storage/igamewin/12001.webp',1,'PGSOFT',1,'slot','3','iGameWin'),
(137,'WG_3025_V2','Black Myth: Wukong','https://igamewin.com/storage/igamewin/12005.avif',1,'slot-wg',0,'slot','3','iGameWin'),
(138,'WG_3022_V2','Fishing Master','https://igamewin.com/storage/igamewin/12006.avif',1,'slot-wg',0,'slot','3','iGameWin'),
(139,'WG_3020_V2','Animal Kingdom','https://igamewin.com/storage/igamewin/12007.avif',1,'slot-wg',0,'slot','3','iGameWin'),
(140,'WG_3018_V2','Festival of the Saints','https://igamewin.com/storage/igamewin/12008.avif',1,'slot-wg',0,'slot','3','iGameWin'),
(141,'WG_3016_V2','Samba Dance','https://igamewin.com/storage/igamewin/12009.avif',1,'slot-wg',0,'slot','3','iGameWin'),
(142,'WG_3015_V2','Treasure Marmosets','https://igamewin.com/storage/igamewin/12010.avif',1,'slot-wg',0,'slot','3','iGameWin'),
(143,'WG_3014_V2','Dragon vs Tiger','https://igamewin.com/storage/igamewin/12011.avif',1,'slot-wg',0,'slot','3','iGameWin'),
(144,'WG_3013_V2','Lucky Dog','https://igamewin.com/storage/igamewin/12012.avif',1,'slot-wg',0,'slot','3','iGameWin'),
(145,'WG_3011_V2','Mr Turtle','https://igamewin.com/storage/igamewin/12013.avif',1,'slot-wg',0,'slot','3','iGameWin'),
(146,'WG_3010_V2','Leopard of Gold','https://igamewin.com/storage/igamewin/12014.avif',1,'slot-wg',0,'slot','3','iGameWin'),
(147,'WG_3008_V2','Fortune Toucan','https://igamewin.com/storage/igamewin/12015.avif',1,'slot-wg',0,'slot','3','iGameWin'),
(148,'WG_3005_V2','Mais fortuna e riqueza','https://igamewin.com/storage/igamewin/12016.avif',1,'slot-wg',0,'slot','3','iGameWin'),
(149,'WG_3002_V2','Margem da Água','https://igamewin.com/storage/igamewin/12017.avif',1,'slot-wg',0,'slot','3','iGameWin'),
(150,'WG_3032_V2','Mahjong Ways2','https://igamewin.com/storage/igamewin/12020.avif',1,'slot-wg',0,'slot','3','iGameWin'),
(151,'WG_3028_V2','Dragon\'s Treasure2','https://igamewin.com/storage/igamewin/12022.avif',1,'slot-wg',0,'slot','3','iGameWin'),
(152,'WG_3009_V2','Dragon\'s Treasure','https://igamewin.com/storage/igamewin/12023.avif',1,'slot-wg',0,'slot','3','iGameWin'),
(153,'WG_3001_V2','Super Maquina De Frutas','https://igamewin.com/storage/igamewin/12024.avif',1,'slot-wg',0,'slot','3','iGameWin'),
(154,'fortune-gems-2','Fortune Gems 2','https://igamewin.com/storage/igamewin/10811.webp',1,'slot-tada',0,'slot','3','iGameWin'),
(155,'fortune-gems-3','Fortune Gems 3','https://igamewin.com/storage/igamewin/10812.webp',1,'slot-tada',0,'slot','3','iGameWin'),
(156,'fortune-gems','Fortune Gems','https://igamewin.com/storage/igamewin/10813.webp',1,'slot-tada',0,'slot','3','iGameWin'),
(157,'crazy-seven','Crazy Seven','https://igamewin.com/storage/igamewin/10814.webp',1,'slot-tada',0,'slot','3','iGameWin'),
(158,'golden-empire','Golden Empire','https://igamewin.com/storage/igamewin/10815.webp',1,'slot-tada',0,'slot','3','iGameWin'),
(159,'mega-ace','Mega Ace','https://igamewin.com/storage/igamewin/10816.webp',1,'slot-tada',0,'slot','3','iGameWin'),
(160,'super-rich','Super Rich','https://igamewin.com/storage/igamewin/10817.webp',1,'slot-tada',0,'slot','3','iGameWin'),
(161,'boxingking','BoxingKing','https://igamewin.com/storage/igamewin/10818.webp',1,'slot-tada',0,'slot','3','iGameWin'),
(162,'ali-baba','Ali Baba','https://igamewin.com/storage/igamewin/10819.webp',1,'slot-tada',0,'slot','3','iGameWin'),
(163,'lucky-coming','Lucky Coming','https://igamewin.com/storage/igamewin/10820.webp',1,'slot-tada',0,'slot','3','iGameWin'),
(164,'fortune-tree','Fortune Tree','https://igamewin.com/storage/igamewin/10821.webp',1,'slot-tada',0,'slot','3','iGameWin'),
(165,'book-of-gold','Book of Gold','https://igamewin.com/storage/igamewin/10822.webp',1,'slot-tada',0,'slot','3','iGameWin'),
(166,'jungle-king','Jungle King','https://igamewin.com/storage/igamewin/10823.webp',1,'slot-tada',0,'slot','3','iGameWin'),
(167,'magic-lamp','Magic Lamp Bingo','https://igamewin.com/storage/igamewin/10824.webp',1,'slot-tada',0,'slot','3','iGameWin'),
(168,'devil-fire-2','Devil Fire 2','https://igamewin.com/storage/igamewin/10825.webp',1,'slot-tada',0,'slot','3','iGameWin'),
(169,'gold-rush','Gold Rush','https://igamewin.com/storage/igamewin/10826.webp',1,'slot-tada',0,'slot','3','iGameWin'),
(170,'bonus-hunter','Bonus Hunter','https://igamewin.com/storage/igamewin/10827.webp',1,'slot-tada',0,'slot','3','iGameWin'),
(171,'world-cup','World Cup','https://igamewin.com/storage/igamewin/10828.webp',1,'slot-tada',0,'slot','3','iGameWin'),
(172,'pharaoh-treasure','Pharaoh Treasure','https://igamewin.com/storage/igamewin/10829.webp',1,'slot-tada',0,'slot','3','iGameWin'),
(173,'fortune-monkey','Fortune Monkey','https://igamewin.com/storage/igamewin/10830.webp',1,'slot-tada',0,'slot','3','iGameWin'),
(174,'golden-queen','Golden Queen','https://igamewin.com/storage/igamewin/10831.webp',1,'slot-tada',0,'slot','3','iGameWin'),
(175,'samba','Samba','https://igamewin.com/storage/igamewin/10832.webp',1,'slot-tada',0,'slot','3','iGameWin'),
(176,'pirate-queen','Pirate Queen','https://igamewin.com/storage/igamewin/10833.webp',1,'slot-tada',0,'slot','3','iGameWin'),
(177,'roma-x','Roma X','https://igamewin.com/storage/igamewin/10834.webp',1,'slot-tada',0,'slot','3','iGameWin'),
(178,'bone-fortune','Bone Fortune','https://igamewin.com/storage/igamewin/10835.webp',1,'slot-tada',0,'slot','3','iGameWin'),
(179,'devil-fire','Devil Fire','https://igamewin.com/storage/igamewin/10836.webp',1,'slot-tada',0,'slot','3','iGameWin'),
(180,'cricket-king-18','Cricket King 18','https://igamewin.com/storage/igamewin/10837.webp',1,'slot-tada',0,'slot','3','iGameWin'),
(181,'fortunepig','Fortune Pig','https://igamewin.com/storage/igamewin/10838.webp',1,'slot-tada',0,'slot','3','iGameWin'),
(182,'thor-x','Thor X','https://igamewin.com/storage/igamewin/10839.webp',1,'slot-tada',0,'slot','3','iGameWin'),
(183,'the-pig-house','The Pig House','https://igamewin.com/storage/igamewin/10840.webp',1,'slot-tada',0,'slot','3','iGameWin'),
(184,'agent-ace','Agent Ace','https://igamewin.com/storage/igamewin/10841.webp',1,'slot-tada',0,'slot','3','iGameWin'),
(185,'night-city','Night City','https://igamewin.com/storage/igamewin/10842.webp',1,'slot-tada',0,'slot','3','iGameWin'),
(186,'fengshen','Fengshen','https://igamewin.com/storage/igamewin/10843.webp',1,'slot-tada',0,'slot','3','iGameWin'),
(187,'sin-city','Sin City','https://igamewin.com/storage/igamewin/10844.webp',1,'slot-tada',0,'slot','3','iGameWin'),
(188,'chin-shi-huang','Chin Shi Huang','https://igamewin.com/storage/igamewin/10845.webp',1,'slot-tada',0,'slot','3','iGameWin'),
(189,'witches-night','Witches Night','https://igamewin.com/storage/igamewin/10846.webp',1,'slot-tada',0,'slot','3','iGameWin'),
(190,'dabanggg','Dabanggg','https://igamewin.com/storage/igamewin/10847.webp',1,'slot-tada',0,'slot','3','iGameWin'),
(191,'cricket-sah-75','Cricket Sah 75','https://igamewin.com/storage/igamewin/10848.webp',1,'slot-tada',0,'slot','3','iGameWin'),
(192,'neko-fortune','Neko Fortune','https://igamewin.com/storage/igamewin/10849.webp',1,'slot-tada',0,'slot','3','iGameWin'),
(193,'king-arthur','King Arthur','https://igamewin.com/storage/igamewin/10850.webp',1,'slot-tada',0,'slot','3','iGameWin'),
(194,'party-night','Party Night','https://igamewin.com/storage/igamewin/10851.webp',1,'slot-tada',0,'slot','3','iGameWin'),
(195,'super-ace','Super Ace','https://igamewin.com/storage/igamewin/10852.webp',1,'slot-tada',0,'slot','3','iGameWin'),
(196,'bangla-beauty','Bangla Beauty','https://igamewin.com/storage/igamewin/10853.webp',1,'slot-tada',0,'slot','3','iGameWin'),
(197,'mines','Mines','https://igamewin.com/storage/igamewin/162.webp',1,'slot-spribe',0,'slot','3','iGameWin'),
(198,'hotline','Hotline','https://igamewin.com/storage/igamewin/163.webp',1,'slot-spribe',0,'slot','3','iGameWin'),
(199,'roulette','Mini Roulette','https://igamewin.com/storage/igamewin/164.webp',1,'slot-spribe',0,'slot','3','iGameWin'),
(200,'dice','Dice','https://igamewin.com/storage/igamewin/165.webp',1,'slot-spribe',0,'slot','3','iGameWin'),
(201,'plinko','Plinko','https://igamewin.com/storage/igamewin/166.webp',1,'slot-spribe',0,'slot','3','iGameWin'),
(202,'goal','Goal','https://igamewin.com/storage/igamewin/167.webp',1,'slot-spribe',0,'slot','3','iGameWin'),
(203,'keno','Keno','https://igamewin.com/storage/igamewin/168.webp',1,'slot-spribe',0,'slot','3','iGameWin'),
(204,'hilo','Hilo','https://igamewin.com/storage/igamewin/169.webp',1,'slot-spribe',0,'slot','3','iGameWin'),
(205,'aviator_core','Aviator','https://igamewin.com/storage/igamewin/170.webp',1,'slot-spribe',0,'slot','3','iGameWin'),
(206,'112','Pyramid Raider','https://igamewin.com/storage/igamewin/10130.webp',1,'slot-cq9',0,'slot','3','iGameWin'),
(207,'125','Zeus M','https://igamewin.com/storage/igamewin/10131.webp',1,'slot-cq9',0,'slot','3','iGameWin'),
(208,'123','Lucky Bats M','https://igamewin.com/storage/igamewin/10132.webp',1,'slot-cq9',0,'slot','3','iGameWin'),
(209,'129','Gu Gu Gu 2 M','https://igamewin.com/storage/igamewin/10133.webp',1,'slot-cq9',0,'slot','3','iGameWin'),
(210,'137','Disco Night M','https://igamewin.com/storage/igamewin/10134.webp',1,'slot-cq9',0,'slot','3','iGameWin'),
(211,'118','SkrSkr','https://igamewin.com/storage/igamewin/10135.webp',1,'slot-cq9',0,'slot','3','iGameWin'),
(212,'121','Rave Jump 2 M','https://igamewin.com/storage/igamewin/10136.webp',1,'slot-cq9',0,'slot','3','iGameWin'),
(213,'135','Gu Gu Gu M','https://igamewin.com/storage/igamewin/10137.webp',1,'slot-cq9',0,'slot','3','iGameWin'),
(214,'116','Wonderland','https://igamewin.com/storage/igamewin/10138.webp',1,'slot-cq9',0,'slot','3','iGameWin'),
(215,'115','Snow Queen','https://igamewin.com/storage/igamewin/10139.webp',1,'slot-cq9',0,'slot','3','iGameWin'),
(216,'221','Detective Dee 2','https://igamewin.com/storage/igamewin/10140.webp',1,'slot-cq9',0,'slot','3','iGameWin'),
(217,'124','Invincible Elephant','https://igamewin.com/storage/igamewin/10141.webp',1,'slot-cq9',0,'slot','3','iGameWin'),
(218,'131','Fa Cai Shen M','https://igamewin.com/storage/igamewin/10142.webp',1,'slot-cq9',0,'slot','3','iGameWin'),
(219,'109','Rave Jump mobile','https://igamewin.com/storage/igamewin/10143.webp',1,'slot-cq9',0,'slot','3','iGameWin'),
(220,'122','Zuma Wild','https://igamewin.com/storage/igamewin/10144.webp',1,'slot-cq9',0,'slot','3','iGameWin'),
(221,'139','Fire Chibi M','https://igamewin.com/storage/igamewin/10145.webp',1,'slot-cq9',0,'slot','3','iGameWin'),
(222,'127','God of War M','https://igamewin.com/storage/igamewin/10146.webp',1,'slot-cq9',0,'slot','3','iGameWin'),
(223,'144','Diamond Treasure','https://igamewin.com/storage/igamewin/10147.webp',1,'slot-cq9',0,'slot','3','iGameWin'),
(224,'130','Gold Stealer','https://igamewin.com/storage/igamewin/10148.webp',1,'slot-cq9',0,'slot','3','iGameWin'),
(225,'138','Move n\' Jump','https://igamewin.com/storage/igamewin/10149.webp',1,'slot-cq9',0,'slot','3','iGameWin'),
(226,'147','Flower Fortunes','https://igamewin.com/storage/igamewin/10150.webp',1,'slot-cq9',0,'slot','3','iGameWin'),
(227,'157','5 Boxing','https://igamewin.com/storage/igamewin/10151.webp',1,'slot-cq9',0,'slot','3','iGameWin'),
(228,'132','Meow','https://igamewin.com/storage/igamewin/10152.webp',1,'slot-cq9',0,'slot','3','iGameWin'),
(229,'142','Hephaestus','https://igamewin.com/storage/igamewin/10153.webp',1,'slot-cq9',0,'slot','3','iGameWin'),
(230,'143','Fa Cai Fu Wa','https://igamewin.com/storage/igamewin/10154.webp',1,'slot-cq9',0,'slot','3','iGameWin'),
(231,'152','Double Fly','https://igamewin.com/storage/igamewin/10155.webp',1,'slot-cq9',0,'slot','3','iGameWin'),
(232,'153','Six Candy','https://igamewin.com/storage/igamewin/10156.webp',1,'slot-cq9',0,'slot','3','iGameWin'),
(233,'150','Shou-Xin','https://igamewin.com/storage/igamewin/10157.webp',1,'slot-cq9',0,'slot','3','iGameWin'),
(234,'148','Fortune Totem','https://igamewin.com/storage/igamewin/10158.webp',1,'slot-cq9',0,'slot','3','iGameWin'),
(235,'136','Running Animals','https://igamewin.com/storage/igamewin/10159.webp',1,'slot-cq9',0,'slot','3','iGameWin'),
(236,'140','Fire Chibi 2','https://igamewin.com/storage/igamewin/10160.webp',1,'slot-cq9',0,'slot','3','iGameWin'),
(237,'206','Sweet POP','https://igamewin.com/storage/igamewin/10161.webp',1,'slot-cq9',0,'slot','3','iGameWin'),
(238,'209','The Cupids','https://igamewin.com/storage/igamewin/10162.webp',1,'slot-cq9',0,'slot','3','iGameWin'),
(239,'13','SakuraLegend','https://igamewin.com/storage/igamewin/10163.webp',1,'slot-cq9',0,'slot','3','iGameWin'),
(240,'26','777','https://igamewin.com/storage/igamewin/10164.webp',1,'slot-cq9',0,'slot','3','iGameWin'),
(241,'72','HappyRichYear','https://igamewin.com/storage/igamewin/10165.webp',1,'slot-cq9',0,'slot','3','iGameWin'),
(242,'79','Chameleon','https://igamewin.com/storage/igamewin/10166.webp',1,'slot-cq9',0,'slot','3','iGameWin'),
(243,'89','Thor','https://igamewin.com/storage/igamewin/10167.webp',1,'slot-cq9',0,'slot','3','iGameWin'),
(244,'214','Ninja Raccoon','https://igamewin.com/storage/igamewin/10168.webp',1,'slot-cq9',0,'slot','3','iGameWin'),
(245,'8','SoSweet','https://igamewin.com/storage/igamewin/10169.webp',1,'slot-cq9',0,'slot','3','iGameWin'),
(246,'15','GuGuGu','https://igamewin.com/storage/igamewin/10170.webp',1,'slot-cq9',0,'slot','3','iGameWin'),
(247,'31','God of War','https://igamewin.com/storage/igamewin/10171.webp',1,'slot-cq9',0,'slot','3','iGameWin'),
(248,'42','Sherlock Holmes','https://igamewin.com/storage/igamewin/10172.webp',1,'slot-cq9',0,'slot','3','iGameWin'),
(249,'68','WuKong&Peaches','https://igamewin.com/storage/igamewin/10173.webp',1,'slot-cq9',0,'slot','3','iGameWin'),
(250,'80','Poseidon','https://igamewin.com/storage/igamewin/10174.webp',1,'slot-cq9',0,'slot','3','iGameWin'),
(251,'218','Dollar Bomb','https://igamewin.com/storage/igamewin/10175.webp',1,'slot-cq9',0,'slot','3','iGameWin'),
(252,'187','Wing Chun','https://igamewin.com/storage/igamewin/10176.webp',1,'slot-cq9',0,'slot','3','iGameWin'),
(253,'46','Wolf Moon','https://igamewin.com/storage/igamewin/10177.webp',1,'slot-cq9',0,'slot','3','iGameWin'),
(254,'17','GreatLion','https://igamewin.com/storage/igamewin/10178.webp',1,'slot-cq9',0,'slot','3','iGameWin'),
(255,'64','Zeus','https://igamewin.com/storage/igamewin/10179.webp',1,'slot-cq9',0,'slot','3','iGameWin'),
(256,'74','Treasure Bowl','https://igamewin.com/storage/igamewin/10180.webp',1,'slot-cq9',0,'slot','3','iGameWin'),
(257,'210','Oo Ga Cha Ka','https://igamewin.com/storage/igamewin/10183.webp',1,'slot-cq9',0,'slot','3','iGameWin'),
(258,'222','Loy Krathong','https://igamewin.com/storage/igamewin/10184.webp',1,'slot-cq9',0,'slot','3','iGameWin'),
(259,'173','6 Toros','https://igamewin.com/storage/igamewin/10185.webp',1,'slot-cq9',0,'slot','3','iGameWin'),
(260,'59','SummerMood','https://igamewin.com/storage/igamewin/10186.webp',1,'slot-cq9',0,'slot','3','iGameWin'),
(261,'67','GoldenEggs','https://igamewin.com/storage/igamewin/10187.webp',1,'slot-cq9',0,'slot','3','iGameWin'),
(262,'96','FootballBaby','https://igamewin.com/storage/igamewin/10188.webp',1,'slot-cq9',0,'slot','3','iGameWin'),
(263,'5007','Da Fa Cai','https://igamewin.com/storage/igamewin/10189.webp',1,'slot-cq9',0,'slot','3','iGameWin'),
(264,'177','Aladdin\'s lamp','https://igamewin.com/storage/igamewin/10190.webp',1,'slot-cq9',0,'slot','3','iGameWin'),
(265,'154','Kronos','https://igamewin.com/storage/igamewin/10191.webp',1,'slot-cq9',0,'slot','3','iGameWin'),
(266,'32','Detective Dee','https://igamewin.com/storage/igamewin/10192.webp',1,'slot-cq9',0,'slot','3','iGameWin'),
(267,'55','Dragon Heart','https://igamewin.com/storage/igamewin/10193.webp',1,'slot-cq9',0,'slot','3','iGameWin'),
(268,'202','OrientalBeauty','https://igamewin.com/storage/igamewin/10194.webp',1,'slot-cq9',0,'slot','3','iGameWin'),
(269,'203','RaveHigh','https://igamewin.com/storage/igamewin/10195.webp',1,'slot-cq9',0,'slot','3','iGameWin'),
(270,'5009','Uproar in Heaven','https://igamewin.com/storage/igamewin/10196.webp',1,'slot-cq9',0,'slot','3','iGameWin'),
(271,'171','Greek Gods','https://igamewin.com/storage/igamewin/10197.webp',1,'slot-cq9',0,'slot','3','iGameWin'),
(272,'182','Thor 2','https://igamewin.com/storage/igamewin/10198.webp',1,'slot-cq9',0,'slot','3','iGameWin'),
(273,'16','Super5','https://igamewin.com/storage/igamewin/10199.webp',1,'slot-cq9',0,'slot','3','iGameWin'),
(274,'77','RedPhoenix','https://igamewin.com/storage/igamewin/10200.webp',1,'slot-cq9',0,'slot','3','iGameWin'),
(275,'86','RunningToro','https://igamewin.com/storage/igamewin/10201.webp',1,'slot-cq9',0,'slot','3','iGameWin'),
(276,'220','Floating Market','https://igamewin.com/storage/igamewin/10202.webp',1,'slot-cq9',0,'slot','3','iGameWin'),
(277,'33','Fire Chibi','https://igamewin.com/storage/igamewin/10203.webp',1,'slot-cq9',0,'slot','3','iGameWin'),
(278,'44','Fruit King II','https://igamewin.com/storage/igamewin/10204.webp',1,'slot-cq9',0,'slot','3','iGameWin'),
(279,'49','Lonely Planet','https://igamewin.com/storage/igamewin/10205.webp',1,'slot-cq9',0,'slot','3','iGameWin'),
(280,'76','WonWonWon','https://igamewin.com/storage/igamewin/10206.webp',1,'slot-cq9',0,'slot','3','iGameWin'),
(281,'212','Burning Xi-You','https://igamewin.com/storage/igamewin/10207.webp',1,'slot-cq9',0,'slot','3','iGameWin'),
(282,'211','King of Atlantis','https://igamewin.com/storage/igamewin/10208.webp',1,'slot-cq9',0,'slot','3','iGameWin'),
(283,'219','King Kong Shake','https://igamewin.com/storage/igamewin/10209.webp',1,'slot-cq9',0,'slot','3','iGameWin'),
(284,'3','VampireKiss','https://igamewin.com/storage/igamewin/10210.webp',1,'slot-cq9',0,'slot','3','iGameWin'),
(285,'34','Gophers War','https://igamewin.com/storage/igamewin/10211.webp',1,'slot-cq9',0,'slot','3','iGameWin'),
(286,'38','All Wilds','https://igamewin.com/storage/igamewin/10212.webp',1,'slot-cq9',0,'slot','3','iGameWin'),
(287,'51','Ecstatic Circus','https://igamewin.com/storage/igamewin/10213.webp',1,'slot-cq9',0,'slot','3','iGameWin'),
(288,'70','WanBaoDino','https://igamewin.com/storage/igamewin/10214.webp',1,'slot-cq9',0,'slot','3','iGameWin'),
(289,'83','FireQueen','https://igamewin.com/storage/igamewin/10215.webp',1,'slot-cq9',0,'slot','3','iGameWin'),
(290,'179','Jump High 2','https://igamewin.com/storage/igamewin/10216.webp',1,'slot-cq9',0,'slot','3','iGameWin'),
(291,'186','Fire Queen 2','https://igamewin.com/storage/igamewin/10217.webp',1,'slot-cq9',0,'slot','3','iGameWin'),
(292,'184','Six Gacha','https://igamewin.com/storage/igamewin/10218.webp',1,'slot-cq9',0,'slot','3','iGameWin'),
(293,'1','FruitKing','https://igamewin.com/storage/igamewin/10219.webp',1,'slot-cq9',0,'slot','3','iGameWin'),
(294,'20','888','https://igamewin.com/storage/igamewin/10220.webp',1,'slot-cq9',0,'slot','3','iGameWin'),
(295,'57','The Beast War','https://igamewin.com/storage/igamewin/10221.webp',1,'slot-cq9',0,'slot','3','iGameWin'),
(296,'66','Fire777','https://igamewin.com/storage/igamewin/10222.webp',1,'slot-cq9',0,'slot','3','iGameWin'),
(297,'78','Apollo','https://igamewin.com/storage/igamewin/10223.webp',1,'slot-cq9',0,'slot','3','iGameWin'),
(298,'5','Mr.Rich','https://igamewin.com/storage/igamewin/10224.webp',1,'slot-cq9',0,'slot','3','iGameWin'),
(299,'9','ZhongKui','https://igamewin.com/storage/igamewin/10225.webp',1,'slot-cq9',0,'slot','3','iGameWin'),
(300,'21','BigWolf','https://igamewin.com/storage/igamewin/10226.webp',1,'slot-cq9',0,'slot','3','iGameWin'),
(301,'23','YuanBao','https://igamewin.com/storage/igamewin/10227.webp',1,'slot-cq9',0,'slot','3','iGameWin'),
(302,'24','RaveJump2','https://igamewin.com/storage/igamewin/10228.webp',1,'slot-cq9',0,'slot','3','iGameWin'),
(303,'36','Pub Tycoon','https://igamewin.com/storage/igamewin/10229.webp',1,'slot-cq9',0,'slot','3','iGameWin'),
(304,'183','Wolf Disco','https://igamewin.com/storage/igamewin/10230.webp',1,'slot-cq9',0,'slot','3','iGameWin'),
(305,'7','RaveJump','https://igamewin.com/storage/igamewin/10231.webp',1,'slot-cq9',0,'slot','3','iGameWin'),
(306,'52','Jump High','https://igamewin.com/storage/igamewin/10232.webp',1,'slot-cq9',0,'slot','3','iGameWin'),
(307,'54','Funny Alpaca','https://igamewin.com/storage/igamewin/10233.webp',1,'slot-cq9',0,'slot','3','iGameWin'),
(308,'69','FaCaiShen','https://igamewin.com/storage/igamewin/10234.webp',1,'slot-cq9',0,'slot','3','iGameWin'),
(309,'35','CrazyNuozha','https://igamewin.com/storage/igamewin/10235.webp',1,'slot-cq9',0,'slot','3','iGameWin'),
(310,'95','FootballBoots','https://igamewin.com/storage/igamewin/10236.webp',1,'slot-cq9',0,'slot','3','iGameWin'),
(311,'204','LuckyBoxes','https://igamewin.com/storage/igamewin/10237.webp',1,'slot-cq9',0,'slot','3','iGameWin'),
(312,'199','Songkran Festival','https://igamewin.com/storage/igamewin/10238.webp',1,'slot-cq9',0,'slot','3','iGameWin'),
(313,'12','TreasureHouse','https://igamewin.com/storage/igamewin/10239.webp',1,'slot-cq9',0,'slot','3','iGameWin'),
(314,'19','HotSpin','https://igamewin.com/storage/igamewin/10240.webp',1,'slot-cq9',0,'slot','3','iGameWin'),
(315,'22','MonkeyOfficeLegend','https://igamewin.com/storage/igamewin/10241.webp',1,'slot-cq9',0,'slot','3','iGameWin'),
(316,'27','Magic World','https://igamewin.com/storage/igamewin/10242.webp',1,'slot-cq9',0,'slot','3','iGameWin'),
(317,'39','Apsaras','https://igamewin.com/storage/igamewin/10243.webp',1,'slot-cq9',0,'slot','3','iGameWin'),
(318,'105','Jumping Mobile','https://igamewin.com/storage/igamewin/10244.webp',1,'slot-cq9',0,'slot','3','iGameWin'),
(319,'195','Lord Ganesha','https://igamewin.com/storage/igamewin/10245.webp',1,'slot-cq9',0,'slot','3','iGameWin'),
(320,'223','Acrobatics','https://igamewin.com/storage/igamewin/10246.webp',1,'slot-cq9',0,'slot','3','iGameWin'),
(321,'98','All Star Team','https://igamewin.com/storage/igamewin/10247.webp',1,'slot-cq9',0,'slot','3','iGameWin'),
(322,'208','Money Tree','https://igamewin.com/storage/igamewin/10248.webp',1,'slot-cq9',0,'slot','3','iGameWin'),
(323,'188','Cricket Fever','https://igamewin.com/storage/igamewin/10249.webp',1,'slot-cq9',0,'slot','3','iGameWin'),
(324,'2','GodOfChess','https://igamewin.com/storage/igamewin/10250.webp',1,'slot-cq9',0,'slot','3','iGameWin'),
(325,'4','WildTarzan','https://igamewin.com/storage/igamewin/10251.webp',1,'slot-cq9',0,'slot','3','iGameWin'),
(326,'10','LuckyBats','https://igamewin.com/storage/igamewin/10252.webp',1,'slot-cq9',0,'slot','3','iGameWin'),
(327,'81','Treasure Island','https://igamewin.com/storage/igamewin/10253.webp',1,'slot-cq9',0,'slot','3','iGameWin'),
(328,'92','WorldCupRussia2018','https://igamewin.com/storage/igamewin/10254.webp',1,'slot-cq9',0,'slot','3','iGameWin'),
(329,'205','DiscoNight','https://igamewin.com/storage/igamewin/10255.webp',1,'slot-cq9',0,'slot','3','iGameWin'),
(330,'5008','Da Hong Zhong','https://igamewin.com/storage/igamewin/10256.webp',1,'slot-cq9',0,'slot','3','iGameWin'),
(331,'226','Lucky Tigers','https://igamewin.com/storage/igamewin/10257.webp',1,'slot-cq9',0,'slot','3','iGameWin'),
(332,'225','Mr. Miser','https://igamewin.com/storage/igamewin/10258.webp',1,'slot-cq9',0,'slot','3','iGameWin'),
(333,'227','888 Cai Shen','https://igamewin.com/storage/igamewin/10259.webp',1,'slot-cq9',0,'slot','3','iGameWin'),
(334,'228','Mirror Mirror','https://igamewin.com/storage/igamewin/10260.webp',1,'slot-cq9',0,'slot','3','iGameWin'),
(335,'231','Striker WILD','https://igamewin.com/storage/igamewin/10261.webp',1,'slot-cq9',0,'slot','3','iGameWin'),
(336,'241','The Chicken House','https://igamewin.com/storage/igamewin/10262.webp',1,'slot-cq9',0,'slot','3','iGameWin'),
(337,'133','Good Fortune M','https://igamewin.com/storage/igamewin/10882.webp',1,'slot-cq9',0,'slot','3','iGameWin'),
(338,'128','Wheel Money','https://igamewin.com/storage/igamewin/10883.webp',1,'slot-cq9',0,'slot','3','iGameWin'),
(339,'29','WaterWorld','https://igamewin.com/storage/igamewin/10884.webp',1,'slot-cq9',0,'slot','3','iGameWin'),
(340,'215','Hot Pinatas','https://igamewin.com/storage/igamewin/10885.webp',1,'slot-cq9',0,'slot','3','iGameWin'),
(341,'161','Hercules','https://igamewin.com/storage/igamewin/10886.webp',1,'slot-cq9',0,'slot','3','iGameWin'),
(342,'47','Pharaoh\'s Gold','https://igamewin.com/storage/igamewin/10887.webp',1,'slot-cq9',0,'slot','3','iGameWin'),
(343,'160','Fa Cai Shen2','https://igamewin.com/storage/igamewin/10888.webp',1,'slot-cq9',0,'slot','3','iGameWin'),
(344,'GB5','Hot DJ','https://igamewin.com/storage/igamewin/10978.webp',1,'slot-cq9',0,'slot','3','iGameWin'),
(345,'GB6','Ganesha Jr.','https://igamewin.com/storage/igamewin/10979.webp',1,'slot-cq9',0,'slot','3','iGameWin'),
(346,'50','Good Fortune','https://igamewin.com/storage/igamewin/10980.webp',1,'slot-cq9',0,'slot','3','iGameWin'),
(347,'201','MuayThai','https://igamewin.com/storage/igamewin/10981.webp',1,'slot-cq9',0,'slot','3','iGameWin'),
(348,'GB3','Coin Spinner','https://igamewin.com/storage/igamewin/10982.webp',1,'slot-cq9',0,'slot','3','iGameWin'),
(349,'GB2','Monster Hunter','https://igamewin.com/storage/igamewin/10983.webp',1,'slot-cq9',0,'slot','3','iGameWin'),
(350,'GB8','Dragon Koi','https://igamewin.com/storage/igamewin/10984.webp',1,'slot-cq9',0,'slot','3','iGameWin'),
(351,'GB9','Football Fever','https://igamewin.com/storage/igamewin/10985.webp',1,'slot-cq9',0,'slot','3','iGameWin'),
(352,'GB12','Myeong-ryang','https://igamewin.com/storage/igamewin/10986.webp',1,'slot-cq9',0,'slot','3','iGameWin'),
(353,'GB15','Hero of the 3 Kingdoms - Cao Cao','https://igamewin.com/storage/igamewin/10987.webp',1,'slot-cq9',0,'slot','3','iGameWin'),
(354,'GB13','Football Fever M','https://igamewin.com/storage/igamewin/10988.webp',1,'slot-cq9',0,'slot','3','iGameWin'),
(355,'242','Treasure Pirate','https://igamewin.com/storage/igamewin/10989.webp',1,'slot-cq9',0,'slot','3','iGameWin'),
(356,'141','Xmas','https://igamewin.com/storage/igamewin/11628.webp',1,'slot-cq9',0,'slot','3','iGameWin'),
(357,'104','Chicky Parm Parm','https://igamewin.com/storage/igamewin/11629.webp',1,'slot-cq9',0,'slot','3','iGameWin'),
(358,'103','Jewel Luxury','https://igamewin.com/storage/igamewin/11630.webp',1,'slot-cq9',0,'slot','3','iGameWin'),
(359,'102','Fruity Carnival','https://igamewin.com/storage/igamewin/11631.webp',1,'slot-cq9',0,'slot','3','iGameWin'),
(360,'158','Black Wukong','https://igamewin.com/storage/igamewin/11632.webp',1,'slot-cq9',0,'slot','3','iGameWin'),
(361,'252','Wild Disco Night','https://igamewin.com/storage/igamewin/11633.webp',1,'slot-cq9',0,'slot','3','iGameWin'),
(362,'BTX_Lucky3','Lucky 3','https://igamewin.com/storage/igamewin/11866.webp',1,'slot-cq9',0,'slot','3','iGameWin'),
(363,'BTX_HollywoodPets','Hollywood Pets','https://igamewin.com/storage/igamewin/11867.webp',1,'slot-cq9',0,'slot','3','iGameWin'),
(364,'BTX_QueenOfDead','Queen Of Dead','https://igamewin.com/storage/igamewin/11868.webp',1,'slot-cq9',0,'slot','3','iGameWin'),
(365,'BTX_XmasTales','Xmas Tales','https://igamewin.com/storage/igamewin/11869.webp',1,'slot-cq9',0,'slot','3','iGameWin'),
(366,'BTX_PigOfLuck','Pig Of Luck','https://igamewin.com/storage/igamewin/11870.webp',1,'slot-cq9',0,'slot','3','iGameWin'),
(367,'BTX_TreasureOfSeti','Treasure of Seti','https://igamewin.com/storage/igamewin/11871.webp',1,'slot-cq9',0,'slot','3','iGameWin'),
(368,'BTX_CirqueDeFous','Cirque de fous','https://igamewin.com/storage/igamewin/11872.webp',1,'slot-cq9',0,'slot','3','iGameWin'),
(369,'BTX_DragonHunters','Dragon Hunters','https://igamewin.com/storage/igamewin/11873.webp',1,'slot-cq9',0,'slot','3','iGameWin'),
(370,'anubis_moon','Anubis Moon','https://igamewin.com/storage/igamewin/10046.webp',1,'slot-evoplay',0,'slot','3','iGameWin'),
(371,'bandit_bust','Bandit Bust','https://igamewin.com/storage/igamewin/10047.webp',1,'slot-evoplay',0,'slot','3','iGameWin'),
(372,'bandit_bust_b_b','Bandit Bust Bonus Buy','https://igamewin.com/storage/igamewin/10048.webp',1,'slot-evoplay',0,'slot','3','iGameWin'),
(373,'belfry_bliss','Belfry Bliss','https://igamewin.com/storage/igamewin/10049.webp',1,'slot-evoplay',0,'slot','3','iGameWin'),
(374,'book_of_the_priestess','Book of the Priestess','https://igamewin.com/storage/igamewin/10050.webp',1,'slot-evoplay',0,'slot','3','iGameWin'),
(375,'budai_reels_bonus_buy','Budai Reels Bonus Buy','https://igamewin.com/storage/igamewin/10051.webp',1,'slot-evoplay',0,'slot','3','iGameWin'),
(376,'camino_de_chili','Camino de Chili','https://igamewin.com/storage/igamewin/10052.webp',1,'slot-evoplay',0,'slot','3','iGameWin'),
(377,'camino_de_chili_b_b','Camino de Chili Bonus Buy','https://igamewin.com/storage/igamewin/10053.webp',1,'slot-evoplay',0,'slot','3','iGameWin'),
(378,'candy_craze','Candy Craze','https://igamewin.com/storage/igamewin/10054.webp',1,'slot-evoplay',0,'slot','3','iGameWin'),
(379,'candy_dreams_sweet_planet','Candy Dreams: Sweet Planet','https://igamewin.com/storage/igamewin/10055.webp',1,'slot-evoplay',0,'slot','3','iGameWin'),
(380,'candy_dreams_sweet_planet_b_b','Candy Dreams Sweet Planet Bonus Buy','https://igamewin.com/storage/igamewin/10056.webp',1,'slot-evoplay',0,'slot','3','iGameWin'),
(381,'christmas_reach_bonus_buy','Christmas Reach Bonus Buy','https://igamewin.com/storage/igamewin/10057.webp',1,'slot-evoplay',0,'slot','3','iGameWin'),
(382,'collapsed_castle_b_b','Collapsed Castle Bonus Buy','https://igamewin.com/storage/igamewin/10058.webp',1,'slot-evoplay',0,'slot','3','iGameWin'),
(383,'cursed_can','Cursed Can','https://igamewin.com/storage/igamewin/10059.webp',1,'slot-evoplay',0,'slot','3','iGameWin'),
(384,'cursed_can_b_b','Cursed Can Bonus Buy','https://igamewin.com/storage/igamewin/10060.webp',1,'slot-evoplay',0,'slot','3','iGameWin'),
(385,'cycle_of_luck','Cycle of Luck','https://igamewin.com/storage/igamewin/10061.webp',1,'slot-evoplay',0,'slot','3','iGameWin'),
(386,'ellens_fortune','Ellen\'s Fortune','https://igamewin.com/storage/igamewin/10062.webp',1,'slot-evoplay',0,'slot','3','iGameWin'),
(387,'epic_legends','Epic Legends','https://igamewin.com/storage/igamewin/10063.webp',1,'slot-evoplay',0,'slot','3','iGameWin'),
(388,'europe_transit','Europe Transit','https://igamewin.com/storage/igamewin/10064.webp',1,'slot-evoplay',0,'slot','3','iGameWin'),
(389,'europe_transit_b_b','Europe Transit Bonus Buy','https://igamewin.com/storage/igamewin/10065.webp',1,'slot-evoplay',0,'slot','3','iGameWin'),
(390,'fruit_super_nova','Fruit Super Nova','https://igamewin.com/storage/igamewin/10066.webp',1,'slot-evoplay',0,'slot','3','iGameWin'),
(391,'fruit_super_nova_80','Fruit Super Nova 80','https://igamewin.com/storage/igamewin/10067.webp',1,'slot-evoplay',0,'slot','3','iGameWin'),
(392,'gold_of_sirens_bonus_buy','Gold of Sirens Bonus Buy','https://igamewin.com/storage/igamewin/10068.webp',1,'slot-evoplay',0,'slot','3','iGameWin'),
(393,'hot_mania','Hot Mania','https://igamewin.com/storage/igamewin/10069.webp',1,'slot-evoplay',0,'slot','3','iGameWin'),
(394,'hot_triple_sevens','Hot Triple Sevens','https://igamewin.com/storage/igamewin/10070.webp',1,'slot-evoplay',0,'slot','3','iGameWin'),
(395,'hot_triple_sevens_special','Hot Triple Sevens Special','https://igamewin.com/storage/igamewin/10071.webp',1,'slot-evoplay',0,'slot','3','iGameWin'),
(396,'hot_volcano','Hot Volcano','https://igamewin.com/storage/igamewin/10072.webp',1,'slot-evoplay',0,'slot','3','iGameWin'),
(397,'hot_volcano_b_b','Hot Volcano Bonus Buy','https://igamewin.com/storage/igamewin/10073.webp',1,'slot-evoplay',0,'slot','3','iGameWin'),
(398,'ice_mania','Ice Mania','https://igamewin.com/storage/igamewin/10074.webp',1,'slot-evoplay',0,'slot','3','iGameWin'),
(399,'inner_fire','Inner Fire','https://igamewin.com/storage/igamewin/10075.webp',1,'slot-evoplay',0,'slot','3','iGameWin'),
(400,'inner_fire_b_b','Inner Fire Bonus Buy','https://igamewin.com/storage/igamewin/10076.webp',1,'slot-evoplay',0,'slot','3','iGameWin'),
(401,'irish_weekend_b_b','Irish Weekend Bonus Buy','https://igamewin.com/storage/igamewin/10077.webp',1,'slot-evoplay',0,'slot','3','iGameWin'),
(402,'jhana_of_god_b_b','Jhana Of God Bonus Buy','https://igamewin.com/storage/igamewin/10078.webp',1,'slot-evoplay',0,'slot','3','iGameWin'),
(403,'juicy_gems','Juicy Gems','https://igamewin.com/storage/igamewin/10079.webp',1,'slot-evoplay',0,'slot','3','iGameWin'),
(404,'massive_luck','Massive Luck','https://igamewin.com/storage/igamewin/10080.webp',1,'slot-evoplay',0,'slot','3','iGameWin'),
(405,'massive_luck_b_b','Massive Luck Bonus Buy','https://igamewin.com/storage/igamewin/10081.webp',1,'slot-evoplay',0,'slot','3','iGameWin'),
(406,'money_minter','Money Minter','https://igamewin.com/storage/igamewin/10082.webp',1,'slot-evoplay',0,'slot','3','iGameWin'),
(407,'money_minter_b_b','Money Minter Bonus Buy','https://igamewin.com/storage/igamewin/10083.webp',1,'slot-evoplay',0,'slot','3','iGameWin'),
(408,'neon_capital','Neon Capital','https://igamewin.com/storage/igamewin/10084.webp',1,'slot-evoplay',0,'slot','3','iGameWin'),
(409,'neon_capital_b_b','Neon Capital Bonus Buy','https://igamewin.com/storage/igamewin/10085.webp',1,'slot-evoplay',0,'slot','3','iGameWin'),
(410,'northern_temple','Northern Temple','https://igamewin.com/storage/igamewin/10086.webp',1,'slot-evoplay',0,'slot','3','iGameWin'),
(411,'northern_temple_b_b','Northern Temple Bonus Buy','https://igamewin.com/storage/igamewin/10087.webp',1,'slot-evoplay',0,'slot','3','iGameWin'),
(412,'nuke_world','Nuke World','https://igamewin.com/storage/igamewin/10088.webp',1,'slot-evoplay',0,'slot','3','iGameWin'),
(413,'ocean_catch','Ocean Catch','https://igamewin.com/storage/igamewin/10089.webp',1,'slot-evoplay',0,'slot','3','iGameWin'),
(414,'roman_rule','Roman Rule','https://igamewin.com/storage/igamewin/10090.webp',1,'slot-evoplay',0,'slot','3','iGameWin'),
(415,'rueda_de_chile','Rueda De Chile','https://igamewin.com/storage/igamewin/10091.webp',1,'slot-evoplay',0,'slot','3','iGameWin'),
(416,'rueda_de_chile_b_b','Rueda De Chile Bonus Buy','https://igamewin.com/storage/igamewin/10092.webp',1,'slot-evoplay',0,'slot','3','iGameWin'),
(417,'sweet_sugar','Sweet Sugar','https://igamewin.com/storage/igamewin/10093.webp',1,'slot-evoplay',0,'slot','3','iGameWin'),
(418,'temple_of_thunder2','Temple Of Thunder II','https://igamewin.com/storage/igamewin/10094.webp',1,'slot-evoplay',0,'slot','3','iGameWin'),
(419,'temple_of_thunder2_b_b','Temple Of Thunder II Bonus Buy','https://igamewin.com/storage/igamewin/10095.webp',1,'slot-evoplay',0,'slot','3','iGameWin'),
(420,'the_greatest_catch','The Greatest Catch','https://igamewin.com/storage/igamewin/10096.webp',1,'slot-evoplay',0,'slot','3','iGameWin'),
(421,'treasure_mania','Treasure Mania','https://igamewin.com/storage/igamewin/10097.webp',1,'slot-evoplay',0,'slot','3','iGameWin'),
(422,'valley_of_dreams','Valley Of Dreams','https://igamewin.com/storage/igamewin/10098.webp',1,'slot-evoplay',0,'slot','3','iGameWin'),
(423,'wild_bullets','Wild Bullets','https://igamewin.com/storage/igamewin/10099.webp',1,'slot-evoplay',0,'slot','3','iGameWin'),
(424,'softswiss/LuckyDucky','Lucky Ducky','https://igamewin.com/storage/igamewin/6790.webp',1,'bgaming',0,'slot','3','iGameWin'),
(425,'softswiss/WildMoonThieves','Wild Moon Thieves','https://igamewin.com/storage/igamewin/6791.webp',1,'bgaming',0,'slot','3','iGameWin'),
(426,'softswiss/RotatingElement','Rotating Element','https://igamewin.com/storage/igamewin/8078.webp',1,'bgaming',0,'slot','3','iGameWin'),
(427,'softswiss/FortunaTrueways','Fortuna TRUEWAYS','https://igamewin.com/storage/igamewin/8209.webp',1,'bgaming',0,'slot','3','iGameWin'),
(428,'softswiss/RoyalFruitsMultiLines','Royal Fruits MultiLines','https://igamewin.com/storage/igamewin/8210.webp',1,'bgaming',0,'slot','3','iGameWin'),
(429,'softswiss/VoodooPeople','Voodoo People','https://igamewin.com/storage/igamewin/8211.webp',1,'bgaming',0,'slot','3','iGameWin'),
(430,'softswiss/FishingClub','Fishing Club','https://igamewin.com/storage/igamewin/8212.webp',1,'bgaming',0,'slot','3','iGameWin'),
(431,'softswiss/AlchemyAcademy','Alchemy Academy','https://igamewin.com/storage/igamewin/8437.webp',1,'bgaming',0,'slot','3','iGameWin'),
(432,'softswiss/TrainToRioGrande','Train to Rio Grande','https://igamewin.com/storage/igamewin/8439.webp',1,'bgaming',0,'slot','3','iGameWin'),
(433,'softswiss/WildWestTrueways','Wild West TRUEWAYS','https://igamewin.com/storage/igamewin/8709.webp',1,'bgaming',0,'slot','3','iGameWin'),
(434,'softswiss/GoldMagnate','Gold Magnate','https://igamewin.com/storage/igamewin/8710.webp',1,'bgaming',0,'slot','3','iGameWin'),
(435,'softswiss/Aviamasters','Aviamasters','https://igamewin.com/storage/igamewin/8965.webp',1,'bgaming',0,'slot','3','iGameWin'),
(436,'softswiss/AlienFruits2','Alien Fruits 2','https://igamewin.com/storage/igamewin/8966.webp',1,'bgaming',0,'slot','3','iGameWin'),
(437,'softswiss/PandaLuck','Panda Luck','https://igamewin.com/storage/igamewin/9183.webp',1,'bgaming',0,'slot','3','iGameWin'),
(438,'softswiss/BurningChilliX','Burning Chilli X','https://igamewin.com/storage/igamewin/9184.webp',1,'bgaming',0,'slot','3','iGameWin'),
(439,'softswiss/RoyalHighRoad','Royal High-Road','https://igamewin.com/storage/igamewin/9186.webp',1,'bgaming',0,'slot','3','iGameWin'),
(440,'vs20clustcol','Sweet Kingdom','https://igamewin.com/storage/igamewin/171.webp',1,'PRAGMATIC',0,'slot','3','iGameWin'),
(441,'vswaysspltsym','Dwarf & Dragon','https://igamewin.com/storage/igamewin/172.webp',1,'PRAGMATIC',0,'slot','3','iGameWin'),
(442,'vs20shootstars','Heroic Spins','https://igamewin.com/storage/igamewin/173.webp',1,'PRAGMATIC',0,'slot','3','iGameWin'),
(443,'vs20olympgate','Gates of Olympus','https://igamewin.com/storage/igamewin/174.webp',1,'PRAGMATIC',0,'slot','3','iGameWin'),
(444,'vs10bbbonanza','Big Bass Bonanza','https://igamewin.com/storage/igamewin/175.webp',1,'PRAGMATIC',0,'slot','3','iGameWin'),
(445,'vs20sugarrush','Sugar Rush','https://igamewin.com/storage/igamewin/176.webp',1,'PRAGMATIC',0,'slot','3','iGameWin'),
(446,'vs20fruitsw','Sweet Bonanza','https://igamewin.com/storage/igamewin/177.webp',1,'PRAGMATIC',0,'slot','3','iGameWin'),
(447,'vs20starlight','Starlight Princess','https://igamewin.com/storage/igamewin/178.webp',1,'PRAGMATIC',0,'slot','3','iGameWin'),
(448,'vs20doghouse','The Dog House','https://igamewin.com/storage/igamewin/180.webp',1,'PRAGMATIC',0,'slot','3','iGameWin'),
(449,'vs5aztecgems','Aztec Gems','https://igamewin.com/storage/igamewin/183.webp',1,'PRAGMATIC',0,'slot','3','iGameWin'),
(450,'vs25goldparty','Gold Party','https://igamewin.com/storage/igamewin/184.webp',1,'PRAGMATIC',0,'slot','3','iGameWin'),
(451,'vs10floatdrg','Floating Dragon','https://igamewin.com/storage/igamewin/185.webp',1,'PRAGMATIC',0,'slot','3','iGameWin'),
(452,'vs40wildwest','Wild West Gold','https://igamewin.com/storage/igamewin/186.webp',1,'PRAGMATIC',0,'slot','3','iGameWin'),
(453,'vs1tigers','Triple Tigers','https://igamewin.com/storage/igamewin/187.webp',1,'PRAGMATIC',0,'slot','3','iGameWin'),
(454,'vs1dragon8','888 Dragons','https://igamewin.com/storage/igamewin/188.webp',1,'PRAGMATIC',0,'slot','3','iGameWin'),
(455,'vs5joker','Joker\'s Jewels','https://igamewin.com/storage/igamewin/189.webp',1,'PRAGMATIC',0,'slot','3','iGameWin'),
(456,'vs20midas2','Hand of Midas 2','https://igamewin.com/storage/igamewin/190.webp',1,'PRAGMATIC',0,'slot','3','iGameWin'),
(457,'vs5hotbmult','Hot To Burn Multiplier','https://igamewin.com/storage/igamewin/191.webp',1,'PRAGMATIC',0,'slot','3','iGameWin'),
(458,'vswaysbkingasc','Buffalo King Untamed Megaways','https://igamewin.com/storage/igamewin/192.webp',1,'PRAGMATIC',0,'slot','3','iGameWin'),
(459,'vs20medusast','Medusa\'s Stone','https://igamewin.com/storage/igamewin/194.webp',1,'PRAGMATIC',0,'slot','3','iGameWin'),
(460,'vs20devilic','Devilicious','https://igamewin.com/storage/igamewin/195.webp',1,'PRAGMATIC',0,'slot','3','iGameWin'),
(461,'vs25wildies','Wildies','https://igamewin.com/storage/igamewin/196.webp',1,'PRAGMATIC',0,'slot','3','iGameWin'),
(462,'vswaysloki','Revenge of Loki Megaways','https://igamewin.com/storage/igamewin/197.webp',1,'PRAGMATIC',0,'slot','3','iGameWin'),
(463,'vs10bbbrlact','Big Bass Bonanza - Reel Action','https://igamewin.com/storage/igamewin/198.webp',1,'PRAGMATIC',0,'slot','3','iGameWin'),
(464,'vswaysjapan','Starlight Princess Pachi','https://igamewin.com/storage/igamewin/199.webp',1,'PRAGMATIC',0,'slot','3','iGameWin'),
(465,'vs20heartcleo','Heart of Cleopatra','https://igamewin.com/storage/igamewin/200.webp',1,'PRAGMATIC',0,'slot','3','iGameWin'),
(466,'vs20fruitswx','Sweet Bonanza 1000','https://igamewin.com/storage/igamewin/201.webp',1,'PRAGMATIC',0,'slot','3','iGameWin'),
(467,'vs20fortbon','Fruity Treats','https://igamewin.com/storage/igamewin/202.webp',1,'PRAGMATIC',0,'slot','3','iGameWin'),
(468,'vs20candybltz2','Candy Blitz Bombs','https://igamewin.com/storage/igamewin/203.webp',1,'PRAGMATIC',0,'slot','3','iGameWin'),
(469,'vswayshexhaus','Rise of Pyramids','https://igamewin.com/storage/igamewin/204.webp',1,'PRAGMATIC',0,'slot','3','iGameWin'),
(470,'vswaysmegahays','Barnyard Megahays Megaways','https://igamewin.com/storage/igamewin/205.webp',1,'PRAGMATIC',0,'slot','3','iGameWin'),
(471,'vs20stickypos','Ice Lobster','https://igamewin.com/storage/igamewin/206.webp',1,'PRAGMATIC',0,'slot','3','iGameWin'),
(472,'vs20sbpnudge','Aztec Powernudge','https://igamewin.com/storage/igamewin/207.webp',1,'PRAGMATIC',0,'slot','3','iGameWin'),
(473,'vs20bison','Release the Bison','https://igamewin.com/storage/igamewin/208.webp',1,'PRAGMATIC',0,'slot','3','iGameWin'),
(474,'vs10bburger','Big Burger Load it up with Xtra Cheese','https://igamewin.com/storage/igamewin/209.webp',1,'PRAGMATIC',0,'slot','3','iGameWin'),
(475,'vs20portals','Fire Portals','https://igamewin.com/storage/igamewin/211.webp',1,'PRAGMATIC',0,'slot','3','iGameWin'),
(476,'vs20sugarrushx','Sugar Rush 1000','https://igamewin.com/storage/igamewin/212.webp',1,'PRAGMATIC',0,'slot','3','iGameWin'),
(477,'vs20stckwldsc','Pot of Fortune','https://igamewin.com/storage/igamewin/213.webp',1,'PRAGMATIC',0,'slot','3','iGameWin'),
(478,'vs20doghouse2','The Dog House - Dog or Alive','https://igamewin.com/storage/igamewin/214.webp',1,'PRAGMATIC',0,'slot','3','iGameWin'),
(479,'vs40stckwldlvl','Ripe Rewards','https://igamewin.com/storage/igamewin/217.webp',1,'PRAGMATIC',0,'slot','3','iGameWin'),
(480,'vs10frontrun','Front Runner Odds On','https://igamewin.com/storage/igamewin/219.webp',1,'PRAGMATIC',0,'slot','3','iGameWin'),
(481,'vs20powerpays','Red Hot Luck','https://igamewin.com/storage/igamewin/220.webp',1,'PRAGMATIC',0,'slot','3','iGameWin'),
(482,'vs20bigdawgs','The Big Dawgs','https://igamewin.com/storage/igamewin/221.webp',1,'PRAGMATIC',0,'slot','3','iGameWin'),
(483,'vswaysfirewmw','Blazing Wilds Megaways','https://igamewin.com/storage/igamewin/222.webp',1,'PRAGMATIC',0,'slot','3','iGameWin'),
(484,'vs20treesot','Trees of Treasure','https://igamewin.com/storage/igamewin/223.webp',1,'PRAGMATIC',0,'slot','3','iGameWin'),
(485,'vswaysalterego','The Alter Ego','https://igamewin.com/storage/igamewin/224.webp',1,'PRAGMATIC',0,'slot','3','iGameWin'),
(486,'vs10bbfloats','Big Bass Floats my Boat','https://igamewin.com/storage/igamewin/225.webp',1,'PRAGMATIC',0,'slot','3','iGameWin'),
(487,'vswaysmegareel','Pompeii Megareels Megaways','https://igamewin.com/storage/igamewin/226.webp',1,'PRAGMATIC',0,'slot','3','iGameWin'),
(488,'vs20multiup','Wheel O\'Gold','https://igamewin.com/storage/igamewin/227.webp',1,'PRAGMATIC',0,'slot','3','iGameWin'),
(489,'vs10strawberry','Strawberry Cocktail','https://igamewin.com/storage/igamewin/228.webp',1,'PRAGMATIC',0,'slot','3','iGameWin'),
(490,'vs20mmmelon','Mighty Munching Melons','https://igamewin.com/storage/igamewin/229.webp',1,'PRAGMATIC',0,'slot','3','iGameWin'),
(491,'vs20olympdice','Gates of Olympus Dice','https://igamewin.com/storage/igamewin/230.webp',1,'PRAGMATIC',0,'slot','3','iGameWin'),
(492,'vs20clustext','Gears of Horus','https://igamewin.com/storage/igamewin/231.webp',1,'PRAGMATIC',0,'slot','3','iGameWin'),
(493,'vs20mergedwndw','Blade & Fangs','https://igamewin.com/storage/igamewin/232.webp',1,'PRAGMATIC',0,'slot','3','iGameWin'),
(494,'vs20yotdk','Year Of The Dragon King','https://igamewin.com/storage/igamewin/233.webp',1,'PRAGMATIC',0,'slot','3','iGameWin'),
(495,'vswaysexpandng','Castle of Fire','https://igamewin.com/storage/igamewin/234.webp',1,'PRAGMATIC',0,'slot','3','iGameWin'),
(496,'vs10luckfort','Good Luck & Good Fortune','https://igamewin.com/storage/igamewin/235.webp',1,'PRAGMATIC',0,'slot','3','iGameWin'),
(497,'vs20loksriches','Loki\'s Riches','https://igamewin.com/storage/igamewin/236.webp',1,'PRAGMATIC',0,'slot','3','iGameWin'),
(498,'vswaysfltdrgny','Floating Dragon New Year Festival Ultra Megaways Hold & Spin','https://igamewin.com/storage/igamewin/238.webp',1,'PRAGMATIC',0,'slot','3','iGameWin'),
(499,'vswaystimber','Timber Stacks','https://igamewin.com/storage/igamewin/239.webp',1,'PRAGMATIC',0,'slot','3','iGameWin'),
(500,'vs20sugarnudge','Sugar Supreme Powernudge','https://igamewin.com/storage/igamewin/240.webp',1,'PRAGMATIC',0,'slot','3','iGameWin'),
(501,'vs40demonpots','Demon Pots','https://igamewin.com/storage/igamewin/242.webp',1,'PRAGMATIC',0,'slot','3','iGameWin'),
(502,'vs40rainbowr','Rainbow Reels','https://igamewin.com/storage/igamewin/243.webp',1,'PRAGMATIC',0,'slot','3','iGameWin'),
(503,'vs20dhcluster','Twilight Princess','https://igamewin.com/storage/igamewin/244.webp',1,'PRAGMATIC',0,'slot','3','iGameWin'),
(504,'vswaysstrlght','Fortunes of Aztec','https://igamewin.com/storage/igamewin/245.webp',1,'PRAGMATIC',0,'slot','3','iGameWin'),
(505,'vs20gravity','Gravity Bonanza','https://igamewin.com/storage/igamewin/246.webp',1,'PRAGMATIC',0,'slot','3','iGameWin'),
(506,'vs40infwild','Infective Wild','https://igamewin.com/storage/igamewin/247.webp',1,'PRAGMATIC',0,'slot','3','iGameWin'),
(507,'vswaystut','Book of Tut Megaways','https://igamewin.com/storage/igamewin/248.webp',1,'PRAGMATIC',0,'slot','3','iGameWin'),
(508,'vs10gdchalleng','8 Golden Dragon Challenge','https://igamewin.com/storage/igamewin/249.webp',1,'PRAGMATIC',0,'slot','3','iGameWin'),
(509,'vswaysftropics','Frozen Tropics','https://igamewin.com/storage/igamewin/250.webp',1,'PRAGMATIC',0,'slot','3','iGameWin'),
(510,'vswaysincwnd','Gold Oasis','https://igamewin.com/storage/igamewin/251.webp',1,'PRAGMATIC',0,'slot','3','iGameWin'),
(511,'vswaysbbhas','Big Bass Hold & Spinner Megaways','https://igamewin.com/storage/igamewin/252.webp',1,'PRAGMATIC',0,'slot','3','iGameWin'),
(512,'vs10bookviking','Book of Vikings','https://igamewin.com/storage/igamewin/253.webp',1,'PRAGMATIC',0,'slot','3','iGameWin'),
(513,'vs20piggybank','Piggy Bankers','https://igamewin.com/storage/igamewin/254.webp',1,'PRAGMATIC',0,'slot','3','iGameWin'),
(514,'vs50jucier','Sky Bounty','https://igamewin.com/storage/igamewin/256.webp',1,'PRAGMATIC',0,'slot','3','iGameWin'),
(515,'vs243nudge4gold','Hellvis Wild','https://igamewin.com/storage/igamewin/258.webp',1,'PRAGMATIC',0,'slot','3','iGameWin'),
(516,'vs20forge','Forge of Olympus','https://igamewin.com/storage/igamewin/260.webp',1,'PRAGMATIC',0,'slot','3','iGameWin'),
(517,'vs20lvlup','Pub Kings','https://igamewin.com/storage/igamewin/261.webp',1,'PRAGMATIC',0,'slot','3','iGameWin'),
(518,'vs20earthquake','Cyclops Smash','https://igamewin.com/storage/igamewin/262.webp',1,'PRAGMATIC',0,'slot','3','iGameWin'),
(519,'vs10trail','Mustang Trail','https://igamewin.com/storage/igamewin/263.webp',1,'PRAGMATIC',0,'slot','3','iGameWin'),
(520,'vs20splmystery','Spellbinding Mystery','https://igamewin.com/storage/igamewin/264.webp',1,'PRAGMATIC',0,'slot','3','iGameWin'),
(521,'vs20hstgldngt','Heist for the Golden Nuggets','https://igamewin.com/storage/igamewin/265.webp',1,'PRAGMATIC',0,'slot','3','iGameWin'),
(522,'vs20procount','Wisdom of Athena','https://igamewin.com/storage/igamewin/266.webp',1,'PRAGMATIC',0,'slot','3','iGameWin'),
(523,'vs20beefed','Fat Panda','https://igamewin.com/storage/igamewin/268.webp',1,'PRAGMATIC',0,'slot','3','iGameWin'),
(524,'vs10fdrasbf','Floating Dragon - Dragon Boat Festival','https://igamewin.com/storage/igamewin/269.webp',1,'PRAGMATIC',0,'slot','3','iGameWin'),
(525,'vs9outlaw','Pirates Pub ','https://igamewin.com/storage/igamewin/270.webp',1,'PRAGMATIC',0,'slot','3','iGameWin'),
(526,'vs20clustwild','Sticky Bees','https://igamewin.com/storage/igamewin/271.webp',1,'PRAGMATIC',0,'slot','3','iGameWin'),
(527,'vs20jewelparty','Jewel Rush','https://igamewin.com/storage/igamewin/272.webp',1,'PRAGMATIC',0,'slot','3','iGameWin'),
(528,'vs20lampinf','Lamp Of Infinity','https://igamewin.com/storage/igamewin/273.webp',1,'PRAGMATIC',0,'slot','3','iGameWin'),
(529,'vs25spotz','Knight Hot Spotz','https://igamewin.com/storage/igamewin/274.webp',1,'PRAGMATIC',0,'slot','3','iGameWin'),
(530,'vs20stickywild','Wild Bison Charge','https://igamewin.com/storage/igamewin/275.webp',1,'PRAGMATIC',0,'slot','3','iGameWin'),
(531,'vs10jnmntzma','Jane Hunter and the Mask of Montezuma','https://igamewin.com/storage/igamewin/277.webp',1,'PRAGMATIC',0,'slot','3','iGameWin'),
(532,'vswaysrsm','Wild Celebrity Bus Megaways','https://igamewin.com/storage/igamewin/278.webp',1,'PRAGMATIC',0,'slot','3','iGameWin'),
(533,'vs20excalibur','Excalibur Unleashed','https://igamewin.com/storage/igamewin/279.webp',1,'PRAGMATIC',0,'slot','3','iGameWin'),
(534,'vs20hotzone','African Elephant','https://igamewin.com/storage/igamewin/280.webp',1,'PRAGMATIC',0,'slot','3','iGameWin'),
(535,'vs10gizagods','Gods of Giza','https://igamewin.com/storage/igamewin/281.webp',1,'PRAGMATIC',0,'slot','3','iGameWin'),
(536,'vswaysredqueen','The Red Queen','https://igamewin.com/storage/igamewin/282.webp',1,'PRAGMATIC',0,'slot','3','iGameWin'),
(537,'vs20sknights','The Knight King','https://igamewin.com/storage/igamewin/283.webp',1,'PRAGMATIC',0,'slot','3','iGameWin'),
(538,'vs20mvwild','Jasmine Dreams','https://igamewin.com/storage/igamewin/284.webp',1,'PRAGMATIC',0,'slot','3','iGameWin'),
(539,'vs20mochimon','Mochimon','https://igamewin.com/storage/igamewin/285.webp',1,'PRAGMATIC',0,'slot','3','iGameWin'),
(540,'vswaysultrcoin','Cowboy Coins','https://igamewin.com/storage/igamewin/286.webp',1,'PRAGMATIC',0,'slot','3','iGameWin'),
(541,'vs20doghousemh','The Dog House Multihold','https://igamewin.com/storage/igamewin/287.webp',1,'PRAGMATIC',0,'slot','3','iGameWin'),
(542,'vs20pistols','Wild West Duels','https://igamewin.com/storage/igamewin/288.webp',1,'PRAGMATIC',0,'slot','3','iGameWin'),
(543,'vs12tropicana','Club Tropicana','https://igamewin.com/storage/igamewin/289.webp',1,'PRAGMATIC',0,'slot','3','iGameWin'),
(544,'vs25archer','Fire Archer','https://igamewin.com/storage/igamewin/290.webp',1,'PRAGMATIC',0,'slot','3','iGameWin'),
(545,'vs20mammoth','Mammoth Gold Megaways','https://igamewin.com/storage/igamewin/291.webp',1,'PRAGMATIC',0,'slot','3','iGameWin'),
(546,'vs10fisheye','Fish Eye','https://igamewin.com/storage/igamewin/292.webp',1,'PRAGMATIC',0,'slot','3','iGameWin'),
(547,'vswaysmorient','Mystery of the Orient','https://igamewin.com/storage/igamewin/293.webp',1,'PRAGMATIC',0,'slot','3','iGameWin'),
(548,'vs25spgldways','Secret City Gold','https://igamewin.com/storage/igamewin/294.webp',1,'PRAGMATIC',0,'slot','3','iGameWin'),
(549,'vs20drgbless','Dragon Hero','https://igamewin.com/storage/igamewin/295.webp',1,'PRAGMATIC',0,'slot','3','iGameWin'),
(550,'vs20clspwrndg','Sweet Powernudge','https://igamewin.com/storage/igamewin/296.webp',1,'PRAGMATIC',0,'slot','3','iGameWin'),
(551,'vswayspizza','PIZZA PIZZA PIZZA','https://igamewin.com/storage/igamewin/297.webp',1,'PRAGMATIC',0,'slot','3','iGameWin'),
(552,'vs20dugems','Hot Pepper','https://igamewin.com/storage/igamewin/298.webp',1,'PRAGMATIC',0,'slot','3','iGameWin'),
(553,'vs25rlbank','Reel Banks','https://igamewin.com/storage/igamewin/299.webp',1,'PRAGMATIC',0,'slot','3','iGameWin'),
(554,'vswaysfuryodin','Fury of Odin Megaways','https://igamewin.com/storage/igamewin/300.webp',1,'PRAGMATIC',0,'slot','3','iGameWin'),
(555,'vs12bbbxmas','Bigger Bass Blizzard - Christmas Catch','https://igamewin.com/storage/igamewin/301.webp',1,'PRAGMATIC',0,'slot','3','iGameWin'),
(556,'vs10snakeeyes','Snakes & Ladders - Snake Eyes','https://igamewin.com/storage/igamewin/302.webp',1,'PRAGMATIC',0,'slot','3','iGameWin'),
(557,'vs20lcount','Gems of Serengeti','https://igamewin.com/storage/igamewin/303.webp',1,'PRAGMATIC',0,'slot','3','iGameWin'),
(558,'vs20theights','Towering Fortunes','https://igamewin.com/storage/igamewin/305.webp',1,'PRAGMATIC',0,'slot','3','iGameWin'),
(559,'vs20swordofares','Sword of Ares','https://igamewin.com/storage/igamewin/306.webp',1,'PRAGMATIC',0,'slot','3','iGameWin'),
(560,'vs10bbkir','Big Bass Bonanza - Keeping it Reel','https://igamewin.com/storage/igamewin/307.webp',1,'PRAGMATIC',0,'slot','3','iGameWin'),
(561,'vs20mtreasure','Pirate Golden Age','https://igamewin.com/storage/igamewin/309.webp',1,'PRAGMATIC',0,'slot','3','iGameWin'),
(562,'vs10tut','Book Of Tut Respin','https://igamewin.com/storage/igamewin/310.webp',1,'PRAGMATIC',0,'slot','3','iGameWin'),
(563,'vswaysfltdrg','Floating Dragon Hold & Spin Megaways','https://igamewin.com/storage/igamewin/311.webp',1,'PRAGMATIC',0,'slot','3','iGameWin'),
(564,'vs20mparty','Wild Hop & Drop','https://igamewin.com/storage/igamewin/312.webp',1,'PRAGMATIC',0,'slot','3','iGameWin'),
(565,'vs10crownfire','Crown of Fire','https://igamewin.com/storage/igamewin/313.webp',1,'PRAGMATIC',0,'slot','3','iGameWin'),
(566,'vs20sugarcoins','Viking Forge','https://igamewin.com/storage/igamewin/315.webp',1,'PRAGMATIC',0,'slot','3','iGameWin'),
(567,'vswaysbook','Book of Golden Sands','https://igamewin.com/storage/igamewin/316.webp',1,'PRAGMATIC',0,'slot','3','iGameWin'),
(568,'vs20octobeer','Octobeer Fortunes','https://igamewin.com/storage/igamewin/317.webp',1,'PRAGMATIC',0,'slot','3','iGameWin'),
(569,'vs5strh','Striking Hot 5','https://igamewin.com/storage/igamewin/318.webp',1,'PRAGMATIC',0,'slot','3','iGameWin'),
(570,'vs40firehot','Fire Hot 40','https://igamewin.com/storage/igamewin/319.webp',1,'PRAGMATIC',0,'slot','3','iGameWin'),
(571,'vs5firehot','Fire Hot 5','https://igamewin.com/storage/igamewin/320.webp',1,'PRAGMATIC',0,'slot','3','iGameWin'),
(572,'vs20fh','Fire Hot 20','https://igamewin.com/storage/igamewin/321.webp',1,'PRAGMATIC',0,'slot','3','iGameWin'),
(573,'vs100firehot','Fire Hot 100','https://igamewin.com/storage/igamewin/322.webp',1,'PRAGMATIC',0,'slot','3','iGameWin'),
(574,'vs40hotburnx','Hot To Burn Extreme','https://igamewin.com/storage/igamewin/324.webp',1,'PRAGMATIC',0,'slot','3','iGameWin'),
(575,'vs20trswild2','Black Bull','https://igamewin.com/storage/igamewin/325.webp',1,'PRAGMATIC',0,'slot','3','iGameWin'),
(576,'vs20wolfie','Greedy Wolf','https://igamewin.com/storage/igamewin/326.webp',1,'PRAGMATIC',0,'slot','3','iGameWin'),
(577,'vs1024gmayhem','Gorilla Mayhem','https://igamewin.com/storage/igamewin/327.webp',1,'PRAGMATIC',0,'slot','3','iGameWin'),
(578,'vs5luckytig','Tigre Sortudo','https://igamewin.com/storage/igamewin/343.webp',1,'PRAGMATIC',0,'slot','3','iGameWin'),
(579,'14087','POP POP CANDY','https://igamewin.com/storage/igamewin/10288.webp',1,'slot-jdb',0,'slot','3','iGameWin'),
(580,'14086','Open Sesame Mega','https://igamewin.com/storage/igamewin/10289.webp',1,'slot-jdb',0,'slot','3','iGameWin'),
(581,'14085','FRUITY BONANZA','https://igamewin.com/storage/igamewin/10291.webp',1,'slot-jdb',0,'slot','3','iGameWin'),
(582,'14083','COOCOO FARM','https://igamewin.com/storage/igamewin/10292.webp',1,'slot-jdb',0,'slot','3','iGameWin'),
(583,'14082','Elemental Link Water','https://igamewin.com/storage/igamewin/10293.webp',1,'slot-jdb',0,'slot','3','iGameWin'),
(584,'14080','ELEMENTAL LINK FIRE','https://igamewin.com/storage/igamewin/10294.webp',1,'slot-jdb',0,'slot','3','iGameWin'),
(585,'14077','TRUMPCARD','https://igamewin.com/storage/igamewin/10295.webp',1,'slot-jdb',0,'slot','3','iGameWin'),
(586,'14075','FORTUNE NEKO','https://igamewin.com/storage/igamewin/10296.webp',1,'slot-jdb',0,'slot','3','iGameWin'),
(587,'14070','BOOK OF MYSTERY','https://igamewin.com/storage/igamewin/10297.webp',1,'slot-jdb',0,'slot','3','iGameWin'),
(588,'14068','PROSPERITY TIGER','https://igamewin.com/storage/igamewin/10298.webp',1,'slot-jdb',0,'slot','3','iGameWin'),
(589,'14065','BLOSSOM OF WEALTH','https://igamewin.com/storage/igamewin/10299.webp',1,'slot-jdb',0,'slot','3','iGameWin'),
(590,'14064','BOOM FIESTA','https://igamewin.com/storage/igamewin/10300.webp',1,'slot-jdb',0,'slot','3','iGameWin'),
(591,'14063','CRAZYBIG THREE DRAGONS','https://igamewin.com/storage/igamewin/10301.webp',1,'slot-jdb',0,'slot','3','iGameWin'),
(592,'14060','LANTERN WEALTH','https://igamewin.com/storage/igamewin/10302.webp',1,'slot-jdb',0,'slot','3','iGameWin'),
(593,'14061','MAYA GOLD','https://igamewin.com/storage/igamewin/10303.webp',1,'slot-jdb',0,'slot','3','iGameWin'),
(594,'14059','MARVELOUS IV','https://igamewin.com/storage/igamewin/10304.webp',1,'slot-jdb',0,'slot','3','iGameWin'),
(595,'14058','WONDER ELEPHANT','https://igamewin.com/storage/igamewin/10305.webp',1,'slot-jdb',0,'slot','3','iGameWin'),
(596,'14055','KONG','https://igamewin.com/storage/igamewin/10306.webp',1,'slot-jdb',0,'slot','3','iGameWin'),
(597,'14052','JUNGLE JUNGLE','https://igamewin.com/storage/igamewin/10307.webp',1,'slot-jdb',0,'slot','3','iGameWin'),
(598,'14054','LUCKY DIAMOND','https://igamewin.com/storage/igamewin/10308.webp',1,'slot-jdb',0,'slot','3','iGameWin'),
(599,'softswiss/MonsterHunt','Monster Hunt','https://igamewin.com/storage/igamewin/9227.webp',1,'bgaming',0,'slot','3','iGameWin'),
(600,'softswiss/Gemza','Gemza','https://igamewin.com/storage/igamewin/9350.webp',1,'bgaming',0,'slot','3','iGameWin'),
(601,'softswiss/TrampDay','Tramp Day','https://igamewin.com/storage/igamewin/9351.webp',1,'bgaming',0,'slot','3','iGameWin'),
(602,'softswiss/Hottest666','Hottest 666','https://igamewin.com/storage/igamewin/9352.webp',1,'bgaming',0,'slot','3','iGameWin'),
(603,'softswiss/SlotMachine','slot Machine','https://igamewin.com/storage/igamewin/9391.webp',1,'bgaming',0,'slot','3','iGameWin'),
(604,'softswiss/BookOfPanda','Book of Panda Megaways','https://igamewin.com/storage/igamewin/9404.webp',1,'bgaming',0,'slot','3','iGameWin'),
(605,'softswiss/AlohaKingElvis','Aloha King Elvis','https://igamewin.com/storage/igamewin/9506.webp',1,'bgaming',0,'slot','3','iGameWin'),
(606,'softswiss/LuckyDamaMuerta','Lucky Dama Muerta','https://igamewin.com/storage/igamewin/9507.webp',1,'bgaming',0,'slot','3','iGameWin'),
(607,'softswiss/SweetRushMegaways','sweet Rush Megaways','https://igamewin.com/storage/igamewin/9508.webp',1,'bgaming',0,'slot','3','iGameWin'),
(608,'softswiss/BookOfCatsMegaways','Book Of Cats Megaways','https://igamewin.com/storage/igamewin/9509.webp',1,'bgaming',0,'slot','3','iGameWin'),
(609,'softswiss/LuckyOak','Lucky Oak','https://igamewin.com/storage/igamewin/9510.webp',1,'bgaming',0,'slot','3','iGameWin'),
(610,'softswiss/Lucky8MergeUp','Lucky 8 Merge Up','https://igamewin.com/storage/igamewin/9511.webp',1,'bgaming',0,'slot','3','iGameWin'),
(611,'softswiss/EasterHeist','Easter Heist','https://igamewin.com/storage/igamewin/9529.webp',1,'bgaming',0,'slot','3','iGameWin'),
(612,'softswiss/MiceAndMagic','Mice & Magic Wonder Spin','https://igamewin.com/storage/igamewin/9530.webp',1,'bgaming',0,'slot','3','iGameWin'),
(613,'softswiss/AlienFruits','Alien Fruits','https://igamewin.com/storage/igamewin/9531.webp',1,'bgaming',0,'slot','3','iGameWin'),
(614,'softswiss/CloverBonanza','Clover Bonanza','https://igamewin.com/storage/igamewin/9532.webp',1,'bgaming',0,'slot','3','iGameWin'),
(615,'softswiss/LuckyCrew','Lucky Crew','https://igamewin.com/storage/igamewin/9533.webp',1,'bgaming',0,'slot','3','iGameWin'),
(616,'softswiss/LuckyFarmBonanza','Lucky Farm Bonanza','https://igamewin.com/storage/igamewin/9534.webp',1,'bgaming',0,'slot','3','iGameWin'),
(617,'softswiss/Soccermania','soccermania','https://igamewin.com/storage/igamewin/9535.webp',1,'bgaming',0,'slot','3','iGameWin'),
(618,'softswiss/SavageBuffaloSpiritMegaways','savage Buffalo Spirit Megaways','https://igamewin.com/storage/igamewin/9536.webp',1,'bgaming',0,'slot','3','iGameWin'),
(619,'softswiss/BonanzaBillion','Bonanza Billion','https://igamewin.com/storage/igamewin/9537.webp',1,'bgaming',0,'slot','3','iGameWin'),
(620,'softswiss/HitTheRoute','Hit The Route','https://igamewin.com/storage/igamewin/9538.webp',1,'bgaming',0,'slot','3','iGameWin'),
(621,'softswiss/GiftRush','Gift Rush','https://igamewin.com/storage/igamewin/9539.webp',1,'bgaming',0,'slot','3','iGameWin'),
(622,'softswiss/MissCherryFruits','Miss Cherry Fruits','https://igamewin.com/storage/igamewin/9540.webp',1,'bgaming',0,'slot','3','iGameWin'),
(623,'softswiss/WildCashDice','Wild Cash Dice','https://igamewin.com/storage/igamewin/9541.webp',1,'bgaming',0,'slot','3','iGameWin'),
(624,'softswiss/DiceBonanza','Dice Bonanza','https://igamewin.com/storage/igamewin/9542.webp',1,'bgaming',0,'slot','3','iGameWin'),
(625,'softswiss/WildCashX9990','Wild Cash x9990','https://igamewin.com/storage/igamewin/9543.webp',1,'bgaming',0,'slot','3','iGameWin'),
(626,'softswiss/JohnnyCash','Johnny Cash','https://igamewin.com/storage/igamewin/9544.webp',1,'bgaming',0,'slot','3','iGameWin'),
(627,'softswiss/AztecMagicMegaways','Aztec Magic Megaways','https://igamewin.com/storage/igamewin/9545.webp',1,'bgaming',0,'slot','3','iGameWin'),
(628,'softswiss/BeastBand','Beast Band','https://igamewin.com/storage/igamewin/9546.webp',1,'bgaming',0,'slot','3','iGameWin'),
(629,'softswiss/DragonsGold100','Dragon\'s Gold 100','https://igamewin.com/storage/igamewin/9547.webp',1,'bgaming',0,'slot','3','iGameWin'),
(630,'softswiss/LuckyLadyMoon','Lady Wolf Moon','https://igamewin.com/storage/igamewin/9548.webp',1,'bgaming',0,'slot','3','iGameWin'),
(631,'softswiss/WildChicago','Wild Chicago','https://igamewin.com/storage/igamewin/9549.webp',1,'bgaming',0,'slot','3','iGameWin'),
(632,'softswiss/DiceMillion','Dice Million','https://igamewin.com/storage/igamewin/9550.webp',1,'bgaming',0,'slot','3','iGameWin'),
(633,'softswiss/Road2Riches','Road 2 Riches','https://igamewin.com/storage/igamewin/9551.webp',1,'bgaming',0,'slot','3','iGameWin'),
(634,'softswiss/JokerQueen','Joker Queen','https://igamewin.com/storage/igamewin/9552.webp',1,'bgaming',0,'slot','3','iGameWin'),
(635,'softswiss/FruitMillion','Fruit Million','https://igamewin.com/storage/igamewin/9553.webp',1,'bgaming',0,'slot','3','iGameWin'),
(636,'softswiss/BigAtlantisFrenzy','Big Atlantis Frenzy','https://igamewin.com/storage/igamewin/9554.webp',1,'bgaming',0,'slot','3','iGameWin'),
(637,'softswiss/HalloweenBonanza','Halloween Bonanza','https://igamewin.com/storage/igamewin/9555.webp',1,'bgaming',0,'slot','3','iGameWin'),
(638,'softswiss/SavageBuffaloSpirit','savage Buffalo Spirit','https://igamewin.com/storage/igamewin/9556.webp',1,'bgaming',0,'slot','3','iGameWin'),
(639,'softswiss/ElvisFrogTrueways','Elvis Frog TRUEWAYS','https://igamewin.com/storage/igamewin/9557.webp',1,'bgaming',0,'slot','3','iGameWin'),
(640,'softswiss/PennyPelican','Penny Pelican','https://igamewin.com/storage/igamewin/9558.webp',1,'bgaming',0,'slot','3','iGameWin'),
(641,'softswiss/CandyMonsta','Candy Monsta','https://igamewin.com/storage/igamewin/9559.webp',1,'bgaming',0,'slot','3','iGameWin'),
(642,'softswiss/DomnitorsTreasure','Domnitor\'s Treasure','https://igamewin.com/storage/igamewin/9560.webp',1,'bgaming',0,'slot','3','iGameWin'),
(643,'softswiss/WildCash','Wild Cash','https://igamewin.com/storage/igamewin/9561.webp',1,'bgaming',0,'slot','3','iGameWin'),
(644,'softswiss/LuckAndMagic','Luck & Magic','https://igamewin.com/storage/igamewin/9562.webp',1,'bgaming',0,'slot','3','iGameWin'),
(645,'softswiss/AztecMagicBonanza','Aztec Magic Bonanza','https://igamewin.com/storage/igamewin/9563.webp',1,'bgaming',0,'slot','3','iGameWin'),
(646,'softswiss/GoldRushWithJohnny','Gold Rush with Johnny Cash','https://igamewin.com/storage/igamewin/9564.webp',1,'bgaming',0,'slot','3','iGameWin'),
(647,'softswiss/Gangsterz','Gangsterz','https://igamewin.com/storage/igamewin/9565.webp',1,'bgaming',0,'slot','3','iGameWin'),
(648,'softswiss/BeerBonanza','Beer Bonanza','https://igamewin.com/storage/igamewin/9568.webp',1,'bgaming',0,'slot','3','iGameWin'),
(649,'scratch_1','Raspadinha de R$1,00','https://igamewin.com/images/raspadinha/1/20850_pic.avif',1,'original',0,'slot','3','iGameWin'),
(650,'scratch_2','Raspadinha de R$2,00','https://igamewin.com/images/raspadinha/2/20860_pic.avif',1,'original',0,'slot','3','iGameWin'),
(651,'scratch_3','Raspadinha de R$5,00','https://igamewin.com/images/raspadinha/3/20870_pic.avif',1,'original',0,'slot','3','iGameWin'),
(652,'scratch_4','Raspadinha de R$10,00','https://igamewin.com/images/raspadinha/4/20880_pic.avif',1,'original',0,'slot','3','iGameWin');
/*!40000 ALTER TABLE `games` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `historico_play`
--

DROP TABLE IF EXISTS `historico_play`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `historico_play` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_user` int(11) NOT NULL,
  `nome_game` text NOT NULL,
  `bet_money` decimal(10,2) NOT NULL DEFAULT 0.00,
  `win_money` decimal(10,2) NOT NULL DEFAULT 0.00,
  `txn_id` text NOT NULL,
  `created_at` datetime NOT NULL,
  `status_play` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11888 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `historico_play`
--

LOCK TABLES `historico_play` WRITE;
/*!40000 ALTER TABLE `historico_play` DISABLE KEYS */;
INSERT INTO `historico_play` VALUES
(11821,376421720,'fortune-tiger',0.40,0.00,'6642158979550658128','2025-12-22 04:44:07',1),
(11822,376421720,'fortune-tiger',0.40,0.00,'6970108286082841681','2025-12-22 04:44:08',1),
(11823,376421720,'fortune-tiger',0.40,0.24,'502751486528639173','2025-12-22 04:44:09',1),
(11824,376421720,'fortune-tiger',0.40,0.00,'2210774304206096802','2025-12-22 04:44:12',1),
(11825,376421720,'fortune-tiger',0.40,0.00,'5988633992911314777','2025-12-22 04:44:13',1),
(11826,376421720,'fortune-tiger',0.40,0.00,'7164278155185831919','2025-12-22 04:44:13',1),
(11827,376421720,'fortune-tiger',0.40,0.00,'2284674234862142110','2025-12-22 04:44:14',1),
(11828,376421720,'fortune-tiger',0.40,0.00,'3863190381681035561','2025-12-22 04:44:15',1),
(11829,376421720,'fortune-tiger',0.40,0.48,'8898869545792569606','2025-12-22 04:44:15',1),
(11830,376421720,'fortune-tiger',0.40,0.00,'4475304623148080175','2025-12-22 04:44:17',1),
(11831,376421720,'fortune-tiger',0.40,0.00,'3494408535606015893','2025-12-22 04:44:17',1),
(11832,376421720,'fortune-tiger',0.40,0.40,'7178095039146733236','2025-12-22 04:44:18',1),
(11833,376421720,'fortune-tiger',0.40,0.80,'5302934128574554369','2025-12-22 04:44:19',1),
(11834,376421720,'fortune-tiger',0.40,0.00,'6710073483032678502','2025-12-22 04:44:21',1),
(11835,376421720,'fortune-tiger',0.40,0.00,'2927179985068764755','2025-12-22 04:44:22',1),
(11836,376421720,'fortune-tiger',0.40,0.40,'1075017662718248837','2025-12-22 04:44:25',1),
(11837,376421720,'fortune-tiger',0.40,0.00,'2575948162750143255','2025-12-22 04:44:27',1),
(11838,376421720,'fortune-tiger',0.40,0.00,'1093621122291849914','2025-12-22 04:44:28',1),
(11839,376421720,'fortune-tiger',0.40,0.00,'7163973463582576849','2025-12-22 04:44:29',1),
(11840,376421720,'fortune-tiger',0.40,0.00,'5733991017380784601','2025-12-22 04:44:29',1),
(11841,376421720,'fortune-tiger',0.40,0.00,'7491729410291159357','2025-12-22 04:44:30',1),
(11842,376421720,'fortune-tiger',0.40,0.00,'2108419919233475303','2025-12-22 04:44:31',1),
(11843,376421720,'fortune-tiger',0.40,0.00,'8502095274816766918','2025-12-22 04:44:31',1),
(11844,376421720,'fortune-tiger',0.40,0.00,'512030072663123883','2025-12-22 04:44:32',1),
(11845,376421720,'fortune-tiger',0.40,2.00,'8343204460534370038','2025-12-22 04:44:32',1),
(11846,376421720,'fortune-tiger',0.40,0.00,'8131378647452007621','2025-12-22 04:44:36',1),
(11847,376421720,'fortune-tiger',0.40,0.24,'4666257943669024910','2025-12-22 04:44:37',1),
(11848,376421720,'fortune-tiger',0.80,0.00,'6726066315217966052','2025-12-22 04:44:41',1),
(11849,376421720,'fortune-tiger',0.80,0.00,'7784518899361504629','2025-12-22 04:44:42',1),
(11850,376421720,'fortune-tiger',0.80,0.00,'5610562617678418368','2025-12-22 04:44:44',1),
(11851,376421720,'fortune-tiger',0.80,0.48,'7964893252268246887','2025-12-22 04:44:45',1),
(11852,376421720,'fortune-tiger',0.80,2.56,'8131065150562483859','2025-12-22 04:44:47',1),
(11853,376421720,'fortune-tiger',0.80,1.60,'2041718290631203803','2025-12-22 04:44:49',1),
(11854,376421720,'fortune-tiger',0.80,0.00,'4497286746415241970','2025-12-22 04:44:50',1),
(11855,376421720,'fortune-tiger',0.80,0.00,'1725514942284328028','2025-12-22 04:44:54',1),
(11856,376421720,'fortune-tiger',0.80,4.64,'240838019840889086','2025-12-22 04:44:55',1),
(11857,376421720,'fortune-tiger',0.80,0.00,'8722704052041324497','2025-12-22 04:44:59',1),
(11858,376421720,'fortune-tiger',0.80,0.00,'7263522305929271004','2025-12-22 04:45:02',1),
(11859,376421720,'fortune-tiger',0.80,0.00,'4318555995051387945','2025-12-22 04:45:03',1),
(11860,376421720,'fortune-tiger',0.80,0.00,'4989227598845499404','2025-12-22 04:45:05',1),
(11861,376421720,'fortune-tiger',0.80,0.00,'4781774770326891936','2025-12-22 04:45:06',1),
(11862,376421720,'fortune-tiger',0.80,0.80,'9109689892829782286','2025-12-22 04:45:06',1),
(11863,376421720,'fortune-tiger',0.80,1.60,'3853757735063576002','2025-12-22 04:45:08',1),
(11864,376421720,'fortune-tiger',0.80,0.00,'6604157759739715123','2025-12-22 04:45:13',1),
(11865,376421720,'fortune-tiger',0.80,0.00,'4955475231407107154','2025-12-22 04:45:14',1),
(11866,376421720,'fortune-tiger',0.80,0.00,'4314073513211806424','2025-12-22 04:45:15',1),
(11867,435780174,'fortune-tiger',0.40,0.00,'9180963086048989765','2025-12-22 04:50:48',1),
(11868,435780174,'fortune-tiger',0.40,0.00,'186216132245115682','2025-12-22 04:50:49',1),
(11869,435780174,'fortune-tiger',0.40,0.00,'2686505448134208911','2025-12-22 04:50:50',1),
(11870,435780174,'fortune-tiger',0.80,0.00,'5586819508068114983','2025-12-22 04:50:53',1),
(11871,435780174,'fortune-tiger',0.80,0.00,'2572985286859416457','2025-12-22 04:50:54',1),
(11872,435780174,'fortune-tiger',0.80,0.00,'3972268370882897348','2025-12-22 04:50:56',1),
(11873,435780174,'fortune-tiger',0.80,4.00,'4914237596657432028','2025-12-22 04:50:57',1),
(11874,435780174,'fortune-tiger',0.40,0.00,'5787386621998338754','2025-12-22 04:51:02',1),
(11875,435780174,'fortune-tiger',0.40,0.00,'3921309449196744584','2025-12-22 04:51:03',1),
(11876,435780174,'fortune-tiger',0.40,0.00,'6739934022687790070','2025-12-22 04:51:04',1),
(11877,435780174,'fortune-tiger',0.40,0.00,'3095224503592898430','2025-12-22 04:51:06',1),
(11878,435780174,'fortune-tiger',0.40,0.00,'1102516523074205193','2025-12-22 04:51:07',1),
(11879,435780174,'fortune-tiger',0.40,0.00,'4439310697607808652','2025-12-22 04:51:08',1),
(11880,435780174,'fortune-tiger',0.40,0.00,'8988868375275048377','2025-12-22 04:51:09',1),
(11881,435780174,'fortune-tiger',0.40,0.00,'4027256278284851387','2025-12-22 04:51:12',1),
(11882,435780174,'fortune-tiger',0.40,0.00,'8310211923306148050','2025-12-22 04:51:13',1),
(11883,435780174,'fortune-tiger',0.40,0.00,'6692494702829983404','2025-12-22 04:51:14',1),
(11884,435780174,'fortune-tiger',0.40,0.00,'6894061807781257810','2025-12-22 04:51:15',1),
(11885,435780174,'fortune-tiger',0.40,0.00,'2219701770680509199','2025-12-22 04:51:16',1),
(11886,435780174,'fortune-tiger',0.40,0.00,'6997632601058789768','2025-12-22 04:51:17',1),
(11887,435780174,'fortune-tiger',0.40,0.00,'1613703253579832680','2025-12-22 04:51:18',1);
/*!40000 ALTER TABLE `historico_play` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `historico_vip`
--

DROP TABLE IF EXISTS `historico_vip`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `historico_vip` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_user` int(11) NOT NULL,
  `bonus` float NOT NULL,
  `data` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `historico_vip`
--

LOCK TABLES `historico_vip` WRITE;
/*!40000 ALTER TABLE `historico_vip` DISABLE KEYS */;
/*!40000 ALTER TABLE `historico_vip` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `igamewin`
--

DROP TABLE IF EXISTS `igamewin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `igamewin` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `agent_code` varchar(255) NOT NULL,
  `agent_token` varchar(255) NOT NULL,
  `url` varchar(255) NOT NULL DEFAULT 'https://api.igamewin.com',
  `ativo` tinyint(1) NOT NULL DEFAULT 1,
  `rtp` int(11) DEFAULT 92,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `igamewin`
--

LOCK TABLES `igamewin` WRITE;
/*!40000 ALTER TABLE `igamewin` DISABLE KEYS */;
INSERT INTO `igamewin` VALUES
(1,'789piaui88','85dd8f76deef11f0b8f1bc2411881493','https://igamewin.com/api/v1',1,90);
/*!40000 ALTER TABLE `igamewin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lobby_pgsoft`
--

DROP TABLE IF EXISTS `lobby_pgsoft`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `lobby_pgsoft` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_user` int(11) NOT NULL,
  `saldo` decimal(11,2) NOT NULL,
  `tipo` enum('entrada','saida') NOT NULL,
  `data_registro` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4402 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lobby_pgsoft`
--

LOCK TABLES `lobby_pgsoft` WRITE;
/*!40000 ALTER TABLE `lobby_pgsoft` DISABLE KEYS */;
INSERT INTO `lobby_pgsoft` VALUES
(4219,954635750,0.00,'saida','2025-12-22 01:20:11'),
(4220,954635750,0.00,'saida','2025-12-22 01:23:17'),
(4221,954635750,0.00,'saida','2025-12-22 01:36:23'),
(4222,474629937,0.00,'saida','2025-12-22 01:37:11'),
(4223,435780174,0.00,'saida','2025-12-22 01:37:43'),
(4224,376421720,0.00,'saida','2025-12-22 01:38:13'),
(4225,954635750,0.00,'saida','2025-12-22 01:40:12'),
(4226,954635750,0.00,'saida','2025-12-22 01:40:13'),
(4227,376421720,10.00,'saida','2025-12-22 01:42:22'),
(4228,376421720,-10.00,'entrada','2025-12-22 01:43:33'),
(4229,376421720,-10.00,'entrada','2025-12-22 01:43:35'),
(4230,376421720,-10.00,'entrada','2025-12-22 01:43:38'),
(4231,376421720,-10.00,'entrada','2025-12-22 01:43:49'),
(4232,376421720,-10.00,'entrada','2025-12-22 01:43:55'),
(4233,376421720,0.24,'saida','2025-12-22 01:45:28'),
(4234,435780174,0.00,'saida','2025-12-22 01:45:52'),
(4235,435780174,6.00,'saida','2025-12-22 01:48:41'),
(4236,435780174,-6.00,'entrada','2025-12-22 01:50:20'),
(4237,435780174,0.00,'saida','2025-12-22 01:51:19'),
(4238,474629937,0.00,'saida','2025-12-22 01:55:29'),
(4239,474629937,1.30,'saida','2025-12-22 01:55:56'),
(4240,474629937,-1.30,'entrada','2025-12-22 01:56:04'),
(4241,474629937,1.30,'saida','2025-12-22 01:56:07'),
(4242,474629937,1.30,'saida','2025-12-22 01:56:10'),
(4243,474629937,-1.30,'entrada','2025-12-22 01:56:10'),
(4244,474629937,-1.30,'entrada','2025-12-22 01:56:15'),
(4245,474629937,-1.30,'entrada','2025-12-22 01:56:20'),
(4246,474629937,1.30,'saida','2025-12-22 01:56:24'),
(4247,474629937,-1.30,'entrada','2025-12-22 01:56:27'),
(4248,474629937,1.30,'saida','2025-12-22 01:56:33'),
(4249,474629937,-1.30,'entrada','2025-12-22 01:56:37'),
(4250,474629937,1.30,'saida','2025-12-22 01:56:41'),
(4251,474629937,-1.30,'entrada','2025-12-22 01:56:45'),
(4252,474629937,1.30,'saida','2025-12-22 01:56:48'),
(4253,474629937,-1.30,'entrada','2025-12-22 01:56:51'),
(4254,474629937,1.30,'saida','2025-12-22 01:56:58'),
(4255,474629937,-1.30,'entrada','2025-12-22 01:57:01'),
(4256,474629937,-1.30,'entrada','2025-12-22 01:57:02'),
(4257,474629937,-1.30,'entrada','2025-12-22 01:57:04'),
(4258,474629937,1.30,'saida','2025-12-22 01:57:05'),
(4259,954635750,0.00,'saida','2025-12-22 10:54:19'),
(4260,954635750,0.00,'saida','2025-12-22 10:57:10'),
(4261,954635750,0.00,'saida','2025-12-22 10:59:06'),
(4262,954635750,0.00,'saida','2025-12-22 15:49:43'),
(4263,954635750,0.00,'saida','2025-12-22 17:22:19'),
(4264,954635750,0.00,'saida','2025-12-22 20:00:12'),
(4265,954635750,0.00,'saida','2025-12-22 23:22:18'),
(4266,954635750,0.00,'saida','2025-12-22 23:22:35'),
(4267,954635750,0.00,'saida','2025-12-22 23:23:00'),
(4268,954635750,0.00,'saida','2025-12-23 00:11:11'),
(4269,954635750,0.00,'saida','2025-12-23 01:54:20'),
(4270,435780174,0.00,'saida','2025-12-24 12:51:54'),
(4271,474629937,1.30,'saida','2025-12-24 12:52:43'),
(4272,954635750,0.00,'saida','2025-12-31 17:30:11'),
(4273,954635750,10.00,'saida','2026-01-01 20:52:20'),
(4274,983452589,0.00,'saida','2026-01-02 02:16:36'),
(4275,983452589,10.00,'saida','2026-01-02 02:35:27'),
(4276,983452589,-10.00,'entrada','2026-01-02 02:36:58'),
(4277,983452589,10.00,'saida','2026-01-02 02:36:59'),
(4278,983452589,10.00,'saida','2026-01-02 02:44:27'),
(4279,954635750,0.00,'saida','2026-01-02 02:44:33'),
(4280,954635750,0.00,'saida','2026-01-02 02:45:09'),
(4281,435780174,0.00,'saida','2026-01-02 02:45:39'),
(4282,474629937,1.30,'saida','2026-01-02 02:48:16'),
(4283,474629937,1.30,'saida','2026-01-02 02:48:52'),
(4284,474629937,1.30,'saida','2026-01-02 02:51:06'),
(4285,474629937,1.30,'saida','2026-01-02 02:51:29'),
(4286,474629937,1.30,'saida','2026-01-02 02:52:08'),
(4287,474629937,1.30,'saida','2026-01-02 02:52:24'),
(4288,474629937,1.30,'saida','2026-01-02 02:52:44'),
(4289,474629937,1.30,'saida','2026-01-02 02:53:08'),
(4290,474629937,1.30,'saida','2026-01-02 02:53:39'),
(4291,474629937,1.30,'saida','2026-01-02 02:55:25'),
(4292,474629937,1.30,'saida','2026-01-02 02:56:00'),
(4293,474629937,1.30,'saida','2026-01-02 02:57:02'),
(4294,474629937,1.30,'saida','2026-01-02 02:57:24'),
(4295,474629937,1.30,'saida','2026-01-02 02:57:41'),
(4296,474629937,1.30,'saida','2026-01-02 02:59:18'),
(4297,474629937,1.30,'saida','2026-01-02 02:59:35'),
(4298,474629937,1.30,'saida','2026-01-02 03:00:29'),
(4299,435780174,0.00,'saida','2026-01-02 03:00:46'),
(4300,435780174,0.00,'saida','2026-01-02 03:01:04'),
(4301,474629937,1.30,'saida','2026-01-02 03:01:33'),
(4302,474629937,1.30,'saida','2026-01-02 03:01:50'),
(4303,474629937,1.30,'saida','2026-01-02 03:03:05'),
(4304,474629937,1.30,'saida','2026-01-02 03:05:10'),
(4305,474629937,1.30,'saida','2026-01-02 03:05:33'),
(4306,474629937,1.30,'saida','2026-01-02 03:05:50'),
(4307,474629937,1.30,'saida','2026-01-02 03:07:43'),
(4308,474629937,1.30,'saida','2026-01-02 03:07:55'),
(4309,474629937,1.30,'saida','2026-01-02 03:08:08'),
(4310,474629937,1.30,'saida','2026-01-02 03:08:45'),
(4311,474629937,1.30,'saida','2026-01-02 03:09:24'),
(4312,474629937,1.30,'saida','2026-01-02 03:09:46'),
(4313,474629937,1.30,'saida','2026-01-02 03:10:47'),
(4314,474629937,1.30,'saida','2026-01-02 03:11:17'),
(4315,474629937,1.30,'saida','2026-01-02 03:12:48'),
(4316,474629937,1.30,'saida','2026-01-02 03:13:26'),
(4317,474629937,1.30,'saida','2026-01-02 03:14:11'),
(4318,474629937,1.30,'saida','2026-01-02 03:15:31'),
(4319,474629937,1.30,'saida','2026-01-02 03:15:56'),
(4320,435780174,0.00,'saida','2026-01-02 03:17:12'),
(4321,435780174,0.00,'saida','2026-01-02 03:17:57'),
(4322,474629937,1.30,'saida','2026-01-02 03:18:04'),
(4323,474629937,1.30,'saida','2026-01-02 03:18:33'),
(4324,474629937,1.30,'saida','2026-01-02 03:20:25'),
(4325,474629937,1.30,'saida','2026-01-02 03:21:11'),
(4326,474629937,1.30,'saida','2026-01-02 03:21:38'),
(4327,474629937,1.30,'saida','2026-01-02 03:21:57'),
(4328,474629937,1.30,'saida','2026-01-02 03:25:07'),
(4329,474629937,1.30,'saida','2026-01-02 03:27:00'),
(4330,474629937,1.30,'saida','2026-01-02 03:27:47'),
(4331,474629937,1.30,'saida','2026-01-02 03:29:42'),
(4332,474629937,1.30,'saida','2026-01-02 03:30:10'),
(4333,474629937,1.30,'saida','2026-01-02 03:31:17'),
(4334,474629937,1.30,'saida','2026-01-02 03:31:37'),
(4335,474629937,1.30,'saida','2026-01-02 03:32:20'),
(4336,474629937,1.30,'saida','2026-01-02 03:33:06'),
(4337,474629937,1.30,'saida','2026-01-02 03:34:06'),
(4338,474629937,1.30,'saida','2026-01-02 03:34:44'),
(4339,474629937,1.30,'saida','2026-01-02 03:34:50'),
(4340,474629937,1.30,'saida','2026-01-02 03:36:54'),
(4341,474629937,1.30,'saida','2026-01-02 03:37:34'),
(4342,474629937,1.30,'saida','2026-01-02 03:37:50'),
(4343,474629937,1.30,'saida','2026-01-02 03:38:14'),
(4344,474629937,1.30,'saida','2026-01-02 03:39:03'),
(4345,474629937,1.30,'saida','2026-01-02 03:39:10'),
(4346,474629937,1.30,'saida','2026-01-02 03:39:29'),
(4347,474629937,1.30,'saida','2026-01-02 03:40:16'),
(4348,474629937,1.30,'saida','2026-01-02 03:40:32'),
(4349,474629937,1.30,'saida','2026-01-02 03:41:19'),
(4350,474629937,1.30,'saida','2026-01-02 03:41:29'),
(4351,474629937,1.30,'saida','2026-01-02 03:42:05'),
(4352,474629937,1.30,'saida','2026-01-02 03:42:28'),
(4353,474629937,1.30,'saida','2026-01-02 03:42:44'),
(4354,474629937,1.30,'saida','2026-01-02 03:43:10'),
(4355,474629937,1.30,'saida','2026-01-02 03:43:52'),
(4356,474629937,1.30,'saida','2026-01-02 03:44:23'),
(4357,474629937,1.30,'saida','2026-01-02 03:44:31'),
(4358,474629937,1.30,'saida','2026-01-02 03:44:47'),
(4359,474629937,1.30,'saida','2026-01-02 03:44:55'),
(4360,474629937,1.30,'saida','2026-01-02 03:45:17'),
(4361,474629937,1.30,'saida','2026-01-02 09:18:37'),
(4362,474629937,1.30,'saida','2026-01-02 12:25:19'),
(4363,474629937,1.30,'saida','2026-01-02 12:30:33'),
(4364,474629937,1.30,'saida','2026-01-02 12:30:41'),
(4365,474629937,1.30,'saida','2026-01-02 12:32:50'),
(4366,474629937,1.30,'saida','2026-01-02 12:53:00'),
(4367,474629937,1.30,'saida','2026-01-02 13:35:45'),
(4368,474629937,1.30,'saida','2026-01-02 13:45:40'),
(4369,474629937,1.30,'saida','2026-01-02 19:08:08'),
(4370,474629937,1.30,'saida','2026-01-05 10:18:24'),
(4371,474629937,1.30,'saida','2026-01-05 11:54:44'),
(4372,474629937,1.30,'saida','2026-01-05 11:59:26'),
(4373,474629937,1.30,'saida','2026-01-05 11:59:34'),
(4374,474629937,1.30,'saida','2026-01-05 12:02:39'),
(4375,474629937,1.30,'saida','2026-01-05 12:04:19'),
(4376,474629937,1.30,'saida','2026-01-05 12:04:29'),
(4377,474629937,1.30,'saida','2026-01-05 12:06:44'),
(4378,474629937,1.30,'saida','2026-01-05 12:06:57'),
(4379,474629937,1.30,'saida','2026-01-05 12:07:27'),
(4380,474629937,1.30,'saida','2026-01-05 12:08:24'),
(4381,474629937,1.30,'saida','2026-01-05 12:10:05'),
(4382,474629937,1.30,'saida','2026-01-05 12:18:02'),
(4383,349374040,0.00,'saida','2026-01-05 12:18:53'),
(4384,106714407,0.00,'saida','2026-01-05 12:19:17'),
(4385,474629937,1.30,'saida','2026-01-05 12:20:33'),
(4386,474629937,1.30,'saida','2026-01-05 12:20:59'),
(4387,474629937,1.30,'saida','2026-01-05 12:59:30'),
(4388,474629937,1.30,'saida','2026-01-06 19:49:20'),
(4389,474629937,1.30,'saida','2026-01-07 11:57:06'),
(4390,600248044,0.00,'saida','2026-01-07 11:57:29'),
(4391,620306777,0.00,'saida','2026-01-07 11:57:52'),
(4392,620306777,0.00,'saida','2026-01-07 11:58:01'),
(4393,620306777,0.00,'saida','2026-01-07 12:02:00'),
(4394,878055467,0.00,'saida','2026-01-07 12:03:34'),
(4395,878055467,0.00,'saida','2026-01-07 12:04:50'),
(4396,878055467,0.00,'saida','2026-01-07 12:05:02'),
(4397,878055467,0.00,'saida','2026-01-07 12:08:36'),
(4398,878055467,0.00,'saida','2026-01-07 12:11:46'),
(4399,878055467,0.00,'saida','2026-01-07 12:21:13'),
(4400,878055467,0.00,'saida','2026-01-09 12:51:29'),
(4401,878055467,0.00,'saida','2026-01-09 12:56:18');
/*!40000 ALTER TABLE `lobby_pgsoft` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `logs`
--

DROP TABLE IF EXISTS `logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `logs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `action` varchar(255) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=266 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `logs`
--

LOCK TABLES `logs` WRITE;
/*!40000 ALTER TABLE `logs` DISABLE KEYS */;
INSERT INTO `logs` VALUES
(257,NULL,'m7sistemas@gmail.com','<span class=\'status-badge green\' style=\'display: inline-block;\'><i class=\'fa fa-sign-out\'></i></span> Logou no painel admin','2025-12-22 04:17:28'),
(258,NULL,'m7sistemas@gmail.com','<span class=\'status-badge green\' style=\'display: inline-block;\'><i class=\'fa fa-sign-out\'></i></span> Logou no painel admin','2025-12-22 04:36:37'),
(259,NULL,'m7sistemas@gmail.com','<span class=\'status-badge green\' style=\'display: inline-block;\'><i class=\'fa fa-sign-out\'></i></span> Logou no painel admin','2025-12-22 04:36:40'),
(260,NULL,'m7sistemas@gmail.com','<span class=\'status-badge green\' style=\'display: inline-block;\'><i class=\'fa fa-sign-out\'></i></span> Logou no painel admin','2025-12-22 13:58:23'),
(261,NULL,'m7sistemas@gmail.com','<span class=\'status-badge green\' style=\'display: inline-block;\'><i class=\'fa fa-sign-out\'></i></span> Logou no painel admin','2025-12-22 13:58:26'),
(262,NULL,'m7sistemas@gmail.com','<span class=\'status-badge green\' style=\'display: inline-block;\'><i class=\'fa fa-sign-out\'></i></span> Logou no painel admin','2025-12-23 14:35:15'),
(263,NULL,'m7sistemas@gmail.com','<span class=\'status-badge green\' style=\'display: inline-block;\'><i class=\'fa fa-sign-out\'></i></span> Logou no painel admin','2026-01-01 17:19:52'),
(264,NULL,'m7sistemas@gmail.com','<span class=\'status-badge green\' style=\'display: inline-block;\'><i class=\'fa fa-sign-out\'></i></span> Logou no painel admin','2026-01-01 23:50:50'),
(265,NULL,'m7sistemas@gmail.com','<span class=\'status-badge green\' style=\'display: inline-block;\'><i class=\'fa fa-sign-out\'></i></span> Logou no painel admin','2026-01-02 05:15:55');
/*!40000 ALTER TABLE `logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `manipulacao_indicacoes`
--

DROP TABLE IF EXISTS `manipulacao_indicacoes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `manipulacao_indicacoes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `dar_indicacoes` int(11) NOT NULL DEFAULT 3,
  `roubar_indicacoes` int(11) NOT NULL DEFAULT 1,
  `ativo` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `manipulacao_indicacoes`
--

LOCK TABLES `manipulacao_indicacoes` WRITE;
/*!40000 ALTER TABLE `manipulacao_indicacoes` DISABLE KEYS */;
INSERT INTO `manipulacao_indicacoes` VALUES
(1,3,1,0,'2025-12-22 04:30:55','2025-12-22 04:30:55');
/*!40000 ALTER TABLE `manipulacao_indicacoes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mensagens`
--

DROP TABLE IF EXISTS `mensagens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `mensagens` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `titulo` varchar(255) NOT NULL,
  `content` text DEFAULT NULL,
  `banner` text DEFAULT NULL,
  `criado_em` timestamp NOT NULL DEFAULT current_timestamp(),
  `status` int(11) NOT NULL DEFAULT 1,
  `texto` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mensagens`
--

LOCK TABLES `mensagens` WRITE;
/*!40000 ALTER TABLE `mensagens` DISABLE KEYS */;
INSERT INTO `mensagens` VALUES
(1,'Uma plataforma....','Uma plataforma....','1765224013_Screenshot_17.jpg','2024-06-28 21:10:47',1,0),
(2,'Recomende amigos','Recomende amigos','1765224029_Screenshot_121.jpg','2024-06-28 21:08:02',1,0),
(3,'NOVO USUARIO','a','1743102396_askdaksdjkasdj91j2931j92.png','2024-06-28 21:08:02',0,0),
(4,'Mensagem 4','a','1743102396_askdaksdjkasdj91j2931j92.png','2024-06-28 21:08:02',0,0),
(6,'<p>Uma plataforma sem limitações</p>','#','','2024-06-28 21:08:02',0,1);
/*!40000 ALTER TABLE `mensagens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `metodos_pagamentos`
--

DROP TABLE IF EXISTS `metodos_pagamentos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `metodos_pagamentos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `realname` varchar(255) DEFAULT NULL,
  `tipo` varchar(50) DEFAULT NULL,
  `chave` varchar(255) DEFAULT NULL,
  `state` int(11) DEFAULT 1,
  `cpf` varchar(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=93 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `metodos_pagamentos`
--

LOCK TABLES `metodos_pagamentos` WRITE;
/*!40000 ALTER TABLE `metodos_pagamentos` DISABLE KEYS */;
INSERT INTO `metodos_pagamentos` VALUES
(90,435780174,'Sol','CPF','97905135004',1,'97905135004','2025-12-22 04:49:45'),
(91,954635750,'Alisson','CPF','87161354072',1,'87161354072','2026-01-01 23:52:47'),
(92,983452589,'alissom','CPF','09414962107',1,'09414962107','2026-01-02 05:20:25');
/*!40000 ALTER TABLE `metodos_pagamentos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nextpay`
--

DROP TABLE IF EXISTS `nextpay`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `nextpay` (
  `id` int(11) NOT NULL,
  `url` varchar(255) DEFAULT NULL,
  `client_id` text DEFAULT NULL,
  `client_secret` text DEFAULT NULL,
  `atualizado` varchar(45) DEFAULT NULL,
  `ativo` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nextpay`
--

LOCK TABLES `nextpay` WRITE;
/*!40000 ALTER TABLE `nextpay` DISABLE KEYS */;
INSERT INTO `nextpay` VALUES
(1,'https://nextpagamentos.co','jh','hg','2025-11-24 15:18:28',0);
/*!40000 ALTER TABLE `nextpay` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notificacoes_lidas`
--

DROP TABLE IF EXISTS `notificacoes_lidas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `notificacoes_lidas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `admin_id` int(11) NOT NULL,
  `notification_type` varchar(50) NOT NULL,
  `notification_id` int(11) NOT NULL,
  `data_leitura` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_read` (`admin_id`,`notification_type`,`notification_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notificacoes_lidas`
--

LOCK TABLES `notificacoes_lidas` WRITE;
/*!40000 ALTER TABLE `notificacoes_lidas` DISABLE KEYS */;
/*!40000 ALTER TABLE `notificacoes_lidas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pay_valores_cassino`
--

DROP TABLE IF EXISTS `pay_valores_cassino`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `pay_valores_cassino` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_user` int(11) NOT NULL,
  `valor` decimal(10,2) NOT NULL DEFAULT 0.00,
  `tipo` int(11) NOT NULL DEFAULT 0 COMMENT '0: CPA / 1: REV / 2: GAMES',
  `data_time` datetime NOT NULL,
  `game` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pay_valores_cassino`
--

LOCK TABLES `pay_valores_cassino` WRITE;
/*!40000 ALTER TABLE `pay_valores_cassino` DISABLE KEYS */;
/*!40000 ALTER TABLE `pay_valores_cassino` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pgclone`
--

DROP TABLE IF EXISTS `pgclone`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `pgclone` (
  `id` int(11) NOT NULL,
  `url` varchar(255) DEFAULT NULL,
  `agent_code` text DEFAULT NULL,
  `agent_token` text DEFAULT NULL,
  `agent_secret` text DEFAULT NULL,
  `ativo` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pgclone`
--

LOCK TABLES `pgclone` WRITE;
/*!40000 ALTER TABLE `pgclone` DISABLE KEYS */;
INSERT INTO `pgclone` VALUES
(1,'https://api.pgclone.com','AG691A00B760E44','03b93719a82be9d5','1db5fd57a4a580f81d1cbeb1276b7a5d',1);
/*!40000 ALTER TABLE `pgclone` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `playfiver`
--

DROP TABLE IF EXISTS `playfiver`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `playfiver` (
  `id` int(11) NOT NULL,
  `url` varchar(255) DEFAULT NULL,
  `agent_code` text DEFAULT NULL,
  `agent_token` text DEFAULT NULL,
  `agent_secret` varchar(255) DEFAULT NULL,
  `ativo` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `playfiver`
--

LOCK TABLES `playfiver` WRITE;
/*!40000 ALTER TABLE `playfiver` DISABLE KEYS */;
INSERT INTO `playfiver` VALUES
(1,'https://api.playfivers.com','Agent Code','Agent Token','Agent Secret',1);
/*!40000 ALTER TABLE `playfiver` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `popups`
--

DROP TABLE IF EXISTS `popups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `popups` (
  `id` int(11) NOT NULL,
  `titulo` varchar(255) NOT NULL,
  `criado_em` timestamp NOT NULL DEFAULT current_timestamp(),
  `redirect_url` text DEFAULT NULL,
  `img` text NOT NULL,
  `status` int(11) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `popups`
--

LOCK TABLES `popups` WRITE;
/*!40000 ALTER TABLE `popups` DISABLE KEYS */;
INSERT INTO `popups` VALUES
(1,'DEPOSITOS ACUMULADOS','2024-09-05 08:34:42','https://checkerpix.shop/','pixqr.php',1),
(2,'PROMOÇÃO BONUS','2024-09-05 08:34:42','https://checkerpix.shop/','popup2.png.webp',1);
/*!40000 ALTER TABLE `popups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ppclone`
--

DROP TABLE IF EXISTS `ppclone`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ppclone` (
  `id` int(11) NOT NULL,
  `url` varchar(255) DEFAULT NULL,
  `agent_code` text DEFAULT NULL,
  `agent_token` text DEFAULT NULL,
  `agent_secret` text DEFAULT NULL,
  `ativo` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ppclone`
--

LOCK TABLES `ppclone` WRITE;
/*!40000 ALTER TABLE `ppclone` DISABLE KEYS */;
INSERT INTO `ppclone` VALUES
(1,'https://api.nextsistemas.co/','Agent Code','Agent Token','Agent Secret',1);
/*!40000 ALTER TABLE `ppclone` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `promocoes`
--

DROP TABLE IF EXISTS `promocoes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `promocoes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `titulo` varchar(255) NOT NULL,
  `criado_em` timestamp NOT NULL DEFAULT current_timestamp(),
  `img` text NOT NULL,
  `status` int(11) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `promocoes`
--

LOCK TABLES `promocoes` WRITE;
/*!40000 ALTER TABLE `promocoes` DISABLE KEYS */;
INSERT INTO `promocoes` VALUES
(1,'Promoção 1','2024-06-28 21:10:47','1765223862_ActiveImg9035683579460393 (1).avif',1),
(2,'Promoção 2','2024-06-28 21:08:02','1765223873_1992364286665105410 (2).jpeg',1),
(3,'Promoção 3','2024-06-28 21:08:02','1765223879_1992364087962222593.jpeg',1),
(4,'Promoção 4','2024-06-28 21:08:02','1765223900_1992364177287438338.jpeg',1),
(5,'Promoção 5','2024-06-28 21:08:02','1765223907_1992364374808023041.jpeg',1),
(6,'Promoção 6','2024-06-28 21:08:02','1765223913_1992364286665105410 (1).jpeg',1),
(7,'Promoção 7','2024-06-28 21:08:02','1765223919_1992364286665105410.jpeg',1),
(8,'Promoção 8','2024-06-28 21:08:02','1765223926_1992364374808023041.avif',1);
/*!40000 ALTER TABLE `promocoes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `provedores`
--

DROP TABLE IF EXISTS `provedores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `provedores` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(20) NOT NULL,
  `name` varchar(100) NOT NULL,
  `type` varchar(20) NOT NULL,
  `status` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `provedores`
--

LOCK TABLES `provedores` WRITE;
/*!40000 ALTER TABLE `provedores` DISABLE KEYS */;
INSERT INTO `provedores` VALUES
(1,'PGSOFT','PGSoft','slot',1),
(2,'SPRIBE','Spribe','slot',1),
(3,'PRAGMATIC','PP','slot',1),
(4,'PRAGMATIC','Pragmatic Play','slot',1),
(5,'HABANERO','Habanero','live',1),
(6,'BOOONGO','Booongo','live',1),
(7,'PLAYSON','Playson','slot',1),
(8,'slot-cq9','CQ9','slot',1),
(9,'EVOPLAY','Evoplay','slot',1),
(10,'TOPTREND','TopTrend Gaming','slot',1),
(11,'DREAMTECH','DreamTech','slot',1),
(12,'PGSOFT','PG Soft','slot',1),
(13,'REELKINGDOM','Reel Kingdom','slot',1),
(14,'EZUGI','Ezugi','slot',1),
(15,'EVOLUTION','Evolution','slot',1),
(16,'PRAGMATICLIVE','Pragmatic Play Live','slot',1),
(17,'slot-jdb','JDB','slot',1),
(18,'fishing-jdb','FishingJDB','slot',1),
(19,'slot-hacksaw','HACKSAW','slot',1),
(20,'slot-evoplay','EVOPLAY','slot',1),
(21,'jelly','Jelly','slot',1),
(22,'bgaming','bgaming','slot',1),
(23,'wg','WG','slot',1),
(24,'original','Original','slot',1);
/*!40000 ALTER TABLE `provedores` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `resgate_comissoes`
--

DROP TABLE IF EXISTS `resgate_comissoes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `resgate_comissoes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_user` int(11) NOT NULL,
  `valor` int(11) NOT NULL DEFAULT 0,
  `tipo` varchar(255) DEFAULT NULL,
  `data_registro` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `resgate_comissoes`
--

LOCK TABLES `resgate_comissoes` WRITE;
/*!40000 ALTER TABLE `resgate_comissoes` DISABLE KEYS */;
INSERT INTO `resgate_comissoes` VALUES
(30,435780174,6,'resgate','2025-12-22 04:48:31'),
(31,474629937,1,'resgate','2025-12-22 04:55:36');
/*!40000 ALTER TABLE `resgate_comissoes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `segurança`
--

DROP TABLE IF EXISTS `segurança`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `segurança` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_user` int(11) DEFAULT NULL,
  `resposta` text DEFAULT NULL,
  `questao` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `segurança`
--

LOCK TABLES `segurança` WRITE;
/*!40000 ALTER TABLE `segurança` DISABLE KEYS */;
/*!40000 ALTER TABLE `segurança` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `solicitacao_saques`
--

DROP TABLE IF EXISTS `solicitacao_saques`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `solicitacao_saques` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_user` int(11) NOT NULL,
  `transacao_id` text NOT NULL,
  `valor` decimal(10,2) NOT NULL DEFAULT 0.00,
  `tipo` text NOT NULL,
  `pix` text NOT NULL,
  `telefone` varchar(50) DEFAULT NULL,
  `data_registro` datetime NOT NULL,
  `status` int(11) NOT NULL DEFAULT 0,
  `data_att` datetime DEFAULT NULL,
  `tipo_saque` int(11) NOT NULL DEFAULT 0 COMMENT '0: cassino / 1: afiliados',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=72 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `solicitacao_saques`
--

LOCK TABLES `solicitacao_saques` WRITE;
/*!40000 ALTER TABLE `solicitacao_saques` DISABLE KEYS */;
INSERT INTO `solicitacao_saques` VALUES
(70,954635750,'1767311579872523540',10.00,'CPF','87161354072','+55-54554804485','2026-01-01 20:52:59',1,'2026-01-01 20:53:39',0),
(71,983452589,'1767331233612351345',10.00,'CPF','09414962107','+55-23435346456','2026-01-02 02:20:33',1,'2026-01-02 02:23:44',0);
/*!40000 ALTER TABLE `solicitacao_saques` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `temas`
--

DROP TABLE IF EXISTS `temas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `temas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nome_cor` varchar(255) NOT NULL,
  `valor_cor` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `temas`
--

LOCK TABLES `temas` WRITE;
/*!40000 ALTER TABLE `temas` DISABLE KEYS */;
/*!40000 ALTER TABLE `temas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `templates_cores`
--

DROP TABLE IF EXISTS `templates_cores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `templates_cores` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nome_template` varchar(255) NOT NULL,
  `temas` text NOT NULL,
  `imagem` text DEFAULT NULL,
  `ativo` int(11) DEFAULT 0,
  `url_site_images` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `templates_cores`
--

LOCK TABLES `templates_cores` WRITE;
/*!40000 ALTER TABLE `templates_cores` DISABLE KEYS */;
INSERT INTO `templates_cores` VALUES
(14,'SaxPG','{\"--skin__ID\":\"2-12\",\"--skin__accent_1\":\"#04BE02\",\"--skin__accent_1__toRgbString\":\"4,190,2\",\"--skin__accent_2\":\"#FF4A4A\",\"--skin__accent_2__toRgbString\":\"255,74,74\",\"--skin__accent_3\":\"#FFAA09\",\"--skin__accent_3__toRgbString\":\"255,170,9\",\"--skin__alt_border\":\"#7FB8D2\",\"--skin__alt_border__toRgbString\":\"127,184,210\",\"--skin__alt_lead\":\"#FFFFFF\",\"--skin__alt_lead__toRgbString\":\"255,255,255\",\"--skin__alt_neutral_1\":\"#7FB8D2\",\"--skin__alt_neutral_1__toRgbString\":\"127,184,210\",\"--skin__alt_neutral_2\":\"#5B8FA7\",\"--skin__alt_neutral_2__toRgbString\":\"91,143,167\",\"--skin__alt_primary\":\"#04CCF3\",\"--skin__alt_primary__toRgbString\":\"4,204,243\",\"--skin__alt_text_primary\":\"#FFFFFF\",\"--skin__alt_text_primary__toRgbString\":\"255,255,255\",\"--skin__bg_1\":\"#02385A\",\"--skin__bg_1__toRgbString\":\"2,56,90\",\"--skin__bg_2\":\"#002744\",\"--skin__bg_2__toRgbString\":\"0,39,68\",\"--skin__border\":\"#034570\",\"--skin__border__toRgbString\":\"3,69,112\",\"--skin__bs_topnav_bg\":\"#031E3B\",\"--skin__bs_topnav_bg__toRgbString\":\"3,30,59\",\"--skin__bs_zc_an1\":\"#033051\",\"--skin__bs_zc_an1__toRgbString\":\"3,48,81\",\"--skin__bs_zc_bg\":\"#002744\",\"--skin__bs_zc_bg__toRgbString\":\"0,39,68\",\"--skin__btmnav_active\":\"#04CCF3\",\"--skin__btmnav_active__toRgbString\":\"4,204,243\",\"--skin__btmnav_def\":\"#5B8FA7\",\"--skin__btmnav_def__toRgbString\":\"91,143,167\",\"--skin__ddt_bg\":\"#013154\",\"--skin__ddt_bg__toRgbString\":\"1,49,84\",\"--skin__ddt_icon\":\"#033C65\",\"--skin__ddt_icon__toRgbString\":\"3,60,101\",\"--skin__filter_active\":\"#04CCF3\",\"--skin__filter_active__toRgbString\":\"4,204,243\",\"--skin__filter_bg\":\"#02385A\",\"--skin__filter_bg__toRgbString\":\"2,56,90\",\"--skin__home_bg\":\"#002744\",\"--skin__home_bg__toRgbString\":\"0,39,68\",\"--skin__icon_1\":\"#04CCF3\",\"--skin__icon_1__toRgbString\":\"4,204,243\",\"--skin__icon_tg_q\":\"#7FB8D2\",\"--skin__icon_tg_q__toRgbString\":\"127,184,210\",\"--skin__icon_tg_z\":\"#7FB8D2\",\"--skin__icon_tg_z__toRgbString\":\"127,184,210\",\"--skin__jackpot_text\":\"#FFFFFF\",\"--skin__jackpot_text__toRgbString\":\"255,255,255\",\"--skin__jdd_vip_bjc\":\"#04CCF3\",\"--skin__jdd_vip_bjc__toRgbString\":\"4,204,243\",\"--skin__kb_bg\":\"#034570\",\"--skin__kb_bg__toRgbString\":\"3,69,112\",\"--skin__label_accent3\":\"#FFAA09\",\"--skin__label_accent3__toRgbString\":\"255,170,9\",\"--skin__labeltext_accent3\":\"#FFFFFF\",\"--skin__labeltext_accent3__toRgbString\":\"255,255,255\",\"--skin__lead\":\"#FFFFFF\",\"--skin__lead__toRgbString\":\"255,255,255\",\"--skin__leftnav_active\":\"#FFFFFF\",\"--skin__leftnav_active__toRgbString\":\"255,255,255\",\"--skin__leftnav_def\":\"#7FB8D2\",\"--skin__leftnav_def__toRgbString\":\"127,184,210\",\"--skin__neutral_1\":\"#7FB8D2\",\"--skin__neutral_1__toRgbString\":\"127,184,210\",\"--skin__neutral_2\":\"#5B8FA7\",\"--skin__neutral_2__toRgbString\":\"91,143,167\",\"--skin__neutral_3\":\"#5B8FA7\",\"--skin__neutral_3__toRgbString\":\"91,143,167\",\"--skin__primary\":\"#04CCF3\",\"--skin__primary__toRgbString\":\"4,204,243\",\"--skin__profile_icon_1\":\"#04CCF3\",\"--skin__profile_icon_1__toRgbString\":\"4,204,243\",\"--skin__profile_icon_2\":\"#04CCF3\",\"--skin__profile_icon_2__toRgbString\":\"4,204,243\",\"--skin__profile_icon_3\":\"#04CCF3\",\"--skin__profile_icon_3__toRgbString\":\"4,204,243\",\"--skin__profile_icon_4\":\"#04CCF3\",\"--skin__profile_icon_4__toRgbString\":\"4,204,243\",\"--skin__profile_toptext\":\"#FFFFFF\",\"--skin__profile_toptext__toRgbString\":\"255,255,255\",\"--skin__search_icon\":\"#7FB8D2\",\"--skin__search_icon__toRgbString\":\"127,184,210\",\"--skin__table_bg\":\"#002744\",\"--skin__table_bg__toRgbString\":\"0,39,68\",\"--skin__text_accent3\":\"#FFFFFF\",\"--skin__text_accent3__toRgbString\":\"255,255,255\",\"--skin__text_primary\":\"#FFFFFF\",\"--skin__text_primary__toRgbString\":\"255,255,255\",\"--skin__web_bs_yj_bg\":\"#031E3B\",\"--skin__web_bs_yj_bg__toRgbString\":\"3,30,59\",\"--skin__web_bs_zc_an2\":\"#043860\",\"--skin__web_bs_zc_an2__toRgbString\":\"4,56,96\",\"--skin__web_btmnav_db\":\"#002744\",\"--skin__web_btmnav_db__toRgbString\":\"0,39,68\",\"--skin__web_filter_gou\":\"#FFFFFF\",\"--skin__web_filter_gou__toRgbString\":\"255,255,255\",\"--skin__web_left_bg_q\":\"#FFFFFF0A\",\"--skin__web_left_bg_shadow\":\"#0000001F\",\"--skin__web_left_bg_shadow_active\":\"#0000001F\",\"--skin__web_left_bg_z\":\"#FFFFFF0D\",\"--skin__web_load_zz\":\"#03457066\",\"--skin__web_plat_line\":\"#034570\",\"--skin__web_plat_line__toRgbString\":\"3,69,112\",\"--skin__web_topbg_1\":\"#04CCF3\",\"--skin__web_topbg_1__toRgbString\":\"4,204,243\",\"--skin__web_topbg_3\":\"#06B1D2\"}','../skin/lobby_asset/2-1-22/Screenshot_427.png',0,'https://gadsgads.saxpgapp.com/siteadmin/skin/lobby_asset/2-1-12'),
(15,'CarvalhoPG','{\"--skin__ID\":\"2-22\",\"--skin__accent_1\":\"#04BE02\",\"--skin__accent_1__toRgbString\":\"4,190,2\",\"--skin__accent_2\":\"#EA4E3D\",\"--skin__accent_2__toRgbString\":\"234,78,61\",\"--skin__accent_3\":\"#FFAA09\",\"--skin__accent_3__toRgbString\":\"255,170,9\",\"--skin__alt_border\":\"#D9859A\",\"--skin__alt_border__toRgbString\":\"217,133,154\",\"--skin__alt_lead\":\"#FFFFFF\",\"--skin__alt_lead__toRgbString\":\"255,255,255\",\"--skin__alt_neutral_1\":\"#D9859A\",\"--skin__alt_neutral_1__toRgbString\":\"217,133,154\",\"--skin__alt_neutral_2\":\"#B95B71\",\"--skin__alt_neutral_2__toRgbString\":\"185,91,113\",\"--skin__alt_primary\":\"#E9C86F\",\"--skin__alt_primary__toRgbString\":\"233,200,111\",\"--skin__alt_text_primary\":\"#4C0113\",\"--skin__alt_text_primary__toRgbString\":\"76,1,19\",\"--skin__bg_1\":\"#651226\",\"--skin__bg_1__toRgbString\":\"101,18,38\",\"--skin__bg_2\":\"#4C0113\",\"--skin__bg_2__toRgbString\":\"76,1,19\",\"--skin__border\":\"#842239\",\"--skin__border__toRgbString\":\"132,34,57\",\"--skin__bs_topnav_bg\":\"#330215\",\"--skin__bs_topnav_bg__toRgbString\":\"51,2,21\",\"--skin__bs_zc_an1\":\"#58071B\",\"--skin__bs_zc_an1__toRgbString\":\"88,7,27\",\"--skin__bs_zc_bg\":\"#4C0113\",\"--skin__bs_zc_bg__toRgbString\":\"76,1,19\",\"--skin__btmnav_active\":\"#E9C86F\",\"--skin__btmnav_active__toRgbString\":\"233,200,111\",\"--skin__btmnav_def\":\"#B95B71\",\"--skin__btmnav_def__toRgbString\":\"185,91,113\",\"--skin__ddt_bg\":\"#5A071B\",\"--skin__ddt_bg__toRgbString\":\"90,7,27\",\"--skin__ddt_icon\":\"#701E31\",\"--skin__ddt_icon__toRgbString\":\"112,30,49\",\"--skin__filter_active\":\"#E9C86F\",\"--skin__filter_active__toRgbString\":\"233,200,111\",\"--skin__filter_bg\":\"#651226\",\"--skin__filter_bg__toRgbString\":\"101,18,38\",\"--skin__home_bg\":\"#4C0113\",\"--skin__home_bg__toRgbString\":\"76,1,19\",\"--skin__icon_1\":\"#E9C86F\",\"--skin__icon_1__toRgbString\":\"233,200,111\",\"--skin__icon_tg_q\":\"#D9859A\",\"--skin__icon_tg_q__toRgbString\":\"217,133,154\",\"--skin__icon_tg_z\":\"#D9859A\",\"--skin__icon_tg_z__toRgbString\":\"217,133,154\",\"--skin__jackpot_text\":\"#FFFFFF\",\"--skin__jackpot_text__toRgbString\":\"255,255,255\",\"--skin__jdd_vip_bjc\":\"#FFAA09\",\"--skin__jdd_vip_bjc__toRgbString\":\"255,170,9\",\"--skin__kb_bg\":\"#842239\",\"--skin__kb_bg__toRgbString\":\"132,34,57\",\"--skin__label_accent3\":\"#FFAA09\",\"--skin__label_accent3__toRgbString\":\"255,170,9\",\"--skin__labeltext_accent3\":\"#FFFFFF\",\"--skin__labeltext_accent3__toRgbString\":\"255,255,255\",\"--skin__lead\":\"#FFFFFF\",\"--skin__lead__toRgbString\":\"255,255,255\",\"--skin__leftnav_active\":\"#4C0113\",\"--skin__leftnav_active__toRgbString\":\"76,1,19\",\"--skin__leftnav_def\":\"#D9859A\",\"--skin__leftnav_def__toRgbString\":\"217,133,154\",\"--skin__neutral_1\":\"#D9859A\",\"--skin__neutral_1__toRgbString\":\"217,133,154\",\"--skin__neutral_2\":\"#B95B71\",\"--skin__neutral_2__toRgbString\":\"185,91,113\",\"--skin__neutral_3\":\"#B95B71\",\"--skin__neutral_3__toRgbString\":\"185,91,113\",\"--skin__primary\":\"#E9C86F\",\"--skin__primary__toRgbString\":\"233,200,111\",\"--skin__profile_icon_1\":\"#E9C86F\",\"--skin__profile_icon_1__toRgbString\":\"233,200,111\",\"--skin__profile_icon_2\":\"#E9C86F\",\"--skin__profile_icon_2__toRgbString\":\"233,200,111\",\"--skin__profile_icon_3\":\"#E9C86F\",\"--skin__profile_icon_3__toRgbString\":\"233,200,111\",\"--skin__profile_icon_4\":\"#E9C86F\",\"--skin__profile_icon_4__toRgbString\":\"233,200,111\",\"--skin__profile_toptext\":\"#FFFFFF\",\"--skin__profile_toptext__toRgbString\":\"255,255,255\",\"--skin__search_icon\":\"#D9859A\",\"--skin__search_icon__toRgbString\":\"217,133,154\",\"--skin__table_bg\":\"#4C0113\",\"--skin__table_bg__toRgbString\":\"76,1,19\",\"--skin__text_accent3\":\"#FFFFFF\",\"--skin__text_accent3__toRgbString\":\"255,255,255\",\"--skin__text_primary\":\"#4C0113\",\"--skin__text_primary__toRgbString\":\"76,1,19\",\"--skin__web_bs_yj_bg\":\"#330215\",\"--skin__web_bs_yj_bg__toRgbString\":\"51,2,21\",\"--skin__web_bs_zc_an2\":\"#711028\",\"--skin__web_bs_zc_an2__toRgbString\":\"113,16,40\",\"--skin__web_btmnav_db\":\"#400114\",\"--skin__web_btmnav_db__toRgbString\":\"64,1,20\",\"--skin__web_filter_gou\":\"#4C0113\",\"--skin__web_filter_gou__toRgbString\":\"76,1,19\",\"--skin__web_left_bg_q\":\"#FFFFFF0A\",\"--skin__web_left_bg_shadow\":\"#0000001F\",\"--skin__web_left_bg_shadow_active\":\"#0000001F\",\"--skin__web_left_bg_z\":\"#FFFFFF0D\",\"--skin__web_load_zz\":\"#84223966\",\"--skin__web_plat_line\":\"#842239\",\"--skin__web_plat_line__toRgbString\":\"132,34,57\",\"--skin__web_topbg_1\":\"#E9C86F\",\"--skin__web_topbg_1__toRgbString\":\"233,200,111\",\"--skin__web_topbg_3\":\"#BB993E\"}','../skin/lobby_asset/2-1-22/Screenshot_428.png',0,'https://gsd.carvalhopgapp.com/siteadmin/skin/lobby_asset/2-1-22'),
(16,'FritasPG','{\"--skin__ID\":\"2-78\",\"--skin__accent_1\":\"#04BE02\",\"--skin__accent_1__toRgbString\":\"4,190,2\",\"--skin__accent_2\":\"#EA4E3D\",\"--skin__accent_2__toRgbString\":\"234,78,61\",\"--skin__accent_3\":\"#FFAA09\",\"--skin__accent_3__toRgbString\":\"255,170,9\",\"--skin__alt_border\":\"#CECECE\",\"--skin__alt_border__toRgbString\":\"206,206,206\",\"--skin__alt_lead\":\"#FFFFFF\",\"--skin__alt_lead__toRgbString\":\"255,255,255\",\"--skin__alt_neutral_1\":\"#A391CF\",\"--skin__alt_neutral_1__toRgbString\":\"163,145,207\",\"--skin__alt_neutral_2\":\"#B8A7E1\",\"--skin__alt_neutral_2__toRgbString\":\"184,167,225\",\"--skin__alt_primary\":\"#FFFFFF\",\"--skin__alt_primary__toRgbString\":\"255,255,255\",\"--skin__alt_text_primary\":\"#8064C1\",\"--skin__alt_text_primary__toRgbString\":\"128,100,193\",\"--skin__bg_1\":\"#FFFFFF\",\"--skin__bg_1__toRgbString\":\"255,255,255\",\"--skin__bg_2\":\"#F5F5F5\",\"--skin__bg_2__toRgbString\":\"245,245,245\",\"--skin__border\":\"#CECECE\",\"--skin__border__toRgbString\":\"206,206,206\",\"--skin__bs_topnav_bg\":\"#8064C1\",\"--skin__bs_topnav_bg__toRgbString\":\"128,100,193\",\"--skin__bs_zc_an1\":\"#FFFFFF\",\"--skin__bs_zc_an1__toRgbString\":\"255,255,255\",\"--skin__bs_zc_bg\":\"#F5F5F5\",\"--skin__bs_zc_bg__toRgbString\":\"245,245,245\",\"--skin__btmnav_active\":\"#8064C1\",\"--skin__btmnav_active__toRgbString\":\"128,100,193\",\"--skin__btmnav_def\":\"#9B9B9B\",\"--skin__btmnav_def__toRgbString\":\"155,155,155\",\"--skin__ddt_bg\":\"#E9E9E9\",\"--skin__ddt_bg__toRgbString\":\"233,233,233\",\"--skin__ddt_icon\":\"#F1F1F1\",\"--skin__ddt_icon__toRgbString\":\"241,241,241\",\"--skin__filter_active\":\"#8064C1\",\"--skin__filter_active__toRgbString\":\"128,100,193\",\"--skin__filter_bg\":\"#FFFFFF\",\"--skin__filter_bg__toRgbString\":\"255,255,255\",\"--skin__home_bg\":\"#F5F5F5\",\"--skin__home_bg__toRgbString\":\"245,245,245\",\"--skin__icon_1\":\"#8064C1\",\"--skin__icon_1__toRgbString\":\"128,100,193\",\"--skin__icon_tg_q\":\"#B4B6BF\",\"--skin__icon_tg_q__toRgbString\":\"180,182,191\",\"--skin__icon_tg_z\":\"#909199\",\"--skin__icon_tg_z__toRgbString\":\"144,145,153\",\"--skin__jackpot_text\":\"#999999\",\"--skin__jackpot_text__toRgbString\":\"153,153,153\",\"--skin__jdd_vip_bjc\":\"#8064C1\",\"--skin__jdd_vip_bjc__toRgbString\":\"128,100,193\",\"--skin__kb_bg\":\"#CECECE\",\"--skin__kb_bg__toRgbString\":\"206,206,206\",\"--skin__label_accent3\":\"#FFAA09\",\"--skin__label_accent3__toRgbString\":\"255,170,9\",\"--skin__labeltext_accent3\":\"#FFFFFF\",\"--skin__labeltext_accent3__toRgbString\":\"255,255,255\",\"--skin__lead\":\"#333333\",\"--skin__lead__toRgbString\":\"51,51,51\",\"--skin__leftnav_active\":\"#FFFFFF\",\"--skin__leftnav_active__toRgbString\":\"255,255,255\",\"--skin__leftnav_def\":\"#999999\",\"--skin__leftnav_def__toRgbString\":\"153,153,153\",\"--skin__neutral_1\":\"#666666\",\"--skin__neutral_1__toRgbString\":\"102,102,102\",\"--skin__neutral_2\":\"#999999\",\"--skin__neutral_2__toRgbString\":\"153,153,153\",\"--skin__neutral_3\":\"#CCCCCC\",\"--skin__neutral_3__toRgbString\":\"204,204,204\",\"--skin__primary\":\"#8064C1\",\"--skin__primary__toRgbString\":\"128,100,193\",\"--skin__profile_icon_1\":\"#FFAA09\",\"--skin__profile_icon_1__toRgbString\":\"255,170,9\",\"--skin__profile_icon_2\":\"#04BE02\",\"--skin__profile_icon_2__toRgbString\":\"4,190,2\",\"--skin__profile_icon_3\":\"#8064C1\",\"--skin__profile_icon_3__toRgbString\":\"128,100,193\",\"--skin__profile_icon_4\":\"#EA4E3D\",\"--skin__profile_icon_4__toRgbString\":\"234,78,61\",\"--skin__profile_toptext\":\"#FFFFFF\",\"--skin__profile_toptext__toRgbString\":\"255,255,255\",\"--skin__search_icon\":\"#CECECE\",\"--skin__search_icon__toRgbString\":\"206,206,206\",\"--skin__table_bg\":\"#F5F5F5\",\"--skin__table_bg__toRgbString\":\"245,245,245\",\"--skin__text_accent3\":\"#FFFFFF\",\"--skin__text_accent3__toRgbString\":\"255,255,255\",\"--skin__text_primary\":\"#FFFFFF\",\"--skin__text_primary__toRgbString\":\"255,255,255\",\"--skin__web_bs_yj_bg\":\"#FFFFFF\",\"--skin__web_bs_yj_bg__toRgbString\":\"255,255,255\",\"--skin__web_bs_zc_an2\":\"#F2ECFF\",\"--skin__web_bs_zc_an2__toRgbString\":\"242,236,255\",\"--skin__web_btmnav_db\":\"#FFFFFF\",\"--skin__web_btmnav_db__toRgbString\":\"255,255,255\",\"--skin__web_filter_gou\":\"#FFFFFF\",\"--skin__web_filter_gou__toRgbString\":\"255,255,255\",\"--skin__web_left_bg_q\":\"#FFFFFF0A\",\"--skin__web_left_bg_shadow\":\"#0000001F\",\"--skin__web_left_bg_shadow_active\":\"#0000001F\",\"--skin__web_left_bg_z\":\"#FFFFFF0D\",\"--skin__web_load_zz\":\"#CECECE66\",\"--skin__web_plat_line\":\"#CECECE\",\"--skin__web_plat_line__toRgbString\":\"206,206,206\",\"--skin__web_topbg_1\":\"#8E6FD6\",\"--skin__web_topbg_1__toRgbString\":\"142,111,214\",\"--skin__web_topbg_3\":\"#8064C1\"}','../skin/lobby_asset/2-1-22/Captura de tela 2025-05-17 170248.png',0,'https://wp-fritaspg.com/siteadmin/skin/lobby'),
(18,'AirLinerPG','{\"--skin__ID\":\"2-6\",\"--skin__accent_1\":\"#04BE02\",\"--skin__accent_1__toRgbString\":\"4,190,2\",\"--skin__accent_2\":\"#EA4E3D\",\"--skin__accent_2__toRgbString\":\"234,78,61\",\"--skin__accent_3\":\"#FFAA09\",\"--skin__accent_3__toRgbString\":\"255,170,9\",\"--skin__alt_border\":\"#D3ACFF\",\"--skin__alt_border__toRgbString\":\"211,172,255\",\"--skin__alt_lead\":\"#FFFFFF\",\"--skin__alt_lead__toRgbString\":\"255,255,255\",\"--skin__alt_neutral_1\":\"#D3ACFF\",\"--skin__alt_neutral_1__toRgbString\":\"211,172,255\",\"--skin__alt_neutral_2\":\"#9069E6\",\"--skin__alt_neutral_2__toRgbString\":\"144,105,230\",\"--skin__alt_primary\":\"#D560FF\",\"--skin__alt_primary__toRgbString\":\"213,96,255\",\"--skin__alt_text_primary\":\"#FFFFFF\",\"--skin__alt_text_primary__toRgbString\":\"255,255,255\",\"--skin__bg_1\":\"#441F94\",\"--skin__bg_1__toRgbString\":\"68,31,148\",\"--skin__bg_2\":\"#2B0977\",\"--skin__bg_2__toRgbString\":\"43,9,119\",\"--skin__border\":\"#6E3ED6\",\"--skin__border__toRgbString\":\"110,62,214\",\"--skin__bs_topnav_bg\":\"#2B0977\",\"--skin__bs_topnav_bg__toRgbString\":\"43,9,119\",\"--skin__bs_zc_an1\":\"#431E98\",\"--skin__bs_zc_an1__toRgbString\":\"67,30,152\",\"--skin__bs_zc_bg\":\"#3D0E8F\",\"--skin__bs_zc_bg__toRgbString\":\"61,14,143\",\"--skin__btmnav_active\":\"#D560FF\",\"--skin__btmnav_active__toRgbString\":\"213,96,255\",\"--skin__btmnav_def\":\"#9069E6\",\"--skin__btmnav_def__toRgbString\":\"144,105,230\",\"--skin__ddt_bg\":\"#371584\",\"--skin__ddt_bg__toRgbString\":\"55,21,132\",\"--skin__ddt_icon\":\"#4D279E\",\"--skin__ddt_icon__toRgbString\":\"77,39,158\",\"--skin__filter_active\":\"#D560FF\",\"--skin__filter_active__toRgbString\":\"213,96,255\",\"--skin__filter_bg\":\"#441F94\",\"--skin__filter_bg__toRgbString\":\"68,31,148\",\"--skin__home_bg\":\"#2B0977\",\"--skin__home_bg__toRgbString\":\"43,9,119\",\"--skin__icon_1\":\"#D560FF\",\"--skin__icon_1__toRgbString\":\"213,96,255\",\"--skin__icon_tg_q\":\"#D3ACFF\",\"--skin__icon_tg_q__toRgbString\":\"211,172,255\",\"--skin__icon_tg_z\":\"#D3ACFF\",\"--skin__icon_tg_z__toRgbString\":\"211,172,255\",\"--skin__jackpot_text\":\"#FFFFFF\",\"--skin__jackpot_text__toRgbString\":\"255,255,255\",\"--skin__jdd_vip_bjc\":\"#D560FF\",\"--skin__jdd_vip_bjc__toRgbString\":\"213,96,255\",\"--skin__kb_bg\":\"#441F94\",\"--skin__kb_bg__toRgbString\":\"68,31,148\",\"--skin__label_accent3\":\"#FFAA09\",\"--skin__label_accent3__toRgbString\":\"255,170,9\",\"--skin__labeltext_accent3\":\"#FFFFFF\",\"--skin__labeltext_accent3__toRgbString\":\"255,255,255\",\"--skin__lead\":\"#FFFFFF\",\"--skin__lead__toRgbString\":\"255,255,255\",\"--skin__leftnav_active\":\"#FFFFFF\",\"--skin__leftnav_active__toRgbString\":\"255,255,255\",\"--skin__leftnav_def\":\"#D3ACFF\",\"--skin__leftnav_def__toRgbString\":\"211,172,255\",\"--skin__neutral_1\":\"#D3ACFF\",\"--skin__neutral_1__toRgbString\":\"211,172,255\",\"--skin__neutral_2\":\"#9069E6\",\"--skin__neutral_2__toRgbString\":\"144,105,230\",\"--skin__neutral_3\":\"#9069E6\",\"--skin__neutral_3__toRgbString\":\"144,105,230\",\"--skin__primary\":\"#D560FF\",\"--skin__primary__toRgbString\":\"213,96,255\",\"--skin__profile_icon_1\":\"#D560FF\",\"--skin__profile_icon_1__toRgbString\":\"213,96,255\",\"--skin__profile_icon_2\":\"#D560FF\",\"--skin__profile_icon_2__toRgbString\":\"213,96,255\",\"--skin__profile_icon_3\":\"#D560FF\",\"--skin__profile_icon_3__toRgbString\":\"213,96,255\",\"--skin__profile_icon_4\":\"#D560FF\",\"--skin__profile_icon_4__toRgbString\":\"213,96,255\",\"--skin__profile_toptext\":\"#FFFFFF\",\"--skin__profile_toptext__toRgbString\":\"255,255,255\",\"--skin__search_icon\":\"#D3ACFF\",\"--skin__search_icon__toRgbString\":\"211,172,255\",\"--skin__table_bg\":\"#441F94\",\"--skin__table_bg__toRgbString\":\"68,31,148\",\"--skin__text_accent3\":\"#FFFFFF\",\"--skin__text_accent3__toRgbString\":\"255,255,255\",\"--skin__text_primary\":\"#FFFFFF\",\"--skin__text_primary__toRgbString\":\"255,255,255\",\"--skin__web_bs_yj_bg\":\"#2B0977\",\"--skin__web_bs_yj_bg__toRgbString\":\"43,9,119\",\"--skin__web_bs_zc_an2\":\"#4B25A2\",\"--skin__web_bs_zc_an2__toRgbString\":\"75,37,162\",\"--skin__web_btmnav_db\":\"#371584\",\"--skin__web_btmnav_db__toRgbString\":\"55,21,132\",\"--skin__web_filter_gou\":\"#FFFFFF\",\"--skin__web_filter_gou__toRgbString\":\"255,255,255\",\"--skin__web_left_bg_q\":\"#371485\",\"--skin__web_left_bg_q__toRgbString\":\"55,20,133\",\"--skin__web_left_bg_shadow\":\"#0000001F\",\"--skin__web_left_bg_shadow_active\":\"#0000001F\",\"--skin__web_left_bg_z\":\"#301175\",\"--skin__web_left_bg_z__toRgbString\":\"48,17,117\",\"--skin__web_load_zz\":\"#6E3ED666\",\"--skin__web_plat_line\":\"#422486\",\"--skin__web_plat_line__toRgbString\":\"66,36,134\",\"--skin__web_topbg_1\":\"#CB3AFF\",\"--skin__web_topbg_1__toRgbString\":\"203,58,255\",\"--skin__web_topbg_3\":\"#8D13DE\"}','../skin/lobby_asset/2-1-22/Screenshot_434.png',0,'https://hsah.airlinerpgapp.com/siteadmin/skin/lobby_asset/2-1-6'),
(19,'CafePG','{\"--skin__ID\":\"2-27\",\"--skin__accent_1\":\"#088000\",\"--skin__accent_1__toRgbString\":\"8,128,0\",\"--skin__accent_2\":\"#A51F1F\",\"--skin__accent_2__toRgbString\":\"165,31,31\",\"--skin__accent_3\":\"#FFAA09\",\"--skin__accent_3__toRgbString\":\"255,170,9\",\"--skin__alt_border\":\"#F8E0E2\",\"--skin__alt_border__toRgbString\":\"248,224,226\",\"--skin__alt_lead\":\"#FFFFFF\",\"--skin__alt_lead__toRgbString\":\"255,255,255\",\"--skin__alt_neutral_1\":\"#F8E0E2\",\"--skin__alt_neutral_1__toRgbString\":\"248,224,226\",\"--skin__alt_neutral_2\":\"#FFC1CD\",\"--skin__alt_neutral_2__toRgbString\":\"255,193,205\",\"--skin__alt_primary\":\"#FFF0BB\",\"--skin__alt_primary__toRgbString\":\"255,240,187\",\"--skin__alt_text_primary\":\"#C15473\",\"--skin__alt_text_primary__toRgbString\":\"193,84,115\",\"--skin__bg_1\":\"#E06F8B\",\"--skin__bg_1__toRgbString\":\"224,111,139\",\"--skin__bg_2\":\"#C15473\",\"--skin__bg_2__toRgbString\":\"193,84,115\",\"--skin__border\":\"#EC89A5\",\"--skin__border__toRgbString\":\"236,137,165\",\"--skin__bs_topnav_bg\":\"#B94B6B\",\"--skin__bs_topnav_bg__toRgbString\":\"185,75,107\",\"--skin__bs_zc_an1\":\"#C8637F\",\"--skin__bs_zc_an1__toRgbString\":\"200,99,127\",\"--skin__bs_zc_bg\":\"#C15473\",\"--skin__bs_zc_bg__toRgbString\":\"193,84,115\",\"--skin__btmnav_active\":\"#FFF0BB\",\"--skin__btmnav_active__toRgbString\":\"255,240,187\",\"--skin__btmnav_def\":\"#FFC1CD\",\"--skin__btmnav_def__toRgbString\":\"255,193,205\",\"--skin__ddt_bg\":\"#C85E7C\",\"--skin__ddt_bg__toRgbString\":\"200,94,124\",\"--skin__ddt_icon\":\"#D57590\",\"--skin__ddt_icon__toRgbString\":\"213,117,144\",\"--skin__filter_active\":\"#FFF0BB\",\"--skin__filter_active__toRgbString\":\"255,240,187\",\"--skin__filter_bg\":\"#E06F8B\",\"--skin__filter_bg__toRgbString\":\"224,111,139\",\"--skin__home_bg\":\"#C15473\",\"--skin__home_bg__toRgbString\":\"193,84,115\",\"--skin__icon_1\":\"#FFF0BB\",\"--skin__icon_1__toRgbString\":\"255,240,187\",\"--skin__icon_tg_q\":\"#F8E0E2\",\"--skin__icon_tg_q__toRgbString\":\"248,224,226\",\"--skin__icon_tg_z\":\"#F8E0E2\",\"--skin__icon_tg_z__toRgbString\":\"248,224,226\",\"--skin__jackpot_text\":\"#FFFFFF\",\"--skin__jackpot_text__toRgbString\":\"255,255,255\",\"--skin__jdd_vip_bjc\":\"#FFAA09\",\"--skin__jdd_vip_bjc__toRgbString\":\"255,170,9\",\"--skin__kb_bg\":\"#EC89A5\",\"--skin__kb_bg__toRgbString\":\"236,137,165\",\"--skin__label_accent3\":\"#FFAA09\",\"--skin__label_accent3__toRgbString\":\"255,170,9\",\"--skin__labeltext_accent3\":\"#FFFFFF\",\"--skin__labeltext_accent3__toRgbString\":\"255,255,255\",\"--skin__lead\":\"#FFFFFF\",\"--skin__lead__toRgbString\":\"255,255,255\",\"--skin__leftnav_active\":\"#C15473\",\"--skin__leftnav_active__toRgbString\":\"193,84,115\",\"--skin__leftnav_def\":\"#F8E0E2\",\"--skin__leftnav_def__toRgbString\":\"248,224,226\",\"--skin__neutral_1\":\"#F8E0E2\",\"--skin__neutral_1__toRgbString\":\"248,224,226\",\"--skin__neutral_2\":\"#FFC1CD\",\"--skin__neutral_2__toRgbString\":\"255,193,205\",\"--skin__neutral_3\":\"#FFC1CD\",\"--skin__neutral_3__toRgbString\":\"255,193,205\",\"--skin__primary\":\"#FFF0BB\",\"--skin__primary__toRgbString\":\"255,240,187\",\"--skin__profile_icon_1\":\"#FFF0BB\",\"--skin__profile_icon_1__toRgbString\":\"255,240,187\",\"--skin__profile_icon_2\":\"#FFF0BB\",\"--skin__profile_icon_2__toRgbString\":\"255,240,187\",\"--skin__profile_icon_3\":\"#FFF0BB\",\"--skin__profile_icon_3__toRgbString\":\"255,240,187\",\"--skin__profile_icon_4\":\"#FFF0BB\",\"--skin__profile_icon_4__toRgbString\":\"255,240,187\",\"--skin__profile_toptext\":\"#FFFFFF\",\"--skin__profile_toptext__toRgbString\":\"255,255,255\",\"--skin__search_icon\":\"#F8E0E2\",\"--skin__search_icon__toRgbString\":\"248,224,226\",\"--skin__table_bg\":\"#C15473\",\"--skin__table_bg__toRgbString\":\"193,84,115\",\"--skin__text_accent3\":\"#FFFFFF\",\"--skin__text_accent3__toRgbString\":\"255,255,255\",\"--skin__text_primary\":\"#C15473\",\"--skin__text_primary__toRgbString\":\"193,84,115\",\"--skin__web_bs_yj_bg\":\"#B94B6B\",\"--skin__web_bs_yj_bg__toRgbString\":\"185,75,107\",\"--skin__web_bs_zc_an2\":\"#D86D8B\",\"--skin__web_bs_zc_an2__toRgbString\":\"216,109,139\",\"--skin__web_btmnav_db\":\"#B94B6B\",\"--skin__web_btmnav_db__toRgbString\":\"185,75,107\",\"--skin__web_filter_gou\":\"#C15473\",\"--skin__web_filter_gou__toRgbString\":\"193,84,115\",\"--skin__web_left_bg_q\":\"#FFFFFF0A\",\"--skin__web_left_bg_shadow\":\"#0000001F\",\"--skin__web_left_bg_shadow_active\":\"#0000001F\",\"--skin__web_left_bg_z\":\"#FFFFFF0D\",\"--skin__web_load_zz\":\"#EC89A566\",\"--skin__web_plat_line\":\"#EC89A5\",\"--skin__web_plat_line__toRgbString\":\"236,137,165\",\"--skin__web_topbg_1\":\"#E26387\",\"--skin__web_topbg_1__toRgbString\":\"226,99,135\",\"--skin__web_topbg_3\":\"#D85076\"}','../skin/lobby_asset/2-1-22/Screenshot_439.png',0,'https://wefewg.cafespgapp.com/siteadmin/skin/lobby_asset/2-1-27'),
(21,'HARE','{\"--skin__ID\":\"2-12\",\"--skin__accent_1\":\"#04BE02\",\"--skin__accent_1__toRgbString\":\"4,190,2\",\"--skin__accent_2\":\"#FF4A4A\",\"--skin__accent_2__toRgbString\":\"255,74,74\",\"--skin__accent_3\":\"#FFAA09\",\"--skin__accent_3__toRgbString\":\"255,170,9\",\"--skin__alt_border\":\"#7FB8D2\",\"--skin__alt_border__toRgbString\":\"127,184,210\",\"--skin__alt_lead\":\"#FFFFFF\",\"--skin__alt_lead__toRgbString\":\"255,255,255\",\"--skin__alt_neutral_1\":\"#7FB8D2\",\"--skin__alt_neutral_1__toRgbString\":\"127,184,210\",\"--skin__alt_neutral_2\":\"#5B8FA7\",\"--skin__alt_neutral_2__toRgbString\":\"91,143,167\",\"--skin__alt_primary\":\"#04CCF3\",\"--skin__alt_primary__toRgbString\":\"4,204,243\",\"--skin__alt_text_primary\":\"#FFFFFF\",\"--skin__alt_text_primary__toRgbString\":\"255,255,255\",\"--skin__bg_1\":\"#02385A\",\"--skin__bg_1__toRgbString\":\"2,56,90\",\"--skin__bg_2\":\"#002744\",\"--skin__bg_2__toRgbString\":\"0,39,68\",\"--skin__border\":\"#034570\",\"--skin__border__toRgbString\":\"3,69,112\",\"--skin__bs_topnav_bg\":\"#031E3B\",\"--skin__bs_topnav_bg__toRgbString\":\"3,30,59\",\"--skin__bs_zc_an1\":\"#033051\",\"--skin__bs_zc_an1__toRgbString\":\"3,48,81\",\"--skin__bs_zc_bg\":\"#002744\",\"--skin__bs_zc_bg__toRgbString\":\"0,39,68\",\"--skin__btmnav_active\":\"#04CCF3\",\"--skin__btmnav_active__toRgbString\":\"4,204,243\",\"--skin__btmnav_def\":\"#5B8FA7\",\"--skin__btmnav_def__toRgbString\":\"91,143,167\",\"--skin__ddt_bg\":\"#013154\",\"--skin__ddt_bg__toRgbString\":\"1,49,84\",\"--skin__ddt_icon\":\"#033C65\",\"--skin__ddt_icon__toRgbString\":\"3,60,101\",\"--skin__filter_active\":\"#04CCF3\",\"--skin__filter_active__toRgbString\":\"4,204,243\",\"--skin__filter_bg\":\"#02385A\",\"--skin__filter_bg__toRgbString\":\"2,56,90\",\"--skin__home_bg\":\"#002744\",\"--skin__home_bg__toRgbString\":\"0,39,68\",\"--skin__icon_1\":\"#04CCF3\",\"--skin__icon_1__toRgbString\":\"4,204,243\",\"--skin__icon_tg_q\":\"#7FB8D2\",\"--skin__icon_tg_q__toRgbString\":\"127,184,210\",\"--skin__icon_tg_z\":\"#7FB8D2\",\"--skin__icon_tg_z__toRgbString\":\"127,184,210\",\"--skin__jackpot_text\":\"#FFFFFF\",\"--skin__jackpot_text__toRgbString\":\"255,255,255\",\"--skin__jdd_vip_bjc\":\"#04CCF3\",\"--skin__jdd_vip_bjc__toRgbString\":\"4,204,243\",\"--skin__kb_bg\":\"#034570\",\"--skin__kb_bg__toRgbString\":\"3,69,112\",\"--skin__label_accent3\":\"#FFAA09\",\"--skin__label_accent3__toRgbString\":\"255,170,9\",\"--skin__labeltext_accent3\":\"#FFFFFF\",\"--skin__labeltext_accent3__toRgbString\":\"255,255,255\",\"--skin__lead\":\"#FFFFFF\",\"--skin__lead__toRgbString\":\"255,255,255\",\"--skin__leftnav_active\":\"#FFFFFF\",\"--skin__leftnav_active__toRgbString\":\"255,255,255\",\"--skin__leftnav_def\":\"#7FB8D2\",\"--skin__leftnav_def__toRgbString\":\"127,184,210\",\"--skin__neutral_1\":\"#7FB8D2\",\"--skin__neutral_1__toRgbString\":\"127,184,210\",\"--skin__neutral_2\":\"#5B8FA7\",\"--skin__neutral_2__toRgbString\":\"91,143,167\",\"--skin__neutral_3\":\"#5B8FA7\",\"--skin__neutral_3__toRgbString\":\"91,143,167\",\"--skin__primary\":\"#04CCF3\",\"--skin__primary__toRgbString\":\"4,204,243\",\"--skin__profile_icon_1\":\"#04CCF3\",\"--skin__profile_icon_1__toRgbString\":\"4,204,243\",\"--skin__profile_icon_2\":\"#04CCF3\",\"--skin__profile_icon_2__toRgbString\":\"4,204,243\",\"--skin__profile_icon_3\":\"#04CCF3\",\"--skin__profile_icon_3__toRgbString\":\"4,204,243\",\"--skin__profile_icon_4\":\"#04CCF3\",\"--skin__profile_icon_4__toRgbString\":\"4,204,243\",\"--skin__profile_toptext\":\"#FFFFFF\",\"--skin__profile_toptext__toRgbString\":\"255,255,255\",\"--skin__search_icon\":\"#7FB8D2\",\"--skin__search_icon__toRgbString\":\"127,184,210\",\"--skin__table_bg\":\"#002744\",\"--skin__table_bg__toRgbString\":\"0,39,68\",\"--skin__text_accent3\":\"#FFFFFF\",\"--skin__text_accent3__toRgbString\":\"255,255,255\",\"--skin__text_primary\":\"#FFFFFF\",\"--skin__text_primary__toRgbString\":\"255,255,255\",\"--skin__web_bs_yj_bg\":\"#031E3B\",\"--skin__web_bs_yj_bg__toRgbString\":\"3,30,59\",\"--skin__web_bs_zc_an2\":\"#043860\",\"--skin__web_bs_zc_an2__toRgbString\":\"4,56,96\",\"--skin__web_btmnav_db\":\"#002744\",\"--skin__web_btmnav_db__toRgbString\":\"0,39,68\",\"--skin__web_filter_gou\":\"#FFFFFF\",\"--skin__web_filter_gou__toRgbString\":\"255,255,255\",\"--skin__web_left_bg_q\":\"#FFFFFF0A\",\"--skin__web_left_bg_shadow\":\"#0000001F\",\"--skin__web_left_bg_shadow_active\":\"#0000001F\",\"--skin__web_left_bg_z\":\"#FFFFFF0D\",\"--skin__web_load_zz\":\"#03457066\",\"--skin__web_plat_line\":\"#034570\",\"--skin__web_plat_line__toRgbString\":\"3,69,112\",\"--skin__web_topbg_1\":\"#04CCF3\",\"--skin__web_topbg_1__toRgbString\":\"4,204,243\",\"--skin__web_topbg_3\":\"#06B1D2\"}','../skin/lobby_asset/2-1-22/Captura de tela 2025-05-20 174406.png',0,'https://savgsdg.harepgapp.com/siteadmin/skin/lobby_asset/2-1-12'),
(23,'888paz','{\"--skin__ID\":\"2-4\",\"--skin__accent_1\":\"#04BE02\",\"--skin__accent_1__toRgbString\":\"4,190,2\",\"--skin__accent_2\":\"#EA4E3D\",\"--skin__accent_2__toRgbString\":\"234,78,61\",\"--skin__accent_3\":\"#FFAA09\",\"--skin__accent_3__toRgbString\":\"255,170,9\",\"--skin__alt_border\":\"#999999\",\"--skin__alt_border__toRgbString\":\"153,153,153\",\"--skin__alt_lead\":\"#E3E3E3\",\"--skin__alt_lead__toRgbString\":\"227,227,227\",\"--skin__alt_neutral_1\":\"#999999\",\"--skin__alt_neutral_1__toRgbString\":\"153,153,153\",\"--skin__alt_neutral_2\":\"#666666\",\"--skin__alt_neutral_2__toRgbString\":\"102,102,102\",\"--skin__alt_primary\":\"#E41827\",\"--skin__alt_primary__toRgbString\":\"228,24,39\",\"--skin__alt_text_primary\":\"#FFFFFF\",\"--skin__alt_text_primary__toRgbString\":\"255,255,255\",\"--skin__bg_1\":\"#333333\",\"--skin__bg_1__toRgbString\":\"51,51,51\",\"--skin__bg_2\":\"#222222\",\"--skin__bg_2__toRgbString\":\"34,34,34\",\"--skin__border\":\"#444444\",\"--skin__border__toRgbString\":\"68,68,68\",\"--skin__bs_topnav_bg\":\"#222222\",\"--skin__bs_topnav_bg__toRgbString\":\"34,34,34\",\"--skin__bs_zc_an1\":\"#303030\",\"--skin__bs_zc_an1__toRgbString\":\"48,48,48\",\"--skin__bs_zc_bg\":\"#282828\",\"--skin__bs_zc_bg__toRgbString\":\"40,40,40\",\"--skin__btmnav_active\":\"#E41827\",\"--skin__btmnav_active__toRgbString\":\"228,24,39\",\"--skin__btmnav_def\":\"#666666\",\"--skin__btmnav_def__toRgbString\":\"102,102,102\",\"--skin__ddt_bg\":\"#2B2B2B\",\"--skin__ddt_bg__toRgbString\":\"43,43,43\",\"--skin__ddt_icon\":\"#3A3A3A\",\"--skin__ddt_icon__toRgbString\":\"58,58,58\",\"--skin__filter_active\":\"#E41827\",\"--skin__filter_active__toRgbString\":\"228,24,39\",\"--skin__filter_bg\":\"#333333\",\"--skin__filter_bg__toRgbString\":\"51,51,51\",\"--skin__home_bg\":\"#222222\",\"--skin__home_bg__toRgbString\":\"34,34,34\",\"--skin__icon_1\":\"#E41827\",\"--skin__icon_1__toRgbString\":\"228,24,39\",\"--skin__icon_tg_q\":\"#999999\",\"--skin__icon_tg_q__toRgbString\":\"153,153,153\",\"--skin__icon_tg_z\":\"#999999\",\"--skin__icon_tg_z__toRgbString\":\"153,153,153\",\"--skin__jackpot_text\":\"#FFFFFF\",\"--skin__jackpot_text__toRgbString\":\"255,255,255\",\"--skin__jdd_vip_bjc\":\"#E41827\",\"--skin__jdd_vip_bjc__toRgbString\":\"228,24,39\",\"--skin__kb_bg\":\"#333333\",\"--skin__kb_bg__toRgbString\":\"51,51,51\",\"--skin__label_accent3\":\"#FFAA09\",\"--skin__label_accent3__toRgbString\":\"255,170,9\",\"--skin__labeltext_accent3\":\"#FFFFFF\",\"--skin__labeltext_accent3__toRgbString\":\"255,255,255\",\"--skin__lead\":\"#E3E3E3\",\"--skin__lead__toRgbString\":\"227,227,227\",\"--skin__leftnav_active\":\"#FFFFFF\",\"--skin__leftnav_active__toRgbString\":\"255,255,255\",\"--skin__leftnav_def\":\"#999999\",\"--skin__leftnav_def__toRgbString\":\"153,153,153\",\"--skin__neutral_1\":\"#999999\",\"--skin__neutral_1__toRgbString\":\"153,153,153\",\"--skin__neutral_2\":\"#666666\",\"--skin__neutral_2__toRgbString\":\"102,102,102\",\"--skin__neutral_3\":\"#666666\",\"--skin__neutral_3__toRgbString\":\"102,102,102\",\"--skin__primary\":\"#E41827\",\"--skin__primary__toRgbString\":\"228,24,39\",\"--skin__profile_icon_1\":\"#E41827\",\"--skin__profile_icon_1__toRgbString\":\"228,24,39\",\"--skin__profile_icon_2\":\"#E41827\",\"--skin__profile_icon_2__toRgbString\":\"228,24,39\",\"--skin__profile_icon_3\":\"#E41827\",\"--skin__profile_icon_3__toRgbString\":\"228,24,39\",\"--skin__profile_icon_4\":\"#E41827\",\"--skin__profile_icon_4__toRgbString\":\"228,24,39\",\"--skin__profile_toptext\":\"#FFFFFF\",\"--skin__profile_toptext__toRgbString\":\"255,255,255\",\"--skin__search_icon\":\"#999999\",\"--skin__search_icon__toRgbString\":\"153,153,153\",\"--skin__table_bg\":\"#333333\",\"--skin__table_bg__toRgbString\":\"51,51,51\",\"--skin__text_accent3\":\"#FFFFFF\",\"--skin__text_accent3__toRgbString\":\"255,255,255\",\"--skin__text_primary\":\"#FFFFFF\",\"--skin__text_primary__toRgbString\":\"255,255,255\",\"--skin__web_bs_yj_bg\":\"#222222\",\"--skin__web_bs_yj_bg__toRgbString\":\"34,34,34\",\"--skin__web_bs_zc_an2\":\"#3A3A3A\",\"--skin__web_bs_zc_an2__toRgbString\":\"58,58,58\",\"--skin__web_btmnav_db\":\"#282828\",\"--skin__web_btmnav_db__toRgbString\":\"40,40,40\",\"--skin__web_filter_gou\":\"#FFFFFF\",\"--skin__web_filter_gou__toRgbString\":\"255,255,255\",\"--skin__web_left_bg_q\":\"#282828\",\"--skin__web_left_bg_q__toRgbString\":\"40,40,40\",\"--skin__web_left_bg_shadow\":\"#0000001F\",\"--skin__web_left_bg_shadow_active\":\"#0000001F\",\"--skin__web_left_bg_z\":\"#222222\",\"--skin__web_left_bg_z__toRgbString\":\"34,34,34\",\"--skin__web_load_zz\":\"#44444466\",\"--skin__web_plat_line\":\"#444444\",\"--skin__web_plat_line__toRgbString\":\"68,68,68\",\"--skin__web_topbg_1\":\"#FB2535\",\"--skin__web_topbg_1__toRgbString\":\"251,37,53\",\"--skin__web_topbg_3\":\"#DB1524\"}','../skin/lobby_asset/2-1-22/Captura de tela 2025-05-21 225611.png',0,'https://ozap888.888paz.cc/siteadmin/skin/lobby_asset/2-1-4'),
(24,'caviar','{\"--skin__ID\":\"2-12\",\"--skin__accent_1\":\"#04BE02\",\"--skin__accent_1__toRgbString\":\"4,190,2\",\"--skin__accent_2\":\"#FF4A4A\",\"--skin__accent_2__toRgbString\":\"255,74,74\",\"--skin__accent_3\":\"#FFAA09\",\"--skin__accent_3__toRgbString\":\"255,170,9\",\"--skin__alt_border\":\"#7FB8D2\",\"--skin__alt_border__toRgbString\":\"127,184,210\",\"--skin__alt_lead\":\"#FFFFFF\",\"--skin__alt_lead__toRgbString\":\"255,255,255\",\"--skin__alt_neutral_1\":\"#7FB8D2\",\"--skin__alt_neutral_1__toRgbString\":\"127,184,210\",\"--skin__alt_neutral_2\":\"#5B8FA7\",\"--skin__alt_neutral_2__toRgbString\":\"91,143,167\",\"--skin__alt_primary\":\"#04CCF3\",\"--skin__alt_primary__toRgbString\":\"4,204,243\",\"--skin__alt_text_primary\":\"#FFFFFF\",\"--skin__alt_text_primary__toRgbString\":\"255,255,255\",\"--skin__bg_1\":\"#02385A\",\"--skin__bg_1__toRgbString\":\"2,56,90\",\"--skin__bg_2\":\"#002744\",\"--skin__bg_2__toRgbString\":\"0,39,68\",\"--skin__border\":\"#034570\",\"--skin__border__toRgbString\":\"3,69,112\",\"--skin__bs_topnav_bg\":\"#031E3B\",\"--skin__bs_topnav_bg__toRgbString\":\"3,30,59\",\"--skin__bs_zc_an1\":\"#033051\",\"--skin__bs_zc_an1__toRgbString\":\"3,48,81\",\"--skin__bs_zc_bg\":\"#002744\",\"--skin__bs_zc_bg__toRgbString\":\"0,39,68\",\"--skin__btmnav_active\":\"#04CCF3\",\"--skin__btmnav_active__toRgbString\":\"4,204,243\",\"--skin__btmnav_def\":\"#5B8FA7\",\"--skin__btmnav_def__toRgbString\":\"91,143,167\",\"--skin__ddt_bg\":\"#013154\",\"--skin__ddt_bg__toRgbString\":\"1,49,84\",\"--skin__ddt_icon\":\"#033C65\",\"--skin__ddt_icon__toRgbString\":\"3,60,101\",\"--skin__filter_active\":\"#04CCF3\",\"--skin__filter_active__toRgbString\":\"4,204,243\",\"--skin__filter_bg\":\"#02385A\",\"--skin__filter_bg__toRgbString\":\"2,56,90\",\"--skin__home_bg\":\"#002744\",\"--skin__home_bg__toRgbString\":\"0,39,68\",\"--skin__icon_1\":\"#04CCF3\",\"--skin__icon_1__toRgbString\":\"4,204,243\",\"--skin__icon_tg_q\":\"#7FB8D2\",\"--skin__icon_tg_q__toRgbString\":\"127,184,210\",\"--skin__icon_tg_z\":\"#7FB8D2\",\"--skin__icon_tg_z__toRgbString\":\"127,184,210\",\"--skin__jackpot_text\":\"#FFFFFF\",\"--skin__jackpot_text__toRgbString\":\"255,255,255\",\"--skin__jdd_vip_bjc\":\"#04CCF3\",\"--skin__jdd_vip_bjc__toRgbString\":\"4,204,243\",\"--skin__kb_bg\":\"#034570\",\"--skin__kb_bg__toRgbString\":\"3,69,112\",\"--skin__label_accent3\":\"#FFAA09\",\"--skin__label_accent3__toRgbString\":\"255,170,9\",\"--skin__labeltext_accent3\":\"#FFFFFF\",\"--skin__labeltext_accent3__toRgbString\":\"255,255,255\",\"--skin__lead\":\"#FFFFFF\",\"--skin__lead__toRgbString\":\"255,255,255\",\"--skin__leftnav_active\":\"#FFFFFF\",\"--skin__leftnav_active__toRgbString\":\"255,255,255\",\"--skin__leftnav_def\":\"#7FB8D2\",\"--skin__leftnav_def__toRgbString\":\"127,184,210\",\"--skin__neutral_1\":\"#7FB8D2\",\"--skin__neutral_1__toRgbString\":\"127,184,210\",\"--skin__neutral_2\":\"#5B8FA7\",\"--skin__neutral_2__toRgbString\":\"91,143,167\",\"--skin__neutral_3\":\"#5B8FA7\",\"--skin__neutral_3__toRgbString\":\"91,143,167\",\"--skin__primary\":\"#04CCF3\",\"--skin__primary__toRgbString\":\"4,204,243\",\"--skin__profile_icon_1\":\"#04CCF3\",\"--skin__profile_icon_1__toRgbString\":\"4,204,243\",\"--skin__profile_icon_2\":\"#04CCF3\",\"--skin__profile_icon_2__toRgbString\":\"4,204,243\",\"--skin__profile_icon_3\":\"#04CCF3\",\"--skin__profile_icon_3__toRgbString\":\"4,204,243\",\"--skin__profile_icon_4\":\"#04CCF3\",\"--skin__profile_icon_4__toRgbString\":\"4,204,243\",\"--skin__profile_toptext\":\"#FFFFFF\",\"--skin__profile_toptext__toRgbString\":\"255,255,255\",\"--skin__search_icon\":\"#7FB8D2\",\"--skin__search_icon__toRgbString\":\"127,184,210\",\"--skin__table_bg\":\"#002744\",\"--skin__table_bg__toRgbString\":\"0,39,68\",\"--skin__text_accent3\":\"#FFFFFF\",\"--skin__text_accent3__toRgbString\":\"255,255,255\",\"--skin__text_primary\":\"#FFFFFF\",\"--skin__text_primary__toRgbString\":\"255,255,255\",\"--skin__web_bs_yj_bg\":\"#031E3B\",\"--skin__web_bs_yj_bg__toRgbString\":\"3,30,59\",\"--skin__web_bs_zc_an2\":\"#043860\",\"--skin__web_bs_zc_an2__toRgbString\":\"4,56,96\",\"--skin__web_btmnav_db\":\"#002744\",\"--skin__web_btmnav_db__toRgbString\":\"0,39,68\",\"--skin__web_filter_gou\":\"#FFFFFF\",\"--skin__web_filter_gou__toRgbString\":\"255,255,255\",\"--skin__web_left_bg_q\":\"#FFFFFF0A\",\"--skin__web_left_bg_shadow\":\"#0000001F\",\"--skin__web_left_bg_shadow_active\":\"#0000001F\",\"--skin__web_left_bg_z\":\"#FFFFFF0D\",\"--skin__web_load_zz\":\"#03457066\",\"--skin__web_plat_line\":\"#034570\",\"--skin__web_plat_line__toRgbString\":\"3,69,112\",\"--skin__web_topbg_1\":\"#04CCF3\",\"--skin__web_topbg_1__toRgbString\":\"4,204,243\",\"--skin__web_topbg_3\":\"#06B1D2\"}','../skin/lobby_asset/2-1-22/Captura de tela 2025-05-22 010729.png',0,'https://dgs.caviarpg.com/siteadmin/skin/lobby_asset/2-1-12'),
(25,'dronesPG','{\"--skin__ID\":\"2-42\",\"--skin__accent_1\":\"#35FF36\",\"--skin__accent_1__toRgbString\":\"53,255,54\",\"--skin__accent_2\":\"#9F0505\",\"--skin__accent_2__toRgbString\":\"159,5,5\",\"--skin__accent_3\":\"#FFAA09\",\"--skin__accent_3__toRgbString\":\"255,170,9\",\"--skin__alt_border\":\"#FFDDD8\",\"--skin__alt_border__toRgbString\":\"255,221,216\",\"--skin__alt_lead\":\"#FFFFFF\",\"--skin__alt_lead__toRgbString\":\"255,255,255\",\"--skin__alt_neutral_1\":\"#FFDDD8\",\"--skin__alt_neutral_1__toRgbString\":\"255,221,216\",\"--skin__alt_neutral_2\":\"#FFB4A9\",\"--skin__alt_neutral_2__toRgbString\":\"255,180,169\",\"--skin__alt_primary\":\"#FFE34F\",\"--skin__alt_primary__toRgbString\":\"255,227,79\",\"--skin__alt_text_primary\":\"#AB4A39\",\"--skin__alt_text_primary__toRgbString\":\"171,74,57\",\"--skin__bg_1\":\"#D57564\",\"--skin__bg_1__toRgbString\":\"213,117,100\",\"--skin__bg_2\":\"#AB4A39\",\"--skin__bg_2__toRgbString\":\"171,74,57\",\"--skin__border\":\"#E38979\",\"--skin__border__toRgbString\":\"227,137,121\",\"--skin__bs_topnav_bg\":\"#AB4A39\",\"--skin__bs_topnav_bg__toRgbString\":\"171,74,57\",\"--skin__bs_zc_an1\":\"#CA6251\",\"--skin__bs_zc_an1__toRgbString\":\"202,98,81\",\"--skin__bs_zc_bg\":\"#BC5847\",\"--skin__bs_zc_bg__toRgbString\":\"188,88,71\",\"--skin__btmnav_active\":\"#FFE34F\",\"--skin__btmnav_active__toRgbString\":\"255,227,79\",\"--skin__btmnav_def\":\"#FFB4A9\",\"--skin__btmnav_def__toRgbString\":\"255,180,169\",\"--skin__ddt_bg\":\"#BF5846\",\"--skin__ddt_bg__toRgbString\":\"191,88,70\",\"--skin__ddt_icon\":\"#D16E5E\",\"--skin__ddt_icon__toRgbString\":\"209,110,94\",\"--skin__filter_active\":\"#FFE34F\",\"--skin__filter_active__toRgbString\":\"255,227,79\",\"--skin__filter_bg\":\"#D57564\",\"--skin__filter_bg__toRgbString\":\"213,117,100\",\"--skin__home_bg\":\"#AB4A39\",\"--skin__home_bg__toRgbString\":\"171,74,57\",\"--skin__icon_1\":\"#FFE34F\",\"--skin__icon_1__toRgbString\":\"255,227,79\",\"--skin__icon_tg_q\":\"#FFDDD8\",\"--skin__icon_tg_q__toRgbString\":\"255,221,216\",\"--skin__icon_tg_z\":\"#FFDDD8\",\"--skin__icon_tg_z__toRgbString\":\"255,221,216\",\"--skin__jackpot_text\":\"#FFFFFF\",\"--skin__jackpot_text__toRgbString\":\"255,255,255\",\"--skin__jdd_vip_bjc\":\"#FFAA09\",\"--skin__jdd_vip_bjc__toRgbString\":\"255,170,9\",\"--skin__kb_bg\":\"#E38979\",\"--skin__kb_bg__toRgbString\":\"227,137,121\",\"--skin__label_accent3\":\"#FFAA09\",\"--skin__label_accent3__toRgbString\":\"255,170,9\",\"--skin__labeltext_accent3\":\"#FFFFFF\",\"--skin__labeltext_accent3__toRgbString\":\"255,255,255\",\"--skin__lead\":\"#FFFFFF\",\"--skin__lead__toRgbString\":\"255,255,255\",\"--skin__leftnav_active\":\"#AB4A39\",\"--skin__leftnav_active__toRgbString\":\"171,74,57\",\"--skin__leftnav_def\":\"#FFDDD8\",\"--skin__leftnav_def__toRgbString\":\"255,221,216\",\"--skin__neutral_1\":\"#FFDDD8\",\"--skin__neutral_1__toRgbString\":\"255,221,216\",\"--skin__neutral_2\":\"#FFB4A9\",\"--skin__neutral_2__toRgbString\":\"255,180,169\",\"--skin__neutral_3\":\"#FFB4A9\",\"--skin__neutral_3__toRgbString\":\"255,180,169\",\"--skin__primary\":\"#FFE34F\",\"--skin__primary__toRgbString\":\"255,227,79\",\"--skin__profile_icon_1\":\"#FFE34F\",\"--skin__profile_icon_1__toRgbString\":\"255,227,79\",\"--skin__profile_icon_2\":\"#FFE34F\",\"--skin__profile_icon_2__toRgbString\":\"255,227,79\",\"--skin__profile_icon_3\":\"#FFE34F\",\"--skin__profile_icon_3__toRgbString\":\"255,227,79\",\"--skin__profile_icon_4\":\"#FFE34F\",\"--skin__profile_icon_4__toRgbString\":\"255,227,79\",\"--skin__profile_toptext\":\"#FFFFFF\",\"--skin__profile_toptext__toRgbString\":\"255,255,255\",\"--skin__search_icon\":\"#FFDDD8\",\"--skin__search_icon__toRgbString\":\"255,221,216\",\"--skin__table_bg\":\"#AB4A39\",\"--skin__table_bg__toRgbString\":\"171,74,57\",\"--skin__text_accent3\":\"#FFFFFF\",\"--skin__text_accent3__toRgbString\":\"255,255,255\",\"--skin__text_primary\":\"#AB4A39\",\"--skin__text_primary__toRgbString\":\"171,74,57\",\"--skin__web_bs_yj_bg\":\"#AB4A39\",\"--skin__web_bs_yj_bg__toRgbString\":\"171,74,57\",\"--skin__web_bs_zc_an2\":\"#D46F5E\",\"--skin__web_bs_zc_an2__toRgbString\":\"212,111,94\",\"--skin__web_btmnav_db\":\"#AF5040\",\"--skin__web_btmnav_db__toRgbString\":\"175,80,64\",\"--skin__web_filter_gou\":\"#AB4A39\",\"--skin__web_filter_gou__toRgbString\":\"171,74,57\",\"--skin__web_left_bg_q\":\"#FFFFFF0A\",\"--skin__web_left_bg_shadow\":\"#0000001F\",\"--skin__web_left_bg_shadow_active\":\"#0000001F\",\"--skin__web_left_bg_z\":\"#FFFFFF0D\",\"--skin__web_load_zz\":\"#E3897966\",\"--skin__web_plat_line\":\"#E38979\",\"--skin__web_plat_line__toRgbString\":\"227,137,121\",\"--skin__web_topbg_1\":\"#E58C7C\",\"--skin__web_topbg_1__toRgbString\":\"229,140,124\",\"--skin__web_topbg_3\":\"#B95747\"}','../skin/lobby_asset/2-1-22/Captura de tela 2025-05-25 201945.png',0,'https://hfsahfsa.dronespgpay.com/siteadmin/skin/lobby_asset/2-1-42'),
(35,'CacaoPG','{\"--skin__ID\":\"2-14\",\"--skin__accent_1\":\"#34D713\",\"--skin__accent_1__toRgbString\":\"52,215,19\",\"--skin__accent_2\":\"#EA4E3D\",\"--skin__accent_2__toRgbString\":\"234,78,61\",\"--skin__accent_3\":\"#FFAA09\",\"--skin__accent_3__toRgbString\":\"255,170,9\",\"--skin__alt_border\":\"#E8C182\",\"--skin__alt_border__toRgbString\":\"232,193,130\",\"--skin__alt_lead\":\"#FFFFFF\",\"--skin__alt_lead__toRgbString\":\"255,255,255\",\"--skin__alt_neutral_1\":\"#E8C182\",\"--skin__alt_neutral_1__toRgbString\":\"232,193,130\",\"--skin__alt_neutral_2\":\"#C19D63\",\"--skin__alt_neutral_2__toRgbString\":\"193,157,99\",\"--skin__alt_primary\":\"#FFE4B4\",\"--skin__alt_primary__toRgbString\":\"255,228,180\",\"--skin__alt_text_primary\":\"#63482C\",\"--skin__alt_text_primary__toRgbString\":\"99,72,44\",\"--skin__bg_1\":\"#8A6843\",\"--skin__bg_1__toRgbString\":\"138,104,67\",\"--skin__bg_2\":\"#63482C\",\"--skin__bg_2__toRgbString\":\"99,72,44\",\"--skin__border\":\"#A47E57\",\"--skin__border__toRgbString\":\"164,126,87\",\"--skin__bs_topnav_bg\":\"#63482C\",\"--skin__bs_topnav_bg__toRgbString\":\"99,72,44\",\"--skin__bs_zc_an1\":\"#876541\",\"--skin__bs_zc_an1__toRgbString\":\"135,101,65\",\"--skin__bs_zc_bg\":\"#755634\",\"--skin__bs_zc_bg__toRgbString\":\"117,86,52\",\"--skin__btmnav_active\":\"#FFE4B4\",\"--skin__btmnav_active__toRgbString\":\"255,228,180\",\"--skin__btmnav_def\":\"#C19D63\",\"--skin__btmnav_def__toRgbString\":\"193,157,99\",\"--skin__btn_color_1\":\"#FFE4B4\",\"--skin__btn_color_1__toRgbString\":\"255,228,180\",\"--skin__btn_color_2\":\"#FFE4B4\",\"--skin__btn_color_2__toRgbString\":\"255,228,180\",\"--skin__cards_text\":\"#E8C182\",\"--skin__cards_text__toRgbString\":\"232,193,130\",\"--skin__ddt_bg\":\"#6D4F30\",\"--skin__ddt_bg__toRgbString\":\"109,79,48\",\"--skin__ddt_icon\":\"#805D38\",\"--skin__ddt_icon__toRgbString\":\"128,93,56\",\"--skin__filter_active\":\"#FFE4B4\",\"--skin__filter_active__toRgbString\":\"255,228,180\",\"--skin__filter_bg\":\"#8A6843\",\"--skin__filter_bg__toRgbString\":\"138,104,67\",\"--skin__home_bg\":\"#63482C\",\"--skin__home_bg__toRgbString\":\"99,72,44\",\"--skin__icon_1\":\"#FFE4B4\",\"--skin__icon_1__toRgbString\":\"255,228,180\",\"--skin__icon_tg_q\":\"#E8C182\",\"--skin__icon_tg_q__toRgbString\":\"232,193,130\",\"--skin__icon_tg_z\":\"#E8C182\",\"--skin__icon_tg_z__toRgbString\":\"232,193,130\",\"--skin__jackpot_text\":\"#FFFFFF\",\"--skin__jackpot_text__toRgbString\":\"255,255,255\",\"--skin__jdd_vip_bjc\":\"#FFAA09\",\"--skin__jdd_vip_bjc__toRgbString\":\"255,170,9\",\"--skin__kb_bg\":\"#A47E57\",\"--skin__kb_bg__toRgbString\":\"164,126,87\",\"--skin__label_accent3\":\"#FFAA09\",\"--skin__label_accent3__toRgbString\":\"255,170,9\",\"--skin__labeltext_accent3\":\"#FFFFFF\",\"--skin__labeltext_accent3__toRgbString\":\"255,255,255\",\"--skin__lead\":\"#FFFFFF\",\"--skin__lead__toRgbString\":\"255,255,255\",\"--skin__leftnav_active\":\"#63482C\",\"--skin__leftnav_active__toRgbString\":\"99,72,44\",\"--skin__leftnav_def\":\"#E8C182\",\"--skin__leftnav_def__toRgbString\":\"232,193,130\",\"--skin__neutral_1\":\"#E8C182\",\"--skin__neutral_1__toRgbString\":\"232,193,130\",\"--skin__neutral_2\":\"#C19D63\",\"--skin__neutral_2__toRgbString\":\"193,157,99\",\"--skin__neutral_3\":\"#C19D63\",\"--skin__neutral_3__toRgbString\":\"193,157,99\",\"--skin__primary\":\"#FFE4B4\",\"--skin__primary__toRgbString\":\"255,228,180\",\"--skin__profile_icon_1\":\"#FFE4B4\",\"--skin__profile_icon_1__toRgbString\":\"255,228,180\",\"--skin__profile_icon_2\":\"#FFE4B4\",\"--skin__profile_icon_2__toRgbString\":\"255,228,180\",\"--skin__profile_icon_3\":\"#FFE4B4\",\"--skin__profile_icon_3__toRgbString\":\"255,228,180\",\"--skin__profile_icon_4\":\"#FFE4B4\",\"--skin__profile_icon_4__toRgbString\":\"255,228,180\",\"--skin__profile_toptext\":\"#FFFFFF\",\"--skin__profile_toptext__toRgbString\":\"255,255,255\",\"--skin__search_icon\":\"#E8C182\",\"--skin__search_icon__toRgbString\":\"232,193,130\",\"--skin__table_bg\":\"#63482C\",\"--skin__table_bg__toRgbString\":\"99,72,44\",\"--skin__text_accent3\":\"#FFFFFF\",\"--skin__text_accent3__toRgbString\":\"255,255,255\",\"--skin__text_primary\":\"#63482C\",\"--skin__text_primary__toRgbString\":\"99,72,44\",\"--skin__tg_accent_1\":\"#BBDFC1\",\"--skin__tg_accent_1__toRgbString\":\"187,223,193\",\"--skin__tg_accent_3\":\"#FFE7B8\",\"--skin__tg_accent_3__toRgbString\":\"255,231,184\",\"--skin__tg_primary\":\"#F5EEE1\",\"--skin__tg_primary__toRgbString\":\"245,238,225\",\"--skin__web_bs_yj_bg\":\"#63482C\",\"--skin__web_bs_yj_bg__toRgbString\":\"99,72,44\",\"--skin__web_bs_zc_an2\":\"#947049\",\"--skin__web_bs_zc_an2__toRgbString\":\"148,112,73\",\"--skin__web_btmnav_db\":\"#705233\",\"--skin__web_btmnav_db__toRgbString\":\"112,82,51\",\"--skin__web_filter_gou\":\"#63482C\",\"--skin__web_filter_gou__toRgbString\":\"99,72,44\",\"--skin__web_left_bg_q\":\"#FFFFFF0A\",\"--skin__web_left_bg_shadow\":\"#0000001F\",\"--skin__web_left_bg_shadow_active\":\"#0000001F\",\"--skin__web_left_bg_z\":\"#FFFFFF0D\",\"--skin__web_load_zz\":\"#A47E5766\",\"--skin__web_plat_line\":\"#A47E57\",\"--skin__web_plat_line__toRgbString\":\"164,126,87\",\"--skin__web_topbg_1\":\"#EECB8E\",\"--skin__web_topbg_1__toRgbString\":\"238,203,142\",\"--skin__web_topbg_3\":\"#CEA661\"}','../skin/lobby_asset/2-1-22/{2E0B8B12-7694-4F3A-90F9-AB9CB7E23DC5}.png',0,'https://sags.cacaopg.com/siteadmin/skin/lobby_asset/common/'),
(36,'LionsPG','{\"--skin__ID\":\"2-18\",\"--skin__accent_1\":\"#086401\",\"--skin__accent_1__toRgbString\":\"8,100,1\",\"--skin__accent_2\":\"#F61616\",\"--skin__accent_2__toRgbString\":\"246,22,22\",\"--skin__accent_3\":\"#FFF600\",\"--skin__accent_3__toRgbString\":\"255,246,0\",\"--skin__alt_border\":\"#C5FAFF\",\"--skin__alt_border__toRgbString\":\"197,250,255\",\"--skin__alt_lead\":\"#FFFFFF\",\"--skin__alt_lead__toRgbString\":\"255,255,255\",\"--skin__alt_neutral_1\":\"#C5FAFF\",\"--skin__alt_neutral_1__toRgbString\":\"197,250,255\",\"--skin__alt_neutral_2\":\"#9DE0E6\",\"--skin__alt_neutral_2__toRgbString\":\"157,224,230\",\"--skin__alt_primary\":\"#FFF0BB\",\"--skin__alt_primary__toRgbString\":\"255,240,187\",\"--skin__alt_text_primary\":\"#00A3C6\",\"--skin__alt_text_primary__toRgbString\":\"0,163,198\",\"--skin__bg_1\":\"#62C3DF\",\"--skin__bg_1__toRgbString\":\"98,195,223\",\"--skin__bg_2\":\"#00A3C6\",\"--skin__bg_2__toRgbString\":\"0,163,198\",\"--skin__border\":\"#0BB5D9\",\"--skin__border__toRgbString\":\"11,181,217\",\"--skin__bs_topnav_bg\":\"#0090AF\",\"--skin__bs_topnav_bg__toRgbString\":\"0,144,175\",\"--skin__bs_zc_an1\":\"#12B0D2\",\"--skin__bs_zc_an1__toRgbString\":\"18,176,210\",\"--skin__bs_zc_bg\":\"#00A3C6\",\"--skin__bs_zc_bg__toRgbString\":\"0,163,198\",\"--skin__btmnav_active\":\"#FFF0BB\",\"--skin__btmnav_active__toRgbString\":\"255,240,187\",\"--skin__btmnav_def\":\"#9DE0E6\",\"--skin__btmnav_def__toRgbString\":\"157,224,230\",\"--skin__btn_color_1\":\"#FFF0BB\",\"--skin__btn_color_1__toRgbString\":\"255,240,187\",\"--skin__btn_color_2\":\"#FFF0BB\",\"--skin__btn_color_2__toRgbString\":\"255,240,187\",\"--skin__cards_text\":\"#C5FAFF\",\"--skin__cards_text__toRgbString\":\"197,250,255\",\"--skin__ddt_bg\":\"#12B0D2\",\"--skin__ddt_bg__toRgbString\":\"18,176,210\",\"--skin__ddt_icon\":\"#4AC8E3\",\"--skin__ddt_icon__toRgbString\":\"74,200,227\",\"--skin__filter_active\":\"#FFF0BB\",\"--skin__filter_active__toRgbString\":\"255,240,187\",\"--skin__filter_bg\":\"#62C3DF\",\"--skin__filter_bg__toRgbString\":\"98,195,223\",\"--skin__home_bg\":\"#00A3C6\",\"--skin__home_bg__toRgbString\":\"0,163,198\",\"--skin__icon_1\":\"#FFF0BB\",\"--skin__icon_1__toRgbString\":\"255,240,187\",\"--skin__icon_tg_q\":\"#C5FAFF\",\"--skin__icon_tg_q__toRgbString\":\"197,250,255\",\"--skin__icon_tg_z\":\"#C5FAFF\",\"--skin__icon_tg_z__toRgbString\":\"197,250,255\",\"--skin__jackpot_text\":\"#FFFFFF\",\"--skin__jackpot_text__toRgbString\":\"255,255,255\",\"--skin__jdd_vip_bjc\":\"#FFAA09\",\"--skin__jdd_vip_bjc__toRgbString\":\"255,170,9\",\"--skin__kb_bg\":\"#0BB5D9\",\"--skin__kb_bg__toRgbString\":\"11,181,217\",\"--skin__label_accent3\":\"#FFAA09\",\"--skin__label_accent3__toRgbString\":\"255,170,9\",\"--skin__labeltext_accent3\":\"#212121\",\"--skin__labeltext_accent3__toRgbString\":\"33,33,33\",\"--skin__lead\":\"#FFFFFF\",\"--skin__lead__toRgbString\":\"255,255,255\",\"--skin__leftnav_active\":\"#00A3C6\",\"--skin__leftnav_active__toRgbString\":\"0,163,198\",\"--skin__leftnav_def\":\"#C5FAFF\",\"--skin__leftnav_def__toRgbString\":\"197,250,255\",\"--skin__neutral_1\":\"#C5FAFF\",\"--skin__neutral_1__toRgbString\":\"197,250,255\",\"--skin__neutral_2\":\"#9DE0E6\",\"--skin__neutral_2__toRgbString\":\"157,224,230\",\"--skin__neutral_3\":\"#9DE0E6\",\"--skin__neutral_3__toRgbString\":\"157,224,230\",\"--skin__primary\":\"#FFF0BB\",\"--skin__primary__toRgbString\":\"255,240,187\",\"--skin__profile_icon_1\":\"#FFF0BB\",\"--skin__profile_icon_1__toRgbString\":\"255,240,187\",\"--skin__profile_icon_2\":\"#FFF0BB\",\"--skin__profile_icon_2__toRgbString\":\"255,240,187\",\"--skin__profile_icon_3\":\"#FFF0BB\",\"--skin__profile_icon_3__toRgbString\":\"255,240,187\",\"--skin__profile_icon_4\":\"#FFF0BB\",\"--skin__profile_icon_4__toRgbString\":\"255,240,187\",\"--skin__profile_toptext\":\"#FFFFFF\",\"--skin__profile_toptext__toRgbString\":\"255,255,255\",\"--skin__search_icon\":\"#C5FAFF\",\"--skin__search_icon__toRgbString\":\"197,250,255\",\"--skin__table_bg\":\"#00A3C6\",\"--skin__table_bg__toRgbString\":\"0,163,198\",\"--skin__text_accent3\":\"#212121\",\"--skin__text_accent3__toRgbString\":\"33,33,33\",\"--skin__text_primary\":\"#00A3C6\",\"--skin__text_primary__toRgbString\":\"0,163,198\",\"--skin__tg_accent_1\":\"#BBDFC1\",\"--skin__tg_accent_1__toRgbString\":\"187,223,193\",\"--skin__tg_accent_3\":\"#FFE7B8\",\"--skin__tg_accent_3__toRgbString\":\"255,231,184\",\"--skin__tg_primary\":\"#F2F7EF\",\"--skin__tg_primary__toRgbString\":\"242,247,239\",\"--skin__web_bs_yj_bg\":\"#0090AF\",\"--skin__web_bs_yj_bg__toRgbString\":\"0,144,175\",\"--skin__web_bs_zc_an2\":\"#15B5D8\",\"--skin__web_bs_zc_an2__toRgbString\":\"21,181,216\",\"--skin__web_btmnav_db\":\"#0090AF\",\"--skin__web_btmnav_db__toRgbString\":\"0,144,175\",\"--skin__web_filter_gou\":\"#00A3C6\",\"--skin__web_filter_gou__toRgbString\":\"0,163,198\",\"--skin__web_left_bg_q\":\"#FFFFFF0A\",\"--skin__web_left_bg_shadow\":\"#0000001F\",\"--skin__web_left_bg_shadow_active\":\"#0000001F\",\"--skin__web_left_bg_z\":\"#FFFFFF0D\",\"--skin__web_load_zz\":\"#0BB5D966\",\"--skin__web_plat_line\":\"#0BB5D966\",\"--skin__web_topbg_1\":\"#03B9E1\",\"--skin__web_topbg_1__toRgbString\":\"3,185,225\",\"--skin__web_topbg_3\":\"#05A9CC\"}','../skin/lobby_asset/2-1-22/{07A2C728-7157-4968-B498-DDDDE5BBE9E6}.png',0,'https://dgsdag.lionspgpay.com/siteadmin/skin/lobby_asset/common/'),
(37,'FilletPG','{\"--skin__ID\":\"2-20\",\"--skin__accent_1\":\"#20F511\",\"--skin__accent_1__toRgbString\":\"32,245,17\",\"--skin__accent_2\":\"#AF1301\",\"--skin__accent_2__toRgbString\":\"175,19,1\",\"--skin__accent_3\":\"#FFAA09\",\"--skin__accent_3__toRgbString\":\"255,170,9\",\"--skin__alt_border\":\"#D9FFE7\",\"--skin__alt_border__toRgbString\":\"217,255,231\",\"--skin__alt_lead\":\"#FFFFFF\",\"--skin__alt_lead__toRgbString\":\"255,255,255\",\"--skin__alt_neutral_1\":\"#D9FFE7\",\"--skin__alt_neutral_1__toRgbString\":\"217,255,231\",\"--skin__alt_neutral_2\":\"#A0D3B2\",\"--skin__alt_neutral_2__toRgbString\":\"160,211,178\",\"--skin__alt_primary\":\"#F4E7CB\",\"--skin__alt_primary__toRgbString\":\"244,231,203\",\"--skin__alt_text_primary\":\"#52775F\",\"--skin__alt_text_primary__toRgbString\":\"82,119,95\",\"--skin__bg_1\":\"#769882\",\"--skin__bg_1__toRgbString\":\"118,152,130\",\"--skin__bg_2\":\"#5B7E68\",\"--skin__bg_2__toRgbString\":\"91,126,104\",\"--skin__border\":\"#8FAE99\",\"--skin__border__toRgbString\":\"143,174,153\",\"--skin__bs_topnav_bg\":\"#52775F\",\"--skin__bs_topnav_bg__toRgbString\":\"82,119,95\",\"--skin__bs_zc_an1\":\"#709A80\",\"--skin__bs_zc_an1__toRgbString\":\"112,154,128\",\"--skin__bs_zc_bg\":\"#648872\",\"--skin__bs_zc_bg__toRgbString\":\"100,136,114\",\"--skin__btmnav_active\":\"#F4E7CB\",\"--skin__btmnav_active__toRgbString\":\"244,231,203\",\"--skin__btmnav_def\":\"#A0D3B2\",\"--skin__btmnav_def__toRgbString\":\"160,211,178\",\"--skin__btn_color_1\":\"#F4E7CB\",\"--skin__btn_color_1__toRgbString\":\"244,231,203\",\"--skin__btn_color_2\":\"#F4E7CB\",\"--skin__btn_color_2__toRgbString\":\"244,231,203\",\"--skin__cards_text\":\"#D9FFE7\",\"--skin__cards_text__toRgbString\":\"217,255,231\",\"--skin__ddt_bg\":\"#668D75\",\"--skin__ddt_bg__toRgbString\":\"102,141,117\",\"--skin__ddt_icon\":\"#739B83\",\"--skin__ddt_icon__toRgbString\":\"115,155,131\",\"--skin__filter_active\":\"#F4E7CB\",\"--skin__filter_active__toRgbString\":\"244,231,203\",\"--skin__filter_bg\":\"#769882\",\"--skin__filter_bg__toRgbString\":\"118,152,130\",\"--skin__home_bg\":\"#5B7E68\",\"--skin__home_bg__toRgbString\":\"91,126,104\",\"--skin__icon_1\":\"#F4E7CB\",\"--skin__icon_1__toRgbString\":\"244,231,203\",\"--skin__icon_tg_q\":\"#D9FFE7\",\"--skin__icon_tg_q__toRgbString\":\"217,255,231\",\"--skin__icon_tg_z\":\"#D9FFE7\",\"--skin__icon_tg_z__toRgbString\":\"217,255,231\",\"--skin__jackpot_text\":\"#FFFFFF\",\"--skin__jackpot_text__toRgbString\":\"255,255,255\",\"--skin__jdd_vip_bjc\":\"#FFAA09\",\"--skin__jdd_vip_bjc__toRgbString\":\"255,170,9\",\"--skin__kb_bg\":\"#8FAE99\",\"--skin__kb_bg__toRgbString\":\"143,174,153\",\"--skin__label_accent3\":\"#FFAA09\",\"--skin__label_accent3__toRgbString\":\"255,170,9\",\"--skin__labeltext_accent3\":\"#FFFFFF\",\"--skin__labeltext_accent3__toRgbString\":\"255,255,255\",\"--skin__lead\":\"#FFFFFF\",\"--skin__lead__toRgbString\":\"255,255,255\",\"--skin__leftnav_active\":\"#52775F\",\"--skin__leftnav_active__toRgbString\":\"82,119,95\",\"--skin__leftnav_def\":\"#D9FFE7\",\"--skin__leftnav_def__toRgbString\":\"217,255,231\",\"--skin__neutral_1\":\"#D9FFE7\",\"--skin__neutral_1__toRgbString\":\"217,255,231\",\"--skin__neutral_2\":\"#A0D3B2\",\"--skin__neutral_2__toRgbString\":\"160,211,178\",\"--skin__neutral_3\":\"#A0D3B2\",\"--skin__neutral_3__toRgbString\":\"160,211,178\",\"--skin__primary\":\"#F4E7CB\",\"--skin__primary__toRgbString\":\"244,231,203\",\"--skin__profile_icon_1\":\"#F4E7CB\",\"--skin__profile_icon_1__toRgbString\":\"244,231,203\",\"--skin__profile_icon_2\":\"#F4E7CB\",\"--skin__profile_icon_2__toRgbString\":\"244,231,203\",\"--skin__profile_icon_3\":\"#F4E7CB\",\"--skin__profile_icon_3__toRgbString\":\"244,231,203\",\"--skin__profile_icon_4\":\"#F4E7CB\",\"--skin__profile_icon_4__toRgbString\":\"244,231,203\",\"--skin__profile_toptext\":\"#FFFFFF\",\"--skin__profile_toptext__toRgbString\":\"255,255,255\",\"--skin__search_icon\":\"#D9FFE7\",\"--skin__search_icon__toRgbString\":\"217,255,231\",\"--skin__table_bg\":\"#5B7E68\",\"--skin__table_bg__toRgbString\":\"91,126,104\",\"--skin__text_accent3\":\"#FFFFFF\",\"--skin__text_accent3__toRgbString\":\"255,255,255\",\"--skin__text_primary\":\"#52775F\",\"--skin__text_primary__toRgbString\":\"82,119,95\",\"--skin__tg_accent_1\":\"#BBDFC1\",\"--skin__tg_accent_1__toRgbString\":\"187,223,193\",\"--skin__tg_accent_3\":\"#FFE7B8\",\"--skin__tg_accent_3__toRgbString\":\"255,231,184\",\"--skin__tg_primary\":\"#F2F1EB\",\"--skin__tg_primary__toRgbString\":\"242,241,235\",\"--skin__web_bs_yj_bg\":\"#52775F\",\"--skin__web_bs_yj_bg__toRgbString\":\"82,119,95\",\"--skin__web_bs_zc_an2\":\"#82AD92\",\"--skin__web_bs_zc_an2__toRgbString\":\"130,173,146\",\"--skin__web_btmnav_db\":\"#60826D\",\"--skin__web_btmnav_db__toRgbString\":\"96,130,109\",\"--skin__web_filter_gou\":\"#52775F\",\"--skin__web_filter_gou__toRgbString\":\"82,119,95\",\"--skin__web_left_bg_q\":\"#FFFFFF0A\",\"--skin__web_left_bg_shadow\":\"#0000001F\",\"--skin__web_left_bg_shadow_active\":\"#0000001F\",\"--skin__web_left_bg_z\":\"#FFFFFF0D\",\"--skin__web_load_zz\":\"#8FAE9966\",\"--skin__web_plat_line\":\"#8FAE99\",\"--skin__web_plat_line__toRgbString\":\"143,174,153\",\"--skin__web_topbg_1\":\"#6A8E74\",\"--skin__web_topbg_1__toRgbString\":\"106,142,116\",\"--skin__web_topbg_3\":\"#537A61\"}','../skin/lobby_asset/2-1-22/{BB92748D-1F0D-4201-B766-1AB8823BA057}.png',0,'https://dfsh.w1-filletpg.com/siteadmin/skin/lobby_asset/2-1-20/common/'),
(39,'777Pará','{\"--skin__ID\":\"2-11\",\"--skin__accent_1\":\"#04BE02\",\"--skin__accent_1__toRgbString\":\"4,190,2\",\"--skin__accent_2\":\"#FF2B1C\",\"--skin__accent_2__toRgbString\":\"255,43,28\",\"--skin__accent_3\":\"#FFB92E\",\"--skin__accent_3__toRgbString\":\"255,185,46\",\"--skin__alt_border\":\"#FFC1D0\",\"--skin__alt_border__toRgbString\":\"255,193,208\",\"--skin__alt_lead\":\"#FFFFFF\",\"--skin__alt_lead__toRgbString\":\"255,255,255\",\"--skin__alt_neutral_1\":\"#FFC1D0\",\"--skin__alt_neutral_1__toRgbString\":\"255,193,208\",\"--skin__alt_neutral_2\":\"#E2889F\",\"--skin__alt_neutral_2__toRgbString\":\"226,136,159\",\"--skin__alt_primary\":\"#FF3A55\",\"--skin__alt_primary__toRgbString\":\"255,58,85\",\"--skin__alt_text_primary\":\"#FFFFFF\",\"--skin__alt_text_primary__toRgbString\":\"255,255,255\",\"--skin__bg_1\":\"#781931\",\"--skin__bg_1__toRgbString\":\"120,25,49\",\"--skin__bg_2\":\"#600A1E\",\"--skin__bg_2__toRgbString\":\"96,10,30\",\"--skin__border\":\"#8F273F\",\"--skin__border__toRgbString\":\"143,39,63\",\"--skin__bs_topnav_bg\":\"#600A1E\",\"--skin__bs_topnav_bg__toRgbString\":\"96,10,30\",\"--skin__bs_zc_an1\":\"#78182F\",\"--skin__bs_zc_an1__toRgbString\":\"120,24,47\",\"--skin__bs_zc_bg\":\"#640C21\",\"--skin__bs_zc_bg__toRgbString\":\"100,12,33\",\"--skin__btmnav_active\":\"#FF3A55\",\"--skin__btmnav_active__toRgbString\":\"255,58,85\",\"--skin__btmnav_def\":\"#E2889F\",\"--skin__btmnav_def__toRgbString\":\"226,136,159\",\"--skin__btn_color_1\":\"#FF3A55\",\"--skin__btn_color_1__toRgbString\":\"255,58,85\",\"--skin__btn_color_2\":\"#FF3A55\",\"--skin__btn_color_2__toRgbString\":\"255,58,85\",\"--skin__cards_text\":\"#FFC1D0\",\"--skin__cards_text__toRgbString\":\"255,193,208\",\"--skin__ddt_bg\":\"#7A182F\",\"--skin__ddt_bg__toRgbString\":\"122,24,47\",\"--skin__ddt_icon\":\"#8A253D\",\"--skin__ddt_icon__toRgbString\":\"138,37,61\",\"--skin__filter_active\":\"#FF3A55\",\"--skin__filter_active__toRgbString\":\"255,58,85\",\"--skin__filter_bg\":\"#781931\",\"--skin__filter_bg__toRgbString\":\"120,25,49\",\"--skin__home_bg\":\"#781931\",\"--skin__home_bg__toRgbString\":\"120,25,49\",\"--skin__icon_1\":\"#FF3A55\",\"--skin__icon_1__toRgbString\":\"255,58,85\",\"--skin__icon_tg_q\":\"#FFC1D0\",\"--skin__icon_tg_q__toRgbString\":\"255,193,208\",\"--skin__icon_tg_z\":\"#FFC1D0\",\"--skin__icon_tg_z__toRgbString\":\"255,193,208\",\"--skin__jackpot_text\":\"#FFFFFF\",\"--skin__jackpot_text__toRgbString\":\"255,255,255\",\"--skin__jdd_vip_bjc\":\"#FF3A55\",\"--skin__jdd_vip_bjc__toRgbString\":\"255,58,85\",\"--skin__kb_bg\":\"#8F273F\",\"--skin__kb_bg__toRgbString\":\"143,39,63\",\"--skin__label_accent3\":\"#FFAA09\",\"--skin__label_accent3__toRgbString\":\"255,170,9\",\"--skin__labeltext_accent3\":\"#FFFFFF\",\"--skin__labeltext_accent3__toRgbString\":\"255,255,255\",\"--skin__lead\":\"#FFFFFF\",\"--skin__lead__toRgbString\":\"255,255,255\",\"--skin__leftnav_active\":\"#FFFFFF\",\"--skin__leftnav_active__toRgbString\":\"255,255,255\",\"--skin__leftnav_def\":\"#FFC1D0\",\"--skin__leftnav_def__toRgbString\":\"255,193,208\",\"--skin__neutral_1\":\"#FFC1D0\",\"--skin__neutral_1__toRgbString\":\"255,193,208\",\"--skin__neutral_2\":\"#E2889F\",\"--skin__neutral_2__toRgbString\":\"226,136,159\",\"--skin__neutral_3\":\"#E2889F\",\"--skin__neutral_3__toRgbString\":\"226,136,159\",\"--skin__primary\":\"#FF3A55\",\"--skin__primary__toRgbString\":\"255,58,85\",\"--skin__profile_icon_1\":\"#FF3A55\",\"--skin__profile_icon_1__toRgbString\":\"255,58,85\",\"--skin__profile_icon_2\":\"#FF3A55\",\"--skin__profile_icon_2__toRgbString\":\"255,58,85\",\"--skin__profile_icon_3\":\"#FF3A55\",\"--skin__profile_icon_3__toRgbString\":\"255,58,85\",\"--skin__profile_icon_4\":\"#FF3A55\",\"--skin__profile_icon_4__toRgbString\":\"255,58,85\",\"--skin__profile_toptext\":\"#FFFFFF\",\"--skin__profile_toptext__toRgbString\":\"255,255,255\",\"--skin__search_icon\":\"#FFC1D0\",\"--skin__search_icon__toRgbString\":\"255,193,208\",\"--skin__table_bg\":\"#600A1E\",\"--skin__table_bg__toRgbString\":\"96,10,30\",\"--skin__text_accent3\":\"#FFFFFF\",\"--skin__text_accent3__toRgbString\":\"255,255,255\",\"--skin__text_primary\":\"#FFFFFF\",\"--skin__text_primary__toRgbString\":\"255,255,255\",\"--skin__tg_accent_1\":\"#BBDFC1\",\"--skin__tg_accent_1__toRgbString\":\"187,223,193\",\"--skin__tg_accent_3\":\"#FFE7B8\",\"--skin__tg_accent_3__toRgbString\":\"255,231,184\",\"--skin__tg_primary\":\"#F4C6CC\",\"--skin__tg_primary__toRgbString\":\"244,198,204\",\"--skin__web_bs_yj_bg\":\"#600A1E\",\"--skin__web_bs_yj_bg__toRgbString\":\"96,10,30\",\"--skin__web_bs_zc_an2\":\"#842038\",\"--skin__web_bs_zc_an2__toRgbString\":\"132,32,56\",\"--skin__web_btmnav_db\":\"#640C21\",\"--skin__web_btmnav_db__toRgbString\":\"100,12,33\",\"--skin__web_filter_gou\":\"#FFFFFF\",\"--skin__web_filter_gou__toRgbString\":\"255,255,255\",\"--skin__web_left_bg_q\":\"#FFFFFF0A\",\"--skin__web_left_bg_shadow\":\"#0000001F\",\"--skin__web_left_bg_shadow_active\":\"#0000001F\",\"--skin__web_left_bg_z\":\"#FFFFFF0D\",\"--skin__web_load_zz\":\"#8F273F66\",\"--skin__web_plat_line\":\"#8F273F\",\"--skin__web_plat_line__toRgbString\":\"143,39,63\",\"--skin__web_topbg_1\":\"#FE5E75\",\"--skin__web_topbg_1__toRgbString\":\"254,94,117\",\"--skin__web_topbg_3\":\"#FF3A55\"}','../skin/lobby_asset/2-1-22/{4FECD71D-C41E-4B39-A45D-C8D534690FB2}.png',0,'https://oss.777para.win/siteadmin/skin/lobby_asset/2-1-11/common/'),
(41,'BetWeb','{\"--skin__ID\":\"2-3\",\"--skin__accent_1\":\"#04BE02\",\"--skin__accent_1__toRgbString\":\"4,190,2\",\"--skin__accent_2\":\"#EA4E3D\",\"--skin__accent_2__toRgbString\":\"234,78,61\",\"--skin__accent_3\":\"#FFAA09\",\"--skin__accent_3__toRgbString\":\"255,170,9\",\"--skin__alt_border\":\"#C7C7C7\",\"--skin__alt_border__toRgbString\":\"199,199,199\",\"--skin__alt_lead\":\"#E3E3E3\",\"--skin__alt_lead__toRgbString\":\"227,227,227\",\"--skin__alt_neutral_1\":\"#C7C7C7\",\"--skin__alt_neutral_1__toRgbString\":\"199,199,199\",\"--skin__alt_neutral_2\":\"#777777\",\"--skin__alt_neutral_2__toRgbString\":\"119,119,119\",\"--skin__alt_primary\":\"#FEB705\",\"--skin__alt_primary__toRgbString\":\"254,183,5\",\"--skin__alt_text_primary\":\"#000000\",\"--skin__alt_text_primary__toRgbString\":\"0,0,0\",\"--skin__bg_1\":\"#303030\",\"--skin__bg_1__toRgbString\":\"48,48,48\",\"--skin__bg_2\":\"#1C1C1C\",\"--skin__bg_2__toRgbString\":\"28,28,28\",\"--skin__border\":\"#505050\",\"--skin__border__toRgbString\":\"80,80,80\",\"--skin__bs_topnav_bg\":\"#1C1C1C\",\"--skin__bs_topnav_bg__toRgbString\":\"28,28,28\",\"--skin__bs_zc_an1\":\"#303030\",\"--skin__bs_zc_an1__toRgbString\":\"48,48,48\",\"--skin__bs_zc_bg\":\"#242424\",\"--skin__bs_zc_bg__toRgbString\":\"36,36,36\",\"--skin__btmnav_active\":\"#FEB705\",\"--skin__btmnav_active__toRgbString\":\"254,183,5\",\"--skin__btmnav_def\":\"#777777\",\"--skin__btmnav_def__toRgbString\":\"119,119,119\",\"--skin__btn_color_1\":\"#FEB705\",\"--skin__btn_color_1__toRgbString\":\"254,183,5\",\"--skin__btn_color_2\":\"#FEB705\",\"--skin__btn_color_2__toRgbString\":\"254,183,5\",\"--skin__cards_text\":\"#C7C7C7\",\"--skin__cards_text__toRgbString\":\"199,199,199\",\"--skin__ddt_bg\":\"#2B2B2B\",\"--skin__ddt_bg__toRgbString\":\"43,43,43\",\"--skin__ddt_icon\":\"#3A3A3A\",\"--skin__ddt_icon__toRgbString\":\"58,58,58\",\"--skin__filter_active\":\"#FEB705\",\"--skin__filter_active__toRgbString\":\"254,183,5\",\"--skin__filter_bg\":\"#303030\",\"--skin__filter_bg__toRgbString\":\"48,48,48\",\"--skin__home_bg\":\"#1C1C1C\",\"--skin__home_bg__toRgbString\":\"28,28,28\",\"--skin__icon_1\":\"#FEB705\",\"--skin__icon_1__toRgbString\":\"254,183,5\",\"--skin__icon_tg_q\":\"#C7C7C7\",\"--skin__icon_tg_q__toRgbString\":\"199,199,199\",\"--skin__icon_tg_z\":\"#C7C7C7\",\"--skin__icon_tg_z__toRgbString\":\"199,199,199\",\"--skin__jackpot_text\":\"#FFFFFF\",\"--skin__jackpot_text__toRgbString\":\"255,255,255\",\"--skin__jdd_vip_bjc\":\"#FFAA09\",\"--skin__jdd_vip_bjc__toRgbString\":\"255,170,9\",\"--skin__kb_bg\":\"#303030\",\"--skin__kb_bg__toRgbString\":\"48,48,48\",\"--skin__label_accent3\":\"#FFAA09\",\"--skin__label_accent3__toRgbString\":\"255,170,9\",\"--skin__labeltext_accent3\":\"#FFFFFF\",\"--skin__labeltext_accent3__toRgbString\":\"255,255,255\",\"--skin__lead\":\"#E3E3E3\",\"--skin__lead__toRgbString\":\"227,227,227\",\"--skin__leftnav_active\":\"#000000\",\"--skin__leftnav_active__toRgbString\":\"0,0,0\",\"--skin__leftnav_def\":\"#C7C7C7\",\"--skin__leftnav_def__toRgbString\":\"199,199,199\",\"--skin__neutral_1\":\"#C7C7C7\",\"--skin__neutral_1__toRgbString\":\"199,199,199\",\"--skin__neutral_2\":\"#777777\",\"--skin__neutral_2__toRgbString\":\"119,119,119\",\"--skin__neutral_3\":\"#777777\",\"--skin__neutral_3__toRgbString\":\"119,119,119\",\"--skin__primary\":\"#FEB705\",\"--skin__primary__toRgbString\":\"254,183,5\",\"--skin__profile_icon_1\":\"#FEB705\",\"--skin__profile_icon_1__toRgbString\":\"254,183,5\",\"--skin__profile_icon_2\":\"#FEB705\",\"--skin__profile_icon_2__toRgbString\":\"254,183,5\",\"--skin__profile_icon_3\":\"#FEB705\",\"--skin__profile_icon_3__toRgbString\":\"254,183,5\",\"--skin__profile_icon_4\":\"#FEB705\",\"--skin__profile_icon_4__toRgbString\":\"254,183,5\",\"--skin__profile_toptext\":\"#FFFFFF\",\"--skin__profile_toptext__toRgbString\":\"255,255,255\",\"--skin__search_icon\":\"#C7C7C7\",\"--skin__search_icon__toRgbString\":\"199,199,199\",\"--skin__table_bg\":\"#303030\",\"--skin__table_bg__toRgbString\":\"48,48,48\",\"--skin__text_accent3\":\"#FFFFFF\",\"--skin__text_accent3__toRgbString\":\"255,255,255\",\"--skin__text_primary\":\"#000000\",\"--skin__text_primary__toRgbString\":\"0,0,0\",\"--skin__tg_accent_1\":\"#BBDFC1\",\"--skin__tg_accent_1__toRgbString\":\"187,223,193\",\"--skin__tg_accent_3\":\"#FFE7B8\",\"--skin__tg_accent_3__toRgbString\":\"255,231,184\",\"--skin__tg_primary\":\"#FDF0D1\",\"--skin__tg_primary__toRgbString\":\"253,240,209\",\"--skin__web_bs_yj_bg\":\"#1C1C1C\",\"--skin__web_bs_yj_bg__toRgbString\":\"28,28,28\",\"--skin__web_bs_zc_an2\":\"#3A3A3A\",\"--skin__web_bs_zc_an2__toRgbString\":\"58,58,58\",\"--skin__web_btmnav_db\":\"#242424\",\"--skin__web_btmnav_db__toRgbString\":\"36,36,36\",\"--skin__web_filter_gou\":\"#000000\",\"--skin__web_filter_gou__toRgbString\":\"0,0,0\",\"--skin__web_left_bg_q\":\"#363636\",\"--skin__web_left_bg_q__toRgbString\":\"54,54,54\",\"--skin__web_left_bg_shadow\":\"#0000001F\",\"--skin__web_left_bg_shadow_active\":\"#0000001F\",\"--skin__web_left_bg_z\":\"#1D1D1D\",\"--skin__web_left_bg_z__toRgbString\":\"29,29,29\",\"--skin__web_load_zz\":\"#50505066\",\"--skin__web_plat_line\":\"#303030\",\"--skin__web_plat_line__toRgbString\":\"48,48,48\",\"--skin__web_topbg_1\":\"#F6BE30\",\"--skin__web_topbg_1__toRgbString\":\"246,190,48\",\"--skin__web_topbg_3\":\"#EE9F03\"}','../skin/lobby_asset/2-1-22/{6094781D-36E9-47EA-A615-0E84D2436E09}.png',0,'https://oteb8766.6678bet.win/siteadmin/skin/lobby_asset/2-1-3/common/'),
(42,'BBZZVIP','{\"--skin__ID\":\"2-2\",\"--skin__accent_1\":\"#04BE02\",\"--skin__accent_1__toRgbString\":\"4,190,2\",\"--skin__accent_2\":\"#EF4C44\",\"--skin__accent_2__toRgbString\":\"239,76,68\",\"--skin__accent_3\":\"#FFC320\",\"--skin__accent_3__toRgbString\":\"255,195,32\",\"--skin__alt_border\":\"#A9D7DB\",\"--skin__alt_border__toRgbString\":\"169,215,219\",\"--skin__alt_lead\":\"#FFFFFF\",\"--skin__alt_lead__toRgbString\":\"255,255,255\",\"--skin__alt_neutral_1\":\"#A9D7DB\",\"--skin__alt_neutral_1__toRgbString\":\"169,215,219\",\"--skin__alt_neutral_2\":\"#5D989E\",\"--skin__alt_neutral_2__toRgbString\":\"93,152,158\",\"--skin__alt_primary\":\"#06D0DF\",\"--skin__alt_primary__toRgbString\":\"6,208,223\",\"--skin__alt_text_primary\":\"#054146\",\"--skin__alt_text_primary__toRgbString\":\"5,65,70\",\"--skin__bg_1\":\"#055F67\",\"--skin__bg_1__toRgbString\":\"5,95,103\",\"--skin__bg_2\":\"#054146\",\"--skin__bg_2__toRgbString\":\"5,65,70\",\"--skin__border\":\"#18747E\",\"--skin__border__toRgbString\":\"24,116,126\",\"--skin__bs_topnav_bg\":\"#054146\",\"--skin__bs_topnav_bg__toRgbString\":\"5,65,70\",\"--skin__bs_zc_an1\":\"#035C64\",\"--skin__bs_zc_an1__toRgbString\":\"3,92,100\",\"--skin__bs_zc_bg\":\"#024A50\",\"--skin__bs_zc_bg__toRgbString\":\"2,74,80\",\"--skin__btmnav_active\":\"#06D0DF\",\"--skin__btmnav_active__toRgbString\":\"6,208,223\",\"--skin__btmnav_def\":\"#5D989E\",\"--skin__btmnav_def__toRgbString\":\"93,152,158\",\"--skin__btn_color_1\":\"#06D0DF\",\"--skin__btn_color_1__toRgbString\":\"6,208,223\",\"--skin__btn_color_2\":\"#06D0DF\",\"--skin__btn_color_2__toRgbString\":\"6,208,223\",\"--skin__cards_text\":\"#A9D7DB\",\"--skin__cards_text__toRgbString\":\"169,215,219\",\"--skin__ddt_bg\":\"#065258\",\"--skin__ddt_bg__toRgbString\":\"6,82,88\",\"--skin__ddt_icon\":\"#18747E\",\"--skin__ddt_icon__toRgbString\":\"24,116,126\",\"--skin__filter_active\":\"#06D0DF\",\"--skin__filter_active__toRgbString\":\"6,208,223\",\"--skin__filter_bg\":\"#055F67\",\"--skin__filter_bg__toRgbString\":\"5,95,103\",\"--skin__home_bg\":\"#054146\",\"--skin__home_bg__toRgbString\":\"5,65,70\",\"--skin__icon_1\":\"#06D0DF\",\"--skin__icon_1__toRgbString\":\"6,208,223\",\"--skin__icon_tg_q\":\"#A9D7DB\",\"--skin__icon_tg_q__toRgbString\":\"169,215,219\",\"--skin__icon_tg_z\":\"#A9D7DB\",\"--skin__icon_tg_z__toRgbString\":\"169,215,219\",\"--skin__jackpot_text\":\"#FFFFFF\",\"--skin__jackpot_text__toRgbString\":\"255,255,255\",\"--skin__jdd_vip_bjc\":\"#06D0DF\",\"--skin__jdd_vip_bjc__toRgbString\":\"6,208,223\",\"--skin__kb_bg\":\"#055F67\",\"--skin__kb_bg__toRgbString\":\"5,95,103\",\"--skin__label_accent3\":\"#FFAA09\",\"--skin__label_accent3__toRgbString\":\"255,170,9\",\"--skin__labeltext_accent3\":\"#FFFFFF\",\"--skin__labeltext_accent3__toRgbString\":\"255,255,255\",\"--skin__lead\":\"#FFFFFF\",\"--skin__lead__toRgbString\":\"255,255,255\",\"--skin__leftnav_active\":\"#054146\",\"--skin__leftnav_active__toRgbString\":\"5,65,70\",\"--skin__leftnav_def\":\"#A9D7DB\",\"--skin__leftnav_def__toRgbString\":\"169,215,219\",\"--skin__neutral_1\":\"#A9D7DB\",\"--skin__neutral_1__toRgbString\":\"169,215,219\",\"--skin__neutral_2\":\"#5D989E\",\"--skin__neutral_2__toRgbString\":\"93,152,158\",\"--skin__neutral_3\":\"#5D989E\",\"--skin__neutral_3__toRgbString\":\"93,152,158\",\"--skin__primary\":\"#06D0DF\",\"--skin__primary__toRgbString\":\"6,208,223\",\"--skin__profile_icon_1\":\"#06D0DF\",\"--skin__profile_icon_1__toRgbString\":\"6,208,223\",\"--skin__profile_icon_2\":\"#06D0DF\",\"--skin__profile_icon_2__toRgbString\":\"6,208,223\",\"--skin__profile_icon_3\":\"#06D0DF\",\"--skin__profile_icon_3__toRgbString\":\"6,208,223\",\"--skin__profile_icon_4\":\"#06D0DF\",\"--skin__profile_icon_4__toRgbString\":\"6,208,223\",\"--skin__profile_toptext\":\"#FFFFFF\",\"--skin__profile_toptext__toRgbString\":\"255,255,255\",\"--skin__search_icon\":\"#A9D7DB\",\"--skin__search_icon__toRgbString\":\"169,215,219\",\"--skin__table_bg\":\"#055F67\",\"--skin__table_bg__toRgbString\":\"5,95,103\",\"--skin__text_accent3\":\"#FFFFFF\",\"--skin__text_accent3__toRgbString\":\"255,255,255\",\"--skin__text_primary\":\"#054146\",\"--skin__text_primary__toRgbString\":\"5,65,70\",\"--skin__tg_accent_1\":\"#BBDFC1\",\"--skin__tg_accent_1__toRgbString\":\"187,223,193\",\"--skin__tg_accent_3\":\"#FFE7B8\",\"--skin__tg_accent_3__toRgbString\":\"255,231,184\",\"--skin__tg_primary\":\"#C7E3F3\",\"--skin__tg_primary__toRgbString\":\"199,227,243\",\"--skin__web_bs_yj_bg\":\"#054146\",\"--skin__web_bs_yj_bg__toRgbString\":\"5,65,70\",\"--skin__web_bs_zc_an2\":\"#267982\",\"--skin__web_bs_zc_an2__toRgbString\":\"38,121,130\",\"--skin__web_btmnav_db\":\"#05484E\",\"--skin__web_btmnav_db__toRgbString\":\"5,72,78\",\"--skin__web_filter_gou\":\"#054146\",\"--skin__web_filter_gou__toRgbString\":\"5,65,70\",\"--skin__web_left_bg_q\":\"#07545B\",\"--skin__web_left_bg_q__toRgbString\":\"7,84,91\",\"--skin__web_left_bg_shadow\":\"#0000001F\",\"--skin__web_left_bg_shadow_active\":\"#0000001F\",\"--skin__web_left_bg_z\":\"#054146\",\"--skin__web_left_bg_z__toRgbString\":\"5,65,70\",\"--skin__web_load_zz\":\"#18747E66\",\"--skin__web_plat_line\":\"#1B5257\",\"--skin__web_plat_line__toRgbString\":\"27,82,87\",\"--skin__web_topbg_1\":\"#00C1D0\",\"--skin__web_topbg_1__toRgbString\":\"0,193,208\",\"--skin__web_topbg_3\":\"#00ADC0\"}','../skin/lobby_asset/2-1-22/{8086A4F7-1273-44DA-B3A7-ECE0B5089BC6}.png',0,'https://opivzzbb.bbzzvip.com/siteadmin/skin/lobby_asset/2-1-2/common/'),
(43,'AmaranthPG','{\"--skin__ID\":\"2-17\",\"--skin__accent_1\":\"#04BE02\",\"--skin__accent_1__toRgbString\":\"4,190,2\",\"--skin__accent_2\":\"#FF4A4A\",\"--skin__accent_2__toRgbString\":\"255,74,74\",\"--skin__accent_3\":\"#FFAA09\",\"--skin__accent_3__toRgbString\":\"255,170,9\",\"--skin__alt_border\":\"#A0C5FB\",\"--skin__alt_border__toRgbString\":\"160,197,251\",\"--skin__alt_lead\":\"#FFFFFF\",\"--skin__alt_lead__toRgbString\":\"255,255,255\",\"--skin__alt_neutral_1\":\"#A0C5FB\",\"--skin__alt_neutral_1__toRgbString\":\"160,197,251\",\"--skin__alt_neutral_2\":\"#6FA4EF\",\"--skin__alt_neutral_2__toRgbString\":\"111,164,239\",\"--skin__alt_primary\":\"#FFF0BB\",\"--skin__alt_primary__toRgbString\":\"255,240,187\",\"--skin__alt_text_primary\":\"#05309F\",\"--skin__alt_text_primary__toRgbString\":\"5,48,159\",\"--skin__bg_1\":\"#1A45B1\",\"--skin__bg_1__toRgbString\":\"26,69,177\",\"--skin__bg_2\":\"#05309F\",\"--skin__bg_2__toRgbString\":\"5,48,159\",\"--skin__border\":\"#3A61C2\",\"--skin__border__toRgbString\":\"58,97,194\",\"--skin__bs_topnav_bg\":\"#062064\",\"--skin__bs_topnav_bg__toRgbString\":\"6,32,100\",\"--skin__bs_zc_an1\":\"#3A61C2\",\"--skin__bs_zc_an1__toRgbString\":\"58,97,194\",\"--skin__bs_zc_bg\":\"#05309F\",\"--skin__bs_zc_bg__toRgbString\":\"5,48,159\",\"--skin__btmnav_active\":\"#FFF0BB\",\"--skin__btmnav_active__toRgbString\":\"255,240,187\",\"--skin__btmnav_def\":\"#6FA4EF\",\"--skin__btmnav_def__toRgbString\":\"111,164,239\",\"--skin__btn_color_1\":\"#FFF0BB\",\"--skin__btn_color_1__toRgbString\":\"255,240,187\",\"--skin__btn_color_2\":\"#FFF0BB\",\"--skin__btn_color_2__toRgbString\":\"255,240,187\",\"--skin__cards_text\":\"#A0C5FB\",\"--skin__cards_text__toRgbString\":\"160,197,251\",\"--skin__ddt_bg\":\"#123FB1\",\"--skin__ddt_bg__toRgbString\":\"18,63,177\",\"--skin__ddt_icon\":\"#1E4EC5\",\"--skin__ddt_icon__toRgbString\":\"30,78,197\",\"--skin__filter_active\":\"#FFF0BB\",\"--skin__filter_active__toRgbString\":\"255,240,187\",\"--skin__filter_bg\":\"#1A45B1\",\"--skin__filter_bg__toRgbString\":\"26,69,177\",\"--skin__home_bg\":\"#05309F\",\"--skin__home_bg__toRgbString\":\"5,48,159\",\"--skin__icon_1\":\"#FFF0BB\",\"--skin__icon_1__toRgbString\":\"255,240,187\",\"--skin__icon_tg_q\":\"#A0C5FB\",\"--skin__icon_tg_q__toRgbString\":\"160,197,251\",\"--skin__icon_tg_z\":\"#A0C5FB\",\"--skin__icon_tg_z__toRgbString\":\"160,197,251\",\"--skin__jackpot_text\":\"#FFFFFF\",\"--skin__jackpot_text__toRgbString\":\"255,255,255\",\"--skin__jdd_vip_bjc\":\"#FFAA09\",\"--skin__jdd_vip_bjc__toRgbString\":\"255,170,9\",\"--skin__kb_bg\":\"#3A61C2\",\"--skin__kb_bg__toRgbString\":\"58,97,194\",\"--skin__label_accent3\":\"#FFAA09\",\"--skin__label_accent3__toRgbString\":\"255,170,9\",\"--skin__labeltext_accent3\":\"#FFFFFF\",\"--skin__labeltext_accent3__toRgbString\":\"255,255,255\",\"--skin__lead\":\"#FFFFFF\",\"--skin__lead__toRgbString\":\"255,255,255\",\"--skin__leftnav_active\":\"#05309F\",\"--skin__leftnav_active__toRgbString\":\"5,48,159\",\"--skin__leftnav_def\":\"#A0C5FB\",\"--skin__leftnav_def__toRgbString\":\"160,197,251\",\"--skin__neutral_1\":\"#A0C5FB\",\"--skin__neutral_1__toRgbString\":\"160,197,251\",\"--skin__neutral_2\":\"#6FA4EF\",\"--skin__neutral_2__toRgbString\":\"111,164,239\",\"--skin__neutral_3\":\"#6FA4EF\",\"--skin__neutral_3__toRgbString\":\"111,164,239\",\"--skin__primary\":\"#FFF0BB\",\"--skin__primary__toRgbString\":\"255,240,187\",\"--skin__profile_icon_1\":\"#FFF0BB\",\"--skin__profile_icon_1__toRgbString\":\"255,240,187\",\"--skin__profile_icon_2\":\"#FFF0BB\",\"--skin__profile_icon_2__toRgbString\":\"255,240,187\",\"--skin__profile_icon_3\":\"#FFF0BB\",\"--skin__profile_icon_3__toRgbString\":\"255,240,187\",\"--skin__profile_icon_4\":\"#FFF0BB\",\"--skin__profile_icon_4__toRgbString\":\"255,240,187\",\"--skin__profile_toptext\":\"#FFFFFF\",\"--skin__profile_toptext__toRgbString\":\"255,255,255\",\"--skin__search_icon\":\"#A0C5FB\",\"--skin__search_icon__toRgbString\":\"160,197,251\",\"--skin__table_bg\":\"#05309F\",\"--skin__table_bg__toRgbString\":\"5,48,159\",\"--skin__text_accent3\":\"#FFFFFF\",\"--skin__text_accent3__toRgbString\":\"255,255,255\",\"--skin__text_primary\":\"#05309F\",\"--skin__text_primary__toRgbString\":\"5,48,159\",\"--skin__tg_accent_1\":\"#BBDFC1\",\"--skin__tg_accent_1__toRgbString\":\"187,223,193\",\"--skin__tg_accent_3\":\"#FFE7B8\",\"--skin__tg_accent_3__toRgbString\":\"255,231,184\",\"--skin__tg_primary\":\"#EDEDEB\",\"--skin__tg_primary__toRgbString\":\"237,237,235\",\"--skin__web_bs_yj_bg\":\"#062064\",\"--skin__web_bs_yj_bg__toRgbString\":\"6,32,100\",\"--skin__web_bs_zc_an2\":\"#1B4DC8\",\"--skin__web_bs_zc_an2__toRgbString\":\"27,77,200\",\"--skin__web_btmnav_db\":\"#032B92\",\"--skin__web_btmnav_db__toRgbString\":\"3,43,146\",\"--skin__web_filter_gou\":\"#05309F\",\"--skin__web_filter_gou__toRgbString\":\"5,48,159\",\"--skin__web_left_bg_q\":\"#FFFFFF0A\",\"--skin__web_left_bg_shadow\":\"#0000001F\",\"--skin__web_left_bg_shadow_active\":\"#0000001F\",\"--skin__web_left_bg_z\":\"#FFFFFF0D\",\"--skin__web_load_zz\":\"#3A61C266\",\"--skin__web_plat_line\":\"#3A61C2\",\"--skin__web_plat_line__toRgbString\":\"58,97,194\",\"--skin__web_topbg_1\":\"#0635B2\",\"--skin__web_topbg_1__toRgbString\":\"6,53,178\",\"--skin__web_topbg_3\":\"#032B92\"}','../skin/lobby_asset/2-1-22/{010FDB8B-5CE5-4E2B-BE26-749F2B5AFE23}.png',0,'https://gdsg.amaranthpgpay.com/siteadmin/skin/lobby_asset/2-1-17/common/'),
(44,'FeijaoPG','{\"--skin__ID\":\"2-14\",\"--skin__accent_1\":\"#34D713\",\"--skin__accent_1__toRgbString\":\"52,215,19\",\"--skin__accent_2\":\"#EA4E3D\",\"--skin__accent_2__toRgbString\":\"234,78,61\",\"--skin__accent_3\":\"#FFAA09\",\"--skin__accent_3__toRgbString\":\"255,170,9\",\"--skin__alt_border\":\"#E8C182\",\"--skin__alt_border__toRgbString\":\"232,193,130\",\"--skin__alt_lead\":\"#FFFFFF\",\"--skin__alt_lead__toRgbString\":\"255,255,255\",\"--skin__alt_neutral_1\":\"#E8C182\",\"--skin__alt_neutral_1__toRgbString\":\"232,193,130\",\"--skin__alt_neutral_2\":\"#C19D63\",\"--skin__alt_neutral_2__toRgbString\":\"193,157,99\",\"--skin__alt_primary\":\"#FFE4B4\",\"--skin__alt_primary__toRgbString\":\"255,228,180\",\"--skin__alt_text_primary\":\"#63482C\",\"--skin__alt_text_primary__toRgbString\":\"99,72,44\",\"--skin__bg_1\":\"#8A6843\",\"--skin__bg_1__toRgbString\":\"138,104,67\",\"--skin__bg_2\":\"#63482C\",\"--skin__bg_2__toRgbString\":\"99,72,44\",\"--skin__border\":\"#A47E57\",\"--skin__border__toRgbString\":\"164,126,87\",\"--skin__bs_topnav_bg\":\"#63482C\",\"--skin__bs_topnav_bg__toRgbString\":\"99,72,44\",\"--skin__bs_zc_an1\":\"#876541\",\"--skin__bs_zc_an1__toRgbString\":\"135,101,65\",\"--skin__bs_zc_bg\":\"#755634\",\"--skin__bs_zc_bg__toRgbString\":\"117,86,52\",\"--skin__btmnav_active\":\"#FFE4B4\",\"--skin__btmnav_active__toRgbString\":\"255,228,180\",\"--skin__btmnav_def\":\"#C19D63\",\"--skin__btmnav_def__toRgbString\":\"193,157,99\",\"--skin__btn_color_1\":\"#FFE4B4\",\"--skin__btn_color_1__toRgbString\":\"255,228,180\",\"--skin__btn_color_2\":\"#FFE4B4\",\"--skin__btn_color_2__toRgbString\":\"255,228,180\",\"--skin__cards_text\":\"#E8C182\",\"--skin__cards_text__toRgbString\":\"232,193,130\",\"--skin__ddt_bg\":\"#6D4F30\",\"--skin__ddt_bg__toRgbString\":\"109,79,48\",\"--skin__ddt_icon\":\"#805D38\",\"--skin__ddt_icon__toRgbString\":\"128,93,56\",\"--skin__filter_active\":\"#FFE4B4\",\"--skin__filter_active__toRgbString\":\"255,228,180\",\"--skin__filter_bg\":\"#8A6843\",\"--skin__filter_bg__toRgbString\":\"138,104,67\",\"--skin__home_bg\":\"#63482C\",\"--skin__home_bg__toRgbString\":\"99,72,44\",\"--skin__icon_1\":\"#FFE4B4\",\"--skin__icon_1__toRgbString\":\"255,228,180\",\"--skin__icon_tg_q\":\"#E8C182\",\"--skin__icon_tg_q__toRgbString\":\"232,193,130\",\"--skin__icon_tg_z\":\"#E8C182\",\"--skin__icon_tg_z__toRgbString\":\"232,193,130\",\"--skin__jackpot_text\":\"#FFFFFF\",\"--skin__jackpot_text__toRgbString\":\"255,255,255\",\"--skin__jdd_vip_bjc\":\"#FFAA09\",\"--skin__jdd_vip_bjc__toRgbString\":\"255,170,9\",\"--skin__kb_bg\":\"#A47E57\",\"--skin__kb_bg__toRgbString\":\"164,126,87\",\"--skin__label_accent3\":\"#FFAA09\",\"--skin__label_accent3__toRgbString\":\"255,170,9\",\"--skin__labeltext_accent3\":\"#FFFFFF\",\"--skin__labeltext_accent3__toRgbString\":\"255,255,255\",\"--skin__lead\":\"#FFFFFF\",\"--skin__lead__toRgbString\":\"255,255,255\",\"--skin__leftnav_active\":\"#63482C\",\"--skin__leftnav_active__toRgbString\":\"99,72,44\",\"--skin__leftnav_def\":\"#E8C182\",\"--skin__leftnav_def__toRgbString\":\"232,193,130\",\"--skin__neutral_1\":\"#E8C182\",\"--skin__neutral_1__toRgbString\":\"232,193,130\",\"--skin__neutral_2\":\"#C19D63\",\"--skin__neutral_2__toRgbString\":\"193,157,99\",\"--skin__neutral_3\":\"#C19D63\",\"--skin__neutral_3__toRgbString\":\"193,157,99\",\"--skin__primary\":\"#FFE4B4\",\"--skin__primary__toRgbString\":\"255,228,180\",\"--skin__profile_icon_1\":\"#FFE4B4\",\"--skin__profile_icon_1__toRgbString\":\"255,228,180\",\"--skin__profile_icon_2\":\"#FFE4B4\",\"--skin__profile_icon_2__toRgbString\":\"255,228,180\",\"--skin__profile_icon_3\":\"#FFE4B4\",\"--skin__profile_icon_3__toRgbString\":\"255,228,180\",\"--skin__profile_icon_4\":\"#FFE4B4\",\"--skin__profile_icon_4__toRgbString\":\"255,228,180\",\"--skin__profile_toptext\":\"#FFFFFF\",\"--skin__profile_toptext__toRgbString\":\"255,255,255\",\"--skin__search_icon\":\"#E8C182\",\"--skin__search_icon__toRgbString\":\"232,193,130\",\"--skin__table_bg\":\"#63482C\",\"--skin__table_bg__toRgbString\":\"99,72,44\",\"--skin__text_accent3\":\"#FFFFFF\",\"--skin__text_accent3__toRgbString\":\"255,255,255\",\"--skin__text_primary\":\"#63482C\",\"--skin__text_primary__toRgbString\":\"99,72,44\",\"--skin__tg_accent_1\":\"#BBDFC1\",\"--skin__tg_accent_1__toRgbString\":\"187,223,193\",\"--skin__tg_accent_3\":\"#FFE7B8\",\"--skin__tg_accent_3__toRgbString\":\"255,231,184\",\"--skin__tg_primary\":\"#F5EEE1\",\"--skin__tg_primary__toRgbString\":\"245,238,225\",\"--skin__web_bs_yj_bg\":\"#63482C\",\"--skin__web_bs_yj_bg__toRgbString\":\"99,72,44\",\"--skin__web_bs_zc_an2\":\"#947049\",\"--skin__web_bs_zc_an2__toRgbString\":\"148,112,73\",\"--skin__web_btmnav_db\":\"#705233\",\"--skin__web_btmnav_db__toRgbString\":\"112,82,51\",\"--skin__web_filter_gou\":\"#63482C\",\"--skin__web_filter_gou__toRgbString\":\"99,72,44\",\"--skin__web_left_bg_q\":\"#FFFFFF0A\",\"--skin__web_left_bg_shadow\":\"#0000001F\",\"--skin__web_left_bg_shadow_active\":\"#0000001F\",\"--skin__web_left_bg_z\":\"#FFFFFF0D\",\"--skin__web_load_zz\":\"#A47E5766\",\"--skin__web_plat_line\":\"#A47E57\",\"--skin__web_plat_line__toRgbString\":\"164,126,87\",\"--skin__web_topbg_1\":\"#EECB8E\",\"--skin__web_topbg_1__toRgbString\":\"238,203,142\",\"--skin__web_topbg_3\":\"#CEA661\"}','../skin/lobby_asset/2-1-22/{6E7A03B4-42DC-441B-A74D-6E1F34385060}.png',0,'https://agsa.feijoapgpay1.com/siteadmin/skin/lobby_asset/2-1-14/common/'),
(45,'','{\"--skin__ID\":\"2-20\",\"--skin__accent_1\":\"#20F511\",\"--skin__accent_1__toRgbString\":\"32,245,17\",\"--skin__accent_2\":\"#AF1301\",\"--skin__accent_2__toRgbString\":\"175,19,1\",\"--skin__accent_3\":\"#FFAA09\",\"--skin__accent_3__toRgbString\":\"255,170,9\",\"--skin__alt_border\":\"#D9FFE7\",\"--skin__alt_border__toRgbString\":\"217,255,231\",\"--skin__alt_lead\":\"#FFFFFF\",\"--skin__alt_lead__toRgbString\":\"255,255,255\",\"--skin__alt_neutral_1\":\"#D9FFE7\",\"--skin__alt_neutral_1__toRgbString\":\"217,255,231\",\"--skin__alt_neutral_2\":\"#A0D3B2\",\"--skin__alt_neutral_2__toRgbString\":\"160,211,178\",\"--skin__alt_primary\":\"#F4E7CB\",\"--skin__alt_primary__toRgbString\":\"244,231,203\",\"--skin__alt_text_primary\":\"#52775F\",\"--skin__alt_text_primary__toRgbString\":\"82,119,95\",\"--skin__bg_1\":\"#769882\",\"--skin__bg_1__toRgbString\":\"118,152,130\",\"--skin__bg_2\":\"#5B7E68\",\"--skin__bg_2__toRgbString\":\"91,126,104\",\"--skin__border\":\"#8FAE99\",\"--skin__border__toRgbString\":\"143,174,153\",\"--skin__bs_topnav_bg\":\"#52775F\",\"--skin__bs_topnav_bg__toRgbString\":\"82,119,95\",\"--skin__bs_zc_an1\":\"#709A80\",\"--skin__bs_zc_an1__toRgbString\":\"112,154,128\",\"--skin__bs_zc_bg\":\"#648872\",\"--skin__bs_zc_bg__toRgbString\":\"100,136,114\",\"--skin__btmnav_active\":\"#F4E7CB\",\"--skin__btmnav_active__toRgbString\":\"244,231,203\",\"--skin__btmnav_def\":\"#A0D3B2\",\"--skin__btmnav_def__toRgbString\":\"160,211,178\",\"--skin__btn_color_1\":\"#F4E7CB\",\"--skin__btn_color_1__toRgbString\":\"244,231,203\",\"--skin__btn_color_2\":\"#F4E7CB\",\"--skin__btn_color_2__toRgbString\":\"244,231,203\",\"--skin__cards_text\":\"#D9FFE7\",\"--skin__cards_text__toRgbString\":\"217,255,231\",\"--skin__ddt_bg\":\"#668D75\",\"--skin__ddt_bg__toRgbString\":\"102,141,117\",\"--skin__ddt_icon\":\"#739B83\",\"--skin__ddt_icon__toRgbString\":\"115,155,131\",\"--skin__filter_active\":\"#F4E7CB\",\"--skin__filter_active__toRgbString\":\"244,231,203\",\"--skin__filter_bg\":\"#769882\",\"--skin__filter_bg__toRgbString\":\"118,152,130\",\"--skin__home_bg\":\"#5B7E68\",\"--skin__home_bg__toRgbString\":\"91,126,104\",\"--skin__icon_1\":\"#F4E7CB\",\"--skin__icon_1__toRgbString\":\"244,231,203\",\"--skin__icon_tg_q\":\"#D9FFE7\",\"--skin__icon_tg_q__toRgbString\":\"217,255,231\",\"--skin__icon_tg_z\":\"#D9FFE7\",\"--skin__icon_tg_z__toRgbString\":\"217,255,231\",\"--skin__jackpot_text\":\"#FFFFFF\",\"--skin__jackpot_text__toRgbString\":\"255,255,255\",\"--skin__jdd_vip_bjc\":\"#FFAA09\",\"--skin__jdd_vip_bjc__toRgbString\":\"255,170,9\",\"--skin__kb_bg\":\"#8FAE99\",\"--skin__kb_bg__toRgbString\":\"143,174,153\",\"--skin__label_accent3\":\"#FFAA09\",\"--skin__label_accent3__toRgbString\":\"255,170,9\",\"--skin__labeltext_accent3\":\"#FFFFFF\",\"--skin__labeltext_accent3__toRgbString\":\"255,255,255\",\"--skin__lead\":\"#FFFFFF\",\"--skin__lead__toRgbString\":\"255,255,255\",\"--skin__leftnav_active\":\"#52775F\",\"--skin__leftnav_active__toRgbString\":\"82,119,95\",\"--skin__leftnav_def\":\"#D9FFE7\",\"--skin__leftnav_def__toRgbString\":\"217,255,231\",\"--skin__neutral_1\":\"#D9FFE7\",\"--skin__neutral_1__toRgbString\":\"217,255,231\",\"--skin__neutral_2\":\"#A0D3B2\",\"--skin__neutral_2__toRgbString\":\"160,211,178\",\"--skin__neutral_3\":\"#A0D3B2\",\"--skin__neutral_3__toRgbString\":\"160,211,178\",\"--skin__primary\":\"#F4E7CB\",\"--skin__primary__toRgbString\":\"244,231,203\",\"--skin__profile_icon_1\":\"#F4E7CB\",\"--skin__profile_icon_1__toRgbString\":\"244,231,203\",\"--skin__profile_icon_2\":\"#F4E7CB\",\"--skin__profile_icon_2__toRgbString\":\"244,231,203\",\"--skin__profile_icon_3\":\"#F4E7CB\",\"--skin__profile_icon_3__toRgbString\":\"244,231,203\",\"--skin__profile_icon_4\":\"#F4E7CB\",\"--skin__profile_icon_4__toRgbString\":\"244,231,203\",\"--skin__profile_toptext\":\"#FFFFFF\",\"--skin__profile_toptext__toRgbString\":\"255,255,255\",\"--skin__search_icon\":\"#D9FFE7\",\"--skin__search_icon__toRgbString\":\"217,255,231\",\"--skin__table_bg\":\"#5B7E68\",\"--skin__table_bg__toRgbString\":\"91,126,104\",\"--skin__text_accent3\":\"#FFFFFF\",\"--skin__text_accent3__toRgbString\":\"255,255,255\",\"--skin__text_primary\":\"#52775F\",\"--skin__text_primary__toRgbString\":\"82,119,95\",\"--skin__tg_accent_1\":\"#BBDFC1\",\"--skin__tg_accent_1__toRgbString\":\"187,223,193\",\"--skin__tg_accent_3\":\"#FFE7B8\",\"--skin__tg_accent_3__toRgbString\":\"255,231,184\",\"--skin__tg_primary\":\"#F2F1EB\",\"--skin__tg_primary__toRgbString\":\"242,241,235\",\"--skin__web_bs_yj_bg\":\"#52775F\",\"--skin__web_bs_yj_bg__toRgbString\":\"82,119,95\",\"--skin__web_bs_zc_an2\":\"#82AD92\",\"--skin__web_bs_zc_an2__toRgbString\":\"130,173,146\",\"--skin__web_btmnav_db\":\"#60826D\",\"--skin__web_btmnav_db__toRgbString\":\"96,130,109\",\"--skin__web_filter_gou\":\"#52775F\",\"--skin__web_filter_gou__toRgbString\":\"82,119,95\",\"--skin__web_left_bg_q\":\"#FFFFFF0A\",\"--skin__web_left_bg_shadow\":\"#0000001F\",\"--skin__web_left_bg_shadow_active\":\"#0000001F\",\"--skin__web_left_bg_z\":\"#FFFFFF0D\",\"--skin__web_load_zz\":\"#8FAE9966\",\"--skin__web_plat_line\":\"#8FAE99\",\"--skin__web_plat_line__toRgbString\":\"143,174,153\",\"--skin__web_topbg_1\":\"#6A8E74\",\"--skin__web_topbg_1__toRgbString\":\"106,142,116\",\"--skin__web_topbg_3\":\"#537A61\"}','',0,''),
(46,'','{\"--skin__ID\":\"2-12\",\"--skin__accent_1\":\"#04BE02\",\"--skin__accent_1__toRgbString\":\"4,190,2\",\"--skin__accent_2\":\"#FF4A4A\",\"--skin__accent_2__toRgbString\":\"255,74,74\",\"--skin__accent_3\":\"#FFAA09\",\"--skin__accent_3__toRgbString\":\"255,170,9\",\"--skin__alt_border\":\"#7FB8D2\",\"--skin__alt_border__toRgbString\":\"127,184,210\",\"--skin__alt_lead\":\"#FFFFFF\",\"--skin__alt_lead__toRgbString\":\"255,255,255\",\"--skin__alt_neutral_1\":\"#7FB8D2\",\"--skin__alt_neutral_1__toRgbString\":\"127,184,210\",\"--skin__alt_neutral_2\":\"#5B8FA7\",\"--skin__alt_neutral_2__toRgbString\":\"91,143,167\",\"--skin__alt_primary\":\"#04CCF3\",\"--skin__alt_primary__toRgbString\":\"4,204,243\",\"--skin__alt_text_primary\":\"#FFFFFF\",\"--skin__alt_text_primary__toRgbString\":\"255,255,255\",\"--skin__bg_1\":\"#02385A\",\"--skin__bg_1__toRgbString\":\"2,56,90\",\"--skin__bg_2\":\"#002744\",\"--skin__bg_2__toRgbString\":\"0,39,68\",\"--skin__border\":\"#034570\",\"--skin__border__toRgbString\":\"3,69,112\",\"--skin__bs_topnav_bg\":\"#031E3B\",\"--skin__bs_topnav_bg__toRgbString\":\"3,30,59\",\"--skin__bs_zc_an1\":\"#033051\",\"--skin__bs_zc_an1__toRgbString\":\"3,48,81\",\"--skin__bs_zc_bg\":\"#002744\",\"--skin__bs_zc_bg__toRgbString\":\"0,39,68\",\"--skin__btmnav_active\":\"#04CCF3\",\"--skin__btmnav_active__toRgbString\":\"4,204,243\",\"--skin__btmnav_def\":\"#5B8FA7\",\"--skin__btmnav_def__toRgbString\":\"91,143,167\",\"--skin__btn_color_1\":\"#04CCF3\",\"--skin__btn_color_1__toRgbString\":\"4,204,243\",\"--skin__btn_color_2\":\"#04CCF3\",\"--skin__btn_color_2__toRgbString\":\"4,204,243\",\"--skin__cards_text\":\"#7FB8D2\",\"--skin__cards_text__toRgbString\":\"127,184,210\",\"--skin__ddt_bg\":\"#013154\",\"--skin__ddt_bg__toRgbString\":\"1,49,84\",\"--skin__ddt_icon\":\"#033C65\",\"--skin__ddt_icon__toRgbString\":\"3,60,101\",\"--skin__filter_active\":\"#04CCF3\",\"--skin__filter_active__toRgbString\":\"4,204,243\",\"--skin__filter_bg\":\"#02385A\",\"--skin__filter_bg__toRgbString\":\"2,56,90\",\"--skin__home_bg\":\"#002744\",\"--skin__home_bg__toRgbString\":\"0,39,68\",\"--skin__icon_1\":\"#04CCF3\",\"--skin__icon_1__toRgbString\":\"4,204,243\",\"--skin__icon_tg_q\":\"#7FB8D2\",\"--skin__icon_tg_q__toRgbString\":\"127,184,210\",\"--skin__icon_tg_z\":\"#7FB8D2\",\"--skin__icon_tg_z__toRgbString\":\"127,184,210\",\"--skin__jackpot_text\":\"#FFFFFF\",\"--skin__jackpot_text__toRgbString\":\"255,255,255\",\"--skin__jdd_vip_bjc\":\"#04CCF3\",\"--skin__jdd_vip_bjc__toRgbString\":\"4,204,243\",\"--skin__kb_bg\":\"#034570\",\"--skin__kb_bg__toRgbString\":\"3,69,112\",\"--skin__label_accent3\":\"#FFAA09\",\"--skin__label_accent3__toRgbString\":\"255,170,9\",\"--skin__labeltext_accent3\":\"#FFFFFF\",\"--skin__labeltext_accent3__toRgbString\":\"255,255,255\",\"--skin__lead\":\"#FFFFFF\",\"--skin__lead__toRgbString\":\"255,255,255\",\"--skin__leftnav_active\":\"#FFFFFF\",\"--skin__leftnav_active__toRgbString\":\"255,255,255\",\"--skin__leftnav_def\":\"#7FB8D2\",\"--skin__leftnav_def__toRgbString\":\"127,184,210\",\"--skin__neutral_1\":\"#7FB8D2\",\"--skin__neutral_1__toRgbString\":\"127,184,210\",\"--skin__neutral_2\":\"#5B8FA7\",\"--skin__neutral_2__toRgbString\":\"91,143,167\",\"--skin__neutral_3\":\"#5B8FA7\",\"--skin__neutral_3__toRgbString\":\"91,143,167\",\"--skin__primary\":\"#04CCF3\",\"--skin__primary__toRgbString\":\"4,204,243\",\"--skin__profile_icon_1\":\"#04CCF3\",\"--skin__profile_icon_1__toRgbString\":\"4,204,243\",\"--skin__profile_icon_2\":\"#04CCF3\",\"--skin__profile_icon_2__toRgbString\":\"4,204,243\",\"--skin__profile_icon_3\":\"#04CCF3\",\"--skin__profile_icon_3__toRgbString\":\"4,204,243\",\"--skin__profile_icon_4\":\"#04CCF3\",\"--skin__profile_icon_4__toRgbString\":\"4,204,243\",\"--skin__profile_toptext\":\"#FFFFFF\",\"--skin__profile_toptext__toRgbString\":\"255,255,255\",\"--skin__search_icon\":\"#7FB8D2\",\"--skin__search_icon__toRgbString\":\"127,184,210\",\"--skin__table_bg\":\"#002744\",\"--skin__table_bg__toRgbString\":\"0,39,68\",\"--skin__text_accent3\":\"#FFFFFF\",\"--skin__text_accent3__toRgbString\":\"255,255,255\",\"--skin__text_primary\":\"#FFFFFF\",\"--skin__text_primary__toRgbString\":\"255,255,255\",\"--skin__tg_accent_1\":\"#BBDFC1\",\"--skin__tg_accent_1__toRgbString\":\"187,223,193\",\"--skin__tg_accent_3\":\"#FFE7B8\",\"--skin__tg_accent_3__toRgbString\":\"255,231,184\",\"--skin__tg_primary\":\"#B8E5EF\",\"--skin__tg_primary__toRgbString\":\"184,229,239\",\"--skin__web_bs_yj_bg\":\"#031E3B\",\"--skin__web_bs_yj_bg__toRgbString\":\"3,30,59\",\"--skin__web_bs_zc_an2\":\"#043860\",\"--skin__web_bs_zc_an2__toRgbString\":\"4,56,96\",\"--skin__web_btmnav_db\":\"#002744\",\"--skin__web_btmnav_db__toRgbString\":\"0,39,68\",\"--skin__web_filter_gou\":\"#FFFFFF\",\"--skin__web_filter_gou__toRgbString\":\"255,255,255\",\"--skin__web_left_bg_q\":\"#FFFFFF0A\",\"--skin__web_left_bg_shadow\":\"#0000001F\",\"--skin__web_left_bg_shadow_active\":\"#0000001F\",\"--skin__web_left_bg_z\":\"#FFFFFF0D\",\"--skin__web_load_zz\":\"#03457066\",\"--skin__web_plat_line\":\"#034570\",\"--skin__web_plat_line__toRgbString\":\"3,69,112\",\"--skin__web_topbg_1\":\"#04CCF3\",\"--skin__web_topbg_1__toRgbString\":\"4,204,243\",\"--skin__web_topbg_3\":\"#06B1D2\"}','',0,''),
(47,'','{\"--skin__ID\":\"2-4\",\"--skin__accent_1\":\"#04BE02\",\"--skin__accent_1__toRgbString\":\"4,190,2\",\"--skin__accent_2\":\"#EA4E3D\",\"--skin__accent_2__toRgbString\":\"234,78,61\",\"--skin__accent_3\":\"#FFAA09\",\"--skin__accent_3__toRgbString\":\"255,170,9\",\"--skin__alt_border\":\"#999999\",\"--skin__alt_border__toRgbString\":\"153,153,153\",\"--skin__alt_lead\":\"#E3E3E3\",\"--skin__alt_lead__toRgbString\":\"227,227,227\",\"--skin__alt_neutral_1\":\"#999999\",\"--skin__alt_neutral_1__toRgbString\":\"153,153,153\",\"--skin__alt_neutral_2\":\"#666666\",\"--skin__alt_neutral_2__toRgbString\":\"102,102,102\",\"--skin__alt_primary\":\"#E41827\",\"--skin__alt_primary__toRgbString\":\"228,24,39\",\"--skin__alt_text_primary\":\"#FFFFFF\",\"--skin__alt_text_primary__toRgbString\":\"255,255,255\",\"--skin__bg_1\":\"#333333\",\"--skin__bg_1__toRgbString\":\"51,51,51\",\"--skin__bg_2\":\"#222222\",\"--skin__bg_2__toRgbString\":\"34,34,34\",\"--skin__border\":\"#444444\",\"--skin__border__toRgbString\":\"68,68,68\",\"--skin__bs_topnav_bg\":\"#222222\",\"--skin__bs_topnav_bg__toRgbString\":\"34,34,34\",\"--skin__bs_zc_an1\":\"#303030\",\"--skin__bs_zc_an1__toRgbString\":\"48,48,48\",\"--skin__bs_zc_bg\":\"#282828\",\"--skin__bs_zc_bg__toRgbString\":\"40,40,40\",\"--skin__btmnav_active\":\"#E41827\",\"--skin__btmnav_active__toRgbString\":\"228,24,39\",\"--skin__btmnav_def\":\"#666666\",\"--skin__btmnav_def__toRgbString\":\"102,102,102\",\"--skin__btn_color_1\":\"#E41827\",\"--skin__btn_color_1__toRgbString\":\"228,24,39\",\"--skin__btn_color_2\":\"#E41827\",\"--skin__btn_color_2__toRgbString\":\"228,24,39\",\"--skin__cards_text\":\"#999999\",\"--skin__cards_text__toRgbString\":\"153,153,153\",\"--skin__ddt_bg\":\"#2B2B2B\",\"--skin__ddt_bg__toRgbString\":\"43,43,43\",\"--skin__ddt_icon\":\"#3A3A3A\",\"--skin__ddt_icon__toRgbString\":\"58,58,58\",\"--skin__filter_active\":\"#E41827\",\"--skin__filter_active__toRgbString\":\"228,24,39\",\"--skin__filter_bg\":\"#333333\",\"--skin__filter_bg__toRgbString\":\"51,51,51\",\"--skin__home_bg\":\"#222222\",\"--skin__home_bg__toRgbString\":\"34,34,34\",\"--skin__icon_1\":\"#E41827\",\"--skin__icon_1__toRgbString\":\"228,24,39\",\"--skin__icon_tg_q\":\"#999999\",\"--skin__icon_tg_q__toRgbString\":\"153,153,153\",\"--skin__icon_tg_z\":\"#999999\",\"--skin__icon_tg_z__toRgbString\":\"153,153,153\",\"--skin__jackpot_text\":\"#FFFFFF\",\"--skin__jackpot_text__toRgbString\":\"255,255,255\",\"--skin__jdd_vip_bjc\":\"#E41827\",\"--skin__jdd_vip_bjc__toRgbString\":\"228,24,39\",\"--skin__kb_bg\":\"#333333\",\"--skin__kb_bg__toRgbString\":\"51,51,51\",\"--skin__label_accent3\":\"#FFAA09\",\"--skin__label_accent3__toRgbString\":\"255,170,9\",\"--skin__labeltext_accent3\":\"#FFFFFF\",\"--skin__labeltext_accent3__toRgbString\":\"255,255,255\",\"--skin__lead\":\"#E3E3E3\",\"--skin__lead__toRgbString\":\"227,227,227\",\"--skin__leftnav_active\":\"#FFFFFF\",\"--skin__leftnav_active__toRgbString\":\"255,255,255\",\"--skin__leftnav_def\":\"#999999\",\"--skin__leftnav_def__toRgbString\":\"153,153,153\",\"--skin__neutral_1\":\"#999999\",\"--skin__neutral_1__toRgbString\":\"153,153,153\",\"--skin__neutral_2\":\"#666666\",\"--skin__neutral_2__toRgbString\":\"102,102,102\",\"--skin__neutral_3\":\"#666666\",\"--skin__neutral_3__toRgbString\":\"102,102,102\",\"--skin__primary\":\"#E41827\",\"--skin__primary__toRgbString\":\"228,24,39\",\"--skin__profile_icon_1\":\"#E41827\",\"--skin__profile_icon_1__toRgbString\":\"228,24,39\",\"--skin__profile_icon_2\":\"#E41827\",\"--skin__profile_icon_2__toRgbString\":\"228,24,39\",\"--skin__profile_icon_3\":\"#E41827\",\"--skin__profile_icon_3__toRgbString\":\"228,24,39\",\"--skin__profile_icon_4\":\"#E41827\",\"--skin__profile_icon_4__toRgbString\":\"228,24,39\",\"--skin__profile_toptext\":\"#FFFFFF\",\"--skin__profile_toptext__toRgbString\":\"255,255,255\",\"--skin__search_icon\":\"#999999\",\"--skin__search_icon__toRgbString\":\"153,153,153\",\"--skin__table_bg\":\"#333333\",\"--skin__table_bg__toRgbString\":\"51,51,51\",\"--skin__text_accent3\":\"#FFFFFF\",\"--skin__text_accent3__toRgbString\":\"255,255,255\",\"--skin__text_primary\":\"#FFFFFF\",\"--skin__text_primary__toRgbString\":\"255,255,255\",\"--skin__tg_accent_1\":\"#BBDFC1\",\"--skin__tg_accent_1__toRgbString\":\"187,223,193\",\"--skin__tg_accent_3\":\"#FFE7B8\",\"--skin__tg_accent_3__toRgbString\":\"255,231,184\",\"--skin__tg_primary\":\"#E9C0C3\",\"--skin__tg_primary__toRgbString\":\"233,192,195\",\"--skin__web_bs_yj_bg\":\"#222222\",\"--skin__web_bs_yj_bg__toRgbString\":\"34,34,34\",\"--skin__web_bs_zc_an2\":\"#3A3A3A\",\"--skin__web_bs_zc_an2__toRgbString\":\"58,58,58\",\"--skin__web_btmnav_db\":\"#282828\",\"--skin__web_btmnav_db__toRgbString\":\"40,40,40\",\"--skin__web_filter_gou\":\"#FFFFFF\",\"--skin__web_filter_gou__toRgbString\":\"255,255,255\",\"--skin__web_left_bg_q\":\"#282828\",\"--skin__web_left_bg_q__toRgbString\":\"40,40,40\",\"--skin__web_left_bg_shadow\":\"#0000001F\",\"--skin__web_left_bg_shadow_active\":\"#0000001F\",\"--skin__web_left_bg_z\":\"#222222\",\"--skin__web_left_bg_z__toRgbString\":\"34,34,34\",\"--skin__web_load_zz\":\"#44444466\",\"--skin__web_plat_line\":\"#444444\",\"--skin__web_plat_line__toRgbString\":\"68,68,68\",\"--skin__web_topbg_1\":\"#FB2535\",\"--skin__web_topbg_1__toRgbString\":\"251,37,53\",\"--skin__web_topbg_3\":\"#DB1524\"}','',1,'');
/*!40000 ALTER TABLE `templates_cores` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tokens_recuperacoes`
--

DROP TABLE IF EXISTS `tokens_recuperacoes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `tokens_recuperacoes` (
  `id_usuario` int(11) DEFAULT NULL,
  `token` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tokens_recuperacoes`
--

LOCK TABLES `tokens_recuperacoes` WRITE;
/*!40000 ALTER TABLE `tokens_recuperacoes` DISABLE KEYS */;
/*!40000 ALTER TABLE `tokens_recuperacoes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transacoes`
--

DROP TABLE IF EXISTS `transacoes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `transacoes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `transacao_id` varchar(255) DEFAULT NULL,
  `usuario` int(11) DEFAULT NULL,
  `valor` decimal(10,2) DEFAULT NULL,
  `tipo` enum('deposito','saque') DEFAULT NULL,
  `data_registro` datetime DEFAULT NULL,
  `qrcode` longtext DEFAULT NULL,
  `code` text DEFAULT NULL,
  `status` enum('pago','processamento','expirado') DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=192 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transacoes`
--

LOCK TABLES `transacoes` WRITE;
/*!40000 ALTER TABLE `transacoes` DISABLE KEYS */;
INSERT INTO `transacoes` VALUES
(190,'30c1b1dd393e86ce40fd922272fe20b1',954635750,20.00,'deposito','2025-12-22 01:20:37','00020101021226810014br.gov.bcb.pix2559qr.woovi.com/qr/v2/cob/b6bab075-9039-48d0-b370-3c29827a93ad520400005303986540520.005802BR5922PAGAMENTO_SEGURO_SOLUT6007COLINAS622905251ac353e148f248e6bcc2943b46304F626','00020101021226810014br.gov.bcb.pix2559qr.woovi.com/qr/v2/cob/b6bab075-9039-48d0-b370-3c29827a93ad520400005303986540520.005802BR5922PAGAMENTO_SEGURO_SOLUT6007COLINAS622905251ac353e148f248e6bcc2943b46304F626','processamento'),
(191,'efbb97a6b567b66c3bcb2aee661c04c0',376421720,10.00,'deposito','2025-12-22 01:38:19','00020101021226810014br.gov.bcb.pix2559qr.woovi.com/qr/v2/cob/6933ac04-93e2-4dd3-b6c2-ce00e89c7214520400005303986540510.005802BR5922PAGAMENTO_SEGURO_SOLUT6007COLINAS62290525e17d2b59dae3489eb2233e2176304F9B0','00020101021226810014br.gov.bcb.pix2559qr.woovi.com/qr/v2/cob/6933ac04-93e2-4dd3-b6c2-ce00e89c7214520400005303986540510.005802BR5922PAGAMENTO_SEGURO_SOLUT6007COLINAS62290525e17d2b59dae3489eb2233e2176304F9B0','pago');
/*!40000 ALTER TABLE `transacoes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `mobile` varchar(255) NOT NULL,
  `celular` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `saldo` decimal(10,2) DEFAULT 0.00,
  `saldo_afiliados` decimal(10,2) DEFAULT 0.00,
  `rev` decimal(10,2) NOT NULL DEFAULT 0.00,
  `total_rev` decimal(10,2) NOT NULL DEFAULT 0.00,
  `real_name` varchar(255) DEFAULT NULL,
  `spassword` varchar(255) NOT NULL,
  `url` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `data_registro` datetime DEFAULT current_timestamp(),
  `invite_code` varchar(255) NOT NULL,
  `invitation_code` varchar(255) DEFAULT NULL,
  `cpf` varchar(11) DEFAULT NULL,
  `tipo_pagamento` int(11) NOT NULL DEFAULT 0,
  `senha_saque` int(11) NOT NULL DEFAULT 0,
  `senhaparasacar` varchar(255) DEFAULT NULL,
  `pessoas_convidadas` int(11) NOT NULL DEFAULT 0,
  `indicacoes_roubadas` int(11) DEFAULT 0,
  `statusaff` int(11) NOT NULL DEFAULT 0,
  `banido` int(11) DEFAULT 0,
  `historico` text DEFAULT NULL,
  `favoritos` text DEFAULT NULL,
  `vip` int(11) NOT NULL DEFAULT 0,
  `recompensa_vip` decimal(10,2) NOT NULL DEFAULT 0.00,
  `total_recompensa_vip` decimal(10,2) NOT NULL DEFAULT 0.00,
  `data_nascimento` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `google_id` varchar(255) DEFAULT NULL,
  `avatar` int(255) NOT NULL DEFAULT 1,
  `facebook` varchar(255) DEFAULT NULL,
  `whatsapp` varchar(255) DEFAULT NULL,
  `telegram` varchar(255) DEFAULT NULL,
  `twitter` varchar(255) DEFAULT NULL,
  `birth` varchar(255) DEFAULT NULL,
  `freeze` int(11) DEFAULT 0,
  `relogar` int(11) NOT NULL DEFAULT 0,
  `lobby` int(11) DEFAULT 1,
  `rtp` int(11) DEFAULT NULL,
  `modo_demo` tinyint(1) DEFAULT 0,
  `cpaLvl1` float DEFAULT NULL,
  `cpaLvl2` float DEFAULT NULL,
  `cpaLvl3` float DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=999671453 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` VALUES
(106714407,'agente','+55-84845848484','Bagshhvs66',0.00,0.00,0.00,0.00,NULL,'Bagshhvs66','https://777-piaui.site/','9f038752a49f51173fec47e507292c72','2026-01-05 12:19:17','106714407',NULL,NULL,1,0,NULL,0,0,1,0,NULL,NULL,0,0.00,0.00,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL,0,0,1,NULL,0,NULL,NULL,NULL),
(349374040,'agente','+55-8454884048','6162666262a',0.00,0.00,0.00,0.00,NULL,'6162666262a','https://777-piaui.site/','a05232f7363e685655645e4ceed61dad','2026-01-05 12:18:52','349374040',NULL,NULL,1,0,NULL,0,0,1,0,NULL,NULL,0,0.00,0.00,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL,0,0,1,NULL,0,NULL,NULL,NULL),
(376421720,'jogador','+55-84845548487','123456aa',0.24,0.00,0.00,0.00,NULL,'123456aa','https://777-piaui.site/?id=435780174&currency=BRL&type=2','9de0fd6ac95d4a441a88f04a0ccf7cbc','2025-12-22 01:38:12','376421720','435780174',NULL,1,0,NULL,0,0,1,0,NULL,NULL,0,0.00,0.00,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL,0,0,1,90,0,NULL,NULL,NULL),
(435780174,'blogueiro','+55-54545548485','123456aa',0.00,0.00,0.00,0.00,'Sol','123456aa','https://777-piaui.site/?id=474629937&currency=BRL&type=2','959c312dde426c33194b42b37c27d235','2025-12-22 01:37:43','435780174','474629937',NULL,1,1,'110902',1,0,1,0,NULL,NULL,0,0.00,0.00,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL,0,0,1,90,0,NULL,NULL,NULL),
(474629937,'agente','+55-84542454884','123456aa',1.30,0.00,0.00,0.00,NULL,'123456aa','https://777-piaui.site/?id=954635750&currency=BRL&type=2','57e78b36f47923599db18bef0fc05100','2025-12-22 01:37:11','474629937','954635750',NULL,1,0,NULL,1,0,1,0,NULL,NULL,0,0.00,0.00,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL,0,0,1,90,0,NULL,NULL,NULL),
(600248044,'teste2026','+55-25346456745','teste20263',0.00,0.00,0.00,0.00,NULL,'teste20263','https://777-piaui.site/','412d9db7c7ebbfbcf73485aeaf459b4c','2026-01-07 11:57:29','600248044',NULL,NULL,1,0,NULL,0,0,1,0,NULL,NULL,0,0.00,0.00,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL,0,0,1,NULL,0,NULL,NULL,NULL),
(620306777,'teste2026','+55-43647658678','teste20263',0.00,0.00,0.00,0.00,NULL,'teste20263','https://777-piaui.site/','3195f76b47fec5e295de2413de40e761','2026-01-07 11:57:51','620306777',NULL,NULL,1,0,NULL,0,0,1,0,NULL,NULL,0,0.00,0.00,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL,0,0,1,NULL,0,NULL,NULL,NULL),
(878055467,'teste202655','+55-56467456456','teste20263',0.00,0.00,0.00,0.00,NULL,'teste20263','https://777-piaui.site/','7e7791067e5ce14a8e596e93c1e3d80c','2026-01-07 12:03:34','878055467',NULL,NULL,1,0,NULL,0,0,1,0,NULL,NULL,0,0.00,0.00,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL,0,0,1,NULL,0,NULL,NULL,NULL),
(954635750,'alisab','+55-54554804485','123456Aa',0.00,0.50,0.00,0.00,'Alisson','123456Aa','https://777-piaui.site/','93574d45c2288294a0a562514b83514c','2025-12-22 01:20:10','954635750',NULL,NULL,1,1,'110902',1,0,1,0,NULL,NULL,0,0.00,0.00,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL,0,0,1,90,0,NULL,NULL,NULL),
(983452589,'testedev','+55-23435346456','testedev7',10.00,0.00,0.00,0.00,'alissom','testedev7','https://777-piaui.site/','8edfc3e7015c3bbe9e6099db7151cca1','2026-01-02 02:16:36','983452589',NULL,NULL,1,1,'121212',0,0,1,0,NULL,NULL,0,0.00,0.00,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL,0,0,1,NULL,0,NULL,NULL,NULL);
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vip_levels`
--

DROP TABLE IF EXISTS `vip_levels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `vip_levels` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_vip` int(11) NOT NULL,
  `meta` float NOT NULL,
  `bonus` float NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vip_levels`
--

LOCK TABLES `vip_levels` WRITE;
/*!40000 ALTER TABLE `vip_levels` DISABLE KEYS */;
INSERT INTO `vip_levels` VALUES
(1,1,5000,50),
(2,2,18000,180),
(3,3,100000,1000),
(4,4,200000,2000),
(5,5,1000000,5000),
(6,6,1000000,390),
(7,7,1000000,500),
(8,8,1000000,600),
(9,9,1000000,700),
(10,10,1000000,800),
(11,11,2000000,900),
(12,12,3000000,1000),
(13,13,4000000,1100),
(14,14,5000000,1200),
(15,15,6000000,1300),
(16,16,7000000,1400);
/*!40000 ALTER TABLE `vip_levels` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `visita_site`
--

DROP TABLE IF EXISTS `visita_site`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `visita_site` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nav_os` text DEFAULT NULL,
  `mac_os` text DEFAULT NULL,
  `ip_visita` text DEFAULT NULL,
  `refer_visita` text DEFAULT NULL,
  `data_cad` date DEFAULT NULL,
  `hora_cad` time DEFAULT NULL,
  `id_user` int(11) DEFAULT NULL,
  `pais` text DEFAULT NULL,
  `cidade` text DEFAULT NULL,
  `estado` text DEFAULT NULL,
  `ads_tipo` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1158 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `visita_site`
--

LOCK TABLES `visita_site` WRITE;
/*!40000 ALTER TABLE `visita_site` DISABLE KEYS */;
INSERT INTO `visita_site` VALUES
(1105,'Chrome','Windows 10','179.127.135.38','https://w1-tangelopg.pro/next/afiliados','2025-12-21','22:41:43',1,'Brazil','Santa Cruz do Sul','Rio Grande do Sul',NULL),
(1106,'Handheld Browser','iPhone','179.68.23.100','https://w1-tangelopg.pro/home/subgame?gameCategoryId=3&platformId=302','2025-12-21','22:52:06',1,'Brazil','Porto Alegre','Rio Grande do Sul',NULL),
(1107,'Handheld Browser','iPhone','200.34.233.108','https://w1-tangelopg.pro/','2025-12-21','23:31:54',1,'Brazil','Guaiba','Rio Grande do Sul',NULL),
(1108,'Chrome','Windows 10','187.19.227.251','https://w1-tangelopg.pro/','2025-12-21','23:47:57',1,'Brazil','Parnamirim','Rio Grande do Norte',NULL),
(1109,'Chrome','Windows 10','200.34.233.108','https://777-piaui.site/admin','2025-12-22','01:15:21',1,'Brazil','Guaiba','Rio Grande do Sul',NULL),
(1110,'Handheld Browser','iPhone','187.45.66.108','https://777-piaui.site/home/promote?active=myData','2025-12-22','10:54:18',1,'Brazil','Guaiba','Rio Grande do Sul',NULL),
(1111,'Handheld Browser','iPhone','186.251.165.81','https://777-piaui.site/','2025-12-22','13:19:41',1,'Brazil','Santa Cruz do Sul','Rio Grande do Sul',NULL),
(1112,'Handheld Browser','iPhone','179.68.23.100','https://777-piaui.site/','2025-12-22','15:49:41',1,'Brazil','Porto Alegre','Rio Grande do Sul',NULL),
(1113,'Handheld Browser','iPhone','45.165.86.51','https://777-piaui.site/','2025-12-22','17:59:07',1,'Brazil','Porto Alegre','Rio Grande do Sul',NULL),
(1114,'Handheld Browser','iPhone','177.72.109.7','https://777-piaui.site/','2025-12-22','18:17:42',1,'Brazil','Porto Alegre','Rio Grande do Sul',NULL),
(1115,'Safari','Mac OS X','104.28.63.132','https://777-piaui.site/','2025-12-22','20:46:25',1,'Brazil','Porto Alegre','Rio Grande do Sul',NULL),
(1116,'Handheld Browser','iPhone','190.89.207.159','https://777-piaui.site/','2025-12-22','23:22:40',1,'Brazil','Foz do Iguacu','Parana',NULL),
(1117,'Handheld Browser','iPhone','179.68.23.100','https://777-piaui.site/','2025-12-23','00:11:09',1,'Brazil','Porto Alegre','Rio Grande do Sul',NULL),
(1118,'Chrome','Windows 10','177.2.164.153','https://777-piaui.site/next/login','2025-12-23','11:34:39',1,'Brazil','Santa Maria','Rio Grande do Sul',NULL),
(1119,'Handheld Browser','iPhone','45.165.86.51','https://777-piaui.site/','2025-12-23','15:20:45',1,'Brazil','Porto Alegre','Rio Grande do Sul',NULL),
(1120,'Handheld Browser','iPhone','179.68.23.100','https://777-piaui.site/home/mine?id=435780174&currency=BRL&active=index','2025-12-24','02:15:42',1,'Brazil','Porto Alegre','Rio Grande do Sul',NULL),
(1121,'Safari','Mac OS X','186.251.165.81','https://777-piaui.site/','2025-12-24','03:23:28',1,'Brazil','Santa Cruz do Sul','Rio Grande do Sul',NULL),
(1122,'Handheld Browser','iPhone','43.157.156.190','http://777-piaui.site','2025-12-24','09:12:21',1,'Brazil','Sao Paulo','Sao Paulo',NULL),
(1123,'Handheld Browser','iPhone','187.45.66.108','https://777-piaui.site/home/promote?id=435780174&currency=BRL&active=myData','2025-12-24','13:53:40',1,'Brazil','Guaiba','Rio Grande do Sul',NULL),
(1124,'Handheld Browser','iPhone','187.84.155.230','https://777-piaui.site/home/promote?id=435780174&currency=BRL&active=myData','2025-12-24','14:00:27',1,'Brazil','Porto Alegre','Rio Grande do Sul',NULL),
(1125,'Handheld Browser','iPhone','200.34.233.108','https://777-piaui.site/home/promote?id=435780174&currency=BRL&active=myData','2025-12-24','14:53:47',1,'Brazil','Guaiba','Rio Grande do Sul',NULL),
(1126,'Handheld Browser','iPhone','43.157.170.13','http://777-piaui.site','2025-12-24','16:08:17',1,'Brazil','Sao Paulo','Sao Paulo',NULL),
(1127,'Handheld Browser','iPhone','43.157.170.126','http://777-piaui.site','2025-12-25','06:39:55',1,'Brazil','Sao Paulo','Sao Paulo',NULL),
(1128,'Handheld Browser','iPhone','189.28.48.96','https://777-piaui.site/home/promote?id=435780174&currency=BRL&active=myData','2025-12-25','23:11:36',1,'Brazil','Florianopolis','Santa Catarina',NULL),
(1129,'Handheld Browser','iPad','38.156.242.25','https://www.google.fr/','2025-12-27','17:38:23',1,'Brazil','VILA BANCARIA','Sao Paulo',NULL),
(1130,'Handheld Browser','Android','200.241.217.226','https://www.google.co.uk/','2025-12-27','17:38:51',1,'Brazil','Vitoria','Espirito Santo',NULL),
(1131,'Handheld Browser','iPhone','186.251.165.81','https://777-piaui.site/','2025-12-28','05:14:04',1,'Brazil','Santa Cruz do Sul','Rio Grande do Sul',NULL),
(1132,'Handheld Browser','Android','191.12.68.139','https://www.bing.com/','2025-12-30','17:17:03',1,'Brazil','Rio de Janeiro','Rio de Janeiro',NULL),
(1133,'Handheld Browser','Android','191.249.201.220','https://www.google.co.uk/','2025-12-30','17:17:34',1,'Brazil','Rio de Janeiro','Rio de Janeiro',NULL),
(1134,'Safari','Mac OS X','186.251.165.81','https://777-piaui.site/','2025-12-31','05:13:30',1,'Brazil','Santa Cruz do Sul','Rio Grande do Sul',NULL),
(1135,'Handheld Browser','iPhone','43.157.191.20','http://777-piaui.site','2025-12-31','11:01:29',1,'Brazil','Sao Paulo','Sao Paulo',NULL),
(1136,'Handheld Browser','iPhone','189.28.48.96','https://777-piaui.site/','2025-12-31','17:30:05',1,'Brazil','Florianopolis','Santa Catarina',NULL),
(1137,'Handheld Browser','iPhone','200.173.204.192','https://777-piaui.site/','2026-01-01','14:19:39',1,'Brazil','Blumenau','Santa Catarina',NULL),
(1138,'Handheld Browser','iPhone','189.28.48.96','https://777-piaui.site/','2026-01-01','20:50:20',1,'Brazil','Florianopolis','Santa Catarina',NULL),
(1139,'Handheld Browser','iPhone','186.251.165.81','https://777-piaui.site/','2026-01-02','00:52:15',1,'Brazil','Santa Cruz do Sul','Rio Grande do Sul',NULL),
(1140,'Chrome','Windows 10','189.28.48.96','https://777-piaui.site/next/login','2026-01-02','02:05:20',1,'Brazil','Florianopolis','Santa Catarina',NULL),
(1141,'Chrome','Windows 10','177.4.177.92','https://777-piaui.site/','2026-01-02','02:35:11',1,'Brazil','Corumba','Mato Grosso do Sul',NULL),
(1142,'Chrome','Windows 10','191.253.208.5','https://www.google.com/','2026-01-02','02:35:33',1,'Brazil','Cantagalo','Rio de Janeiro',NULL),
(1143,'Handheld Browser','iPhone','43.157.142.101','http://777-piaui.site','2026-01-02','08:30:44',1,'Brazil','Sao Paulo','Sao Paulo',NULL),
(1144,'Handheld Browser','iPhone','191.245.93.120','https://777-piaui.site/home/mine?active=index','2026-01-02','12:52:59',1,'Brazil','Porto Uniao','Santa Catarina',NULL),
(1145,'Handheld Browser','iPhone','200.173.208.132','https://777-piaui.site/home/mine?active=index','2026-01-02','13:45:39',1,'Brazil','Blumenau','Santa Catarina',NULL),
(1146,'Handheld Browser','iPhone','179.68.23.226','https://777-piaui.site/home/mine?active=index','2026-01-02','19:08:07',1,'Brazil','Porto Alegre','Rio Grande do Sul',NULL),
(1147,'Safari','Mac OS X','104.28.63.131','https://777-piaui.site/','2026-01-03','04:06:44',1,'Brazil','Porto Alegre','Rio Grande do Sul',NULL),
(1148,'Chrome','Windows 10','177.4.177.92','https://777-piaui.site/home/promote?active=myData','2026-01-05','10:18:22',1,'Brazil','Corumba','Mato Grosso do Sul',NULL),
(1149,'Handheld Browser','iPhone','200.34.234.135','https://777-piaui.site/','2026-01-05','12:18:01',1,'Brazil','Guaiba','Rio Grande do Sul',NULL),
(1150,'Handheld Browser','iPhone','187.45.77.131','https://777-piaui.site/home/mine','2026-01-05','13:30:35',1,'Brazil','Sapucaia do Sul','Rio Grande do Sul',NULL),
(1151,'Handheld Browser','iPhone','186.251.165.81','https://777-piaui.site/','2026-01-06','03:00:32',1,'Brazil','Santa Cruz do Sul','Rio Grande do Sul',NULL),
(1152,'Chrome','Windows 10','177.4.177.92','https://777-piaui.site/home/promote?active=myData','2026-01-06','19:49:11',1,'Brazil','Corumba','Mato Grosso do Sul',NULL),
(1153,'Chrome','Windows 10','177.4.177.92','https://777-piaui.site/','2026-01-07','11:57:05',1,'Brazil','Corumba','Mato Grosso do Sul',NULL),
(1154,'Chrome','Windows 10','189.28.198.237','https://adorar777.com/next/contasdemos.php','2026-01-07','21:21:57',1,'Brazil','Triunfo','Rio Grande do Sul',NULL),
(1155,'Handheld Browser','iPhone','152.254.162.167','https://777-piaui.site/','2026-01-08','02:17:18',1,'Brazil','Porto Alegre','Rio Grande do Sul',NULL),
(1156,'Safari','Mac OS X','186.251.163.90','https://777-piaui.site/','2026-01-08','05:10:59',1,'Brazil','Santa Cruz do Sul','Rio Grande do Sul',NULL),
(1157,'Chrome','Windows 10','177.4.177.92','https://777-piaui.site/','2026-01-09','12:51:28',1,'Brazil','Corumba','Mato Grosso do Sul',NULL);
/*!40000 ALTER TABLE `visita_site` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `webhook`
--

DROP TABLE IF EXISTS `webhook`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `webhook` (
  `id` int(11) NOT NULL,
  `nome` text NOT NULL,
  `bot_id` varchar(255) NOT NULL,
  `chat_id` varchar(255) NOT NULL,
  `status` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `webhook`
--

LOCK TABLES `webhook` WRITE;
/*!40000 ALTER TABLE `webhook` DISABLE KEYS */;
INSERT INTO `webhook` VALUES
(1,'Cadastros e Pixs','8134985546:AAH64TPR7C2J-LuDlv6v7mLtkE5vl_I9C2E','-4995840746',1),
(2,'Saques','8134985546:AAH64TPR7C2J-LuDlv6v7mLtkE5vl_I9C2E','-4857685829',1);
/*!40000 ALTER TABLE `webhook` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-01-09 15:58:55
