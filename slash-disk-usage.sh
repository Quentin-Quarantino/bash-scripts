#!/bin/bash

if [ $USER != root ] ; then
        printf "\nyou must be root; exit script!\n$minus\n\n"
        exit 1
fi

#not ready yet 
m=`df -hP |sed 1d |grep ^/ |grep -v '^/ '|awk  -F "/" '{print $NF}'` ;m=`echo $m |tr " " "|"` 
du -sh /* 2>/dev/null |egrep -v "K|$m|^0"

exit 1
