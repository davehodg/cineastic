

DROP TABLE IF EXISTS movie;
CREATE TABLE movie (
       id          INT NOT NULL AUTO_INCREMENT,
       title       varchar(255),
       year        char(10),
       rating      char(4),

       rt_id	   int,
       rt_imdb     char(8),
       rt_img_det  varchar(255),
       rt_img_thu  varchar(255),
       rt_critic   smallint,
       rt_synopsis text,

       PRIMARY KEY (id),
       KEY `title` (`title`),
       index rating (rating),
       unique      (title,year)
) ENGINE InnoDB CHARACTER SET utf8;

