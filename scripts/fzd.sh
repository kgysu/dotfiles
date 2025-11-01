# CD-Function

# fuzzy cd using fd + fzf
fzd() {
  local search_dir dir
  search_dir="${1:-.}"
  [[ "$search_dir" == "~" ]] && search_dir="$HOME"

  if [[ ! -d "$search_dir" ]]; then
    echo "❌ Directory not found: $search_dir" >&2
    return 1
  fi

  dir="$(fd --hidden --type d --follow --exclude .git --exclude node_modules . "$search_dir" \
    | fzf --border --prompt="cd> " \
          --preview 'ls -la --color=always {}' \
          --preview-window='right:60%:wrap')" || return

  [[ -n "$dir" ]] && cd "$dir" && l
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
