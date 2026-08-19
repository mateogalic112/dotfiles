# Dedupes PATH; without it each nested shell re-prepends the entries below
typeset -U path PATH

# Used by lazygit, gh, crontab and fc (git reads core.editor from .gitconfig)
export EDITOR="nvim"
export VISUAL="$EDITOR"

# Required by mvn for the Java projects in ~/projects
export JAVA_HOME="/opt/homebrew/opt/openjdk/libexec/openjdk.jdk/Contents/Home"

# Read by the lazy nvm loader in .zshrc; free to set here so scripts see it too
export NVM_DIR="$HOME/.nvm"

# claude and cursor-agent, the go tooling nvim calls, and the rustup toolchain,
# all ahead of homebrew so rustup and gopls stay authoritative
path=(
  "$HOME/.local/bin"
  "$HOME/go/bin"
  "$HOME/.cargo/bin"
  $path
)
