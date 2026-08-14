# Dotfiles

Personal configuration files for macOS.

## Contents

- **nvim/** — Neovim config (Lazy plugin manager)
- **claude/** — Claude Code settings and status line
- **.zshrc / .zshenv / .zprofile** — Shell config
- **.gitconfig** — Git config
- **git/ignore** — Global gitignore (linked to `~/.config/git/ignore`)
- **.tmux.conf** — Tmux config

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

Neovim plugins auto-install via Lazy on first launch. Tmux plugins install via tpm, which the script clones if missing.
