#!/bin/zsh

# Replace defaults
alias ls='exa -l --icons=always'
alias g=git
alias cd=z
alias n='nvim'
alias vi=n
alias vim=n
alias c=clear
alias e=exit
alias lg=lazygit
alias y=yazi

alias run='nvm use && npm run'

v() {
  nohup ~/.config/zsh/.zshrc.d/neovide.sh "$1" >/dev/null 2>&1 &!
  exit
}

restart() {
  killall "$1"
  hyprctl dispatch exec "$1"
}

alias tt='taskwarrior-tui'

# more ways to ls
alias l=ls
alias ll='ls -lh'
alias la='ls -lAh'
alias ldot='ls -ld .*'

# the only good things in Windows
alias cd..='cd ..'
alias cls='clear'
alias tree='exa --tree --icons=always'

# be kind to your terminal
alias pls=sudo
alias thx='clear && echo "You are very welcome :)"'
