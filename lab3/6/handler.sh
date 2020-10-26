#!/bin/bash

result=1
command="+"

TERM()
{
	echo "Finish"
	exit 0
}

SIG1()
{
	command="+"
}

SIG2()
{
	command="*"
}

trap 'TERM' SIGTERM
trap 'SIG1' USR1
trap 'SIG2' USR2

while true;
do
	case "$command" in
		"+")
			result=$(($result + 2))
		;;
		"*")
			result=$(($result * 2))
		;;
	esac
	echo $result
	sleep 1
done
