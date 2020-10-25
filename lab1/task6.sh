#!/bin/bash

INFO="/var/log/anaconda/X.log"
awk '$3 == "(WW)" {print}' $INFO | sed 's/(WW)/Warning/' > full.log
awk '$3 == "(II)" {print}' $INFO | sed 's/(II)/Info/' >> full.log
