# Dot Config files functions


conf-dot() {
  if [ $# -eq 0 ]; then
      echo "Usage: conf-dot <name>"
      return
  fi
  echo "configure dotfiles for: $1"

  if [[ -d "$HOME/.config/$1" ]]; then
    echo "backup existing config"
    mv -v "$HOME/.config/$1" "$HOME/.config/$1.bak-$(date +%Y-%m-%d)"
  fi

  echo "copy from git.."
  cp -rv "$HOME/.dotfiles/config/$1" "$HOME/.config/$1"

  echo "done!"
}


sync-dot() {
  if [ $# -eq 0 ]; then
      echo "Usage: conf-dot <name>"
      return
  fi
  echo "sync back conf to git for: $1"

  echo "remove in git"
  rm -rf "$HOME/.dotfiles/config/$1"

  echo "copy to git repo"
  cp -rv "$HOME/.config/$1" "$HOME/.dotfiles/config/$1"
}
