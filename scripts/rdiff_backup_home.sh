#!/bin/bash
# 
# Add to /etc/crontab:
#realiza backups weekly 
# 0 4 * * 0 /home/pulido/bin/rdiff_backup_home.sh
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

# Lista de users para backapear
users=("aguirre" "argota" "chomik" "coene" "contardi" "dev" "duarte" "guerrieri" "lobon" "lucini" "manuel"  "marturet" "obregon" "pulido" "rodas"   "rosa" "ruiz"  "vargas" "wiedmann")

# The directory to backup
SRC="/home/"
# Destination
DST="/mnt/grial_6/home_rdiff_backup/"

# How long to keep backup history
# In this case, the user can recover the backup state as it was 8 rdiff times  (maxage)
# 1 per week --> 2 months
MAXAGE="8B"

# Path to rdiff-backup binary
RDIFF="/usr/bin/rdiff-backup"

# Log file directory - needs to be created
LOG="/var/log/rdiff-backup"

# Some basic configuration options; see the manual
OPTIONS="--print-statistics --exclude-special-files" #"--exclude '**/.local' --exclude '**/.cache'"

# ---------------
# BACKUP
# ---------------

echo " -- $TIMESTAMP -- "

for user in ${users[@]}; do
    SRC1="$SRC$user"
    DST1="$DST$user"
#    if [[ "$user" == "dev" ]]
#    then
#	user="root"
#    fi
#    echo "From $SRC1"
#    echo "To $DST1"
    echo "Backup: $RDIFF $OPTIONS --exclude '**/.local' --exclude '**/.cache' $SRC1 $DST1"
    sudo  $RDIFF $OPTIONS --exclude '**/.local' --exclude '**/.cache' --exclude '**/.mozilla' --exclude '**/.venv' $SRC1 $DST1
    if [ $? -eq 0 ]; then
        sudo $RDIFF --force --remove-older-than $MAXAGE $DST1
    else
        echo $? > $LOG/fail$TIMESTAMP.log
    fi    
done

echo "-- EOF --"

