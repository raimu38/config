#!/usr/bin/env bash
set -euo pipefail

# ==============================================================
#  VS Code 設定復元スクリプト (全自動スキップ版)
#  Author: Raimu38
# ==============================================================

VSCODE_CONFIG_DIR="$HOME/.config/Code/User"
BACKUP_DIR="vscode_settings"

echo "[INFO] --- おめえの設定を VS Code に戻してやるにゃ。差分がある時だけ呼ぶにゃ ---"

if [ ! -d "$BACKUP_DIR" ]; then
    echo "[ERROR] '${BACKUP_DIR}' が見当たらないにゃ。話にならないにゃ。" >&2
    exit 1
fi

# 1. 拡張機能の確認
if [ -f "${BACKUP_DIR}/extensions.txt" ]; then
    CURRENT_EXTS=$(mktemp)
    code --list-extensions > "$CURRENT_EXTS"
    ADDED=$(grep -Fvf "$CURRENT_EXTS" "${BACKUP_DIR}/extensions.txt" || true)
    rm -f "$CURRENT_EXTS"

    if [ -n "$ADDED" ]; then
        echo "----------------------------------------------------"
        echo "  [拡張機能] 新しくインストールが必要なものがあるにゃ。"
        echo "$ADDED" | sed 's/^/      [+] /'
        read -p "  インストールしてもいいかにゃ？ (y/N): " -r
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            echo "[INFO] 拡張機能をインストール中だにゃ。"
            echo "$ADDED" | xargs -L 1 code --install-extension
        fi
    else
        echo "[INFO] 拡張機能はすべて導入済みだにゃ。飛ばすにゃ。"
    fi
fi

# 2. 設定ファイルの復元
restore_file() {
    local filename=$1
    local src="${BACKUP_DIR}/${filename}"
    local dest="${VSCODE_CONFIG_DIR}/${filename}"

    if [ ! -f "$src" ]; then return; fi

    if [ -f "$dest" ]; then
        if diff -q "$dest" "$src" > /dev/null; then
            echo "[INFO] ${filename} は一致してるにゃ。飛ばすにゃ。"
            return
        fi

        echo "----------------------------------------------------"
        echo "  [ファイル変更あり: ${filename}]"
        diff -u --color=always "$dest" "$src" || true
        read -p "  上書き反映してもいいかにゃ？ (y/N): " -r
        [[ ! $REPLY =~ ^[Yy]$ ]] && return
    else
        echo "----------------------------------------------------"
        echo "  [新規ファイル: ${filename}]"
        read -p "  新しく配置してもいいかにゃ？ (y/N): " -r
        [[ ! $REPLY =~ ^[Yy]$ ]] && return
    fi

    cp "$src" "$dest"
    echo "  [SUCCESS] ${filename} を反映したにゃ。"
}

restore_file "settings.json"
restore_file "keybindings.json"

# 3. スニペットの復元 (ここも差分がある時だけにするにゃ)
if [ -d "${BACKUP_DIR}/snippets" ]; then
    HAS_SNIPPET_DIFF=false
    # フォルダの中身を比較して、一つでも差分があればフラグを立てるにゃ
    if [ ! -d "$VSCODE_CONFIG_DIR/snippets" ] || ! diff -rq "$VSCODE_CONFIG_DIR/snippets" "${BACKUP_DIR}/snippets" > /dev/null; then
        HAS_SNIPPET_DIFF=true
    fi

    if [ "$HAS_SNIPPET_DIFF" = true ]; then
        echo "----------------------------------------------------"
        echo "  [スニペット変更あり]"
        SNIPPET_LIST=$(ls "${BACKUP_DIR}/snippets/" | tr '\n' ' ')
        echo "  バックアップの中身: ${SNIPPET_LIST}"
        read -p "  これらを同期（上書き）してもいいかにゃ？ (y/N): " -r
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            mkdir -p "$VSCODE_CONFIG_DIR/snippets"
            cp -r "${BACKUP_DIR}/snippets/"* "$VSCODE_CONFIG_DIR/snippets/"
            echo "  [SUCCESS] スニペットを反映したにゃ。"
        fi
    else
        echo "[INFO] スニペットも完全に一致してるにゃ。飛ばすにゃ。"
    fi
fi

echo "----------------------------------------------------"
echo "  [FINISH] 全部おわったにゃ。差分がなければ何もしてないはずだにゃ！"
echo "----------------------------------------------------"
