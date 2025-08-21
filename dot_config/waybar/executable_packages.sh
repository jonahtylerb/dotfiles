#!/bin/bash

check_pacman() {
    checkupdates 2>/dev/null
}

check_aur() {
    paru -Qua 2>/dev/null
}

# Get update counts
pacman_updates=$(check_pacman | wc -l)
aur_updates=$(check_aur | wc -l)
total_updates=$((pacman_updates + aur_updates))

if [ "$total_updates" -gt 0 ]; then
    echo "{\"text\": \"📦  $total_updates\", \"tooltip\": \"Pacman: $(check_pacman) \\nAUR: $(check_aur) \" }"
fi
