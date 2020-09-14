#!/bin/bash

echo -e "1. nano\n2. vim\n3. links\n4. exit"

read options
case $options in
1 )
nano
;;
2 )
vi
;;
3 )
links
;;
4 )
exit 0
;;
esac
