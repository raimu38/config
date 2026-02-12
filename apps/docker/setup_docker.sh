#!/usr/bin/env bash
set -euo pipefail

# ==============================================================
#  Docker Official Repository Installer (Diagnostics Edition)
#  Author: Raimu38
# ==============================================================

if [ "$(id -u)" -ne 0 ]; then
    echo "[ERROR] root権限かsudoをもってこいにゃ。" >&2
    exit 1
fi

export DEBIAN_FRONTEND=noninteractive

# --- くるくるスピナー（カーソル静音） ---
spin() {
    local pid=$1
    local delay=0.1
    local spinstr='|/-\'
    tput civis
    while [ "$(ps a | awk '{print $1}' | grep "$pid")" ]; do
        local temp=${spinstr#?}
        printf " [%c]  " "$spinstr"
        local spinstr=$temp${spinstr%"$temp"}
        sleep $delay
        printf "\b\b\b\b\b\b"
    done
    printf "    \b\b\b\b"
    tput cnorm
}

trap 'tput cnorm; exit' SIGINT SIGTERM EXIT

echo "[INFO] --- Docker 環境の最新情報を照合するにゃ ---"

# 1. 現状確認
CURRENT_VER="未インストール"
if command -v docker >/dev/null 2>&1; then
    CURRENT_VER=$(docker --version | awk '{print $3}' | sed 's/,//')
fi

# 2. 最新情報の先取り取得
echo -n "[INFO] Docker 公式リポジトリから最新情報を取得中だにゃ..."
(
    apt-get update -qq
    apt-get install -y -qq ca-certificates curl gnupg lsb-release > /dev/null
    install -m 0755 -d /etc/apt/keyrings
    curl -fsSL --retry 3 https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor --yes -o /etc/apt/keyrings/docker.gpg
    
    ARCH=$(dpkg --print-architecture)
    RELEASE=$(lsb_release -cs)
    echo "deb [arch=${ARCH} signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu ${RELEASE} stable" > /etc/apt/sources.list.d/docker.list
    apt-get update -qq
) &
spin $!
echo " Done!"

CANDIDATE_VER=$(apt-cache policy docker-ce | grep "候補:" | awk '{print $2}' | cut -d':' -f2 | cut -d'~' -f1 || echo "unknown")

echo "----------------------------------------------------"
echo "  [現在のステータス]"
echo "  現在の Docker: ${CURRENT_VER}"
echo "  最新の候補: ${CANDIDATE_VER}"
echo "----------------------------------------------------"

# 3. 実行確認
if [ "$CURRENT_VER" == "$CANDIDATE_VER" ]; then
    read -p "  すでに最新だけど、再インストール（修復）するかにゃ？ (y/N): " -r
else
    read -p "  Docker Engine を v${CANDIDATE_VER} に更新・導入するかにゃ？ (y/N): " -r
fi

echo
[[ ! $REPLY =~ ^[Yy]$ ]] && { echo "[INFO] 中止だにゃ。"; exit 0; }

# 4. 旧版削除 & クリーンインストール (既存機能継承)
if dpkg -l | grep -E "docker|containerd|runc" > /dev/null 2>&1; then
    echo -n "[INFO] 既存パッケージの競合を排除中だにゃ..."
    (apt-get remove -y -qq docker docker-engine docker.io containerd runc 2>/dev/null || true) &
    spin $!
    echo " Done!"
fi

echo -n "[INFO] Docker Engine & Compose の配置を開始するにゃ..."
(apt-get install -y -qq docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin > /dev/null) &
spin $!
echo " Done!"

# 5. サービス起動と権限設定 (既存機能継承)
echo "[INFO] システムサービスと権限を調整中だにゃ..."
if pidof systemd >/dev/null 2>&1; then
    systemctl enable docker > /dev/null 2>&1
    systemctl start docker > /dev/null 2>&1
else
    dockerd &>/var/log/dockerd.log &
    sleep 2
fi

TARGET_USER=$(logname 2>/dev/null || echo "$SUDO_USER" || true)
[ -n "${TARGET_USER:-}" ] && usermod -aG docker "$TARGET_USER"

# 6. 【追加】動作テストと生ログの表示だにゃ！
echo "----------------------------------------------------"
echo "[INFO] 起動テストを開始するにゃ。生のログを見せてやるにゃ："
echo "----------------------------------------------------"

# テスト1: デーモンの状態確認
if command -v systemctl >/dev/null 2>&1; then
    echo -n "  [TEST 1] Service Status: "
    systemctl is-active docker || echo "inactive"
fi

# テスト2: Docker Info のサマリー
echo "  [TEST 2] Docker Runtime Info:"
docker info 2>/dev/null | grep -E "Server Version|Storage Driver|Kernel Version|Operating System" | sed 's/^/    /'

# テスト3: コンテナの実行テスト (hello-world)
echo -n "  [TEST 3] Running hello-world container..."
(docker run --rm hello-world > /tmp/docker_test.log 2>&1) &
spin $!

if grep -q "Hello from Docker!" /tmp/docker_test.log 2>/dev/null; then
    echo " Success!"
    echo "    -> コンテナからの応答を確認したにゃ。完璧だにゃ！"
else
    echo " Failed."
    echo "[WARN] コンテナの起動に失敗したみたいだにゃ。ログを確認するにゃ："
    cat /tmp/docker_test.log | sed 's/^/    /'
fi
rm -f /tmp/docker_test.log

# 7. 最終確認
echo "----------------------------------------------------"
if command -v docker >/dev/null 2>&1; then
    echo "[SUCCESS] Docker の全工程が完了したにゃ！ Bingo!!"
    docker --version
    echo "  [NOTICE] ${TARGET_USER} をグループに追加したにゃ。"
    echo "  [NOTICE] 権限反映のため、必ず一度ログアウトするんだにゃ！"
else
    echo "[ERROR] 失敗だにゃ。何かがおかしいにゃ。"
    exit 1
fi
echo "----------------------------------------------------"
