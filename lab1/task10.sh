#!/bin/bash

man bash | tr '[:upper:]' '[:lower:]' | tr '[:punct:]' ' '| tr ' ' '\n' | sed '/^$/d' | sed '/..../!d'| sort | uniq -c | sort -nr --key=1 | head -n 3 | awk '{print $2, $1;}'
