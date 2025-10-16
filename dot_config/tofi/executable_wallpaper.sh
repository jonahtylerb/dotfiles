#!/bin/bash

if pkill tofi; then
  exit 0
fi

WALLPAPER_DIR="$HOME/.config/backgrounds"

declare -A file_map
for file in "$WALLPAPER_DIR"/*.*; do
  [[ -f "$file" ]] || continue
  basename="$(basename "${file%.*}")"
  file_map["$basename"]="$file"
done

selected_name=$(printf '%s\n' "${!file_map[@]}" | sort | tofi --prompt-text "Select wallpaper: ")

selected_file="${file_map[$selected_name]}"

if ! [[ -f "$selected_file" ]]; then
  exit
fi

pkill waybar
current_workspace=$(hyprctl activeworkspace | awk 'NR==1 {print $3}')
~/.config/hypr/toggleSpecial.sh
hyprctl dispatch workspace 10

swww img "$selected_file" --transition-type grow --transition-pos bottom --transition-duration 3

wal -i "$selected_file" -n -s -t -e --cols16
matugen image "$selected_file"
ln -sf ~/.cache/wal/colors-kitty.conf ~/.config/kitty/16-colors.conf

hyprctl dispatch workspace "$current_workspace"
hyprctl dispatch exec waybar
