#!/bin/sh

brightness_file='/sys/class/backlight/intel_backlight/brightness'
max_brightness_file='/sys/class/backlight/intel_backlight/max_brightness'
brightness=$(cat $brightness_file)
max_brightness=$(cat $max_brightness_file)
lower_brightness=$((brightness-300))

if [ $lower_brightness -lt 0 ];
then
	lower_brightness=0
fi

echo $lower_brightness > $brightness_file
dunstify -r 9386 -h int:value:$(($lower_brightness*100/$max_brightness)) "Brightness"
