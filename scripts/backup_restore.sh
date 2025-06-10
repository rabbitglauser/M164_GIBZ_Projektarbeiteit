#!/bin/bash
# Usage: ./backup_restore.sh backup|restore dbname filename.sql

ACTION=$1
DBNAME=$2
FILENAME=$3

if [ "$ACTION" = "backup" ]; then
    mysqldump -u your_db_user -p $DBNAME > $FILENAME
elif [ "$ACTION" = "restore" ]; then
    mysql -u your_db_user -p $DBNAME < $FILENAME
else
    echo "Usage: $0 backup|restore dbname filename.sql"
fi