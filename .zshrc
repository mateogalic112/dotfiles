export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion"
export PATH="$HOME/.local/bin:$PATH"

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

