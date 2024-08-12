#!/bin/sh

chosen=$(ls .local/share/password-store -I 'otp_*' | cut -d. -f1 | rofi -dmenu -i)
content=$(pass $chosen)
password=$(echo "$content" | sed -n 1p)
username=$(echo "$content" | sed -n '2s/Username: //p')

echo "$password" | xclip -selection clip
echo "$username" | xclip -selection primary

