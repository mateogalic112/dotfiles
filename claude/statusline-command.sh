#!/bin/sh
input=$(cat)

cwd=$(echo "$input" | jq -r '.workspace.current_dir // .cwd')
model=$(echo "$input" | jq -r '.model.display_name')
used=$(echo "$input" | jq -r '.context_window.used_percentage // empty')

# Get git branch, skipping optional locks
branch=$(git -C "$cwd" --no-optional-locks symbolic-ref --short HEAD 2>/dev/null)

esc=$(printf '\033')
reset="${esc}[0m"
blue="${esc}[94m"
green="${esc}[92m"
magenta="${esc}[95m"
yellow="${esc}[93m"

line=""
append() {
  if [ -n "$2" ]; then
    [ -n "$line" ] && line="$line  "
    line="$line$1$2$reset"
  fi
}

if [ -n "$used" ]; then
  used_int=$(printf "%.0f" "$used")
  filled=$((used_int * 10 / 100))
  [ "$filled" -gt 10 ] && filled=10
  [ "$filled" -lt 0 ] && filled=0
  empty=$((10 - filled))
  bar=""
  [ "$filled" -gt 0 ] && bar=$(printf "%${filled}s" | tr ' ' '▓')
  [ "$empty" -gt 0 ] && bar="${bar}$(printf "%${empty}s" | tr ' ' '░')"
  ctx="ctx:[${bar}] ${used_int}%"
fi

append "$blue" "${cwd##*/}"
append "$green" "$branch"
append "$magenta" "$model"
append "$yellow" "$ctx"

printf '%s' "$line"
