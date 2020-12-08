#!/bin/bash

for pid in $(ps -Ao pid | tail -n +2);
do
	pth="/proc/"$pid
	ppid=$(grep -Ehsi "ppid:\s+(.+)" $pth"/status" | grep -o "[0-9]\+")
	rt=$(grep -Ehsi "se\.sum_exec_runtime(.+):\s+(.+)" $pth/sched | awk '{print $3}')
	sw=$(grep -Ehsi "nr_switches(.+):\s+(.+)" $pth/sched | awk '{print $3}')
	if [ -z $ppid ];
	then
		ppid=0
	fi
	if [ -z $rt ] || [ -z $sw ];
	then
		art=0
	else
		art=$(echo "scale=2; $rt/$sw" | bc | awk '{printf "%.2f", $0}')
	fi
	echo "$pid $ppid $art"
done | sort -nk2 | awk '{print "ProcessID="$1" : Parent_ProcessID="$2" : Average_Running_Time="$3}' > 4.out