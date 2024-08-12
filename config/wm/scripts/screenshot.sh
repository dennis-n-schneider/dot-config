#!/bin/sh

path="$HOME/Pictures/screenshots/$(date -Iseconds).png"
if [ "$1" == "full" ]; then
    import -window root $path
    dunstify "Full Screenshot saved to $path"
else 
    if [ "$1" == "window" ]; then
        import -window "$(xdotool getwindowfocus)" $path
        dunstify "Window Screenshot saved to $path"
    fi
fi
