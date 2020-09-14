#!/bin/bash

if [[ $HOME == $PWD ]]
then
	echo $HOME
	exit 0
else
	echo "ERROR"
	exit 1
fi
