#!/bin/bash
#
# Install script for Plackify koha-common
#

if [ -d /usr/share/koha ]; then

    # copy scripts from plack subfolder into /usr/share/koha/misc/plack
    cp -R ./plack /usr/share/koha/misc/
    
    # copy scripts from sbin subfolder into /usr/sbin
    cp ./sbin/* /usr/sbin/
    
    # offer to patch koha-common init script to start/stop Plack
    read -p "Do you want to run Plack servers at startup? " -n 1 -r
    echo ""
    
    if [[ $REPLY =~ ^[Yy]$ ]]; then
    
        echo "Patching init script..."
        cp /etc/init.d/koha-common ./koha-common-backup
        patch /etc/init.d/koha-common init/koha-common.patch
        echo "done."
        
    fi

else
    echo "Could not find koha-common install -- aborting"
fi
