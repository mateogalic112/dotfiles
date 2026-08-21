eval "$(/opt/homebrew/bin/brew shellenv)"

path=(
  "$HOME/.local/bin"
  "$HOME/go/bin"
  "$HOME/.cargo/bin"
  $path
)
