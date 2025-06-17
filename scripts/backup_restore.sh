#!/bin/bash

ACTION=$1
DBNAME=$2
FILENAME=$3

MYSQLDUMP="/c/Program Files/MySQL/MySQL Server 8.0/bin/mysqldump.exe"
MYSQL="/c/Program Files/MySQL/MySQL Server 8.0/bin/mysql.exe"

if [ "$ACTION" = "backup" ]; then
    echo "Backing up '$DBNAME' to '$FILENAME'..."
    winpty "$MYSQLDUMP" -u root -p "$DBNAME" --result-file="$FILENAME"
elif [ "$ACTION" = "restore" ]; then
    echo "Restoring '$DBNAME' from '$FILENAME'..."
    winpty "$MYSQL" -u root -p "$DBNAME" < "$FILENAME"
else
    echo "Usage: $0 backup|restore dbname filename.sql"
    exit 1
fi
