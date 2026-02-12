#!/usr/bin/env bash
set -euo pipefail

# ==============================================================
#  Ollama GPU Deployment Script
#  Author: Raimu38
# ==============================================================

# 実行権限の確認
if [ "$(id -u)" -ne 0 ]; then
    echo "[ERROR] root権限かsudoをもってこいにゃ。おめえ、権限なしで何ができるとおもってるんだにゃ？" >&2
    exit 1
fi

echo "[INFO] --- おめえの環境を隅々まで調べてやるにゃ ---"

# 1. OS情報の取得（特定のバージョンに依存しないための取得）
OS_ID=$(grep -oP '(?<=^ID=).+' /etc/os-release | tr -d '"')
OS_VER=$(grep -oP '(?<=^VERSION_ID=).+' /etc/os-release | tr -d '"')

# 2. 前提条件のバリデーション
# NVIDIAドライバの確認
if ! command -v nvidia-smi &> /dev/null; then
    echo "[ERROR] nvidia-smiが見当たらないにゃ。ドライバすら入れてないのかにゃ？お話にならないにゃ。" >&2
    exit 1
fi
GPU_MODEL=$(nvidia-smi --query-gpu=name --format=csv,noheader,nounits | head -n 1)

# Dockerの確認
if ! command -v docker &> /dev/null; then
    echo "[ERROR] Dockerが入っていないにゃ。おめえ、基本がなっていないにゃ。" >&2
    exit 1
fi

# 3. 構築プランの提示
echo "----------------------------------------------------"
echo "  実行環境の確認結果"
echo "----------------------------------------------------"
echo "  OS        : ${OS_ID} ${OS_VER} （ふーん、これ使ってるんだにゃ）"
echo "  GPU       : ${GPU_MODEL} （まあ、使ってやれなくはないにゃ）"
echo "  Docker    : 検出済み （奇跡的に入ってたにゃ。褒めてやるにゃ）"
echo "----------------------------------------------------"
echo "  [実行予定タスク]"
echo "  - NVIDIA Container Toolkit のリポジトリ登録"
echo "  - Docker用 NVIDIA Runtime の設定と再起動"
echo "  - Ollama コンテナ（GPU対応）の起動"
echo "----------------------------------------------------"

read -p "びびってないなら、ここらで実行させてやるにゃ？ (y/N): " -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "[INFO] やめるのかにゃ？おめえ、意外と臆病なんだにゃー。"
    exit 0
fi

# 4. NVIDIA Container Toolkit の設定
echo "[INFO] 設定ファイルを準備してやるにゃ。おめえは見てるだけでいいにゃ。"
KEYRING="/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg"
curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | gpg --dearmor -o "$KEYRING" --yes

# リポジトリリストの取得と署名情報の付与
curl -s -L "https://nvidia.github.io/libnvidia-container/stable/deb/nvidia-container-toolkit.list" | \
    sed "s#deb https://#deb [signed-by=$KEYRING] https://#g" | \
    tee /etc/apt/sources.list.d/nvidia-container-toolkit.list > /dev/null

apt-get update -y
apt-get install -y nvidia-container-toolkit

# 5. Dockerランタイムの設定
echo "[INFO] DockerにGPUのランタイムを登録してあげるにゃ。"
nvidia-ctk runtime configure --runtime=docker
systemctl restart docker

# 6. Ollama コンテナの起動
echo "[INFO] Ollamaを起動するにゃ。古いゴミは消しておいてやったにゃ。"
docker rm -f ollama &>/dev/null || true

docker run -d --gpus all \
  -v ollama_data:/root/.ollama \
  -p 11434:11434 \
  --name ollama \
  --restart always \
  ollama/ollama

# 7. 最終確認
echo "[INFO] しあげにおめえの代わりに動作テストをしてやるにゃ。"
sleep 3
if docker exec ollama nvidia-smi &>/dev/null; then
    echo "----------------------------------------------------"
    echo "[SUCCESS] 全部終わったにゃ！おめえにしてはじょうできだにゃ。"
    echo "----------------------------------------------------"
else
    echo "[ERROR] 失敗だにゃ...おめえ、何か余計なことしたのかにゃ？"
fi
