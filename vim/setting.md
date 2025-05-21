より丁寧に、各ステップの目的や注意点、トラブルシュートを含めて書き直します。これを順に進めれば、同じ環境を再現できるはずです。

---

## 事前準備

* **対象OS**：Ubuntu 系 Linux
* **前提ツール**：Git, curl がインストール済み
  まだの場合は以下を実行しておく：

  ```bash
  sudo apt update
  sudo apt install -y git curl
  ```

---

## ステップ 1: 設定リポジトリをクローンする

1. ホームディレクトリに移動

   ```bash
   cd ~
   ```
2. GitHub 上の Vim 設定リポジトリを丸ごと取得

   ```bash
   git clone https://github.com/<ユーザー名>/<リポジトリ名>.git .vim-config
   ```

   * `.` から始まるディレクトリ名は「隠しディレクトリ」として扱われます。
   * クローン先は任意ですが、以降の手順は `~/.vim-config` を想定しています。

---

## ステップ 2: vim-plug をインストールする

Vim プラグインマネージャー `vim-plug` が必要です。存在を確認し、なければ取得します。

```bash
if [ ! -f ~/.vim/autoload/plug.vim ]; then
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi
```

* `~/.vim/autoload/plug.vim` があれば再インストール不要です。
* `--create-dirs` オプションで、`autoload/` が未作成でもディレクトリを自動生成します。

---

## ステップ 3: `.vimrc` を配置する

1. 既存の `~/.vimrc` をバックアップ（念のため）

   ```bash
   [ -f ~/.vimrc ] && mv ~/.vimrc ~/.vimrc.backup
   ```
2. リポジトリ内の設定ファイルを `~/.vimrc` にコピー

   ```bash
   cp ~/.vim-config/.vimrc ~/.vimrc
   ```
3. コピー先の内容を確認

   ```bash
   head -n 30 ~/.vimrc
   ```

---

## ステップ 4: 必須システムパッケージをインストールする

Vim プラグインや機能拡張に必要な外部コマンドをまとめて入れます。

```bash
sudo apt update
sudo apt install -y \
  vim \
  python3 python3-pip \
  nodejs npm \
  zathura latexmk \
  howm
```

* **vim**：エディタ本体
* **python3/python3-pip**：`coc.nvim` や `ale` の Python サポート
* **nodejs/npm**：`coc.nvim` や `neoformat` の JavaScript サポート
* **zathura/latexmk**：`vimtex` で PDF ビューと自動ビルド
* **howm**：メモ管理プラグイン用

※必要に応じて `sudo apt install -y build-essential` を追加してください。

---

## ステップ 5: Vim でプラグインをインストールする

```bash
vim +PlugInstall +qall
```

* Vim 起動後、自動的にプラグインのダウンロード＆インストールが行われます。
* 終了時に `Press ENTER or type command to continue` が表示されたら、Enter を押して戻ります。

---

## ステップ 6: coc.nvim の拡張を追加インストールする

Vim 内で以下コマンドを実行し、各言語の LSP や補完拡張を導入します。

```vim
:CocInstall \
  coc-pyright \
  coc-tsserver \
  coc-json \
  coc-html \
  coc-css
```

* 複数指定はバックスラッシュで改行できます。
* インストール後、`:CocList extensions` で有効化状況を確認可能です。

---

## ステップ 7: neoformat／Prettier の準備

JavaScript/TypeScript の自動整形にはプロジェクトごとの `prettier` が必要です。対象プロジェクトのルートで：

```bash
npm install --save-dev prettier
```

* `package.json` に `devDependencies` として追加されます。
* グローバルインストールは推奨しません。

---

## ステップ 8: howm メモ用ディレクトリを作成する

```bash
mkdir -p ~/Dropbox/Editor/vim/howm
```

* `~/.vimrc` の `howm_dir` 設定と一致させておきます。

---

## ステップ 9: 動作確認

1. **NERDTree**

   * Vim を起動し、`<C-n>` でファイルツリーが開く。
2. **補完＋Lint**

   * Python ファイルで自動補完・`flake8` リントが動作。
3. **Prettier**

   * JS/TS ファイルを保存すると自動整形。
4. **vimtex（※有効化した場合）**

   * LaTeX ファイルを開き、保存すると `latexmk` がビルド。
   * `\cite` や `\ref` の補完、PDF同期が動作。

---

## トラブルシュート

* **PlugInstall が失敗する**

  * ネットワーク確認。プロキシ設定が必要な場合は `export http_proxy=...`
* **coc.nvim が動作しない**

  * `:echo &runtimepath` に `coc.nvim` のパスが含まれているか確認。
* **Prettier が見つからない**

  * プロジェクト直下で `npx prettier --version` を試す。

---

