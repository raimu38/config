FROM node:24-alpine

WORKDIR /app

# 依存をインストール（github-vscode-themes を含む）
COPY package.json package-lock.json ./
RUN npm ci

# スクリプトをコピー
COPY scripts/ ./scripts/
RUN chmod +x scripts/*.js

# 出力先ディレクトリ
RUN mkdir -p output

# デフォルトコマンド
CMD ["node", "scripts/export-to-vim.js"]

