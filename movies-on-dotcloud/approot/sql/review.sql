

DROP TABLE IF EXISTS review;
CREATE TABLE review (
       id   INT NOT NULL AUTO_INCREMENT,
       movie_id	   int,
       user_id	   int,
       rating      smallint,
       wanttosee   smallint,
       review      varchar(255),
       updated	   timestamp,
       PRIMARY KEY (id),
       KEY movie_id (movie_id),
       key(user_id),
       unique  movie_user (movie_id, user_id),
       CONSTRAINT  FOREIGN KEY ibfk_movie (movie_id) REFERENCES movie(id) ON DELETE CASCADE,
       CONSTRAINT  FOREIGN KEY ibfk_user  (user_id)  REFERENCES user(user_id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


