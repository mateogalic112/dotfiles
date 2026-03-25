#!/bin/sh
input=$(cat)

cwd=$(echo "$input" | jq -r '.workspace.current_dir // .cwd')
model=$(echo "$input" | jq -r '.model.display_name')
used=$(echo "$input" | jq -r '.context_window.used_percentage // empty')

# Get git branch, skipping optional locks
branch=$(git -C "$cwd" --no-optional-locks symbolic-ref --short HEAD 2>/dev/null)

# Format the directory to use ~ for home
home="$HOME"
display_dir="${cwd##*/}"

# Soft ANSI colors (using standard 8-color bright variants for broad compatibility)
RESET="\033[0m"
LIGHT_BLUE="\033[94m"    # bright blue  — directory
LIGHT_GREEN="\033[92m"   # bright green — git branch
LIGHT_MAGENTA="\033[95m" # bright magenta — model name
LIGHT_YELLOW="\033[93m"  # bright yellow — context usage

# Format context usage if available
if [ -n "$used" ]; then
  used_int=$(printf "%.0f" "$used")
  # Build a 10-character progress bar
  filled=$(( used_int * 10 / 100 ))
  [ "$filled" -gt 10 ] && filled=10
  empty=$(( 10 - filled ))
  bar=""
  [ "$filled" -gt 0 ] && bar=$(printf "%${filled}s" | tr ' ' '▓')
  [ "$empty" -gt 0 ] && bar="${bar}$(printf "%${empty}s" | tr ' ' '░')"
  ctx_str="ctx:[${bar}] ${used_int}%"
else
  ctx_str=""
fi

if [ -n "$branch" ] && [ -n "$ctx_str" ]; then
  printf "${LIGHT_BLUE}%s${RESET}  ${LIGHT_GREEN}%s${RESET}  ${LIGHT_MAGENTA}%s${RESET}  ${LIGHT_YELLOW}%s${RESET}" \
    "$display_dir" "$branch" "$model" "$ctx_str"
elif [ -n "$branch" ]; then
  printf "${LIGHT_BLUE}%s${RESET}  ${LIGHT_GREEN}%s${RESET}  ${LIGHT_MAGENTA}%s${RESET}" \
    "$display_dir" "$branch" "$model"
elif [ -n "$ctx_str" ]; then
  printf "${LIGHT_BLUE}%s${RESET}  ${LIGHT_MAGENTA}%s${RESET}  ${LIGHT_YELLOW}%s${RESET}" \
    "$display_dir" "$model" "$ctx_str"
else
  printf "${LIGHT_BLUE}%s${RESET}  ${LIGHT_MAGENTA}%s${RESET}" \
    "$display_dir" "$model"
fi
