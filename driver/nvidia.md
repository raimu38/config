# Ubuntu 24.04 で NVIDIA GPU を使って Ollama を構築する手順

このドキュメントでは、Ubuntu 24.04 上において、GPU対応の大規模言語モデル実行環境 **Ollama** をセットアップする方法を解説します。

特に、**NVIDIA GPUの有効化（ドライバ・CUDA・Docker連携）**に重点を置いています。

---

## システム概要
- OS: Ubuntu 24.04 (noble)
- GPU: NVIDIA GeForce RTX 4070
- Docker: GPU対応
- LLM実行環境: Ollama + Docker

---

## 1. NVIDIA GPUの確認

```bash
lspci | grep -i nvidia
```

以下のような結果が出ればOK:

```
NVIDIA Corporation AD104 [GeForce RTX 4070] ...
```

---

## 2. 推奨NVIDIAドライバのチェック

```bash
ubuntu-drivers devices
```

出力例:

```
driver   : nvidia-driver-550 - distro non-free recommended
```

これに基づいて、推奨ドライバをインストール:

```bash
sudo apt install -y nvidia-driver-550
sudo reboot
```

---

## 3. ドライバ動作確認

```bash
nvidia-smi
```

正常な結果:

```
NVIDIA-SMI 550.120    Driver Version: 550.120   CUDA Version: 12.4
...
GPU  Name        Persistence-M ... GeForce RTX 4070 ...
```

---

## 4. NVIDIA Container Toolkit の設定

Ubuntu 24.04 "noble" は正式対応前のため、リポジトリを手動追加する:

```bash
# 不正な.listがある場合は削除
sudo rm /etc/apt/sources.list.d/nvidia-container-toolkit.list

# リポジトリの追加
curl -s -L https://nvidia.github.io/libnvidia-container/stable/deb/nvidia-container-toolkit.list \
  | sudo tee /etc/apt/sources.list.d/nvidia-container-toolkit.list

curl -s -L https://nvidia.github.io/libnvidia-container/gpgkey \
  | sudo tee /etc/apt/trusted.gpg.d/nvidia.asc

# アップデート & インストール
sudo apt update
sudo apt install -y nvidia-container-toolkit
sudo systemctl restart docker
```

---

## 5. Docker から GPU が見えるか確認

```bash
docker run --rm --gpus all nvidia/cuda:12.4.1-base-ubuntu22.04 nvidia-smi
```

これで「コンテナ内で nvidia-smi が動いたら」GPU連携は成功です!

---

## 6. Ollama の起動

```bash
docker run -d --gpus all \
  -v ollama:/root/.ollama \
  -p 11434:11434 \
  --name ollama \
  ollama/ollama
```

これでGPU対応のLLMサーバが起動します。

---

## 7. 実行テスト

```bash
docker exec -it ollama ollama run llama2
```

一言例:

```
>>> こんにちは。あなたは何ができますか？
```

結果が帰ってくれば、GPU効果付きで LLM が動いています!

---

## オプション: Open WebUI を使う

```bash
docker run -d -p 3000:8080 \
  --add-host=host.docker.internal:host-gateway \
  -v open-webui:/app/backend/data \
  --name open-webui \
  ghcr.io/open-webui/open-webui:main
```

ブラウザで `http://localhost:3000` にアクセスするとGUIで使えるようになります！


