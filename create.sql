CREATE DATABASE `tieba` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;

USE `tieba`;

CREATE TABLE `users` (
  `uid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `username` char(30) NOT NULL,
  `password` char(45) NOT NULL,
  `role` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`uid`,`username`),
  UNIQUE KEY `uid_UNIQUE` (`uid`),
  UNIQUE KEY `username_UNIQUE` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;

CREATE TABLE `posts` (
  `pid` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(10) unsigned NOT NULL,
  `p_content` varchar(10000) DEFAULT NULL,
  `p_datetime` datetime NOT NULL,
  `p_floor` int(11) NOT NULL DEFAULT '1',
  `state` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`pid`,`uid`),
  UNIQUE KEY `pid_UNIQUE` (`pid`),
  KEY `uid_idx` (`uid`),
  CONSTRAINT `posts` FOREIGN KEY (`uid`) REFERENCES `users` (`uid`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `comments` (
  `cid` int(11) NOT NULL AUTO_INCREMENT,
  `pid` int(11) NOT NULL,
  `c_floor` int(11) NOT NULL,
  `uid` int(10) unsigned NOT NULL,
  `r_floor` int(11) DEFAULT NULL,
  `c_content` varchar(10000) DEFAULT NULL,
  `state` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`cid`,`pid`),
  UNIQUE KEY `cid_UNIQUE` (`cid`),
  KEY `uid_idx` (`uid`),
  CONSTRAINT `comments` FOREIGN KEY (`uid`) REFERENCES `posts` (`uid`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

