#!/bin/bash

total=$(cat /proc/meminfo | grep "MemTotal" | awk  '{ print $2 }')
available=$(cat /proc/meminfo | grep "MemAvailable" | awk '{print $2}')
echo "scale = 2; 1 - (${available} / ${total})" | bc 
