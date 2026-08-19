#!/bin/bash
set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Installing dotfiles..."

# Dependencies
if ! command -v brew >/dev/null 2>&1; then
  echo "Homebrew is required: https://brew.sh"
  exit 1
fi

BREW_PACKAGES=(neovim tmux starship ripgrep fd lazygit stylua node go ruby vscode-langservers-extracted tailwindcss-language-server lua-language-server bash-language-server)
for pkg in "${BREW_PACKAGES[@]}"; do
  brew list --versions "$pkg" >/dev/null 2>&1 || brew install "$pkg"
done

command -v vtsls >/dev/null 2>&1 || npm install -g @vtsls/language-server

# Go tooling lands in ~/go/bin, which .zshenv puts on PATH
command -v gopls >/dev/null 2>&1 || go install golang.org/x/tools/gopls@latest
command -v goimports >/dev/null 2>&1 || go install golang.org/x/tools/cmd/goimports@latest

# Neovim
mkdir -p ~/.config
ln -sfn "$DOTFILES/nvim" ~/.config/nvim

# Shell
ln -sf "$DOTFILES/.zshrc" ~/.zshrc
ln -sf "$DOTFILES/.zshenv" ~/.zshenv
ln -sf "$DOTFILES/.zprofile" ~/.zprofile

# Git
ln -sf "$DOTFILES/.gitconfig" ~/.gitconfig
mkdir -p ~/.config/git
ln -sf "$DOTFILES/git/ignore" ~/.config/git/ignore

# Claude Code
mkdir -p ~/.claude
ln -sf "$DOTFILES/claude/settings.json" ~/.claude/settings.json
ln -sf "$DOTFILES/claude/statusline-command.sh" ~/.claude/statusline-command.sh

# Ghostty
mkdir -p ~/.config/ghostty
ln -sf "$DOTFILES/ghostty/config.ghostty" ~/.config/ghostty/config.ghostty

# Tmux
ln -sf "$DOTFILES/.tmux.conf" ~/.tmux.conf
if [ ! -d ~/.tmux/plugins/tpm ]; then
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi
~/.tmux/plugins/tpm/bin/install_plugins

echo "Done! Restart your shell or run: source ~/.zshrc"
