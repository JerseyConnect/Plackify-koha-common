#!/bin/sh -e
#
# Create OPAC Plack server for named Koha instance
#
# --max-requests = decreased from 1000 to 50 to keep memory usage sane
# --workers = number of cores on machine
 
test ! -z "$1" && site=$1 && shift
dir=`dirname $0`
 
export KOHA_CONF=/etc/koha/sites/$site/koha-conf.xml
export OPACDIR="$( xmlstarlet sel -t -v 'yazgfs/config/opacdir' $KOHA_CONF | sed 's,/cgi-bin/opac,,' )"
export LOGDIR="$( xmlstarlet sel -t -v 'yazgfs/config/logdir' $KOHA_CONF )"
 
export MEMCACHED_SERVERS=localhost:11211
export MEMCACHED_NAMESPACE=$site
 
PIDFILE=/var/run/koha/$site/opac-plack.pid
 
SOCKET=/var/run/koha/$site/opac-plack.sock
#PORT=5000
 
# uncomment to enable logging
opt="$opt --access-log $LOGDIR/opac-access.log --error-log $LOGDIR/opac-error.log"
opt="$opt -M FindBin --max-requests 50 --workers 2 -E deployment"
 
if [ $SOCKET ]; then
    opt="$opt --listen $SOCKET -D --pid $PIDFILE"
elif [ $PORT ]; then
    opt="$opt --port $PORT -D --pid $PIDFILE"
fi
 
/usr/bin/env starman $opt $dir/koha.psgi
