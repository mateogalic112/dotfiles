# Installed by install.sh via `brew bundle`.
# See what's installed but not listed here: brew bundle cleanup --file=~/dotfiles/Brewfile

tap "stripe/stripe-cli"

# Editor & terminal
brew "neovim"
brew "tmux"
brew "starship"
brew "ripgrep"
brew "fd"
brew "fzf"
brew "bat"
brew "zoxide"
brew "btop"
brew "gh"
brew "lazygit"
brew "stripe"

# Formatters, linters & parsers
brew "stylua"
brew "shellcheck"
brew "prettier"
brew "tree-sitter-cli"

# Languages
brew "node"
brew "nvm"
brew "go"

# Language servers
brew "vscode-langservers-extracted"
brew "tailwindcss-language-server"
brew "lua-language-server"
brew "bash-language-server"

# Zsh plugins
brew "zsh-autosuggestions"
brew "zsh-syntax-highlighting"

# Casks are macOS-only
if OS.mac?
  cask "font-jetbrains-mono-nerd-font"
  cask "1password-cli"
  # Skip when Docker.app was installed outside Homebrew, or the cask refuses to overwrite it
  cask "docker-desktop" unless File.exist?("/Applications/Docker.app")
end
