#!/bin/bash

sh loop.sh&pid0=$!
sh loop.sh&pid1=$!
sh loop.sh&pid2=$!

renice +10 -p $pid0
