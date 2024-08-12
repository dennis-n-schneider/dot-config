#!/bin/sh

function is_browser_window() {
    local window_id=$1
    local browser_name=$2

    local browser_ids=$(xdotool search --class $browser_name)
    return $(echo $browser_ids | grep -qm1 $window_id)
}

# Get the window ID of the active Browser window
active_window_id=$(xdotool getactivewindow)

if is_browser_window $active_window_id 'Brave-browser'; then
    #old_cache=$(xclip -o)
    xdotool key --clearmodifiers --window $active_window_id 'ctrl+l+c'
    url=$(xclip -o)
    #echo $old_cache | xclip -o -selection clipboard
    dunstify "$url"
    if [[ $url == *'youtube.'* ]]; then
        artist=$(ls Music | rofi -dmenu -p "Artist") 
        [ -z "$artist" ] && exit 1
        mkdir -p Music/"$artist"
        album=$(ls Music/"$artist" | rofi -dmenu -p "Album") 
        [ -z "$album" ] && album="$artist"
        mkdir -p Music/"$artist"/"$album"
        dunstify "Downloading to Music/$artist/$album..."
        yt-dlp -x --audio-format opus --audio-quality 0 --no-playlist -o "Music/$artist/$album/%(title)s.%(ext)s" $url
        dunstify "Finished downloading music."
    fi
fi

