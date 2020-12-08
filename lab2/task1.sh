#!/bin/bash

prc=$(ps -u root | tail -n +2 | awk '$1 -eq "root" {print $1" : "$4}')
cnt=$(echo "$prc" | wc -l)
echo "count = $cnt" > 1.out
echo "$prc" >> 1.out