#!/bin/zsh

# Replace defaults
alias ls='exa -l --icons=always'
alias g=git
alias cd=z
alias n='nvim'
alias v=n
alias vi=n
alias vim=n
alias c=clear
alias e=exit
alias lg=lazygit

alias run='nvm use && npm run'

restart() {
  killall "$1"
  hyprctl dispatch exec "$1"
}

function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}

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
