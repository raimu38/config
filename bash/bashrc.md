# ============================================================
# Bash 起動時の基本設定（非ログインシェル用）
# ~/.bashrc: bash(1) 実行時に読み込まれる
# ============================================================

# インタラクティブシェルでなければ処理を中断
case $- in
    *i*) ;;         # インタラクティブシェルの場合はそのまま実行
      *) return;;
esac

# ============================================================
# ヒストリ（コマンド履歴）の設定
# ============================================================
HISTCONTROL=ignoreboth         # 重複行や先頭に空白がある行は記録しない
shopt -s histappend            # ヒストリファイルに追記する（上書きしない）
HISTSIZE=1000                  # メモリ上のヒストリ件数
HISTFILESIZE=2000              # ヒストリファイルの最大件数

# ============================================================
# ウィンドウサイズの自動チェック
# ============================================================
shopt -s checkwinsize          # 各コマンド実行後にウィンドウサイズをチェック

# ============================================================
# less の設定（非テキストファイル対応）
# ============================================================
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# ============================================================
# Debian Chroot の設定（プロンプト用）
# ============================================================
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# ============================================================
# プロンプト（PS1）の設定（色付き／非色付き）
# ============================================================
# TERM が色対応の場合、色付きプロンプトを有効にする
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# 強制的に色付きプロンプトを使いたい場合は、以下のコメントを外す
# force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        color_prompt=yes
    else
        color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# xterm 系ターミナルの場合、ウィンドウタイトルを設定
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# ============================================================
# ls や grep の色付き表示設定
# ============================================================
if [ -x /usr/bin/dircolors ]; then
    # ~/.dircolors があれば読み込む
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    # alias dir='dir --color=auto'
    # alias vdir='vdir --color=auto'
    
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# GCC の警告・エラーを色付きで表示（必要に応じて有効化）
# export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# ============================================================
# その他のエイリアス設定
# ============================================================
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

alias capson="gsettings set org.gnome.desktop.input-sources xkb-options \"['ctrl:nocaps']\""
alias capsoff="gsettings reset org.gnome.desktop.input-sources xkb-options"
alias teams="open https://teams.microsoft.com/v2/"
alias loop="open https://loop.cloud.microsoft/"
alias crone='EDITOR=vim crontab -e'
alias cronlog='tail -n 30 ~/Documents/howm-log/cron.log'
alias drp='docker run --rm -v "$PWD":/app -w /app python:latest '

# zemi.tex を platex→ biber→ platex2→ dvipdfmx で一気にコンパイル
alias buildzemi='platex zemi.tex && biber zemi && platex zemi.tex && platex zemi.tex && dvipdfmx zemi.dvi'
# 長時間実行するコマンドの終了通知（alert エイリアス）
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# ~/.bash_aliases が存在する場合は読み込む
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# ============================================================
# Bash 補完機能の有効化
# ============================================================
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi



# ============================================================
# Bash with Vim
# ============================================================
set -o vi


# ======== png2svg =========

png2svg() {
    if [ $# -ne 1 ]; then
        echo "使い方: png2svg <filename.png>"
        return 1
    fi

    local input="$1"
    local base="${input%.png}"
    local pbm="${base}-mask.pbm"
    local svg="${base}.svg"

    convert "$input" -alpha extract -negate -threshold 50% "$pbm" &&
    potrace "$pbm" -s -o "$svg" &&
    echo "✅ SVG変換完了: $svg" || echo "❌ 変換失敗"
}

# =========================
