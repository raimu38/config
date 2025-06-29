FROM nvidia/cuda:12.4.1-cudnn-runtime-ubuntu22.04

ARG USER_ID=1000
ARG GROUP_ID=1000

# --- ロケールと TERM の設定（先に記述） ---
ENV LANG=ja_JP.UTF-8
ENV LANGUAGE=ja_JP:ja
ENV LC_ALL=ja_JP.UTF-8
ENV TERM=xterm-256color

# ユーザー追加
RUN groupadd -g $GROUP_ID devgroup && \
    useradd -m -s /bin/bash -u $USER_ID -g devgroup devuser

ENV PATH="/home/devuser/.local/bin:$PATH"
ENV HOME="/home/devuser"

# 必要パッケージと Python + curl + Vim をインストール（locales追加済）
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    libgl1-mesa-glx \
    libglib2.0-0 \
    libxext6 \
    git \
    wget \
    vim \
    curl \
    python3 \
    python3-pip \
    python3-venv \
    locales \
    && locale-gen ja_JP.UTF-8 \
    && rm -rf /var/lib/apt/lists/*

# pipアップグレード & PyTorch
RUN python3 -m pip install --upgrade --no-cache-dir pip
RUN python3 -m pip install --no-cache-dir torch==2.6.0 --index-url https://download.pytorch.org/whl/cu124

# Python パッケージのインストール
COPY requirements.txt /tmp/
RUN python3 -m pip install --no-cache-dir -r /tmp/requirements.txt

# 設定ファイルコピー（←プロジェクトルートにある前提）
COPY .bashrc /home/devuser/.bashrc
COPY .vimrc /home/devuser/.vimrc

# vim-plug のインストール
RUN curl -fLo /home/devuser/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim && \
    chown -R devuser:devgroup /home/devuser

# devuser に切り替え
USER devuser
WORKDIR /app

# Vim で PlugInstall を実行（non-interactive モード）
RUN vim +'PlugInstall --sync' +qa

CMD ["bash"]
