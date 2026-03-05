#!/usr/bin/env bash
# Set the per-monitor cropped wallpaper for all monitors via noctalia IPC.
# Usage: set-wallpaper.sh <image-name-or-path>
#   e.g. set-wallpaper.sh "City.jpg"
#   e.g. set-wallpaper.sh "/home/user/.config/backgrounds/City.jpg"

set -euo pipefail

if [ $# -eq 0 ]; then
    echo "Usage: $0 <image-name-or-path>" >&2
    exit 1
fi

BACKGROUNDS_DIR="$HOME/.config/backgrounds"
filename=$(basename "$1")

# Find all per-monitor subdirectories
for monitor_dir in "$BACKGROUNDS_DIR"/*/; do
    monitor=$(basename "$monitor_dir")
    img="$monitor_dir$filename"

    if [ ! -f "$img" ]; then
        echo "Warning: no processed image for monitor '$monitor': $img" >&2
        continue
    fi

    qs -c noctalia-shell ipc call wallpaper set "$img" "$monitor"
done
