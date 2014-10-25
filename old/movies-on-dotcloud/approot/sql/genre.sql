




DROP TABLE IF EXISTS genre;
CREATE TABLE genre (
       id          INT NOT NULL AUTO_INCREMENT,
       title       varchar(32) NOT NULL,
       PRIMARY KEY (id)
) ENGINE InnoDB CHARACTER SET utf8;


DROP TABLE IF EXISTS movie_genre;
CREATE TABLE movie_genre (
       id          INT NOT NULL AUTO_INCREMENT,
       genre_id	   INT NOT NULL,
       movie_id	   INT NOT NULL,
       CONSTRAINT  FOREIGN KEY genre_fk (genre_id) REFERENCES genre(id) ON DELETE CASCADE, 
       CONSTRAINT  FOREIGN KEY movie_fk (movie_id) REFERENCES movie(id) ON DELETE CASCADE,
       PRIMARY KEY (id)
) ENGINE InnoDB CHARACTER SET utf8;

