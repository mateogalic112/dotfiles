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

# Raycast
# Hotkeys and snippets are in an encrypted DB — plist alone won't sync them.
# To fully sync Raycast:
#   1. On source machine: Raycast Settings → Advanced → Export (.rayconfig)
#   2. Save the .rayconfig file to this dotfiles directory
#   3. On target machine: Raycast Settings → Advanced → Import
echo "Raycast: Import $DOTFILES/*.rayconfig manually via Raycast Settings → Advanced → Import"

# Tmux
ln -sf $DOTFILES/.tmux.conf ~/.tmux.conf

echo "Done! Restart your shell or run: source ~/.zshrc"
