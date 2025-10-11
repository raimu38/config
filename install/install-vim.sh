#!/usr/bin/env bash
set -euo pipefail

# ==============================================================
#  Vim + vim-plug Installer for Ubuntu
#  Author: Raimu38
#  Target: Ubuntu 20.04+ (x86_64 / arm64)
#  Features:
#    - Noninteractive APT
#    - vim-plug auto installation
#    - No .vimrc modification
# ==============================================================

if [ "$(id -u)" -ne 0 ]; then
    echo "[ERROR] root または sudo で実行しような。" >&2
    exit 1
fi

export DEBIAN_FRONTEND=noninteractive

echo "[INFO] --- apt 更新と依存パッケージの導入 ---"
apt-get update -y
apt-get install -y ca-certificates curl gnupg lsb-release

# --- 既存 vim の確認 ---
if command -v vim >/dev/null 2>&1; then
    echo "[INFO] 既に Vim がインストールされています。バージョンを確認中..."
    vim --version | head -n 1
else
    echo "[INFO] --- Vim をインストール ---"
    apt-get install -y vim
fi

# --- vim-plug 導入 ---
TARGET_USER=${SUDO_USER:-$USER}
USER_HOME=$(eval echo "~${TARGET_USER}")
PLUG_PATH="${USER_HOME}/.vim/autoload/plug.vim"

if [ -f "$PLUG_PATH" ]; then
    echo "[INFO] vim-plug は既に存在: ${PLUG_PATH}"
else
    echo "[INFO] --- vim-plug をインストール ---"
    sudo -u "$TARGET_USER" mkdir -p "${USER_HOME}/.vim/autoload"
    sudo -u "$TARGET_USER" curl -fLo "${PLUG_PATH}" \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    echo "[INFO] vim-plug を配置: ${PLUG_PATH}"
fi

# --- インストール確認 ---
echo -n "vim:      " && vim --version | head -n 1
if [ -f "$PLUG_PATH" ]; then
    echo "[SUCCESS] vim-plug が導入済み。Vim から :PlugInstall が利用可能。"
else
    echo "[WARN] vim-plug の配置を確認できなかった。"
fi

