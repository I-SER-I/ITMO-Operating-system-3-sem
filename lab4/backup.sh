#!/bin/bash

HOM="/home/user"
LBackupDate=$(ls $HOM | grep -E "^Backup-" | sort -n | tail -1 | sed "s/Backup-//")
LBackup="$HOM/Backup-${LBackupDate}"
Today=$(date +"%Y-%m-%d")
NowTimes=$(date -d "$Today" +"%s")
LBackupTimes=$(date -d "$LBackupDate" +"%s")
Totaltime=$(echo "(${NowTimes} - ${LBackupTimes}) / 60 / 60 / 24" | bc)
rep=$HOM/.backup-report

if [[ $Totaltime > 7 || -z "$LBackupDate" ]];
then
	mkdir "$HOM/Backup-${Today}"
	for obj in $(ls $HOM/source);
    do
	    cp "$HOM/source/$obj" "$HOM/Backup-$Today"
    done
	flist=$(ls $HOM/source | sed "s/^/\t/")
	echo -e "${Today}. Created:\n${flist}" >> $rep
else
	changes=""
	for obj in $(ls $HOM/source);
    do
		if [[ -f "$LBackup/$obj" ]];
        then
			sourceSize=$(wc -c "$HOM/source/${obj}" | awk '{print $1}')
			BackupSize=$(wc -c "${LBackup}/${obj}" | awk '{print $1}')
			TotalSize=$(echo "${sourceSize} - ${BackupSize}" | bc)
			if [[ $TotalSize != 0 ]];
            then
				mv "$LBackup/$obj" "$LBackup/$obj.$Today"
				cp "$HOM/source/$obj" $LBackup
				changes="${changes}\n\t$obj ($obj.$Today)"
			fi
		else
			cp "$HOM/source/$obj" $LBackup
			changes="${changes}\n\t$obj"
        fi
	done
    changes=$(echo $changes | sed 's/^\\n//')
    if [[ ! -z "$changes" ]];
    then
	    echo -e "${LBackupDate}. Updated:\n${changes}" >> $rep
	fi
fi