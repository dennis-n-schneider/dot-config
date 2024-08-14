#!/bin/bash

# Copy configurations.
rsync -Pav config/* ~/.config

# Install packages.
#if which yay &> /dev/null; then
#    yay -Syu --needed $(awk '!/^#/{print $0}' packages-repository.txt)
#else
#    sudo pacman -Syu --needed $(awk '!/^#/{print $0}' packages-repository.txt)
#fi

# Setup zsh as default shell.
mkdir -p ~/.cache/shell
if [ $(basename "$SHELL") != "zsh" ]; then
    chsh -s /bin/zsh
fi
echo "export ZDOTDIR=$HOME/.config/zsh" > ~/.zshenv

# Setup rofi theme (Dracula).
rofi_theme_dir="$HOME/.local/share/rofi/themes"
mkdir -p $rofi_theme_dir
if [ "$(ls -A $rofi_theme_dir 2> /dev/null | wc -l)" -eq 0 ]; then
    curl https://raw.githubusercontent.com/dracula/rofi/master/theme/config1.rasi -o "$rofi_theme_dir"/theme.rasi
fi

# Apply mods
sh ./mods/workbenches/install.sh
#while IFS= read -r line; do
#    $(sh mods/$line/install.sh)
#done < "mods.txt"
