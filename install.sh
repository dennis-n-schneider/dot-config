#!/bin/bash

# Make variables also available in 
export XDG_CACHE_HOME=${XDG_CACHE_HOME:-"~/.cache"}
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-"~/.config"}
export XDG_DATA_HOME=${XDG_DATA_HOME:-"~/.local/share"}
export DOT_CONFIG_CACHE_HOME=${DOT_CONFIG_CACHE_HOME:-"$XDG_CACHE_HOME/dot-config"}
[ -d $DOT_CONFIG_CACHE_HOME ] || mkdir -p $DOT_CONFIG_CACHE_HOME

# Copy configurations.
rsync -Pav config/* $XDG_CONFIG_HOME

# Install packages.
if which yay &> /dev/null; then
    yay -Syu --needed $(awk '!/^#/{print $0}' packages-repository.txt)
else
    sudo pacman -Syu --needed $(awk '!/^#/{print $0}' packages-repository.txt)
fi

# Setup zsh as default shell.
mkdir -p "$XDG_CACHE_HOME/shell"
if [ $(basename "$SHELL") != "zsh" ]; then
    chsh -s /bin/zsh
fi
echo "export ZDOTDIR=$XDG_CONFIG_HOME/zsh" > ~/.zshenv

# Setup rofi theme (Dracula).
rofi_theme_dir="$XDG_DATA_HOME/rofi/themes"
mkdir -p "$rofi_theme_dir"
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

