#!/bin/sh

current_date=$(date +%s)
target_date=$(date -d '2022-07-08' +%s)
date_diff=$((current_date - target_date))
days_since=$(echo "scale=10 ; $date_diff / 86400" | bc -l)
charge_cycles=$(cat '/sys/class/power_supply/BAT0/cycle_count')
result=$(echo "$charge_cycles / $days_since * 100" | bc -l)
printf '%.3f' "$result"
