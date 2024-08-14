#!/bin/sh
# Change directory to project-directory.
cd "$(dirname "${BASH_SOURCE[0]}")"

QTILE_CONFIG_DIR="$XDG_CONFIG_HOME/qtile"
[ -d $TMP_DIR ] || mkdir $TMP_DIR

# Installs the workbenches-extension for qtile.
[ -d qtile-workbenches ] || git clone --branch master --depth 1 https://github.com/dennis-n-schneider/qtile-workbenches.git

rsync -av qtile-workbenches/qt-workbenches/*.py $QTILE_CONFIG_DIR

patch $QTILE_CONFIG_DIR/config.py ./workbenches.diff

