#!/bin/bash

if pkill tofi; then
  exit 0
fi

# Get the clipboard history list
cliphist_output=$(cliphist list)

# Use awk to extract just the text (everything after first tab) for tofi
tofi_input=$(echo "$cliphist_output" | awk -F'\t' '{print $2}')

# Run tofi to get the selected text
selected_text=$(echo "$tofi_input" | tofi)

# Use awk to find the line with matching text and extract its ID
selected_id=$(echo "$cliphist_output" | awk -F'\t' -v target="$selected_text" '$2 == target {print $1; exit}')

cliphist decode "$selected_id" | wl-copy
