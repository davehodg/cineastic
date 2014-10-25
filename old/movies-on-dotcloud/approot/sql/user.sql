
DROP TABLE IF EXISTS user;
CREATE TABLE user (
       user_id   INT NOT NULL AUTO_INCREMENT,
       `email`   varchar(255),
       password  char(40),
       firstname char(16),
       lastname  char(16),
       PRIMARY KEY (user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

