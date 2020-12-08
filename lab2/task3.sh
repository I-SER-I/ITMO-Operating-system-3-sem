#!/bin/bash

ps -o pid,start_time --sort=start_time | head -n 2 > 3.out