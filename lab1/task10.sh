#!/bin/bash

man bash | grep -io "[[:alpha:]]\{4,\}" | tr [:upper:] [:lower:] | sort | uniq -c | sort -nr | head -3
