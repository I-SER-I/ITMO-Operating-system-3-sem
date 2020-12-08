#!/bin/bash

for tmp in $(ps -Ao pid,command | tail -n +2 | awk '{print $1":"$2}');
do
	pid=$(echo $tmp | awk -F ":" '{print $1}')
	com=$(echo $tmp | awk -F ":" '{print $2}')
	pth="/proc/"$pid
	if [ -f $pth/io ];
	then
		byte=$(grep -h "read_bytes:" $pth/io | sed "s/[^0-9]*//")
		echo "$pid $com $byte"
	fi
done | sort -nk1 > _a
sleep 1m
for tmp in $(ps -Ao pid,command | tail -n +2 | awk '{print $1":"$2}');
do
	pid=$(echo $tmp | awk -F ":" '{print $1}')
	com=$(echo $tmp | awk -F ":" '{print $2}')
	pth="/proc/"$pid
	if [ -f $pth/io ];
	then
		byte=$(grep -h "read_bytes:" $pth/io | sed "s/[^0-9]*//")
		echo "$pid $com $byte"
	fi
done | sort -nk1 > _b
cat _a |
while read str;
do
	pid=$(awk '{print $1}' <<< $str)
	com=$(awk '{print $2}' <<< $str)
	mem1=$(awk '{print $3}' <<< $str)
	mem2=$(cat _b | awk -v id="$pid" '{if ($1 == id) print $3}')
	res=$(echo "$mem2-$mem1" | bc)
	echo $pid" : "$com" : "$res
done | sort -t ':' -nrk3 | head -3 > 7.out