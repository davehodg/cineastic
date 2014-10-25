#!/bin/sh

#cp config.yml.live config.yml



#curl ftp://ftp.funet.fi/pub/mirrors/ftp.imdb.com/pub/movies.list.gz >/tmp/movies.list.gz
#curl ftp://ftp.funet.fi/pub/mirrors/ftp.imdb.com/pub/ratings.list.gz >/tmp/ratings.list.gz
curl -kL --user bbccouk-21:fjko123d --digest 'https://assoc-datafeeds-eu.amazon.com/datafeed/getFeed?filename=uk_amazon_dvd.xml.gz' >/tmp/uk_amazon_dvd.xml.gz


#time perl etc/load_imdb.pl

time perl etc/load_amazon.pl
#time perl etc/load_rotten.pl
#time perl etc/load_thehut.pl

#cp config.yml.local config.yml