CREATE DATABASE `tieba` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;

USE `tieba`;

CREATE TABLE `users` (
  `uid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `username` char(30) NOT NULL,
  `password` char(45) NOT NULL,
  `role` int(11) NOT NULL DEFAULT '0',
  `avatar` varchar(200) NOT NULL DEFAULT 'default-avatar.jpg',
  PRIMARY KEY (`uid`,`username`),
  UNIQUE KEY `uid_UNIQUE` (`uid`),
  UNIQUE KEY `username_UNIQUE` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4;



/* The admin's password should be set manually */
/* The current password is 1 */
INSERT INTO `users` (`username`, `password`, `role`) VALUES ('admin', '45d76d8f3ce00ecd799b03a73bf825c8', 99);

CREATE TABLE `posts` (
  `pid` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(10) unsigned NOT NULL,
  `p_title` varchar(100) DEFAULT NULL,
  `p_content` varchar(10000) DEFAULT NULL,
  `p_datetime` datetime NOT NULL,
  `p_floor` int(11) NOT NULL DEFAULT '1',
  `r_uid` int(10) unsigned DEFAULT NULL,
  `r_datetime` datetime DEFAULT NULL,
  `state` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`pid`),
  UNIQUE KEY `pid_UNIQUE` (`pid`),
  KEY `uid_idx` (`uid`,`r_uid`),
  KEY `posts2_idx` (`r_uid`),
  KEY `datetime` (`r_datetime`,`p_datetime`),
  CONSTRAINT `posts2` FOREIGN KEY (`r_uid`) REFERENCES `users` (`uid`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4;

CREATE TABLE `comments` (
  `cid` int(11) NOT NULL AUTO_INCREMENT,
  `pid` int(11) NOT NULL,
  `uid` int(10) unsigned NOT NULL,
  `c_floor` int(11) NOT NULL DEFAULT '0',
  `r_floor` int(11) DEFAULT NULL,
  `c_content` varchar(10000) DEFAULT NULL,
  `c_datetime` datetime NOT NULL,
  `state` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`cid`),
  UNIQUE KEY `cid_UNIQUE` (`cid`),
  KEY `pid_idx` (`pid`),
  KEY `comments_idx` (`uid`),
  CONSTRAINT `comments` FOREIGN KEY (`uid`) REFERENCES `users` (`uid`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4;

DELIMITER $$
USE `tieba`$$
CREATE TRIGGER `tieba`.`posts_BEFORE_INSERT` BEFORE INSERT ON `posts` FOR EACH ROW
BEGIN
	SET new.r_datetime = new.p_datetime;
END$$
DELIMITER ;

DELIMITER $$
USE `tieba`$$
CREATE TRIGGER `tieba`.`comments_BEFORE_INSERT` BEFORE INSERT ON `comments` FOR EACH ROW
BEGIN
	DECLARE sum_floor int;
    SET sum_floor = (SELECT `p_floor` FROM `posts` WHERE `pid` = new.pid FOR UPDATE);
    SET new.c_floor = sum_floor;
    UPDATE `posts` SET `p_floor` = `p_floor` + 1 WHERE `pid` = new.pid;
    UPDATE `posts` SET `r_datetime` = new.c_datetime WHERE `pid` = new.pid;
END$$
DELIMITER ;
