#!/bin/sh

sudo mount -t cifs //nas-ba-f3-f8.local/documents/ -o username='eric',domain='workgroup',uid=$(id -u),gid=$(id -g) /mnt/documents

