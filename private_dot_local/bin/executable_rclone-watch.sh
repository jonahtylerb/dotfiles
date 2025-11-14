#!/bin/bash
NOTES_DIR="$HOME/Documents/Notes"
REMOTE="remote:Notes"

rclone bisync "$NOTES_DIR" "$REMOTE" --resync

while inotifywait -r -e modify,create,delete,move "$NOTES_DIR"; do
  rclone bisync "$NOTES_DIR" "$REMOTE" --resilient
done
