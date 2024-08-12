#!/bin/sh

device_name='SynPS/2 Synaptics TouchPad'

if [ -z $(xinput list-props "$device_name" | grep "Device Enabled.*1$") ]; then
    xinput set-prop "$device_name" "Device Enabled" 1
    dunstify -r 8264 'Touchpad activated'
else
    xinput set-prop "$device_name" "Device Enabled" 0
    dunstify -r 8264 'Touchpad deactivated'
fi
