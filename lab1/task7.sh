#!/bin/bash

grep -E -I -o -s -h "\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,6}\b" /etc/* | tr "\n" "," > emails.lst
