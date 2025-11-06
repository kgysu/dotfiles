# CD-Function

# fuzzy cd using fd + fzf
fzd() {
  local search_dir dir fd_cmd preview_cmd
  search_dir=("${@:-$PWD}")

  # Build preview command
  preview_cmd='
  if git -C {} rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    echo "📦 Git repository:"
    git -C {} status --short --branch
    echo
  fi
  echo "📂 Directory contents:"
  ls -lah --color=always {} | head -n 40
  '

   # Build fd command dynamically for all base dirs
  fd_cmd="fd --type d --follow --exclude node_modules . ${search_dir[@]}"

  # Run fd, pipe to fzf, and select directory
  dir=$(eval "$fd_cmd" | fzf --border --prompt="cd> " --preview="$preview_cmd" --preview-window='right:60%:wrap') || return

  if [[ -n "$dir" ]]; then
    cd "$dir" && l
  fi
}


# bind Control-f key stroke
case "$SHELL" in
    /bin/bash)
       bind -x '"\C-f": "fzd ~"'
        ;;
    /bin/sh)
       bind -x '"\C-f": "fzd ~"'
        ;;
    /bin/zsh)
        bindkey -s '^F' 'fzd ~\n'
        ;;
    /usr/bin/zsh)
        bindkey -s '^F' 'fzd ~\n'
        ;;
    *)
        echo "Key bindings not supported in this shell: $SHELL"
        return
        ;;
esac
