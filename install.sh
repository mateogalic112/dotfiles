#!/bin/bash
set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Installing dotfiles..."

# Homebrew isn't on PATH until .zprofile is linked, so load it from its default location
for brew_bin in /opt/homebrew/bin/brew /usr/local/bin/brew /home/linuxbrew/.linuxbrew/bin/brew; do
  if [ -x "$brew_bin" ]; then
    eval "$("$brew_bin" shellenv)"
    break
  fi
done

if ! command -v brew >/dev/null 2>&1; then
  echo "Homebrew is required: https://brew.sh"
  exit 1
fi

# Go tooling lands in ~/go/bin; .zprofile adds it for shells, this adds it for the checks below
export PATH="$HOME/go/bin:$PATH"

# Dependencies (see Brewfile)
brew bundle --file="$DOTFILES/Brewfile"

# nvm keeps its Node versions here (NVM_DIR in .zshenv); brew does not create it
mkdir -p ~/.nvm

command -v vtsls >/dev/null 2>&1 || npm install -g @vtsls/language-server

command -v gopls >/dev/null 2>&1 || go install golang.org/x/tools/gopls@latest
command -v goimports >/dev/null 2>&1 || go install golang.org/x/tools/cmd/goimports@latest
command -v dlv >/dev/null 2>&1 || go install github.com/go-delve/delve/cmd/dlv@latest

# Symlink $DOTFILES/<src> to <dest>, backing up any real file or folder already there
link() {
  local src="$DOTFILES/$1" dest="$2"
  mkdir -p "$(dirname "$dest")"
  if [ -e "$dest" ] && [ ! -L "$dest" ]; then
    local backup
    backup="$dest.backup.$(date +%Y%m%d%H%M%S)"
    mv "$dest" "$backup"
    echo "Backed up existing $dest to $backup"
  fi
  # -n: replace an existing link to a folder instead of creating a link inside it
  ln -sfn "$src" "$dest"
}

# Neovim
link nvim ~/.config/nvim

# Shell
link .zshrc ~/.zshrc
link .zshenv ~/.zshenv
link .zprofile ~/.zprofile

# Git
link .gitconfig ~/.gitconfig
link git/ignore ~/.config/git/ignore

# Ripgrep
link .ripgreprc ~/.ripgreprc

# Claude Code
link claude/settings.json ~/.claude/settings.json
link claude/statusline-command.sh ~/.claude/statusline-command.sh

# Starship
link starship/starship.toml ~/.config/starship.toml

# Ghostty (macOS only)
if [[ "$OSTYPE" == darwin* ]]; then
  link ghostty/config.ghostty ~/.config/ghostty/config.ghostty
fi

# Tmux
link .tmux.conf ~/.tmux.conf
if [ ! -d ~/.tmux/plugins/tpm ]; then
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi
~/.tmux/plugins/tpm/bin/install_plugins

echo "Done! Restart your shell or run: source ~/.zshrc"
