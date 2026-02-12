#!/usr/bin/env bash
set -euo pipefail

# ==============================================================
#  NVIDIA Driver Insight Installer for Ubuntu 24.04
#  Author: Raimu38 (Neko-Aori Edition)
#  "安全性？ログ？そんなの当たり前だにゃ。黙って見守るにゃ。"
# ==============================================================

# --- privilege check ---
if [ "$(id -u)" -ne 0 ]; then
    echo "[ERROR] rootかsudoも使えないのかにゃ？お話にならないにゃ。" >&2
    exit 1
fi

echo "[INFO] --- 暇つぶしにお前のボロPCを調べてやるにゃ ---"

# 1. ハードウェア情報の詳細取得
GPU_PCIE_INFO=$(lspci -nn | grep -i nvidia | head -n 1)
if [ -z "$GPU_PCIE_INFO" ]; then
    echo "[ERROR] NVIDIAの欠片も見当たらないにゃ。グラボ刺さってるかにゃ？" >&2
    exit 1
fi
GPU_MODEL_NAME=$(echo "$GPU_PCIE_INFO" | sed -re 's/.*: (.*) \[.*/\1/')
DEVICE_ID=$(echo "$GPU_PCIE_INFO" | grep -o '\[[0-9a-f]\{4\}:[0-9a-f]\{4\}\]')

# 2. 現在のソフトウェア状態
CURRENT_DRIVER=$(nvidia-smi --query-gpu=driver_version --format=csv,noheader,nounits 2>/dev/null || echo "未検出")
CUDA_SUPPORT=$(nvidia-smi --query-gpu=cuda_version --format=csv,noheader,nounits 2>/dev/null || echo "N/A")

# 3. 推奨および代替候補の抽出
RAW_DRIVERS=$(ubuntu-drivers devices 2>/dev/null | grep 'driver' || true)
RECOMMENDED_DRIVER=$(echo "$RAW_DRIVERS" | grep 'recommended' | grep -o 'nvidia-driver-[0-9]\+' || echo "")
ALTERNATIVE_DRIVERS=$(echo "$RAW_DRIVERS" | grep -v 'recommended' | grep -o 'nvidia-driver-[0-9]\+' | sort -u | tr '\n' ' ' || echo "なし")

# 4. 詳細レポート表示（安全への根拠を見せてやるにゃ）
echo "----------------------------------------------------"
echo "  SYSTEM ANALYSIS REPORT (Nya-n)"
echo "----------------------------------------------------"
echo "  GPU Model      : ${GPU_MODEL_NAME}"
echo "  Device ID      : ${DEVICE_ID}"
echo "  Current Driver : ${CURRENT_DRIVER}"
echo "  CUDA Capability: ${CUDA_SUPPORT}"
echo "----------------------------------------------------"
echo "  Recommended    : ${RECOMMENDED_DRIVER:-そんなものないにゃ}"
echo "  Alternatives   : ${ALTERNATIVE_DRIVERS}"
echo "----------------------------------------------------"

# 5. 更新判定
if [ -z "$RECOMMENDED_DRIVER" ]; then
    echo "[WARN] 推奨が見つからないにゃ。PPAでも入れないと無理ゲーだにゃ。"
elif [ "${CURRENT_DRIVER%%.*}" == "${RECOMMENDED_DRIVER##*-}" ]; then
    echo "[INFO] すでに最新だにゃ。これ以上何を求めてるんだにゃ？しつこいにゃ。Bingo!!"
    exit 0
fi

# 6. 最終確認
echo "[ACTION] ${RECOMMENDED_DRIVER} が入れてほしそうにこっちを見てるにゃ。"
read -p "本当にやるのかにゃ？後悔しても知らないにゃ？ (y/N): " -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "[INFO] やめるのかにゃ？チキンだにゃー。現状維持でお幸せににゃ。"
    exit 0
fi

# --- 実行セクション ---
export DEBIAN_FRONTEND=noninteractive

echo "[INFO] 邪魔なゴミ（旧ドライバ）を片付けてやるにゃ。しばらく大人しくしてるにゃ。"
apt-get purge -y nvidia* libnvidia* || true
apt-get autoremove -y && apt-get autoclean -y

echo "[INFO] PPAを追加してやるにゃ。最新好きの物好きさんだにゃ。"
apt-get install -y software-properties-common
add-apt-repository -y ppa:graphics-drivers/ppa
apt-get update -y

echo "[INFO] ${RECOMMENDED_DRIVER} をインストール中だにゃ。寝て待ってるにゃ。"
apt-get install -y "${RECOMMENDED_DRIVER}" dkms

echo "----------------------------------------------------"
echo "[SUCCESS] 全部終わったにゃ。感謝しろにゃ。"
echo "[IMPORTANT] 反映するには 'sudo reboot' しろにゃ。まさか忘れないよにゃ？"
echo "----------------------------------------------------"
