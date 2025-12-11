#!/bin/sh

sudo mount -t cifs //nas-ba-f3-f8.local/documents/ -o username='ericbixby',domain='workgroup',uid=$(id -u),gid=$(id -g) /mnt/documents

