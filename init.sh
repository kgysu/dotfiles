#!/usr/bin/env bash

echo "Initializing machine.."

dirs=(
  "$HOME/work/src"
  "$HOME/work/repos"
  "$HOME/work/tmp"
)

for dir in "${dirs[@]}"; do
  if [[ ! -d "$dir" ]]; then
    mkdir -p "$dir"
    echo "created folder: $dir"
  fi
done


echo "cloning repo.."
git clone https://github.com/kgysu/dotfiles ~/.dotfiles


DOTDIR="$HOME/.dotfiles"



if [ -n "$SHELL" ]; then
    sh_type="$SHELL"
elif command -v getent >/dev/null 2>&1; then
    sh_type=$(getent passwd "$USER" | cut -d: -f7)
else
    sh_type=$(grep "^$USER:" /etc/passwd | cut -d: -f7)
fi

echo "Detected shell: $sh_type"

case "$sh_type" in
    bash)
        exec bash "$DOTDIR/bash/install.bash" "$@"
        ;;
    zsh)
          exec zsh "$DORDIR/zsh/install.zsh" "$@"
        ;;
    *)
        echo "Unsupported shell: $sh_type" >&2
        exit 1
        ;;
esac
