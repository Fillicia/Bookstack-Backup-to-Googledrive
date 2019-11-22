#!/bin/bash

url="http://localhost/books/"   #change to your wiki url, must end with "books/"
backupfolder="/home/backup/"
remote="remote:Bookstack"


#Define one or multiple format you wish to backup
html="true"
pdf="true"
plaintext="true"

wget -qO- $url | grep -o "$url[a-zA-Z0-9./?=_-]*" | sort -u | while read -r line ; do
#wget -qO- $url ////// gets the html from the /books/ page
#grep -o "$url[a-zA-Z0-9./?=_-]*" ////// extract all the individual books urls
#sort -u ///// remove all duplicate urls
#while read -r line ; do ///// start an action per resulting url
    filename=${line//$url/}
    if [ $html = "true" ]; then
        wget $line"/export/html" -N -q -O $backupfolder"/html/"$filename".html" #wget [the file] -N (timestamping) -quiet -Output>>
    fi
    if [ $pdf = "true" ]; then
        wget $line"/export/pdf" -N -q -O $backupfolder"/pdf/"$filename".pdf"
    fi
    if [ $plaintext = "true" ]; then
        wget $line"/export/plaintext" -N -q -O $backupfolder"/plaintext/"$filename".plaintext"
    fi
done

rclone sync --quiet --size-only --no-update-modtime --drive-use-trash=false $backupfolder $remote
