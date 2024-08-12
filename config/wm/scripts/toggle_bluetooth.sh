#!/bin/sh

res=$(bluetooth toggle)
dunstify -r 8736 "$res"
