#!/bin/bash

set -u
set -o pipefail

# カラーコードの設定
RED='\033[1;91m'
GREEN='\033[1;92m'
BLUE='\033[1;94m'
YELLOW='\033[1;93m'
BOLD='\033[1m'
NC='\033[0m' # No Color（白/標準）

# 構成設定
readonly EXTENSIONS=(
  "md" "txt" "rst" "adoc" "html" "htm" "xml" "css"
  "yml" "yaml" "json" "csv" "tsv" "ini" "cfg" "conf"
  "toml" "properties" "env" "py" "js" "jsx" "ts" "tsx"
  "sh" "bash" "zsh" "java" "kt" "c" "cpp" "cc" "h" "hpp"
  "go" "rb" "pl" "php" "lua" "rs" "scala" "make" "mk"
  "Dockerfile" "docker-compose.yml" "gitignore" "gitattributes"
  "tf" "tfvars" "terraform" "nomad" "hcl" "bazel" "bzl"
)

readonly EXCLUDE_DIRS=(
  "node_modules" "venv" ".git" "dist" "build" ".next" ".vscode" "coverage"
)

# カウンター
COUNT_CONVERTED=0
COUNT_FAILED=0
COUNT_SKIP_LF=0
COUNT_SKIP_BINARY=0

# エラーハンドラー
trap 'echo -e "\n${RED}[ERROR]${NC} Script interrupted by user"; exit 1' INT TERM

# ログ関数
log_info() { echo -e "${BLUE}[INFO]${NC} $1"; }
log_success() { echo -e "${GREEN}[SUCCESS]${NC} $1"; }
log_error() { echo -e "${RED}[ERROR]${NC} $1"; }
log_warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }

# テキストファイル判定
is_text_file() {
    local file="$1"
    [[ ! -f "$file" ]] && return 1
    [[ ! -r "$file" ]] && return 1
    file "$file" | grep -qi "text" || return 1
    return 0
}

# CRLF判定
has_crlf() {
    grep -q $'\r' "$1" 2>/dev/null || return 1
    return 0
}

# 変換実行
convert_file() {
    local file="$1"
    local backup_file="${file}.bak"
    
    if ! cp -p "$file" "$backup_file" 2>/dev/null; then
        log_error "Failed to create backup: $file"
        ((COUNT_FAILED++))
        return 1
    fi
    
    if dos2unix "$file" >/dev/null 2>&1; then
        log_success "Converted: $file"
        rm -f "$backup_file"
        ((COUNT_CONVERTED++))
        return 0
    else
        mv "$backup_file" "$file" 2>/dev/null
        log_error "Conversion failed, restored backup: $file"
        ((COUNT_FAILED++))
        return 1
    fi
}

main() {
    # ツールチェック
    if ! command -v dos2unix &> /dev/null; then
        log_error "dos2unix command not found. Please install it first."
        exit 1
    fi

    echo "----------------------------------------------------"
    log_info "Starting dos2unix conversion (safe mode)"
    log_info "Target Path: $(pwd)"
    echo "----------------------------------------------------"
    echo ""

    # 除外パターンの構築（最後に -false を置いて OR 結合を完結させる）
    local exclude_conditions=()
    for dir in "${EXCLUDE_DIRS[@]}"; do
        exclude_conditions+=(-path "*/$dir" -prune -o)
    done

    # 検索パターンの構築
    local find_conditions=()
    for ext in "${EXTENSIONS[@]}"; do
        case "$ext" in
            Dockerfile|gitignore|gitattributes)
                find_conditions+=(-o -name "$ext")
                ;;
            *)
                find_conditions+=(-o -name "*.$ext")
                ;;
        esac
    done

    local file_count=0

    # メインループ
    # find の論理構造を (除外リスト -o 偽) -o (検索条件 かつ 出力) に修正
    while IFS= read -r -d '' file; do
        ((file_count++))
        
        if ! is_text_file "$file"; then
            echo "[SKIP] $file (Binary/Non-text)"
            ((COUNT_SKIP_BINARY++))
            continue
        fi
        
        if ! has_crlf "$file"; then
            echo "[SKIP] $file (Already LF)"
            ((COUNT_SKIP_LF++))
            continue
        fi
        
        log_info "Target found: $file (CRLF detected)"
        convert_file "$file"
        
    done < <(find . \( "${exclude_conditions[@]}" -false \) -o \( \( "${find_conditions[@]:1}" \) -type f -print0 \) 2>/dev/null)

    # 最終レポート
    echo ""
    echo "---------------- FINAL REPORT ----------------"
    log_info "Total Files Scanned:    $file_count"
    log_success "Total Converted:        $COUNT_CONVERTED"
    echo "Skipped (Already LF):   $COUNT_SKIP_LF"
    echo "Skipped (Binary/Other): $COUNT_SKIP_BINARY"
    
    if [[ $COUNT_FAILED -gt 0 ]]; then
        log_error "Total Failures:         $COUNT_FAILED"
    fi
    echo "----------------------------------------------"

    [[ $COUNT_FAILED -gt 0 ]] && exit 1
    exit 0
}

main "$@"
