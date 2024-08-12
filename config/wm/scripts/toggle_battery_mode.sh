#!/bin/sh

if $(sudo systemctl status tp-battery-mode | grep -q 'Active: active'); then
    sudo systemctl stop tp-battery-mode
    dunstify -r 9876 "Power Mode enabled"
else
    sudo systemctl start tp-battery-mode
    dunstify -r 9876 "Battery Care Mode enabled"
fi
