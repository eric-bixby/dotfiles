#!/bin/sh

if [ ! -e /Volumes/Documents/ ]
then
    sudo mount -t smbfs  //GUEST:@NAS-BA-F3-F8._smb._tcp.local/Documents /Volumes/Documents
fi

