#!/bin/sh
# Change directory to project-directory.
cd "$(dirname "${BASH_SOURCE[0]}")"

QTILE_CONFIG_DIR="$XDG_CONFIG_HOME/qtile"
TMP_DIR="$XDG_CACHE_HOME/dot-config/qtile-workbenches"
[ -d $TMP_DIR ] || mkdir -p $TMP_DIR

# Installs the workbenches-extension for qtile.
[ -d $TMP_DIR ] || git clone --branch main --depth 1 https://github.com/dennis-n-schneider/qtile-workbenches.git $TMP_DIR

rsync -av $TMP_DIR/qt-workbenches/*.py $QTILE_CONFIG_DIR

patch $QTILE_CONFIG_DIR/config.py ./workbenches.diff

