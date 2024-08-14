#!/bin/sh
# Change directory to project-directory.
cd "$(dirname "${BASH_SOURCE[0]}")"

TMP_DIR="./.tmp"
QTILE_CONFIG_DIR="$HOME/.config/qtile"
[ -d $TMP_DIR ] || mkdir $TMP_DIR

# Installs the workbenches-extension for qtile.
wget --content-disposition -P $TMP_DIR "https://raw.githubusercontent.com/dennis-n-schneider/qtile-workbenches/main/qt-workbenches/core.py"
wget --content-disposition -P $TMP_DIR "https://raw.githubusercontent.com/dennis-n-schneider/qtile-workbenches/main/qt-workbenches/workbenches.py"

rsync -av $TMP_DIR/* $QTILE_CONFIG_DIR

patch $QTILE_CONFIG_DIR/config.py ./workbenches.diff

rm $TMP_DIR/*
