#!/bin/sh

amixer -q sset Master 5%+
volume=$(amixer get Master | grep -o -m 1 -E '[0-9]+%' | grep -o -E '[0-9]+')
dunstify -r 9386 -h int:value:$volume "Volume"
