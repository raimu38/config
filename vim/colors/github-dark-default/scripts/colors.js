// scripts/colors.js

// GitHub Dark Default テーマを直接読み込む（npm パッケージの dist から）
const theme = require("github-vscode-themes/dist/dark-default.json");

function getColors(name) {
  if (name !== "dark") {
    throw new Error("Only 'dark' is supported");
  }

  return {
    colors: theme.colors,         // エディタUIなどの色
    tokenColors: theme.tokenColors // シンタックスハイライト用の色
  };
}

module.exports = { getColors };
