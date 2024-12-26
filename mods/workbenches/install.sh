#!/bin/sh

DOT_CONFIG_CACHE_HOME=${DOT_CONFIG_CACHE_HOME:-"$XDG_CACHE_HOME/dot-config"}
QTILE_WORKBENCHES_CACHE_HOME="$DOT_CONFIG_CACHE_HOME/qtile_workbenches"

# Change directory to project-directory.
cd "$(dirname "${BASH_SOURCE[0]}")"

QTILE_CONFIG_DIR="$XDG_CONFIG_HOME/qtile"

# Installs the workbenches-extension for qtile.
[ -d $QTILE_WORKBENCHES_CACHE_HOME ] || git clone --branch main --depth 1 https://github.com/dennis-n-schneider/qtile-workbenches.git $QTILE_WORKBENCHES_CACHE_HOME

rsync -av $QTILE_WORKBENCHES_CACHE_HOME/qt-workbenches/*.py $QTILE_CONFIG_DIR

patch $QTILE_CONFIG_DIR/config.py ./workbenches.diff

