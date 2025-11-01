# Configure Neovim functions

conf-nvim() {
  echo "configure neovim"

  if [[ -d "$HOME/.config/nvim" ]]; then
    echo "backup existing config"
    mv -v ~/.config/nvim ~/.config/nvim.bak-$(date +%Y-%m-%d)
  fi

  if [[ ! -d "$HOME/nvim" ]]; then
    echo "clone personal nvim conf"
    git clone https://github.com/kgysu/nvim ~/nvim
  fi

  echo "copy from git.."
  cp -rv ~/nvim/nvim-new ~/.config/nvim

  echo "done!"
}


sync-nvim() {
  echo "sync back neovim conf to git"

  if [[ ! -d "$HOME/nvim" ]]; then
    echo "clone personal nvim conf"
    git clone https://github.com/kgysu/nvim ~/nvim
  fi

  echo "remove in git"
  rm -rf ~/nvim/nvim-new

  echo "copy to git repo"
  cp -rv ~/.config/nvim ~/nvim/nvim-new
}
