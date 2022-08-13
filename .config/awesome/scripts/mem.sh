#!/bin/bash

total=$(cat /proc/meminfo | grep "MemTotal" | awk  '{ print $2 }')
free=$(cat /proc/meminfo | grep "MemFree" | awk '{print $2}')
echo "scale = 2; 1 - (${free} / ${total})" | bc 
