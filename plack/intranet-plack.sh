#!/bin/sh -xe
#
# Create Intranet Plack server for named Koha instance
#
# --max-requests = decreased from 1000 to 50 to keep memory usage sane
# --workers = number of cores on machine
 
test ! -z "$1" && site=$1 && shift
dir=`dirname $0`
 
export KOHA_CONF=/etc/koha/sites/$site/koha-conf.xml
export INTRANETDIR="$( xmlstarlet sel -t -v 'yazgfs/config/intranetdir' $KOHA_CONF | sed 's,/cgi-bin,,' )"
export LOGDIR="$( xmlstarlet sel -t -v 'yazgfs/config/logdir' $KOHA_CONF )"
 
export MEMCACHED_SERVERS=localhost:11211
export MEMCACHED_NAMESPACE=$site
 
PIDFILE=/var/run/koha/$site/intranet-plack.pid
 
SOCKET=/var/run/koha/$site/intranet-plack.sock
#PORT=5001
 
# uncomment to enable logging
opt="$opt --access-log $LOGDIR/intranet-access.log --error-log $LOGDIR/intranet-error.log"
opt="$opt -M FindBin --max-requests 50 --workers 2 -E deployment"
 
if [ $SOCKET ]; then
    opt="$opt --listen $SOCKET -D --pid $PIDFILE"
elif [ $PORT ]; then
    opt="$opt --port $PORT -D --pid $PIDFILE"
fi
 
/usr/local/bin/starman $opt $dir/koha.psgi