export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(git zsh-syntax-highlighting zsh-autosuggestions asdf)

source $ZSH/oh-my-zsh.sh

export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

#eval "$(/home/hendel/.local/bin/mise activate zsh)"
eval "$(zoxide init zsh)"
source <(fzf --zsh)
#eval "$(zellij setup --generate-auto-start zsh)"

alias cd="z"
alias cat="bat"
alias ls="exa --icons"
alias htop="btop"

function set_brightness() {
  if [[ -z $1 ]]; then
    echo "Usage: set_brightness <value>"
    echo "Value must be between 0.0 (lowest) and 1.0 (default)."
    return 1
  fi

  xrandr --output HDMI-0 --brightness $1
}

export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"

source <(kubectl completion zsh)

