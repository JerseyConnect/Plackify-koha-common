#!/bin/sh
#
# Make Intranet Plack socket for named Koha instance world-writable
#
 
test ! -z "$1" && site=$1 && shift
 
timeout=0
 
echo "Waiting for Intranet Plack socket for $site"
while [ ! -S /var/run/koha/$site/intranet-plack.sock ] && [ $timeout -lt 10 ]
do
        sleep 1
        timeout=$(($timeout + 1))
done
 
chmod 777 /var/run/koha/$site/intranet-plack.sock
echo "Intranet Plack socket open for $site"