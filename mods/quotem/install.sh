#!/bin/sh
# Change directory to project-directory.
cd "$(dirname "${BASH_SOURCE[0]}")"

[ -d quotem ] || git clone --branch main --depth 1 https://github.com/dennis-n-schneider/quotem.git
cd quotem && make
