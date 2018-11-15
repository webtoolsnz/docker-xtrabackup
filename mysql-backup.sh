#!/bin/bash

rm -rf $BACKUP_DIR.1
mv $BACKUP_DIR $BACKUP_DIR.1

#make backup
innobackupex --host=$MYSQL_HOST --port=$MYSQL_PORT --user=$MYSQL_USER --password=$MYSQL_PASSWORD --no-timestamp $BACKUP_DIR 2>&1

#prepare backup
innobackupex --host=$MYSQL_HOST --port=$MYSQL_PORT --user=$MYSQL_USER --password=$MYSQL_PASSWORD --apply-log $BACKUP_DIR 2>&1


