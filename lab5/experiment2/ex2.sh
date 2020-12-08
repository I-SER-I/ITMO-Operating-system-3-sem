#!/bin/bash

K=$1
N=$2

for i in $(seq 1 $K); do
	./newmem.bash $N&
done
