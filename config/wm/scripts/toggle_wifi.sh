#!/bin/sh

res=$(wifi toggle)
dunstify -r 8736 "$res"
