/*
SQLyog Community v9.10 
MySQL - 5.5.32 : Database - caption_me
*********************************************************************
*/


/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`caption_me` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `caption_me`;

/*Table structure for table `video_captions` */

DROP TABLE IF EXISTS `video_captions`;

CREATE TABLE `video_captions` (
  `video_caption_id` int(11) NOT NULL AUTO_INCREMENT,
  `video_id` int(11) NOT NULL,
  `video_caption_file` varchar(4096) DEFAULT NULL,
  `video_caption_text` text,
  `video_caption_type` varchar(255) DEFAULT NULL,
  `status` char(1) DEFAULT 'A',
  `last_updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`video_caption_id`),
  KEY `FK_videos` (`video_id`),
  CONSTRAINT `FK_videos` FOREIGN KEY (`video_id`) REFERENCES `videos` (`video_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

/*Data for the table `video_captions` */

insert  into `video_captions`(`video_caption_id`,`video_id`,`video_caption_file`,`video_caption_text`,`video_caption_type`,`status`,`last_updated`) values (1,2,NULL,'1\r\n00:00:00,970 --> 00:00:03,000\r\nJellyfish at the Monterey Aquarium\r\n\r\n2\r\n00:00:04,080 --> 00:00:06,080\r\nDude - get out of the way!\r\n\r\n3\r\n00:00:9,350 --> 00:00:13,350\r\nShaky Hands...\r\n\r\n4\r\n00:00:17,000 --> 00:00:22,000\r\nAh yes, this is better...\r\n\r\n5\r\n00:00:24,825 --> 00:00:27,825\r\nPro Tip: Turn off the camera flash!\r\n\r\n5\r\n00:00:33,000 --> 00:00:41,000\r\nThanks for watching and I hope you\'ll have fun with the VideoSub library!','text/srt','A','2014-03-23 06:31:51');

/*Table structure for table `videos` */

DROP TABLE IF EXISTS `videos`;

CREATE TABLE `videos` (
  `video_id` int(11) NOT NULL AUTO_INCREMENT,
  `video_url_sha256` varchar(128) NOT NULL,
  `video_url` varchar(4096) NOT NULL,
  `video_mime_type` varchar(255) DEFAULT NULL,
  `video_codec` varchar(127) DEFAULT NULL,
  `video_views` int(11) DEFAULT NULL,
  `video_name` varchar(1024) DEFAULT NULL,
  `video_description` varchar(1024) DEFAULT NULL,
  `video_tags` varchar(4096) DEFAULT NULL,
  `video_thumbnail` blob,
  `video_thumbnail_filename` varchar(255) DEFAULT NULL,
  `status` char(1) DEFAULT 'A',
  `last_updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`video_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

/*Data for the table `videos` */

insert  into `videos`(`video_id`,`video_url_sha256`,`video_url`,`video_mime_type`,`video_codec`,`video_views`,`video_name`,`video_description`,`video_tags`,`video_thumbnail`,`video_thumbnail_filename`,`status`,`last_updated`) values (1,'a59d877f08c74f6a189482d060b4abdacc97be82f1d7655a473b792a3e9d28ec','http://www.discovery.com/tv-shows/other-shows/videos/how-the-universe-works-black-hole-power.htm','video/mp4',NULL,0,'Black Hole Power','How the Universe Works: Black Hole Power','universe, black hole',NULL,NULL,'A','2014-03-22 01:16:17'),(2,'d4f033297f0f955839b055cca0b7241a0ba35836f2634b3175817291231765ff','http://www.storiesinflight.com/js_videosub/jellies.mp4','video/mp4',NULL,0,'Jellies','Jelly Fish','jelly fish, Aquarium',NULL,NULL,'A','2014-03-23 06:28:55');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
