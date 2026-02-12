#!/bin/bash

function check_status() {
  local target=$1
  if [ -f "$target" ]; then
    echo "File $target exists."
    return 0
  else
    echo "Error: $target not found."
    return 1
  fi
}

# 実行
FILES=( "vimrc" "setup_vim.sh" )
for f in "${FILES[@]}"; do
  check_status "$f"
done
