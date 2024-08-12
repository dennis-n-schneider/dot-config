#!/bin/sh

brightness_file='/sys/class/backlight/intel_backlight/brightness'
max_brightness_file='/sys/class/backlight/intel_backlight/max_brightness'
brightness=$(cat $brightness_file)
max_brightness=$(cat $max_brightness_file)
higher_brightness=$((brightness+300))

if [ $higher_brightness -gt $max_brightness ];
then
	higher_brightness=$max_brightness
fi

echo $higher_brightness > $brightness_file
dunstify -r 9386 -h int:value:$(($higher_brightness*100/$max_brightness)) "Brightness"
