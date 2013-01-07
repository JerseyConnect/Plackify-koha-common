#!/bin/sh
#
# Make OPAC Plack socket for named Koha instance world-writable
#

test ! -z "$1" && site=$1 && shift
 
timeout=0
 
echo "Waiting for OPAC Plack socket for $site"
while [ ! -S /var/run/koha/$site/opac-plack.sock ] && [ $timeout -lt 10 ]
do
        sleep 1
        timeout=$(($timeout + 1))
done
 
chmod 777 /var/run/koha/$site/opac-plack.sock
echo "OPAC Plack socket open for $site"