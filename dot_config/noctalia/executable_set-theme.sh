#!/bin/bash

LOCKFILE="/tmp/wallpaper-hook.lock"
LOCKFD=200

# Try to acquire lock, exit if already running
exec 200>"$LOCKFILE"
flock -n 200 || exit 0

# Store the wallpaper path to detect actual changes
STATEFILE="/tmp/wallpaper-hook.state"
if [ -f "$STATEFILE" ] && [ "$(cat "$STATEFILE")" = "$1" ]; then
  exit 0
fi

# Run your commands
wal -i "$1" -n -s -t -e --cols16
matugen image "$1"
ln -sf ~/.cache/wal/colors-kitty.conf ~/.config/kitty/16-colors.conf

# Save current wallpaper path
echo "$1" >"$STATEFILE"
