#!/bin/bash

minus="--------------------------------------------------------------------------------"
D=$(date +'%d')
if [ $USER != root ] ; then
        printf "\nyou must be root; exit script!\n$minus\n\n"
        exit 1
fi


#fehlend Ordner werden erstellt
for i in $(seq 1 31) ; do i=`echo 0$i |tail -c 3` ; [[ -d /saveconf/date$i/{log,net,block,conf} ]] || mkdir -p /saveconf/date$i/{log,net,block,config} ;done

echo $(date) >/saveconf/date$D/df-hP ;df-hP >>/saveconf/date$D/df-hP
echo $(date) >/saveconf/date$D/dmesg :dmesg -T >>/saveconf/date$D/dmesg
[ -d /saveconf/date$i/ ] ||  mkdir -p /saveconf/date$i
