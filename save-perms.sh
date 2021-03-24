#!/bin/bash
RestoreScript="`echo $1 |sed -e 's/\//_/g'`.`date +%Y%m%d`" 
minus="--------------------------------------------------------------------------------"
usage() 
{
	exit 1
}

check()
{

}

save()
{
	echo '#!/bin/bash' >${RestoreScript}
	echo "restore script generated form $USER at $(date) for all files and folders from $1"
	find $1 -ignore_readdir_race -perm /7777 2>/dev/null -exec stat --printf=' f="%n" ; [ -e "$f" ] && [ "\`stat --printf=\%a "$f" 2>/dev/null\`" -ne %a ] && chmod %a "$f" && echo $f   permission corrected to %a \n' {} \;  >>${RestoreScript} 
}

## --------------------------------------------------------------------------------
# main

#save

exit 1
