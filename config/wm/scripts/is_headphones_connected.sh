#!/bin/sh

SOUND=$(pactl list | grep -m 1 device.alias)
if [[ $SOUND ]]; then
    SOUND_ICON='󰋎'
fi
echo "$SOUND_ICON"
