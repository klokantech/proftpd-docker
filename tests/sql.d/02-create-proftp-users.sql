
-- switch to database
USE proftpd;

-- 

INSERT INTO ftpuser (username, passwd,homedir)
      VALUES ("test", ENCRYPT("test", "NULL"), "/ftp/test")
      ON DUPLICATE KEY UPDATE passwd=SHA2("test", 256);

INSERT INTO ftpgroup (groupname,members)
      VALUES ("test", "test")
      ON DUPLICATE KEY UPDATE groupname=groupname;

-- vim:syntax=mysql
