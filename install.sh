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

# Raycast (import manually: Raycast Settings → Advanced → Import)
echo "Raycast: Import $DOTFILES/raycast.rayconfig via Raycast Settings → Advanced → Import"

# Cursor
CURSOR_DIR="$HOME/Library/Application Support/Cursor/User"
mkdir -p "$CURSOR_DIR/snippets"
cp $DOTFILES/cursor/settings.json "$CURSOR_DIR/settings.json"
cp $DOTFILES/cursor/keybindings.json "$CURSOR_DIR/keybindings.json"
cp $DOTFILES/cursor/snippets/* "$CURSOR_DIR/snippets/"
CURSOR_BIN="/Applications/Cursor.app/Contents/Resources/app/bin/cursor"
if [ -f "$CURSOR_BIN" ]; then
  xargs -n1 "$CURSOR_BIN" --install-extension < $DOTFILES/cursor/extensions.txt
fi

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
