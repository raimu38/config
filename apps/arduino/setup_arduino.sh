#!/usr/bin/env bash
set -euo pipefail

# ==============================================================
#  Arduino-CLI Ultimate Interactive Setup (Clean Environment)
# ==============================================================

if [ "$(id -u)" -ne 0 ]; then
    echo "[ERROR] root権限かsudoをもってこいにゃ。" >&2
    exit 1
fi

REPO="arduino/arduino-cli"
BIN_PATH="/usr/local/bin/arduino-cli"

echo "[INFO] --- おめえの環境をクリーンに保ちつつ更新してやるにゃ ---"

# 1. 現状確認
CURRENT_VER="未インストール"
if command -v arduino-cli &> /dev/null; then
    CURRENT_VER=$(arduino-cli version | grep -oP 'Version: \K[0-9.]+' || arduino-cli version | awk '{print $2}' | sed 's/v//')
fi

echo "----------------------------------------------------"
echo "  [現在のステータス]"
echo "  配置場所: ${BIN_PATH}"
echo "  現在の版: v${CURRENT_VER}"
echo "----------------------------------------------------"

# 2. バージョン取得
echo "[INFO] リリース情報を取得中だにゃ..."
RAW_VERSIONS=$(curl -s "https://api.github.com/repos/${REPO}/releases?per_page=30" | grep -oP '"tag_name": "\K[^"]+' | sed 's/v//')
readarray -t VERSIONS <<< "$RAW_VERSIONS"

echo "  どのバージョンをインストールしたいかにゃ？"
for i in "${!VERSIONS[@]}"; do
    printf "  [%2d] v%-12s" "$i" "${VERSIONS[$i]}"
    if (( (i + 1) % 2 == 0 )); then echo ""; fi
done
echo -e "\n  [ q] やめるにゃ"
echo "----------------------------------------------------"

read -p "  選択 (0-$((${#VERSIONS[@]} - 1))/q): " -r SELECTION
echo
[[ "$SELECTION" == "q" ]] && exit 0

TARGET_VER="${VERSIONS[$SELECTION]}"

# 3. 最終確認
echo "----------------------------------------------------"
echo "  [最終確認] 対象: v${TARGET_VER}"
read -p "  古いバイナリを削除し、クリーンインストールしていいかにゃ？ (y/N): " -r
echo
[[ ! $REPLY =~ ^[Yy]$ ]] && exit 0

# 4. 一時ディレクトリで作業（ここでおめえの足元を汚さないにゃ）
TMP_DIR=$(mktemp -d)
# スクリプト終了時に、エラーだろうがなんだろうが一時ディレクトリを根こそぎ消すにゃ
trap 'rm -rf "$TMP_DIR"' EXIT

DOWNLOAD_URL="https://github.com/${REPO}/releases/download/v${TARGET_VER}/arduino-cli_${TARGET_VER}_Linux_64bit.tar.gz"

echo "[INFO] 一時ディレクトリ ${TMP_DIR} で作業を開始するにゃ。"

# 明示的に移動してからダウンロードするにゃ
cd "$TMP_DIR"
if curl -fLO "$DOWNLOAD_URL"; then
    tar -xzf "arduino-cli_${TARGET_VER}_Linux_64bit.tar.gz"
    
    # 古い実体を消すにゃ
    [ -f "$BIN_PATH" ] && rm -f "$BIN_PATH"
    
    # 新しいバイナリをシステムパスに移動
    mv arduino-cli "$BIN_PATH"
    chmod +x "$BIN_PATH"
    echo "[SUCCESS] /usr/local/bin/arduino-cli に配置完了だにゃ。"
else
    echo "[ERROR] ダウンロード失敗だにゃ。" >&2
    exit 1
fi

# 5. 後処理（既存のゴミも消してやるにゃ）
# おめえが手動で落としちゃった tar.gz が今のディレクトリにあるなら、それも消してやるにゃ
cd - > /dev/null # 元のディレクトリに戻るにゃ
rm -f arduino-cli_*_Linux_64bit.tar.gz

# 6. 権限とコア更新
if ! groups "$SUDO_USER" | grep -q "\bdialout\b"; then
    usermod -a -G dialout "$SUDO_USER"
fi
[ ! -f "/home/$SUDO_USER/.arduino15/arduino-cli.yaml" ] && sudo -u "$SUDO_USER" arduino-cli config init || true
sudo -u "$SUDO_USER" arduino-cli core update-index

echo "----------------------------------------------------"
echo "  [FINISH] これでおめえの足元もスッキリ、中身は最新だにゃ！"
arduino-cli version
echo "----------------------------------------------------"
