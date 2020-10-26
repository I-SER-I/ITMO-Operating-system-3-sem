#!/bin/bash

sh handler.sh&pid=$!
sh generator.sh $pid
