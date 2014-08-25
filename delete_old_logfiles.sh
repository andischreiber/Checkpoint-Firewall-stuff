#!/bin/bash
(
date
. /etc/profile.d/CP.sh
#declare -i FREE
FREE=`df -h | grep "/var/log" | awk '{print $3}' | awk -FG '{print $1}'`
while [ ${FREE%%\.*} -lt 5 ]; do
        OLDLOG=`ls -t $FWDIR/log/*201*.log | /usr/bin/tail -n 1`
        echo "deleting $OLDLOG"
        rm -f $OLDLOG*
        sync
        FREE=`df -h | grep "/var/log" | awk '{print $3}' | awk -FG '{print $1}'`
done
echo
) >> /var/log/delete_old_logfiles.log 2>&1
