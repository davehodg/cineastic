DROP TABLE IF EXISTS product;
CREATE TABLE product (
       product_id   INT NOT NULL AUTO_INCREMENT,
       movie_id	   int,
       title       varchar(255),
       sku	   char(10), 
       ean	   char(13),
       image_url   varchar(255),
       price       char(6),
       shipping char(6),
       salesrank   int,

       name	   varchar(255),
       description text,
       url_small   varchar(255),
       supplier_id int,
       release_date date,

       url         varchar(255),
       PRIMARY KEY (product_id),
       KEY `title` (`title`),
       UNIQUE ean (ean,supplier_id),
       KEY (movie_id),
       index(release_date),
       CONSTRAINT  FOREIGN KEY ibfk_supplier (supplier_id) REFERENCES supplier(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


 CREATE TABLE `product` (
  `product_id` int(11) NOT NULL AUTO_INCREMENT,
  `movie_id` int(11) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `sku` char(10) DEFAULT NULL,
  `ean` char(13) DEFAULT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  `price` char(6) DEFAULT NULL,
  `shipping` char(6) DEFAULT NULL,
  `salesrank` int(11) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `description` text,
  `url_small` varchar(255) DEFAULT NULL,
  `supplier_id` int(11) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `release_date` datetime DEFAULT NULL,
  PRIMARY KEY (`product_id`),
  UNIQUE KEY `ean` (`ean`,`supplier_id`),
  KEY `title` (`title`),
  KEY `movie_id` (`movie_id`),
  KEY `ibfk_supplier` (`supplier_id`),
  KEY `release_date` (`release_date`),
  CONSTRAINT `product_ibfk_1` FOREIGN KEY (`supplier_id`) REFERENCES `supplier` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=85545 DEFAULT CHARSET=utf8