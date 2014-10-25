echo "drop table friend" |  mysql -hmovies-davehodg.dotcloud.com -P33877 -uroot -pKL9OIZ5YBGKpkb1n6a1b
echo "drop table review" |  mysql -hmovies-davehodg.dotcloud.com -P33877 -uroot -pKL9OIZ5YBGKpkb1n6a1b
echo "drop table product" |  mysql -hmovies-davehodg.dotcloud.com -P33877 -uroot -pKL9OIZ5YBGKpkb1n6a1b
echo "drop table movie" |  mysql -hmovies-davehodg.dotcloud.com -P33877 -uroot -pKL9OIZ5YBGKpkb1n6a1b
echo "drop table user" |  mysql -hmovies-davehodg.dotcloud.com -P33877 -uroot -pKL9OIZ5YBGKpkb1n6a1b
echo "drop table supplier" |  mysql -hmovies-davehodg.dotcloud.com -P33877 -uroot -pKL9OIZ5YBGKpkb1n6a1b

for i in supplier movies product user friend review
do
   echo $i
   cat sql/$i.sql |  mysql -hmovies-davehodg.dotcloud.com -P33877 -uroot -pKL9OIZ5YBGKpkb1n6a1b
done

etc/schema_create.pl

etc/load_imdb.pl
etc/load_amazon.pl