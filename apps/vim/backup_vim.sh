#!/usr/bin/env bash

# ==============================================================
#  Vim Smart Backup (Fact-Oriented Logging)
# ==============================================================

PARENT_BACKUP_DIR="backup_vim"
DATE=$(date +%Y%m%d_%H%M%S)
TARGET_DIR="${PARENT_BACKUP_DIR}/${DATE}"

echo "===================================================="
echo "   Vim スマートバックアップ開始だにゃ"
echo "===================================================="

# 1. 状況確認
if [ -d "$PARENT_BACKUP_DIR" ]; then
    BACKUP_LIST=$(ls -1d ${PARENT_BACKUP_DIR}/[0-9]* 2>/dev/null | sort -r)
    BACKUP_COUNT=$(find "$PARENT_BACKUP_DIR" -maxdepth 1 -type d -name "[0-9]*" | wc -l)
else
    BACKUP_COUNT=0
    BACKUP_LIST=""
fi
BACKUP_COUNT=$((BACKUP_COUNT + 0))

# 現在のハッシュ計算 (plugged除外)
HASH_SRC_RC=$(sha256sum "${HOME}/.vimrc" | awk '{print $1}')
HASH_SRC_VIM=$(find "${HOME}/.vim" -path "${HOME}/.vim/plugged" -prune -o -type f -exec sha256sum {} + | awk '{print $1}' | sort | sha256sum | awk '{print $1}')
CURRENT_HASH=$(echo "${HASH_SRC_RC}${HASH_SRC_VIM}" | sha256sum | awk '{print $1}')

echo "[1/3] 設定の照合中だにゃ"
echo "-----------------------------------------------------------------------"
printf "%-20s | %-10s | %s\n" "Target" "Status" "Hash (SHA256)"
echo "-----------------------------------------------------------------------"

printf "%-20s | %-10s | %s...\n" "Current Config" "[ACTIVE]" "${CURRENT_HASH:0:32}"

MATCH_FOUND=""
if [ "$BACKUP_COUNT" -gt 0 ]; then
    for BK in $BACKUP_LIST; do
        BK_NAME=$(basename "$BK")
        HASH_BK_RC=$(sha256sum "${BK}/vimrc" | awk '{print $1}')
        HASH_BK_VIM=$(find "${BK}/vim" -path "${BK}/vim/plugged" -prune -o -type f -exec sha256sum {} + | awk '{print $1}' | sort | sha256sum | awk '{print $1}')
        BACKUP_HASH=$(echo "${HASH_BK_RC}${HASH_BK_VIM}" | sha256sum | awk '{print $1}')

        STATUS="---"
        if [ "$CURRENT_HASH" == "$BACKUP_HASH" ]; then
            STATUS="[MATCH]"
            MATCH_FOUND="$BK"
        fi
        printf "%-20s | %-10s | %s...\n" "$BK_NAME" "$STATUS" "${BACKUP_HASH:0:32}"
    done
else
    echo "  (バックアップ履歴なし)"
fi
echo "-----------------------------------------------------------------------"

if [ -n "$MATCH_FOUND" ]; then
    echo "[2/3] スキップだにゃ (コピー不要)"
    echo "[3/3] スキップだにゃ (リスト更新不要)"
    echo "----------------------------------------------------"
    echo "  結果: 最新の状態が ${MATCH_FOUND} に保存済みだにゃ。"
    echo "  バックアップ総数: ${BACKUP_COUNT} 件"
    echo "----------------------------------------------------"
    exit 0
fi

# 2. コピー処理
echo "  >> 新規設定を検知したにゃ"
echo "[2/3] 設定ファイルをコピー中だにゃ (plugged除外)"
mkdir -p "${TARGET_DIR}/vim"
cp "${HOME}/.vimrc" "${TARGET_DIR}/vimrc"
rsync -av --exclude="plugged" "${HOME}/.vim/" "${TARGET_DIR}/vim/" > /dev/null

# 3. プラグインリスト作成
echo "[3/3] プラグインリストを作成中だにゃ"
if [ -d "${HOME}/.vim/plugged" ]; then
    ls -1 "${HOME}/.vim/plugged" > "${TARGET_DIR}/plugins.txt"
else
    touch "${TARGET_DIR}/plugins.txt"
fi

if [ $? -eq 0 ]; then
    NEW_COUNT=$((BACKUP_COUNT + 1))
    echo "----------------------------------------------------"
    echo "  バックアップ成功だにゃ"
    echo "  保存場所 : ${TARGET_DIR}"
    echo "  総数     : ${NEW_COUNT} 件"
    echo "----------------------------------------------------"
else
    echo "[ERROR] バックアップに失敗したにゃ"
    exit 1
fi
