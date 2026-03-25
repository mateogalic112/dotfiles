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

# Tmux
ln -sf $DOTFILES/.tmux.conf ~/.tmux.conf

echo "Done! Restart your shell or run: source ~/.zshrc"
