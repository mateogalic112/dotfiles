# Dotfiles

Personal configuration files for macOS.

## Contents

- **nvim/** — Neovim config 
- **claude/** — Claude Code settings and status line
- **.zshrc / .zshenv / .zprofile** — Shell config
- **.gitconfig** — Git config
- **git/ignore** — Global gitignore (linked to `~/.config/git/ignore`)
- **.tmux.conf** — Tmux config

## Setup on a new machine

Requires [Homebrew](https://brew.sh). Everything else is installed by the script.

```bash
# Clone the repo
git clone git@github.com:mateogalic112/dotfiles.git ~/dotfiles

# Run install script
cd ~/dotfiles
./install.sh
```

`install.sh` installs neovim, tmux, starship, ripgrep, lazygit, stylua, and node via
Homebrew, plus the `vtsls` and `tailwindcss` language servers via npm — then symlinks
every config. It is idempotent, so re-running it after a config change is safe.

Neovim plugins and treesitter parsers install themselves on first launch. Tmux plugins
install via tpm, which the script clones if missing.
