#!/bin/bash

set -euo pipefail

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
readonly EXTENSIONS=(
  "md" "txt" "rst" "adoc"
  "html" "htm" "xml" "css"
  "yml" "yaml" "json" "csv" "tsv"
  "ini" "cfg" "conf" "toml" "properties" "env"
  "py" "js" "jsx" "ts" "tsx" "sh" "bash" "zsh"
  "java" "kt" "c" "cpp" "cc" "h" "hpp"
  "go" "rb" "pl" "php" "lua" "rs" "scala"
  "make" "mk" "Dockerfile" "docker-compose.yml"
  "gitignore" "gitattributes"
  "tf" "tfvars" "terraform" "nomad" "hcl"
  "bazel" "bzl"
)

readonly EXCLUDE_DIRS=(
  "node_modules"
  "venv"
  ".git"
  "dist"
  "build"
  ".next"
  ".vscode"
  "coverage"
)

# Counters
COUNT_CONVERTED=0
COUNT_FAILED=0

# Error handler
trap 'echo -e "${RED}❌ Script interrupted${NC}"; exit 1' INT TERM

# Logging functions
log_info() {
    echo -e "${BLUE}  $1${NC}"
}

log_success() {
    echo -e "${GREEN}✔ $1${NC}"
}

log_error() {
    echo -e "${RED}✗ $1${NC}"
}

# Build find command with proper escaping
build_find_command() {
    local find_cmd="find . -type f"
    
    # Add exclude patterns
    for dir in "${EXCLUDE_DIRS[@]}"; do
        find_cmd+=" -path */$dir -prune -o"
    done
    
    # Add name patterns
    local first=true
    for ext in "${EXTENSIONS[@]}"; do
        if [[ "$first" == true ]]; then
            find_cmd+=" \( -name"
            first=false
        else
            find_cmd+=" -o -name"
        fi
        
        case "$ext" in
            Dockerfile | gitignore | gitattributes)
                find_cmd+=" $ext"
                ;;
            *)
                find_cmd+=" *.$ext"
                ;;
        esac
    done
    
    find_cmd+=" \) -type f -print0"
    
    echo "$find_cmd"
}

# Check if file is text and contains CRLF
needs_conversion() {
    local file="$1"
    
    # Check if file exists and is readable
    if [[ ! -f "$file" ]] || [[ ! -r "$file" ]]; then
        return 1
    fi
    
    # Check if file is text (using file command)
    if ! file "$file" | grep -q "text"; then
        return 1
    fi
    
    # Check if file contains CRLF
    if grep -q $'\r' "$file" 2>/dev/null; then
        return 0
    fi
    
    return 1
}

# Convert file using dos2unix
convert_file() {
    local file="$1"
    
    # Check if dos2unix is available
    if ! command -v dos2unix &> /dev/null; then
        log_error "converted: $file (dos2unix not found)"
        ((COUNT_FAILED++))
        return 1
    fi
    
    # Backup original file in case of error
    local backup_file="${file}.bak"
    
    # Create backup
    if ! cp -p "$file" "$backup_file"; then
        log_error "converted: $file (failed to create backup)"
        ((COUNT_FAILED++))
        return 1
    fi
    
    # Try conversion
    if dos2unix "$file" >/dev/null 2>&1; then
        log_success "converted: $file"
        rm -f "$backup_file"
        ((COUNT_CONVERTED++))
        return 0
    else
        # Restore from backup on failure
        if mv "$backup_file" "$file"; then
            log_error "converted: $file (dos2unix failed, restored backup)"
        else
            log_error "converted: $file (dos2unix failed, backup restore failed)"
        fi
        ((COUNT_FAILED++))
        return 1
    fi
}

# Main function
main() {
    log_info "Starting dos2unix (safe mode)..."
    log_info "Scanning repository for files with CRLF line endings..."
    echo ""
    
    local find_cmd
    find_cmd=$(build_find_command)
    
    # Process files using null-terminated strings to handle special characters
    local file_count=0
    while IFS= read -r -d '' file; do
        ((file_count++))
        
        if needs_conversion "$file"; then
            convert_file "$file"
        fi
    done < <(eval "$find_cmd")
    
    echo ""
    log_info "Processing complete!"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    log_info "Total files scanned:      $file_count"
    log_success "Total files converted:    $COUNT_CONVERTED"
    if [[ $COUNT_FAILED -gt 0 ]]; then
        log_error "Total files failed:       $COUNT_FAILED"
    fi
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    
    # Exit with error code if any conversions failed
    if [[ $COUNT_FAILED -gt 0 ]]; then
        return 1
    fi
    
    return 0
}

# Run main function
main "$@"
