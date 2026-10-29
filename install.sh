#!/usr/bin/env bash
# Symlink macOS configs from this repo into $HOME.
# Safe to re-run: existing links are refreshed, and any real file or
# directory in the way is moved to ~/.dotfiles-backup/<timestamp>/.
set -euo pipefail

DOTFILES="$(cd "$(dirname "$0")" && pwd)"
BACKUP="$HOME/.dotfiles-backup/$(date +%Y%m%d-%H%M%S)"

# repo path -> target in $HOME
LINKS=(
  "fish:.config/fish"
  "omf:.config/omf"
  "ghostty:.config/ghostty"
  "nvim:.config/nvim"
  "zsh/.zshrc:.zshrc"
  "tmux/.tmux.conf:.tmux.conf"
  "git/.gitconfig:.gitconfig"
)

for pair in "${LINKS[@]}"; do
  src="$DOTFILES/${pair%%:*}"
  dest="$HOME/${pair#*:}"

  if [ -L "$dest" ]; then
    rm "$dest"
  elif [ -e "$dest" ]; then
    mkdir -p "$BACKUP/$(dirname "${pair#*:}")"
    mv "$dest" "$BACKUP/${pair#*:}"
    echo "backed up $dest"
  fi

  mkdir -p "$(dirname "$dest")"
  ln -s "$src" "$dest"
  echo "linked $dest -> $src"
done

# Hide the "Last login" banner in new terminals
touch "$HOME/.hushlogin"
