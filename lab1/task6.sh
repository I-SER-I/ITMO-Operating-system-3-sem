#!/bin/bash

INFO="$(cat /var/log/anaconda/X.log | awk  '$3 == "(II)"')"
WARNING="$(cat /var/log/anaconda/X.log | awk  '$3 == "(WW)"')"

echo "${WARNING//"(WW)"/"WARNING "}"
echo "${INFO//"(II)"/"INFO "}"

