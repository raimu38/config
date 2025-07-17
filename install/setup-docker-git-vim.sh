#!/usr/bin/env bash
set -euxo pipefail

echo "Starting development tools installation..."

sudo apt remove --purge -y docker docker-engine docker.io containerd runc || true

sudo apt update
sudo apt install -y git vim ca-certificates curl gnupg lsb-release

curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

sudo install -m0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg \
  | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
   https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" \
  | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io \
  docker-buildx-plugin docker-compose-plugin

sudo usermod -aG docker "$USER"
newgrp docker <<'EOF'
echo "Docker group membership applied"
EOF

echo -n "git:             " && git --version
echo -n "vim:             " && vim --version | head -n 1
echo -n "docker:          " && docker --version
echo -n "docker compose:  " && docker compose version

