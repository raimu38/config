#!/usr/bin/env bash
set -euo pipefail

# ==============================================================
#  Git Smart Installer & Updater for Ubuntu (Blink-free)
#  Author: Raimu38
# ==============================================================

if [ "$(id -u)" -ne 0 ]; then
    echo "[ERROR] root権限かsudoをもってこいにゃ。おめえ、これがないと何もできないにゃ。" >&2
    exit 1
fi

export DEBIAN_FRONTEND=noninteractive

# --- くるくる回るスピナー関数（カーソル制御付き）だにゃ ---
spin() {
    local pid=$1
    local delay=0.1
    local spinstr='|/-\'
    
    # カーソルを隠すにゃ（おめえの目を守ってやるにゃ）
    tput civis

    while [ "$(ps a | awk '{print $1}' | grep "$pid")" ]; do
        local temp=${spinstr#?}
        printf " [%c]  " "$spinstr"
        local spinstr=$temp${spinstr%"$temp"}
        sleep $delay
        printf "\b\b\b\b\b\b"
    done
    printf "    \b\b\b\b"
    
    # カーソルを元に戻すにゃ
    tput cnorm
}

# 異常終了時も確実にカーソルを戻すための罠を仕掛けておくろにゃ
trap 'tput cnorm; exit' SIGINT SIGTERM EXIT

echo "[INFO] --- Git 環境の整合性を確認中だにゃ ---"

# 1. 現状確認
CURRENT_VER="未インストール"
if command -v git >/dev/null 2>&1; then
    CURRENT_VER=$(git --version | awk '{print $3}')
fi

echo "----------------------------------------------------"
echo "  [現在のステータス]"
echo "  現在の Git: v${CURRENT_VER}"
echo "----------------------------------------------------"

# 2. リポジトリ確認
echo -n "[INFO] パッケージ情報を更新中だにゃ..."
(apt-get update -qq && apt-get install -y -qq software-properties-common > /dev/null) &
spin $!
echo " Done!"

if ! grep -q "^deb.*git-core/ppa" /etc/apt/sources.list /etc/apt/sources.list.d/* 2>/dev/null; then
    echo -n "[INFO] 最新リポジトリ (ppa:git-core/ppa) を登録中だにゃ..."
    (add-apt-repository -y ppa:git-core/ppa > /dev/null && apt-get update -qq) &
    spin $!
    echo " Done!"
fi

# 3. 候補バージョンの抽出
CANDIDATE_VER=$(apt-cache policy git | grep "候補:" | awk '{print $2}' | cut -d':' -f2 | cut -d'-' -f1 || echo "unknown")

echo "  [更新の提案]"
echo "  現在: v${CURRENT_VER}"
echo "  最新: v${CANDIDATE_VER}"
echo "----------------------------------------------------"

# 4. 実行確認
if [ "$CURRENT_VER" == "$CANDIDATE_VER" ]; then
    echo "[INFO] すでに最新だにゃ。やる必要あるのかにゃ？"
    read -p "  再インストールする？ (y/N): " -r
else
    read -p "  v${CANDIDATE_VER} に更新してもいいかにゃ？ (y/N): " -r
fi

echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "[INFO] 中止だにゃ。おめえの判断に従ってやるにゃ。"
    exit 0
fi

# 5. 実行
echo -n "[INFO] Git のインストールを実行中だにゃ..."
(apt-get install -y -qq git) &
spin $!
echo " Done!"

# 6. 結果確認
if command -v git >/dev/null 2>&1; then
    NEW_VER=$(git --version)
    echo "----------------------------------------------------"
    echo "[SUCCESS] セットアップ完了だにゃ！"
    echo "          ${NEW_VER}"
    echo "----------------------------------------------------"
else
    echo "[ERROR] 失敗だにゃ。おめえ、環境を壊したのかにゃ？"
    exit 1
fi
