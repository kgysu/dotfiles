#!/usr/bin/env bash

set -e

echo "Setup BASH"


echo "cp bash files.."
cp -rv ~/.dotfiles/bash/.bash ~/


echo "configure .bashrc"
cat <<'EOF' >> ~/.bashrc

# Source all scripts in ~/.bash
if [ -d "$HOME/.bash" ]; then
    for file in "$HOME/.bash"/*.sh; do
        [ -r "$file" ] && [ -f "$file" ] && source "$file"
    done
fi
EOF


echo "ALL DONE!"
