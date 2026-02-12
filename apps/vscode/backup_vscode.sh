#!/usr/bin/env bash
set -euo pipefail

# ==============================================================
#  VS Code 構成同期スクリプト
#  Author: Raimu38
# ==============================================================

# VS Codeのデータ元
VSCODE_CONFIG_DIR="$HOME/.config/Code/User"
# 保存先（このディレクトリの下にUserディレクトリの構造を再現するにゃ）
SAVE_DIR="vscode_settings"

echo "[INFO] --- おめえの環境を '${SAVE_DIR}' 内にディレクトリ構造ごと再現するにゃ ---"

# 保存先をきれいにするにゃ（古いファイルが残らないように）
mkdir -p "$SAVE_DIR"

# 1. 拡張機能リスト（これはUserフォルダの外に置くのが一般的だにゃ）
echo "[INFO] 拡張機能リストを保存するにゃ。"
code --list-extensions > "${SAVE_DIR}/extensions.txt"
code --list-extensions --show-versions > "${SAVE_DIR}/extensions-doc.txt"

# 2. Userディレクトリ内の重要ファイルをまるごと同期
# ここで VS Code の User フォルダと同じ構造を作るにゃ
echo "[INFO] 設定ファイルを同期中だにゃ..."

# 設定ファイル群
for file in "settings.json" "keybindings.json" "tasks.json"; do
    if [ -f "$VSCODE_CONFIG_DIR/$file" ]; then
        cp "$VSCODE_CONFIG_DIR/$file" "$SAVE_DIR/"
    fi
done

# スニペットフォルダ
if [ -d "$VSCODE_CONFIG_DIR/snippets" ]; then
    echo "[INFO] スニペットフォルダを同期するにゃ。"
    cp -r "$VSCODE_CONFIG_DIR/snippets" "$SAVE_DIR/"
fi

# 3. 今の作業ディレクトリにある古いファイルを掃除（おめえの足元を綺麗にするにゃ）
# 取得したばかりのファイルと重複する古いファイルを消してやるにゃ
rm -f extensions-doc.txt extensions.txt keybindings.json settings.json

echo "----------------------------------------------------"
echo "  [SUCCESS] 完了だにゃ！"
echo "  '${SAVE_DIR}' をまるごとバックアップすれば完璧だにゃ。"
echo "----------------------------------------------------"
tree "$SAVE_DIR"
