#!/usr/bin/env bash

# ==============================================================
#  Vim Setup Script
#  Author: Raimu38
# ==============================================================

if [ "$(id -u)" -ne 0 ]; then
    echo "[ERROR] sudo をつけて実行してください" >&2
    exit 1
fi

echo "===================================================="
echo "   Vim 環境診断・構築"
echo "===================================================="

# 1. リポジトリ更新
echo "[1/3] パッケージリストを更新中だにゃ..."
apt update > /dev/null 2>&1

echo ""
# 2. バージョン情報の取得
# インストール済みバージョンを dpkg から取得
INSTALLED_RAW=$(dpkg-query -W -f='${Version}' vim 2>/dev/null || echo "")

# [修正] 過去に成功した「候補:」と英語の「Candidate:」の両方に対応するにゃ
APT_POLICY=$(apt-cache policy vim)
CANDIDATE_RAW=$(echo "$APT_POLICY" | grep -E "候補:|Candidate:" | awk '{print $2}' | head -n 1)

# 数値の抽出 (例: 2:9.1.0016-1ubuntu7.9 -> 9.1.0016)
CURRENT_NUM=$(echo "$INSTALLED_RAW" | sed -e 's/^[0-9]://' -e 's/-.*//')
LATEST_NUM=$(echo "$CANDIDATE_RAW" | sed -e 's/^[0-9]://' -e 's/-.*//')

echo "----------------------------------------------------"
echo " 【Vim 本体比較】"
echo "  現状のバージョン : ${CURRENT_NUM:-未インストール} (${INSTALLED_RAW:-None})"
echo "  公式の最新候補   : ${LATEST_NUM:-取得失敗} (${CANDIDATE_RAW:-None})"
echo "----------------------------------------------------"

# 3. 比較とアクション
if [ -z "$CANDIDATE_RAW" ]; then
    echo "[ERROR] リポジトリから最新候補を取得できなかったにゃ。処理を中断するにゃ。"
    exit 1
fi

if [ -z "$INSTALLED_RAW" ]; then
    STATUS="[未導入]"
    PROMPT_MSG="Vim を新規インストールするかにゃ？"
elif [ "$INSTALLED_RAW" = "$CANDIDATE_RAW" ]; then
    STATUS="[最新]"
    PROMPT_MSG="すでに最新だにゃ。再インストール（修復）するかにゃ？"
else
    STATUS="[更新あり]"
    PROMPT_MSG="最新版へアップデートするかにゃ？"
fi

echo "  状態 : ${STATUS}"
read -p "  ${PROMPT_MSG} (y/N): " -r CHOICE
echo
if [[ "$CHOICE" =~ ^[Yy]$ ]]; then
    apt install -y vim
    apt autoremove -y
fi

echo ""
# 4. vim-plug の確認
echo "===================================================="
echo "   プラグインマネージャー(vim-plug)の確認"
echo "===================================================="

REAL_USER="${SUDO_USER:-$USER}"
REAL_HOME=$(eval echo "~$REAL_USER")
PLUG_DEST="${REAL_HOME}/.vim/autoload/plug.vim"

if [ -f "$PLUG_DEST" ]; then
    LOCAL_DATE=$(date -u -r "$PLUG_DEST" "+%Y-%m-%dT%H:%M:%SZ")
else
    LOCAL_DATE="未インストール"
fi

echo -n "GitHub API から最新情報を取得中だにゃ..."
REMOTE_DATE=$(curl -s "https://api.github.com/repos/junegunn/vim-plug/commits?path=plug.vim&page=1&per_page=1" | grep '"date":' | head -n 1 | awk -F'"' '{print $4}' || echo "取得失敗")
echo " Done!"

echo "----------------------------------------------------"
echo " 【vim-plug 比較】"
echo "  手元の更新日 : ${LOCAL_DATE}"
echo "  GitHub最新日 : ${REMOTE_DATE}"
echo "----------------------------------------------------"

if [ "$LOCAL_DATE" == "未インストール" ]; then
    STATUS_PLUG="[未導入]"
    PLUG_PROMPT="vim-plug を導入するかにゃ？"
elif [ "$LOCAL_DATE" == "$REMOTE_DATE" ]; then
    STATUS_PLUG="[最新]"
    PLUG_PROMPT="再取得して上書きするかにゃ？"
else
    STATUS_PLUG="[更新あり]"
    PLUG_PROMPT="最新の plug.vim に更新するかにゃ？"
fi

echo "  状態 : ${STATUS_PLUG}"
read -p "  ${PLUG_PROMPT} (y/N): " -r PLUG_CHOICE
if [[ "$PLUG_CHOICE" =~ ^[Yy]$ ]]; then
    mkdir -p "${REAL_HOME}/.vim/autoload"
    curl -fLo "$PLUG_DEST" --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    if [ "$REMOTE_DATE" != "取得失敗" ]; then
        touch -d "$REMOTE_DATE" "$PLUG_DEST"
    fi
    chown -R "$REAL_USER:$REAL_USER" "${REAL_HOME}/.vim"
    echo "完了だにゃ。"
fi

echo "===================================================="
