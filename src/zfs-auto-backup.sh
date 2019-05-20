#! /bin/sh
DATA_SET=$1
PREFIX=$2
BACKUP_DATE=$(date +%d-%b)

sudo zfs list -H -o name -t snapshot |\
    grep $DATA_SET@$PREFIX |\
    xargs echo |\
    awk '{print $1} {print $NF}' |\
    xargs zfs send -DRp -I |\
    xz -c -9 > /backup/incremental-backup-$DATA_SET-$BACKUP_DATE.xz
