#!/bin/sh
#
# Purpose: AAPC course - rename .mov files

OIFS="$IFS"
IFS=$'\n'

for name in `ls *.mov`
do
    echo $name
    newname=`echo $name|sed "s/Chapter /Chapter/"|sed "s/ - /-/"|tr " " "_"`
    echo $newname
    mv "$name" "$newname"
done

IFS="$OIFS"

