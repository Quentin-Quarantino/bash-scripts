#!/bin/bash

minus="--------------------------------------------------------------------------------"

if [ $USER != root ] ; then
        printf "\nyou must be root; exit script!\n$minus\n\n"
        exit 1
fi
# banner
printf "\n$minus\nsearch for user with elevated sudo rights\n\n$minus\n"
# Simple grep command for checkin the files but not in use
# egrep -v '#|^$|Defaults' /etc/sudoers /etc/sudoers.?/*

#variable to run the command only once and then have to filter only
c=$(for i in `find /etc/sudoers.?/* /etc/sudoers` ;do printf "\nsearch in file: $i \n" ;cat $i | sed -e 's/\%/\%\%/' |egrep -v '#|^$|Defaults' || echo "nothing found in $i" ;done)

#echo variable $c
printf "$c"

# noch weiter ausbessern um zu erkennen ob jemand "ALL", "NOPASSWD", "su -", "su - root" oder mit sudo rechten vim/less/more/cp/mv verwenden kann!!!!

echo
exit 1
