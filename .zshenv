# Dedupes PATH; without it each nested shell re-prepends the .zprofile entries.
# fpath needs the same treatment: brew shellenv and .zshrc both add site-functions
typeset -U path PATH fpath FPATH

# Used by lazygit, gh, crontab and fc (git reads core.editor from .gitconfig)
export EDITOR="nvim"
export VISUAL="$EDITOR"

# Required by mvn for the Java projects in ~/projects
export JAVA_HOME="/opt/homebrew/opt/openjdk/libexec/openjdk.jdk/Contents/Home"

# Read by the lazy nvm loader in .zshrc; free to set here so scripts see it too
export NVM_DIR="$HOME/.nvm"
