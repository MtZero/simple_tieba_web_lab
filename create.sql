CREATE DATABASE `tieba` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;

USE `tieba`;

CREATE TABLE `users` (
  `uid`      INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `username` CHAR(30)         NOT NULL,
  `password` CHAR(45)         NOT NULL,
  `role`     INT(11)          NOT NULL DEFAULT '0',
  `avatar`   VARCHAR(100)              DEFAULT NULL,
  PRIMARY KEY (`uid`, `username`),
  UNIQUE KEY `uid_UNIQUE` (`uid`),
  UNIQUE KEY `username_UNIQUE` (`username`)
)
  ENGINE = InnoDB
  AUTO_INCREMENT = 6
  DEFAULT CHARSET = utf8mb4;


/* The admin's password should be set manually */
/* The current password is 1 */
INSERT INTO `users` (`username`, `password`, `role`) VALUES ('admin', '45d76d8f3ce00ecd799b03a73bf825c8', 99);

CREATE TABLE `posts` (
  `pid`        INT(11)          NOT NULL AUTO_INCREMENT,
  `uid`        INT(10) UNSIGNED NOT NULL,
  `p_title`    VARCHAR(100)              DEFAULT NULL,
  `p_content`  VARCHAR(10000)            DEFAULT NULL,
  `p_datetime` DATETIME         NOT NULL,
  `p_floor`    INT(11)          NOT NULL DEFAULT '1',
  `r_uid`      INT(10) UNSIGNED          DEFAULT NULL,
  `r_datetime` DATETIME                  DEFAULT NULL,
  `state`      INT(11)          NOT NULL DEFAULT '0',
  PRIMARY KEY (`pid`),
  UNIQUE KEY `pid_UNIQUE` (`pid`),
  KEY `uid_idx` (`uid`, `r_uid`),
  KEY `posts2_idx` (`r_uid`),
  KEY `datetime` (`r_datetime`, `p_datetime`),
  CONSTRAINT `posts2` FOREIGN KEY (`r_uid`) REFERENCES `users` (`uid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
)
  ENGINE = InnoDB
  AUTO_INCREMENT = 10
  DEFAULT CHARSET = utf8mb4;

CREATE DEFINER =`root`@`localhost` TRIGGER `tieba`.`posts_BEFORE_INSERT`
  BEFORE INSERT
  ON `posts`
  FOR EACH ROW
  BEGIN
    SET new.r_datetime = new.p_datetime;
  END;

CREATE TABLE `comments` (
  `cid`        INT(11)          NOT NULL AUTO_INCREMENT,
  `pid`        INT(11)          NOT NULL,
  `uid`        INT(10) UNSIGNED NOT NULL,
  `c_floor`    INT(11)          NOT NULL DEFAULT '0',
  `r_floor`    INT(11)                   DEFAULT NULL,
  `c_content`  VARCHAR(10000)            DEFAULT NULL,
  `c_datetime` DATETIME         NOT NULL,
  `state`      INT(11)          NOT NULL DEFAULT '0',
  PRIMARY KEY (`cid`),
  UNIQUE KEY `cid_UNIQUE` (`cid`),
  KEY `uid_idx` (`uid`),
  KEY `pid_idx` (`pid`),
  CONSTRAINT `comments` FOREIGN KEY (`uid`) REFERENCES `posts` (`uid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
)
  ENGINE = InnoDB
  AUTO_INCREMENT = 6
  DEFAULT CHARSET = utf8mb4;

CREATE DEFINER =`root`@`localhost` TRIGGER `tieba`.`comments_BEFORE_INSERT`
  BEFORE INSERT
  ON `comments`
  FOR EACH ROW
  BEGIN
    DECLARE sum_floor INT;
    SET sum_floor = (SELECT `p_floor`
                     FROM `posts`
                     WHERE `pid` = new.pid FOR UPDATE);
    SET new.c_floor = sum_floor;
    UPDATE `posts`
    SET `p_floor` = `p_floor` + 1
    WHERE `pid` = new.pid;
    UPDATE `posts`
    SET `r_datetime` = new.c_datetime
    WHERE `pid` = new.pid;
  END;