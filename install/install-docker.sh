#!/usr/bin/env bash
set -euo pipefail

# ==============================================================
#  Docker Official Repository Installer for Ubuntu
#  Author: Raimu38
#  Target: Ubuntu 20.04+ (x86_64 / arm64)
#  Features:
#    - Noninteractive APT
#    - Retry-safe GPG fetch
#    - Systemd fallback
# ==============================================================

# --- privilege check ---
if [ "$(id -u)" -ne 0 ]; then
    echo "[ERROR] root または sudo で実行しような。" >&2
    exit 1
fi

export DEBIAN_FRONTEND=noninteractive

echo "[INFO] --- apt 更新と基本パッケージの導入 ---"
apt-get update -y
apt-get install -y ca-certificates curl gnupg lsb-release

# --- 既存 docker パッケージの削除（干渉回避） ---
if dpkg -l | grep -q docker; then
    echo "[INFO] 旧版 docker パッケージを削除中..."
    apt-get remove -y docker docker-engine docker.io containerd runc || true
fi

# --- GPGキーとリポジトリ設定 ---
echo "[INFO] --- Docker GPGキー登録 ---"
install -m 0755 -d /etc/apt/keyrings
curl -fsSL --retry 3 https://download.docker.com/linux/ubuntu/gpg | \
    gpg --dearmor -o /etc/apt/keyrings/docker.gpg
chmod a+r /etc/apt/keyrings/docker.gpg

echo "[INFO] --- Docker リポジトリ追加 ---"
ARCH=$(dpkg --print-architecture)
RELEASE=$(lsb_release -cs)
cat <<EOF > /etc/apt/sources.list.d/docker.list
deb [arch=${ARCH} signed-by=/etc/apt/keyrings/docker.gpg] \
https://download.docker.com/linux/ubuntu ${RELEASE} stable
EOF

# --- Docker Engine & Compose v2 インストール ---
echo "[INFO] --- Docker Engine 最新版をインストール ---"
apt-get update -y
apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# --- サービス起動と有効化 ---
if pidof systemd >/dev/null 2>&1; then
    echo "[INFO] --- Docker サービス起動 ---"
    systemctl enable docker
    systemctl start docker
else
    echo "[WARN] systemd が存在しない環境のため、自動起動設定をスキップ。"
    dockerd &>/var/log/dockerd.log &
    sleep 3
fi

# --- ユーザーを docker グループに追加 ---
CURRENT_USER=$(logname 2>/dev/null || echo "$SUDO_USER" || true)
if [ -n "${CURRENT_USER:-}" ]; then
    echo "[INFO] --- ${CURRENT_USER} を docker グループに追加 ---"
    usermod -aG docker "$CURRENT_USER" || true
    echo "[INFO] 変更を反映するには再ログインが必要。"
fi

# --- 動作確認 ---
echo "[INFO] --- Docker バージョン確認 ---"
docker --version || echo "[WARN] docker コマンドは再ログイン後に有効になる場合があります。"
docker compose version || echo "[WARN] docker compose コマンドは再ログイン後に有効になる場合があります。"

# --- Buildx 状態チェック ---
echo "[INFO] --- Buildx 動作確認 ---"
if docker buildx version >/dev/null 2>&1; then
    echo "[OK] Buildx 有効"
else
    echo "[WARN] Buildx が検出されませんでした。"
fi

# --- 最終確認 ---
if docker info >/dev/null 2>&1; then
    echo "[SUCCESS] Docker のインストールと起動が確認された!。Bingo!!"
else
    echo "[WARN] Docker デーモンがまだ起動していない可能性がある。> <"
fi

