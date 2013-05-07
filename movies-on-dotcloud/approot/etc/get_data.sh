#!/bin/sh -x

set +e
curl -skL --user bbccouk-21:fjko123d --digest 'https://assoc-datafeeds-eu.amazon.com/datafeed/getFeed?filename=uk_amazon_dvd.xml.gz' -o /tmp/uk_amazon_dvd.xml.gz
gunzip  -f /tmp/uk_amazon_dvd.xml.gz

curl ftp://ftp.funet.fi/pub/mirrors/ftp.imdb.com/pub/movies.list.gz -o /tmp/movies.list.gz 
curl ftp://ftp.funet.fi/pub/mirrors/ftp.imdb.com/pub/movie-links.list.gz -o /tmp/movie-links.list.gz 
curl ftp://ftp.funet.fi/pub/mirrors/ftp.imdb.com/pub/ratings.list.gz -o /tmp/ratings.list.gz 


perl etc/load_imdb.pl
perl etc/load_amazon.pl
perl etc/load_rotten.pl
perl etc/load_thehut.pl

