
-- switch to database
USE proftpd;

-- 

INSERT INTO ftpuser (username, passwd,homedir)
      VALUES ("test", ENCRYPT("test", "NULL"), "/ftp/test")
      ON DUPLICATE KEY UPDATE passwd=SHA2("test", 256);

INSERT INTO ftpgroup (groupname,members)
      VALUES ("test", "test")
      ON DUPLICATE KEY UPDATE groupname=groupname;


-- Set file space to 1MB
INSERT INTO ftpquotalimits (name, quota_type, bytes_in_avail) 
    VALUES ("test", "user", 1024 * 1024)
    ON DUPLICATE KEY UPDATE name="test";

-- vim:syntax=mysql
