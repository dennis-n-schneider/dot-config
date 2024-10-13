#!/bin/sh

cd "$(dirname "${BASH_SOURCE[0]}")"

ROFI_CONFIG_DIR="$XDG_CONFIG_HOME/rofi"

patch $ROFI_CONFIG_DIR/config.rasi ./rofi_sidebar.diff


