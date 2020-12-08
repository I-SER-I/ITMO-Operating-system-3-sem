#!/bin/bash

command="+"
echo "Mode plus: handler"
result=1
tail -f pipe |
while true;
do
	read line
	case $line in
		"+")
			command="$line"
			echo "Switched plus: handler"
		;;
		"*")
			command="$line"
			echo "Switched multi: handler"
		;;
		"QUIT")
			killall tail
			echo "Quit: handler"
			exit 0
		;;
		[0-9])
			case $command in
				"+")
					result=$(($result + $line))
					echo $result
				;;
				"*")
					result=$(($result * $line))
					echo $result
				;;
			esac
		;;
		*)
			killall tail
			echo "Error: handler"
			exit 1
		;;
	esac
done
