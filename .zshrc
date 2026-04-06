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

