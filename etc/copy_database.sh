#!/bin/sh


mysqldump --opt -K -uroot movies | dotcloud run movies.data -- mysql -hmovies-davehodg.dotcloud.com -uroot -pqw36frEfd0nsrjduN9yH -P39647 movies

