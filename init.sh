#!/usr/bin/env bash

# exit on error
set -e 

echo "Initializing machine.."

dirs=(
  "$HOME/.config"
  "$HOME/work/src"
  "$HOME/work/repos"
  "$HOME/work/tmp"
  "$HOME/bin"
  "$HOME/.local/bin"
  "$HOME/go/bin"
  "$HOME/go/src"
  "$HOME/.keys/pass"
  "$HOME/.keys/github"
)

for dir in "${dirs[@]}"; do
  if [[ ! -d "$dir" ]]; then
    mkdir -p "$dir"
    echo "created folder: $dir"
  fi
done


echo "cloning repo.."
git clone https://github.com/kgysu/dotfiles ~/.dotfiles


echo "cp scripts.."
cp -rv ~/.dotfiles/scripts ~/.scripts



if [ -n "$SHELL" ]; then
    sh_type="$SHELL"
elif command -v getent >/dev/null 2>&1; then
    sh_type=$(getent passwd "$USER" | cut -d: -f7)
else
    sh_type=$(grep "^$USER:" /etc/passwd | cut -d: -f7)
fi

echo "Detected shell: $sh_type"


setup_entrypoint() {
  local shell_file="$HOME/$1"
  echo "configure $shell_file"
  cat >> "$shell_file" <<'EOF'

# Source all scripts in ~/.scripts
if [ -d "$HOME/.scripts" ]; then
    for file in "$HOME/.scripts"/*.sh; do
        [ -r "$file" ] && [ -f "$file" ] && source "$file"
    done
fi
EOF
}


case "$sh_type" in
    /bin/bash)
      setup_entrypoint .bashrc
        ;;
    /bin/zsh)
      setup_entrypoint .zshrc
        ;;
    /usr/bin/zsh)
      setup_entrypoint .zshrc
        ;;
    /bin/sh)
      setup_entrypoint .bashrc
        ;;
    *)
        echo "Unsupported shell: $sh_type" >&2
        exit 1
        ;;
esac


echo "All done!"


