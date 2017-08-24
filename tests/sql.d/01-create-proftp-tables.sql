
-- create database
CREATE DATABASE IF NOT EXISTS proftpd;
-- create user (the MySQL way)
GRANT ALL ON `proftpd`.* TO 'proftpd'@'localhost' IDENTIFIED BY 'nbusr123';
GRANT ALL ON `proftpd`.* TO 'proftpd'@'%' IDENTIFIED BY 'nbusr123';


-- switch to database
USE proftpd;

-- 

CREATE TABLE IF NOT EXISTS ftpuser (
  id int unsigned NOT NULL AUTO_INCREMENT,
  username varchar(42) NOT NULL,
  passwd varchar(64) NOT NULL,
  homedir varchar(255) NOT NULL,
  count int unsigned NOT NULL DEFAULT 0,
  accessed datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (id),
  UNIQUE KEY username (username)
);

CREATE TABLE IF NOT EXISTS ftpgroup (
  id int unsigned NOT NULL AUTO_INCREMENT,
  groupname varchar(42) NOT NULL,
  members varchar(255) NOT NULL,
  PRIMARY KEY (id),
  UNIQUE KEY groupname (groupname)
);


-- from http://www.proftpd.org/docs/contrib/mod_quotatab_sql.html

CREATE TABLE ftpquotalimits (
      name VARCHAR(30),
      quota_type ENUM("user", "group", "class", "all") NOT NULL,
      per_session ENUM("false", "true") NOT NULL DEFAULT "false",
      limit_type ENUM("soft", "hard") NOT NULL DEFAULT "hard",
      bytes_in_avail FLOAT NOT NULL DEFAULT 0,
      bytes_out_avail FLOAT NOT NULL DEFAULT 0,
      bytes_xfer_avail FLOAT NOT NULL DEFAULT 0,
      files_in_avail INT UNSIGNED NOT NULL DEFAULT 0,
      files_out_avail INT UNSIGNED NOT NULL DEFAULT 0,
      files_xfer_avail INT UNSIGNED NOT NULL DEFAULT 0
    );

CREATE TABLE ftpquotatallies (
      name VARCHAR(30) NOT NULL,
      quota_type ENUM("user", "group", "class", "all") NOT NULL,
      bytes_in_used FLOAT NOT NULL,
      bytes_out_used FLOAT NOT NULL,
      bytes_xfer_used FLOAT NOT NULL,
      files_in_used INT UNSIGNED NOT NULL,
      files_out_used INT UNSIGNED NOT NULL,
      files_xfer_used INT UNSIGNED NOT NULL
    );

-- vim:syntax=mysql
