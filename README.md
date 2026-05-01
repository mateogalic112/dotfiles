# Dotfiles

Personal configuration files for macOS.

## Contents

- **nvim/** — Neovim config (Lazy plugin manager)
- **cursor/** — Cursor editor settings, keybindings, snippets, and extensions
- **claude/** — Claude Code settings and status line
- **.zshrc / .zshenv / .zprofile** — Shell config
- **.gitconfig** — Git config
- **.tmux.conf** — Tmux config
- **raycast.rayconfig** — Raycast settings (import manually)

## Setup on a new machine

```bash
# Install dependencies
brew install neovim tmux

# Clone the repo
git clone git@github.com:mateogalic112/dotfiles.git ~/dotfiles

# Run install script
cd ~/dotfiles
./install.sh
```

Neovim plugins auto-install via Lazy on first launch. Cursor extensions install automatically if Cursor is installed. Raycast config must be imported manually via Raycast Settings → Advanced → Import.
