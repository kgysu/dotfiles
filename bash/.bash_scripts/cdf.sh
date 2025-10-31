# CD-Function

# fuzzy cd using fd + fzf
cdf() {
  local search_dir dir
  search_dir="${1:-.}"
  [[ "$search_dir" == "~" ]] && search_dir="$HOME"

  if [[ ! -d "$search_dir" ]]; then
    echo "❌ Directory not found: $search_dir" >&2
    return 1
  fi

  #| fzf --height 50% --reverse --border --prompt="cd> " \
  dir="$(fd --hidden --type d --follow --exclude .git --exclude node_modules . "$search_dir" \
    | fzf --border --prompt="cd> " \
          --preview 'ls -la --color=always {}' \
          --preview-window='right:60%:wrap')" || return

  [[ -n "$dir" ]] && cd "$dir" && l
}


# bind Control-f key stroke
bind -x '"\C-f": "cdf ~"'


