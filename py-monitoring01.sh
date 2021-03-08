#!/bin/bash

# Verzeichnis auf anzahl files überprüfen 
##Variabeln die du anpassen musst.

### Absoluter Pfad zum Script
path2script='/home/rick/bin/test.sh'

### Absoluter Pfad zum dir, dass überwacht werden soll
path2dir4count='/home/rick/testout/'

#Skriptname zum suchen der PID
scriptname='test.sh'

### optional
debugfile='/home/rick/debug'

##Als root den crontab erstellen z.B. :
# crontab -e
# 0 * * * * /bin/bash /home/rick/bin/py-monitoring.sh 2>/dev/null
#oder für den debug mode
# 0 * * * * /bin/bash /home/rick/bin/py-monitoring.sh -debug 2>/dev/null

# Das script wird jede stunde in der 59ten minute beendet und durch den cronjob 00 neu gestartet um ressourcen zu sparen

#ganz wichtig für die sicherheit sonst könnte jeder befehle in das skript schreiben die danach als root ausgeführt werden: 
# chown root. diesesSkript.sh && chmod 0744 diesesSkript.sh

#Variabel die automatisch definiert werden
pid=`ps auxf |grep $scriptname |grep -v grep |awk '{print $2}'`
d=`date '+%M'`
tmp=`ls -l $path2dir4count |grep '^-' |wc -l`
filecount=$(echo `expr $tmp - 1`)
# script wird beendet wen der ausführende user nicht root ist
if [ "$1" = "-debug" ] ;then
        echo "start script at: $(date), pid =  $pid, file count = $filecount" >>$debugfile
fi
if [ $USER != root ] ; then 
        echo "you must be root... exit script" >$debugfile
        exit 1 
fi

#solange nicht **:59 ist
while [ $d -ne "59" ] ;do
        # Files zählen 
        newfilecount=`ls -l $path2dir4count |grep '^-' |wc -l`
        if [ "$newfilecount" -gt "$filecount" ] ;then
                if  [ "$1" = "-debug" ] ;then
                        echo "$filecount  $newfilecount " >>$debugfile
                fi
                filecount="$newfilecount" ;sleep 1m 
        else
                if  [ "$1" = "-debug" ] ;then
                        echo "kill $pid and start $path2script" >>$debugfile
                fi
                kill $pid 2>/dev/null ;sleep 3 ;/bin/bash $path2script &
        fi
        d=`date '+%M'`
done 
if [ "$1" = "-debug" ] ;then
        echo "exit script at: $(date)" >>$debugfile
fi    
exit 1

