sleep 0.1
if [ -n "$1" ]; then
  neovide "$1"
else
  neovide
fi
kitty &
