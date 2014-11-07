#!/bin/sh

set +e
set -x

make clean
rm -rf inc

export PERL5LIB=lib:$PERL5LIB
#prove -r t


mysqldump -uroot -d cineastic >sql/schema_local.sql
ssh www.cineastic.co.uk 'mysqldump -uroot -pxmysqlx -d cineastic' >sql/schema_live.sql


rsync -Crvaz --exclude=sql/ --delete . www.cineastic.co.uk:~/cineastic

#ssh www.cineastic.co.uk "(source perl5/perlbrew/etc/bashrc; cd cineastic ;  PERL5LIB=lib cpanm .)"

time mysqldump -uroot cineastic | ssh -C www.cineastic.co.uk mysql -ucineastic -pxcineasticx cineastic
