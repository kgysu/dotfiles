
alias l='ls -lh'
alias ll='ls -lah'
alias la='ls -lah'

alias f='fzf'

if ! command -v fd >/dev/null 2>&1; then
  alias fd='fdfind'
fi

# git
alias gs='git status'
alias gaa='git add .'
alias gc='git commit -m'
alias gp='git push'
alias gfp='git fetch && git pull'

