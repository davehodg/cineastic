
DROP TABLE IF EXISTS friend;
CREATE TABLE friend (
       id          INT NOT NULL AUTO_INCREMENT,
       user_id	    int NOT NULL,
       friend_id    int NOT NULL,
       pending	    smallint,

       PRIMARY KEY (id),
       unique      (user_id, friend_id),
       KEY         (user_id),
       KEY         (friend_id),

       CONSTRAINT  FOREIGN KEY ibfk_user   (user_id)   REFERENCES user(user_id) ON DELETE CASCADE,
       CONSTRAINT  FOREIGN KEY ibfk_friend (friend_id) REFERENCES user(user_id) ON DELETE CASCADE

) ENGINE InnoDB CHARACTER SET utf8;

