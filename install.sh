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

# Tmux
ln -sf $DOTFILES/.tmux.conf ~/.tmux.conf

echo "Done! Restart your shell or run: source ~/.zshrc"
