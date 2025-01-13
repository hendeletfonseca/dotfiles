export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(git zsh-syntax-highlighting zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

eval "$(/home/hendel/.local/bin/mise activate zsh)"
eval "$(zoxide init zsh)"
source <(fzf --zsh)
#eval "$(zellij setup --generate-auto-start zsh)"

alias cd="z"
alias cat="bat"
alias ls="exa --icons"
alias htop="btop"
alias lowbright="xrandr --output HDMI-0 --brightness 0.7"
alias highbright="xrandr --output HDMI-0 --brightness 1"
export CHROME_EXECUTABLE=/usr/bin/chromium

export PATH="/home/hendel/workspace/flutter/bin:$PATH"
