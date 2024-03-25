#!/bin/bash
# 
# Add to /etc/crontab:
#realiza backups weekly 
# 0 4 * * 0 $HOME/bin/rdiff_backup_home.sh
#
#para renovar el cron, hacer: crontab $HOME/bin/weekly  (archivo)
# -     -    -    -    -
#|     |     |     |     |
#|     |     |     |     +----- day of week (0 - 6) (Sunday=0)
#|     |     |     +------- month (1 - 12)
#|     |     +--------- day of month (1 - 31)
#|     +----------- hour (0 - 23)
#+------------- min (0 - 59)
# TO SWITCH DOWN THE SERVICES:
# kill -9 "`ps -C "emacs" -o pid --no-heading`"

# -------------
# CONFIG
# -------------

TIMESTAMP=`date +%m%d_%H%M`


dirs=("argota" "guerrieri") # "obregon" "pulido")
# The directory to backup
SRC="/home/"
# Destination
DST="/mnt/grial_6/home_rdiff_backup/"

# How long to keep backup history
# In this case, the user can recover the backup state as it was 8 rdiff times  (maxage)
# 1 per week --> 2 months
MAXAGE="8B"

# Path to rdiff-backup python script
RDIFF="/usr/bin/rdiff-backup"

# Log file directory - needs to be created
LOG="/var/log/rdiff-backup"

# Some basic configuration options; see the manual
OPTIONS="--print-statistics"

# ---------------
# BACKUP
# ---------------

echo " -- $TIMESTAMP -- "

echo "Backup: $RDIFF $OPTIONS $SRC $DST"

for user in ${users[@]}; do
    SRC1="$SRC$user"
    DST1="$DST$user"
    echo From $SRC1
    echo To  $DST1
#    sudo -u $user $RDIFF $OPTIONS $SRC1 $DST1
#    if [ $? -eq 0 ]; then
#        sudo -u $user $RDIFF --force --remove-older-than $MAXAGE $DST1
#    else
#        echo $? > $LOG/fail$TIMESTAMP.log
#    fi
    
done



echo "-- EOF --"

