# Update scripts function

up-scripts() {

  if [[ -d "$HOME/.scripts" ]]; then
    rm -rf "$HOME/.scripts"
  fi

  echo "cp scripts.."
  cp -rv ~/.dotfiles/scripts ~/.scripts

  echo "scripts updated"
}


save-scripts() {
  echo "rm scripts"
  rm -rf "$HOME/.dotfiles/scripts"

  echo "cp scripts"
  cp -rv ~/.scripts ~/.dotfiles/scripts

  echo "scripts saved"
}


