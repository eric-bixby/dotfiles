#!/bin/sh
#
# Purpose: AAPC course - fix activies

for name in `ls *.mov`
#for name in `find . -type d -exec basename {} \;|fgrep -v "."|sed "s/$/.mov/"`
do
    dir=`basename $name .mov`
    newname=`echo $name|sed -e s/.*-//`
    title=`echo $dir|sed -e s/.*-//|tr "_" " "|awk '{for(i=1;i<=NF;i++){ $i=toupper(substr($i,1,1)) substr($i,2) }}1'`
    mkdir -p $dir
    mv $name $dir/$newname
    cp ~/Desktop/index.html $dir/
    sed -i '' "s/TITLE/$title/" $dir/index.html
    sed -i '' "s/NAME/$newname/" $dir/index.html
done

