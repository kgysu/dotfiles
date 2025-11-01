# Profile

if [[ -d "$HOME/bin" ]]; then
  export PATH="$HOME/bin:$PATH"
fi


if [[ -d "$HOME/.local/bin" ]]; then
  export PATH="$HOME/.local/bin:$PATH"
fi

export PATH="$PATH:/usr/local/go/bin"
export PATH="$HOME/go/bin:$PATH"


# ENV
export TERM="xterm-256color"

export EDITOR="nvim"
