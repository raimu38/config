// export-to-vim.js
const fs   = require("fs");
const path = require("path");
// ① 公式テーマ JSON を読み込む
const theme = require("github-vscode-themes/dist/dark-default.json");

// 出力バッファ
const out = [];

// ─── ヘッダ ───────────────────────────
out.push(`" Name: GitHub Dark Default (imported)`); 
out.push(`" Generated: ${new Date().toISOString()}`);
out.push("if exists('g:colors_name') && g:colors_name ==# 'github-dark' | finish | endif");
out.push("hi clear");
out.push("syntax reset");
out.push(`let g:colors_name = 'github-dark'`);
out.push("if has('termguicolors') | set termguicolors | endif");
out.push("");

// ② Primer Core Palette：すべての theme.colors を s: 変数に
out.push('" ── Primer Core Palette ──');
Object.entries(theme.colors).forEach(([key, val]) => {
  const varName = key.replace(/[^a-zA-Z0-9]/g, "_");
  out.push(`let s:${varName} = '${val}'  " ${key}`);
});
out.push("");

// ③ 全 UI カラーを g:github_ui_* 変数にも
out.push('" ── All UI colors as global variables ──');
Object.entries(theme.colors).forEach(([key, val]) => {
  const varName = key.replace(/[^a-zA-Z0-9]/g, "_");
  out.push(`let g:github_ui_${varName} = '${val}'`);
});
out.push("");

// ④ （必要なら）s:dark_terminal_ansi_colors, s:light_terminal_ansi_colors も自動生成
//    ※ ここでは例として textLink_foreground～terminal.ansiBrightWhite を一列に
const ansiKeys = Object.keys(theme.colors).filter(k =>
  /^terminal\.ansi(Bright)?(Black|Red|Green|Yellow|Blue|Magenta|Cyan|White)$/.test(k)
);
if (ansiKeys.length) {
  out.push('" ── Terminal ANSI Colors ──');
  out.push("let s:dark_terminal_ansi_colors = [");
  ansiKeys.forEach(k => {
    const vn = k.replace(/[^a-zA-Z0-9]/g,"_");
    out.push(`      \\ s:${vn},`);
  });
  out.push("      \\ ]");
  out.push("");
}

// ⑤ トークンカラー（syntax） をそのまま展開
out.push('" ── Syntax token colors ──');
theme.tokenColors.forEach((tc, idx) => {
  const fg = tc.settings && tc.settings.foreground;
  if (!fg) return;
  const scopes = Array.isArray(tc.scope) ? tc.scope : [tc.scope];
  scopes.forEach(scope => {
    const grp = `GitHubScope_${scope.replace(/[^a-zA-Z0-9]/g,"_")}_${idx}`;
    out.push(`hi ${grp} guifg=${fg} guibg=NONE`);
  });
});

// ファイル書き出し
const outPath = path.resolve(__dirname, "../output/github-dark.vim");
fs.writeFileSync(outPath, out.join("\n"));
console.log(`→ ${outPath} に出力しました`);
