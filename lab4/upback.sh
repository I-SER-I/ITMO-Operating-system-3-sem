#!/bin/bash

HOM="/home/user"
LastBackupDate=$(ls $HOM | grep -E "^Backup-" | sort -n | tail -1 | sed 's/^Backup-//')
LastBackup="$HOM/Backup-${LastBackupDate}"

if [[ -z "$LastBackupDate" ]];
then
	echo "Backup not found"
	exit 1
fi

if [[ ! -d $HOM/restore ]];
then
	mkdir $HOM/restore
else
	rm -r $HOM/restore
	mkdir $HOM/restore
fi

for Fi in $(ls $LastBackup | grep -Ev "\.[0-9]{4}-[0-9]{2}-[0-9]{2}$");
do
	cp "${LastBackup}/${Fi}" "$HOM/restore/${Fi}"
	echo "Success!"
done