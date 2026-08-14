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

# Git
ln -sf $DOTFILES/.gitconfig ~/.gitconfig
mkdir -p ~/.config/git
ln -sf $DOTFILES/git/ignore ~/.config/git/ignore

# Claude Code
mkdir -p ~/.claude
ln -sf $DOTFILES/claude/settings.json ~/.claude/settings.json
ln -sf $DOTFILES/claude/statusline-command.sh ~/.claude/statusline-command.sh

# Tmux
ln -sf $DOTFILES/.tmux.conf ~/.tmux.conf
if [ ! -d ~/.tmux/plugins/tpm ]; then
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi
~/.tmux/plugins/tpm/bin/install_plugins

echo "Done! Restart your shell or run: source ~/.zshrc"
