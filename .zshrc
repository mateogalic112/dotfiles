HISTFILE="$HOME/.zsh_history"
HISTSIZE=50000
SAVEHIST=50000
setopt SHARE_HISTORY HIST_IGNORE_ALL_DUPS HIST_IGNORE_SPACE HIST_REDUCE_BLANKS

fpath=("${HOMEBREW_PREFIX:-/opt/homebrew}/share/zsh/site-functions" $fpath)
autoload -Uz compinit
compinit -d "${XDG_CACHE_HOME:-$HOME/.cache}/zcompdump"
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# Sourcing nvm.sh costs ~1.4s, so it is deferred until a node tool is first
# called. The shims replace themselves with the real commands on first use.
NVM_SH="/opt/homebrew/opt/nvm/nvm.sh"
if [ -s "$NVM_SH" ]; then
  for cmd in nvm node npm npx corepack yarn; do
    eval "${cmd}() { unfunction nvm node npm npx corepack yarn; . \"${NVM_SH}\"; ${cmd} \"\$@\" }"
  done
  unset cmd
fi

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

# Open project in tmux: nvim (left 70%, full-height) | claude (top-right 60%) / terminal (bottom-right 40%)
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

  # Split right for the claude/terminal column (nvim keeps 70%)
  tmux split-window -h -t "$session_name":1.1 -c "$PWD" -l 30%

  # Split that right column: terminal on the bottom
  tmux split-window -v -t "$session_name":1.2 -c "$PWD" -l 40%

  # Pane layout: 1=neovim (left), 2=claude (top-right), 3=terminal (bottom-right)
  tmux send-keys -t "$session_name":1.1 'nvim' C-m
  tmux send-keys -t "$session_name":1.2 'claude' C-m

  # Focus on neovim pane
  tmux select-pane -t "$session_name":1.1

  tmux attach-session -t "$session_name"
}

# Open the nova workspace in tmux: backend (atlas-edge | nova-practice), frontend (nvim | claude)
nova() {
  local session_name="nova"
  local projects="$HOME/projects"

  if [[ -n "$TMUX" ]]; then
    echo "Already in a tmux session. Detach first or run from outside tmux."
    return 1
  fi

  if tmux has-session -t "$session_name" 2>/dev/null; then
    tmux attach-session -t "$session_name"
    return
  fi

  tmux new-session -d -s "$session_name" -n backend -c "$projects/atlas-edge" -x "$(tput cols)" -y "$(tput lines)"
  tmux split-window -h -t "$session_name":backend.1 -c "$projects/nova-practice"

  tmux new-window -t "$session_name" -n frontend -c "$projects/nova-web"
  tmux split-window -h -t "$session_name":frontend.1 -c "$projects/nova-web"
  tmux send-keys -t "$session_name":frontend.1 'nvim' C-m
  tmux send-keys -t "$session_name":frontend.2 'claude' C-m

  tmux select-window -t "$session_name":backend
  tmux select-pane -t "$session_name":backend.1

  tmux attach-session -t "$session_name"
}

eval "$(starship init zsh)"

ZSH_PLUGINS="${HOMEBREW_PREFIX:-/opt/homebrew}/share"

# Falls back to the completion system when nothing in history matches
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
source "$ZSH_PLUGINS/zsh-autosuggestions/zsh-autosuggestions.zsh"

# Bound after the source above, which is where autosuggest-accept comes from
bindkey '^Y' autosuggest-accept

# Must stay last: it wraps every widget defined before it
source "$ZSH_PLUGINS/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
