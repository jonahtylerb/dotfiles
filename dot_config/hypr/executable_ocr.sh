#!/bin/bash

TMPDIR=$(mktemp -d)

grim -g "$(slurp)" "$TMPDIR/screenshot.png"

tesseract "$TMPDIR/screenshot.png" "$TMPDIR/output"

cat "$TMPDIR/output.txt" | wl-copy

rm -r "$TMPDIR"
