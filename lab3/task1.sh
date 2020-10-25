#!/bin/bash

dates=$(date '+%F|%T')

mkdir ~/test && { echo "catalog test was created successfully" > ~/report ; touch ~/test/$dates ; }
ping net_nikogo.ru || echo "${dates} ERROR HOST" >> ~/report
