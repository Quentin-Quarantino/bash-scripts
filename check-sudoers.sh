#!/bin/bash

minus="--------------------------------------------------------------------------------"

if [ $USER != root ] ; then
        printf "\nyou must be root; exit script!\n$minus\n\n"
        exit 1
fi

# banner
printf "\n$minus\ncheck syntax of sudoer files\n\n$minus\n"
visudo -c

# banner
printf "\n$minus\nsearch for user or groups in sudoer files \n\n$minus\n"

# Simple grep command for checkin the files but not in use
# egrep -v '#|^$|Defaults' /etc/sudoers /etc/sudoers.?/*

#variable to run the command only once and then have to filter only
c=$(for i in `find /etc/sudoers.?/* /etc/sudoers` ;do printf "\nsearch in file: $i \n" ;cat $i | sed -e 's/\%/\%\%/' |egrep -v '#|^$|Defaults' || echo "nothing found in $i" ;done)

#echo variable $c
printf "$c\n" 

# noch weiter ausbessern um zu erkennen ob jemand "ALL", "NOPASSWD", "su -", "su - root" oder mit sudo rechten vim/less/more/cp/mv verwenden kann!!!!

printf "\n$minus\nsearch for users and groups with dangerous sudoer rules\n\n$minus\n"

printf "$c" |grep -v ^root |egrep -i --color 'ALL$|vi|vim|NOPASSWD|less|more|mv|cp|su - $|su $|su - root|su ,|su - ,|chmod|chown|rm|\/bin/*|\*,|\*$'

echo
exit 1
