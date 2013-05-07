#!/bin/sh

set -e

FE=moviesfe-on-dotcloud/approot
BE=movies-on-dotcloud/approot


export PATH=$PATH:/home/daveh/perl5/perlbrew/bin
#. perl5/perlbrew/etc/bashrc 


echo  HUP the servers
for i in `ps waux | grep 5003 | grep 'starman master' | cut -c10-14` ; do kill -1 $i; done
for i in `ps waux | grep 5002 | grep 'starman master' | cut -c10-14` ; do kill -1 $i; done

#echo bring up new servers
( cd $BE ; nohup starman --port=5003 & )
( cd $FE ; nohup starman --port=5002 & )

