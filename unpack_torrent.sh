#!/bin/bash

# Small script to un-archive all the compressed torrent downloads from transmission and log what happened to the latest torrent downloaded
# Author: Dan Achim (dan@hostatic.ro)

sudo touch /var/log/transmission.log && sudo chown `whoami` /var/log/transmission.log
echo $TR_TIME_LOCALTIME > /var/log/transmission.log
echo $TR_TORRENT_DIR >> /var/log/transmission.log
echo $TR_TORRENT_NAME >> /var/log/transmission.log

if [ -d "$TR_TORRENT_DIR"/"$TR_TORRENT_NAME" ]; then
    cd $TR_TORRENT_DIR/$TR_TORRENT_NAME
    CURRENT_DIR=`pwd`
        if [ $CURRENT_DIR = $HOME ]; then
            echo "The current dir is $CURRENT_DIR so I will not continue because it will mess up!" >> /var/log/transmission.log ; exit 25
        else
            echo "The directory of torrent $TR_TORRENT_NAME is `pwd`" >> /var/log/transmission.log
            find ./ -name "*.rar" -exec unrar e {} \;
            find ./ -name "*.zip" -exec unzip {} \;
        fi
fi
