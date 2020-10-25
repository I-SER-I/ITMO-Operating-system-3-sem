#!/bin/bash

mkfifo pipe
sh handler.sh&sh generator.sh
rm pipe
