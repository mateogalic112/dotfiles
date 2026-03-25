#!/bin/bash
DOTFILES=~/dotfiles

echo "Installing dotfiles..."

# Neovim
mkdir -p ~/.config
ln -sf $DOTFILES/nvim ~/.config/nvim

# Shell
ln -sf $DOTFILES/.zshrc ~/.zshrc
ln -sf $DOTFILES/.zshenv ~/.zshenv
ln -sf $DOTFILES/.zprofile ~/.zprofile
ln -sf $DOTFILES/.profile ~/.profile

# Git
ln -sf $DOTFILES/.gitconfig ~/.gitconfig

# Raycast (import manually: Raycast Settings → Advanced → Import)
echo "Raycast: Import $DOTFILES/raycast.rayconfig via Raycast Settings → Advanced → Import"

# Cursor
CURSOR_DIR="$HOME/Library/Application Support/Cursor/User"
mkdir -p "$CURSOR_DIR/snippets"
ln -sf $DOTFILES/cursor/settings.json "$CURSOR_DIR/settings.json"
ln -sf $DOTFILES/cursor/keybindings.json "$CURSOR_DIR/keybindings.json"
ln -sf $DOTFILES/cursor/snippets/* "$CURSOR_DIR/snippets/"
if command -v cursor &>/dev/null; then
  xargs -n1 cursor --install-extension < $DOTFILES/cursor/extensions.txt
fi

# Tmux
ln -sf $DOTFILES/.tmux.conf ~/.tmux.conf

echo "Done! Restart your shell or run: source ~/.zshrc"
