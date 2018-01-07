#!/bin/bash

DESTINATION=$1

if [ -z "$DESTINATION" ]; then
    echo 'missing argument destination'
    exit 1
fi

copy_app() {
    BIN=$1
    DESTINATION=$2
    cp -a $BIN $DESTINATION/$BIN
    #copy deps
    ldd $BIN | grep -o  -P '\/.*\.[\w:]+' | while read line; do
	cp $line $DESTINATION/$line
    done
}

#make dir structure
mkdir -p $DESTINATION/{bin,dev,etc,lib,lib64,mnt/root,proc,root,sbin,sys,usr/sbin/,usr/lib64}

#copy required dev files
sudo cp -a /dev/{null,console,tty} $DESTINATION/dev

#copy apps
copy_app /bin/busybox $DESTINATION
copy_app /sbin/fsck $DESTINATION
copy_app /usr/sbin/fsck.f2fs $DESTINATION


#copy init
cp -a init $DESTINATION/init
chmod +x $DESTINATION/init
