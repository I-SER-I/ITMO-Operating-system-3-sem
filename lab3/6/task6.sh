#!/bin/bash

sh handler.sh&a=$!
sh generator.sh $a
