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

updates=$(
    printf "Pacman:\n"
    checkupdates --nocolor
    printf "\nAUR:\n"
    paru -Qua
)

if [ "$total_updates" -gt 0 ]; then
    echo "{ \"text\": \"  $total_updates\", \"tooltip\": \"${updates//$'\n'/\\r}\" }"
fi
