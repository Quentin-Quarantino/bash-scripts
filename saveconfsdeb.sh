#!/bin/bash

minus="--------------------------------------------------------------------------------"
D=$(date +'%d')
if [ $USER != root ] ; then
        printf "\nyou must be root; exit script!\n$minus\n\n"
        exit 1
fi

run() 
{
#fehlend Ordner werden erstellt
	for i in $(seq 1 31) ; do i=`echo 0$i |tail -c 3` ; [[ -d /saveconf/date$i/{log,net,block,conf} ]] || mkdir -p /saveconf/date$i/{log,net,block,config} ;done
	
	# general stuff (valid for the most Linux like rhel and debian derivates:
	# general log
#	echo $(date) >/saveconf/date$D/dmesg :dmesg -T >>/saveconf/date$D/log/dmesg
	# general networking

	echo $(date) > 
	echo $(date) >/saveconf/date$D/ipaddrshow ;ip a >>/saveconf/date$D/ipaddrshow
	echo $(date) >/saveconf/date$D/route-n ;route -n >>/saveconf/date$D/route-n

	## REQUIRE ETHTOOL COMMENT IT OUT IF YOU DONT USE ETHTOOL
	echo $(date) >/saveconf/date$D/link-up-down ;for i in `ip a |egrep '^[0-9]' |egrep -v -i 'LOOPBACK|down' |awk '{print $2}' |tr ':' ' '` ;do m=`ifconfig $i |grep 'ether' |awk '{print $2}'`; echo "$i  `ethtool $i |grep "detec" |tr -d '\n'`  MAC  $m" ;done >>/saveconf/date$D/link-up-down
	# general Blockdevice and disks
	echo $(date) >/saveconf/date$D/df-hP ;df -hP >>/saveconf/date$D/block/df-hP
	echo $(date) >/saveconf/date$D/df-inodes ;df -i >>/saveconf/date$D/block/df-inodes
	echo $(date) >/saveconf/date$D/fstab ;cat /etc/fstab >>/saveconf/date$D/fstab

	# general config files

	if [ "$2" = "--deb" ] ; then


	fi
	if [ "$2" = "--rhel" ] ; then

	fi
	if [ "$@" = "--custom" ] ; then

	fi

}

if [ "$1" = "--run" ] ; then
	run
else
	echo "usage:"
fi

exit 1

