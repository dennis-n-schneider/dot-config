#!/bin/sh

cd "$(dirname "${BASH_SOURCE[0]}")"
source .venv/bin/activate

PAPER_STACK_PATH="$HOME/Downloads/paper_stack/all"
PAPER_PATH=$1
PAPER_TITLE=$(pdftitle -p "$PAPER_PATH" --replace-missing-char " ")

if [ $? -eq 0 ]; then
    NEW_TITLE=$(echo $PAPER_TITLE | tr ' .:/' '_' | awk '{print $1".pdf"}')
    mv "$PAPER_PATH" "$PAPER_STACK_PATH/$NEW_TITLE"
    notify-send "$PAPER_PATH -> $PAPER_STACK_PATH/$NEW_TITLE"
    exit 0
else
    notify-send "Did not work."
    exit 1
fi

