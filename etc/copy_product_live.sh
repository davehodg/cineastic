#!/bin/sh


mysqldump --opt -K -uroot movies product | dotcloud run data -- mysql -h cineasticilive-davehodg.azva.dotcloud.net -uroot -p9bNFI6Kw1AJzSH42U79b -P38305 movies

