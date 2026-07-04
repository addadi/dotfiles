#!/usr/bin/zsh
# zmx helper functions - source this from your .zshrc
# Usage: source ~/.config/zmx/rc.zsh

ZMX_SESSIONS_DIR="${ZMX_SESSIONS_DIR:-$HOME/.config/zmx/sessions}"

# Quick attach shortcuts
za() { zmx attach "$1" }

# Dev sessions - attach or create common project sessions
zdev() {
  local sessions=("main" "build" "git" "dotfiles")
  for s in "${sessions[@]}"; do
    zmx attach "$s" &
  done
  wait
}

# Kill all sessions
zkillall() {
  local sessions
  sessions=$(zmx list --short 2>/dev/null)
  if [[ -n "$sessions" ]]; then
    echo "Killing sessions: $sessions"
    echo "$sessions" | xargs zmx kill
  else
    echo "No active sessions"
  fi
}

# Fuzzy attach (requires fzf)
zf() {
  local session
  session=$(zmx list --short 2>/dev/null | fzf --prompt="zmx session> ")
  [[ -n "$session" ]] && zmx attach "$session"
}

# List sessions nicely
zls() {
  zmx list "${@}"
}

# Tail a session
zt() {
  zmx tail "${@}"
}

# Print history
zhist() {
  zmx history "${@}"
}
