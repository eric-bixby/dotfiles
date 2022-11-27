#!/bin/sh

if [ ! -e ~/Docs/Code/ ]
then
    sudo mount -t smbfs  //GUEST:@NAS-BA-F3-F8._smb._tcp.local/Documents /Users/ericbixby/Docs
fi

