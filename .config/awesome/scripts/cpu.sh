#!/bin/bash

# source: https://stackoverflow.com/questions/36952812/total-cpu-usage-multicore-system
usage=$(mpstat 1 1 | awk '/^Average/ {print 100-$NF}')
echo "${usage} * 0.01" | bc
