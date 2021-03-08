#!/bin/bash

minus="--------------------------------------------------------------------------------"
usage() 
{
	printf "\n$minus\nscript for save owner/permissions in a path(not file):\n if you want save the permissions of only a file, use this command; man getfacl ;man setfacl\n\nsyntax:\n$0 path [maxdepth]\n\nexample:\n$0 /home\n$0/home 2\n\n$minus\n"
	exit 1
}

if [ $USER != root ] ; then 
        printf "\nyou must be root; exit script!\n$minus\n\n"
        exit 1 
fi

if [[ -z "$1" ]] || [[ "$1" = "-h"  ]] ; then
       usage
       exit 1
fi

exit 1
