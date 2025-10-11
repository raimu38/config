#!/usr/bin/env bash
set -euo pipefail

# ==============================================================
#  Git Installer for Ubuntu
#  Author: Raimu38
#  Target: Ubuntu 20.04+ (x86_64 / arm64)
#  Features:
#    - Noninteractive APT
#    - Auto GPG & HTTPS support
#    - Version confirmation
# ==============================================================

if [ "$(id -u)" -ne 0 ]; then
    echo "[ERROR] root または sudo で実行しような。" >&2
    exit 1
fi

export DEBIAN_FRONTEND=noninteractive

echo "[INFO] --- apt 更新と依存パッケージの導入 ---"
apt-get update -y
apt-get install -y ca-certificates curl gnupg lsb-release software-properties-common

# --- 既存 Git の確認 ---
if command -v git >/dev/null 2>&1; then
    echo "[INFO] 既に Git がインストールされています。バージョンを確認中..."
    git --version
    exit 0
fi

# --- 最新版のリポジトリ追加 ---
echo "[INFO] --- Git リポジトリを追加 ---"
add-apt-repository -y ppa:git-core/ppa

# --- Git のインストール ---
echo "[INFO] --- Git 最新版をインストール ---"
apt-get update -y
apt-get install -y git

# --- インストール確認 ---
if command -v git >/dev/null 2>&1; then
    GIT_VERSION=$(git --version)
    echo "[SUCCESS] Git のインストールが完了したわ。"
    echo "          Version: ${GIT_VERSION}"
else
    echo "[ERROR] Git のインストールに失敗したみたい。"
    exit 1
fi

