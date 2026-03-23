# Dotfiles

Personal configuration files for macOS.

## Contents

- **nvim** — Neovim config (Lazy plugin manager)
- **.zshrc / .zshenv / .zprofile** — Zsh shell config
- **.gitconfig** — Git config
- **.tmux.conf** — Tmux config
- **.profile** — Shell profile

## Setup on a new machine

```bash
# Install dependencies
brew install neovim tmux

# Clone the repo
git clone git@github.com:mateogalic112/dotfiles.git ~/dotfiles

# Create symlinks
cd ~/dotfiles
./install.sh
```

Open `nvim` and plugins will auto-install via Lazy.
