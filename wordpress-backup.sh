#!/bin/bash
## Version 1.0 - 10-12-16
## Backup Script - CCC 05-13-16

## Backs up the var/www/html folder into a tar
## Backs up the SQL DB

## 10-12-16 - CCC
## Added logging and removal of old files
## Initial Commit and Sanitization

user=insert-mysql-user
password=insert-mysql-password

today=`date -I`;

path=insert-path-for-backups

log=$path/backup-log-$today.txt

## Script Backs Up Data
echo "Backing Up /var/www/ to site-bkp-"$today"" >> $log

tar -cvf $path/site-bkp-"$today".tar /var/www/*;

echo "/var/www/ Backup Complete" >> $log
echo -e "\nBacking Up MySQL to wordpress-db-"$today".sql" >> $log

mysqldump -u $user -p$password --wordpress > $path/wordpress-db-"$today".sql;

echo "Backup completed wordpress-db-"$today"" >> $log

## Script Deletes Files older than 14 days
remDate=`date -I -d 'now -14 days'`

echo -e "\nThese files older than "$remDate" will be removed:\n" >> $log

find $path -name "*20*" -type f -mtime +14 -print -delete >> $log

echo -e "\nScript Completed" >> $log
