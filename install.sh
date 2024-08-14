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
awk '
/^\[mods\]/ { in_mods_section = 1; next }
/^\[.*\]/ && in_mods_section { exit }
in_mods_section { print $0 }
' config.toml | while IFS= read -r mod_name; do
    sh "mods/$mod_name/install.sh"
done

