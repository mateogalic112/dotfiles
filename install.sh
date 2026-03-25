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
echo "Importing Raycast preferences..."
osascript -e 'tell application "Raycast" to quit' 2>/dev/null
sleep 1
defaults import com.raycast.macos $DOTFILES/raycast.plist
echo "Raycast preferences imported. Please relaunch Raycast manually."

# Tmux
ln -sf $DOTFILES/.tmux.conf ~/.tmux.conf

echo "Done! Restart your shell or run: source ~/.zshrc"
