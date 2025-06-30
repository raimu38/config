#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

SRC_DIR="$HOME/Dropbox/Obsidian"
DEST_DIR="$HOME/Documents/Obsidian"
LOG_DIR="$HOME/Documents/obsidian-log"
NOW_LOG_FILE="$LOG_DIR/$(date +%Y/%m/%d)-obsidian-backup.log"
GIT_REMOTE="origin"
GIT_BRANCH="main"

# ログ用ディレクトリ／ファイル準備
mkdir -p "$(dirname "$NOW_LOG_FILE")"
exec > >(tee -a "$NOW_LOG_FILE") 2>&1

echo "=== Obsidian Backup ==="
echo "Start:  $(date)"
echo "Source: $SRC_DIR"
echo "Target: $DEST_DIR"
echo

# rsync：.git とログフォルダは除外してミラーリング
rsync -a --delete \
      --exclude=".git" \
      --exclude="$(basename "$LOG_DIR")" \
      "$SRC_DIR/" "$DEST_DIR/"

echo
echo "Rsync done at $(date)"
echo

cd "$DEST_DIR"

# Gitコミット／プッシュ：変更があるときだけ
git add -A
if [[ -n "$(git status --porcelain)" ]]; then
  COMMIT_MSG="backup: $(date +'%Y-%m-%d %H:%M:%S')"
  git commit -m "$COMMIT_MSG"
  git push "$GIT_REMOTE" "$GIT_BRANCH"
  echo "Committed & pushed: $COMMIT_MSG"
else
  echo "No changes detected; skip commit."
fi

echo
echo "Finished at $(date)"

