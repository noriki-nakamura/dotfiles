#!/bin/sh
# Prints "CPU:xx% MEM:xx%" for use in tmux status-right.

cpu_idle=$(LANG=C top -bn1 | awk -F',' '/Cpu\(s\)/ { for (i=1;i<=NF;i++) if ($i ~ /id/) { gsub(/[^0-9.]/,"",$i); print $i } }')
cpu=$(awk -v idle="$cpu_idle" 'BEGIN { printf "%.0f", 100 - idle }')

mem=$(awk '/MemTotal/ { total=$2 } /MemAvailable/ { avail=$2 } END { printf "%.0f", (total-avail)/total*100 }' /proc/meminfo)

printf 'CPU:%s%% MEM:%s%%' "$cpu" "$mem"
