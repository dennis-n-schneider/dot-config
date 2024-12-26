#!/bin/sh

NUM_WORDS=$(pdftotext $1 - | wc -w)
notify-send "$NUM_WORDS words in PDF"
