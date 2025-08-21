#!/bin/bash

WALLPAPER_DIR="$HOME/.config/backgrounds"

cd "$WALLPAPER_DIR" || exit 1
image_list=$(find . -maxdepth 1 -exec basename {} \; | sed 's/\.[^.]*$//' | sort)
selected=$(echo "$image_list" | tofi --prompt-text "Select wallpaper: ")
actual_file=$(find "$WALLPAPER_DIR" -maxdepth 1 -type f -name "$selected.*" | head -1)

pkill waybar

current_workspace=$(hyprctl activeworkspace | awk 'NR==1 {print $3}')

hyprctl dispatch workspace 10

swww img "$actual_file" --transition-type grow --transition-pos bottom --transition-duration 3

wal -i "$actual_file" -n -s -t -e
matugen image "$actual_file"
ln -sf ~/.cache/wal/colors-kitty.conf ~/.config/kitty/16-colors.conf

hyprctl dispatch workspace "$current_workspace"
hyprctl dispatch exec waybar
