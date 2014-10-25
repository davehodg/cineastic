#!/bin/sh

set +e
set -x

make clean
rm -rf inc

export PERL5LIB=lib:$PERL5LIB
prove -r t


rsync -rvaz --delete . www.cineastic.co.uk:~/cineastic

ssh www.cineastic.co.uk "(cd nomr-api ;  cpanm .)"

time /usr/local/mysql/bin/mysqldump -uroot cineastic \
    | ssh -C www.cineastic.co.uk mysql -ucineastic -pxcineasticx cineastic
