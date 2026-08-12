export CLAUDE_CODE_STATUS_LINE=1

# Kill process on a port
kp() {
  lsof -ti:$1 | xargs kill -9
}

# Quick commit & push
gcp() {
  git add .
  git commit -m "$1"
  git push
}

# Open project in tmux: nvim (left, full-height) | terminal (top-right 40%) / claude (bottom-right 60%)
nic() {
  local session_name="$(basename "$PWD")"

  # If already inside tmux, don't nest
  if [[ -n "$TMUX" ]]; then
    echo "Already in a tmux session. Detach first or run from outside tmux."
    return 1
  fi

  # Attach if session already exists
  if tmux has-session -t "$session_name" 2>/dev/null; then
    tmux attach-session -t "$session_name"
    return
  fi

  # Create session (pane 1: will become neovim, left column, full height)
  tmux new-session -d -s "$session_name" -c "$PWD" -x "$(tput cols)" -y "$(tput lines)"

  # Split right for the claude/terminal column (40% width, full height)
  tmux split-window -h -t "$session_name":1.1 -c "$PWD" -l 40%

  # Split that right column: claude on the bottom (60% of column height)
  tmux split-window -v -t "$session_name":1.2 -c "$PWD" -l 60%

  # Pane layout: 1=neovim (left), 2=terminal (top-right), 3=claude (bottom-right)
  tmux send-keys -t "$session_name":1.1 'nvim' C-m
  tmux send-keys -t "$session_name":1.3 'claude' C-m

  # Focus on neovim pane
  tmux select-pane -t "$session_name":1.1

  tmux attach-session -t "$session_name"
}

export PATH="/opt/homebrew/opt/ruby/bin:$PATH"
eval "$(starship init zsh)"
