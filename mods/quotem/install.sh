#!/bin/sh
# Change directory to project-directory.
cd "$(dirname "${BASH_SOURCE[0]}")"
QUOTEM_CACHE_HOME="$DOT_CONFIG_CACHE_HOME/quotem"

[ -d "$QUOTEM_CACHE_HOME" ] || git clone --branch main --depth 1 https://github.com/dennis-n-schneider/quotem.git "$QUOTEM_CACHE_HOME"
cd "$QUOTEM_CACHE_HOME" && make
