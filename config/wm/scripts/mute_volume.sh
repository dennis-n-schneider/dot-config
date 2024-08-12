#!/bin/sh

amixer -q sset Master toggle

muted=$(amixer get Master | grep -m 1 '\[on\]')
if [ -n $muted ]; then
	text="Muted"
	volume=0
else
	text="Volume"
	volume=$(amixer get Master | grep -o -m 1 -E '[0-9]+%' | grep -o -E '[0-9]+')
fi

dunstify -r 9386 -h int:value:$volume "$text"
