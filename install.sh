#!/bin/sh
#
# Install script for Plackify koha-common
#

if [ -d /usr/share/koha ]; then

    # copy scripts from plack subfolder into /usr/share/koha/misc/plack
    cp -R ./plack /usr/share/koha/misc/
    
    # copy scripts from sbin subfolder into /usr/sbin
    cp ./sbin/* /usr/sbin/

else
    echo "Could not find koha-common install -- aborting"
fi
