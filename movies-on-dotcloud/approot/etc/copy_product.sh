#!/bin/sh


mysqldump --opt -K -uroot movies product | dotcloud run movies.data -- mysql -hmovies-davehodg.dotcloud.com -uroot -puLM3XT86XWeF7JR6OQNL -P33878 movies

