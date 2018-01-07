#!/bin/bash

DESTINATION=$1

if [ -z "$DESTINATION" ]; then
    echo 'missing argument destination'
    exit 1
fi

#make dir structure
mkdir -p $DESTINATION/{bin,dev,etc,lib,lib64,mnt/root,proc,root,sbin,sys}

#copy required dev files
sudo cp -a /dev/{null,console,tty} $DESTINATION/dev

#copy apps
cp -a /bin/busybox $DESTINATION/bin/busybox

#copy init

cp -a init $DESTINATION/init
chmod +x $DESTINATION/init
