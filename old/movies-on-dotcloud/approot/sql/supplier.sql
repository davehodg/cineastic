

DROP TABLE IF EXISTS supplier;
CREATE TABLE supplier (
       id          INT NOT NULL AUTO_INCREMENT,
       title       varchar(255),
       live	   smallint,
       unique	   (title),
       PRIMARY KEY (id)
) ENGINE InnoDB CHARACTER SET utf8;

insert into supplier values (0,"Amazon",1) ;
insert into supplier values (0,"The Hut",1) ;
insert into supplier values (0,"Zavvi",1) ;
