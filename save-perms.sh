#!/bin/bash

re='^[0-9]+$'
d=$(date +"%Y%m%d")
F=/root/perm-save-$d.sh
minus="--------------------------------------------------------------------------------"
usage() 
{
	printf "\n$minus\nscript for save owner/permissions in a path(not file):\n if you want save the permissions of only a file, use this command; man getfacl ;man setfacl\n\nsyntax:\n$0 path [maxdepth]\n\nexample:\n$0 /home\n$0 /home 2\n\n$minus\n"
	exit 1
}

if [ $USER != root ] ; then 
        printf "\nyou must be root; exit script!\n$minus\n\n"
        exit 1 
fi
# if $1 ==-h or empty print the manual and exit
if [[ -z "$1" ]] || [[ "$1" = "-h"  ]] ; then
   	usage
        exit 1
fi
# Check if path exist
if [[ ! -f "$1" ]] && [[ ! -d "$1" ]] ; then
	echo "file odr directory not found"
	exit 1
fi
# check in $2 empty 
if [[ ! -z "$2" ]]  ; then
       #check if $2 an integer	
	if ! [[ "$2" =~ $re ]] ; then
		# echo read the fucking manual and exit 
		echo "RTFM!"
		exit 1
	fi
	Max="-maxdepth $2"
fi
#echo #!bin/bash in base64
echo "IyEvYmluL2Jhc2gK" |base64 -d > "$F"
echo "F=$F" >> "$F"
echo "c2VkIDEsNWQgJEYgPiRGLXRtcApjZCAvIDtzZXRmYWNsICAtLXJlc3RvcmU9JEYtdG1wIApleGl0IDEK" |base64 -d >> "$F"
echo >>"$F"

for i in `find $1 $Max`  ;do getfacl $i 2>/dev/null >>$F ;done
chmod +x "$F"

exit 1
