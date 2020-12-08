#!/bin/bash

max=0
for pid in $(ps uax | awk 'FNR > 1 {print $2}');
do
	if [[ -r /proc/$pid/status ]];
	then
		a=$(grep -i "VmRSS" /proc/$pid/status | awk '{print $2}')
		if [[ $a -ne "" ]];
		then
			if [[ $a -gt "$max" ]];
			then
				res=$pid
				max=$a
			fi
		fi
	fi
done
echo "Process_PID="$res" Memory="$max > 6.out

top -bo RES | head -n8 | tail -n1 | awk '{print "Using top | Process_PID="$1" Memory="$6}' >> 6.out