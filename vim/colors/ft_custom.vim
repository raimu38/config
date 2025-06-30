"─ Primer Core Palette ────────────────────────────────────────────────────────

" Common
let s:black = '#000000'
let s:white = '#ffffff'

"─ GitHub Dark Default Palette ──────────────────────────────────────────────
let s:dark_fg               = '#e6edf3'
let s:dark_bg               = '#0d1117'
let s:dark_bg_subtle        = '#161b22'
let s:dark_bg_sidebar       = '#010409'
let s:dark_border           = '#30363d'
let s:dark_fg_subtle        = '#7d8590'
let s:dark_selection_bg     = '#264366'
let s:dark_find_match_bg    = '#9e6a03'
let s:dark_find_match_fg    = '#e6edf3'
let s:dark_diff_add_bg      = '#1f2d22'
let s:dark_diff_change_bg   = '#2d2013'
let s:dark_diff_delete_bg   = '#2d1618'

" Syntax (Dark)
let s:dark_comment          = '#7d8590'
let s:dark_keyword          = '#ff7b72'
let s:dark_string           = '#79c0ff'
let s:dark_number           = '#56d364'
let s:dark_constant         = '#aff5b4'
let s:dark_function         = '#d2a8ff'
let s:dark_type             = '#f0883e'
let s:dark_operator         = '#79c0ff'
let s:dark_special          = '#ff9bce'
let s:dark_variable         = s:dark_fg

" Feedback Colors (Dark)
let s:dark_blue             = '#2f81f7'
let s:dark_green_fg         = '#3fb950'
let s:dark_red_fg           = '#f85149'
let s:dark_yellow_fg        = '#d29922'
let s:dark_orange_fg        = '#f78166'
let s:dark_purple_fg        = '#bc8cff'


"── 各ファイルタイプ別ハイライト設定 ───────────────────────────────────────
augroup ft_highlight_yaml
  autocmd!
  " YAML
  autocmd FileType yaml execute 'highlight yamlBlockMappingKey   guifg=' . s:dark_number . ' ctermfg=34'
  autocmd FileType yaml execute 'highlight yamlFlowMappingKey    guifg=' . s:dark_number . ' ctermfg=34'
  autocmd FileType yaml execute 'highlight yamlBlockMappingValue guifg=' . s:dark_operator . ' ctermfg=75'
  autocmd FileType yaml execute 'highlight yamlFlowMappingValue  guifg=' . s:dark_operator . ' ctermfg=75'
  autocmd FileType yaml execute 'highlight yamlPlainScalar       guifg=' . s:dark_operator . ' ctermfg=75'
  autocmd FileType yaml execute 'highlight yamlFlowString        guifg=' . s:dark_operator . ' ctermfg=75'
  autocmd FileType yaml execute 'highlight yamlBlockString       guifg=' . s:dark_operator . ' ctermfg=75'
  autocmd FileType yaml execute 'highlight yamlString            guifg=' . s:dark_operator . ' ctermfg=75'
  autocmd FileType yaml execute 'highlight yamlBool              guifg=' . s:dark_number  . ' ctermfg=71'
  autocmd FileType yaml execute 'highlight yamlKeyValueDelimiter guifg=' . s:dark_number . ' ctermfg=34'
augroup END

" JavaScript / TypeScript
augroup ft_highlight_js_ts
  autocmd!
  autocmd FileType javascript,typescript execute 'highlight jsFunction    guifg=' . s:dark_function  . ' ctermfg=225'
  autocmd FileType javascript,typescript execute 'highlight jsVariable    guifg=' . s:dark_variable  . ' ctermfg=7'
  autocmd FileType javascript,typescript execute 'highlight jsString      guifg=' . s:dark_string    . ' ctermfg=75'
  autocmd FileType javascript,typescript execute 'highlight jsNumber      guifg=' . s:dark_number    . ' ctermfg=71'
  autocmd FileType javascript,typescript execute 'highlight jsBoolean     guifg=' . s:dark_constant  . ' ctermfg=151'
  autocmd FileType javascript,typescript execute 'highlight jsKeyword     guifg=' . s:dark_keyword   . ' ctermfg=203'
  autocmd FileType javascript,typescript execute 'highlight jsType        guifg=' . s:dark_type      . ' ctermfg=214'
  autocmd FileType javascript,typescript execute 'highlight jsOperator    guifg=' . s:dark_operator  . ' ctermfg=75'
augroup END

" Python
augroup ft_highlight_python
  autocmd!
  autocmd FileType python execute 'highlight pythonFunction   guifg=' . s:dark_function  . ' ctermfg=225'
  autocmd FileType python execute 'highlight pythonName       guifg=' . s:dark_variable  . ' ctermfg=7'
  autocmd FileType python execute 'highlight pythonString     guifg=' . s:dark_string    . ' ctermfg=75'
  autocmd FileType python execute 'highlight pythonNumber     guifg=' . s:dark_number    . ' ctermfg=71'
  autocmd FileType python execute 'highlight pythonBoolean    guifg=' . s:dark_constant  . ' ctermfg=151'
  autocmd FileType python execute 'highlight pythonKeyword    guifg=' . s:dark_keyword   . ' ctermfg=203'
  autocmd FileType python execute 'highlight pythonType       guifg=' . s:dark_type      . ' ctermfg=214'
  autocmd FileType python execute 'highlight pythonOperator   guifg=' . s:dark_operator  . ' ctermfg=75'
augroup END

"── Rust ────────────────────────────────────────────────────────────────────
augroup ft_highlight_rust
  autocmd!
  autocmd FileType rust        execute 'highlight rustFunction    guifg=' . s:dark_function . ' ctermfg=225'
  autocmd FileType rust        execute 'highlight rustIdentifier  guifg=' . s:dark_variable . ' ctermfg=7'
  autocmd FileType rust        execute 'highlight rustString      guifg=' . s:dark_string   . ' ctermfg=75'
  autocmd FileType rust        execute 'highlight rustNumber      guifg=' . s:dark_number   . ' ctermfg=71'
  autocmd FileType rust        execute 'highlight rustBoolean     guifg=' . s:dark_constant . ' ctermfg=151'
  autocmd FileType rust        execute 'highlight rustKeyword     guifg=' . s:dark_keyword  . ' ctermfg=203'
  autocmd FileType rust        execute 'highlight rustType        guifg=' . s:dark_type     . ' ctermfg=214'
augroup END

"── Dockerfile ─────────────────────────────────────────────────────────────
augroup ft_highlight_dockerfile
  autocmd!
  autocmd FileType dockerfile  execute 'highlight dockerfileInstruction    guifg=' . s:dark_keyword  . ' ctermfg=203'
  autocmd FileType dockerfile  execute 'highlight dockerfileCmdArgument    guifg=' . s:dark_string   . ' ctermfg=75'
  autocmd FileType dockerfile  execute 'highlight dockerfileEnvVar         guifg=' . s:dark_number   . ' ctermfg=71'
  autocmd FileType dockerfile  execute 'highlight dockerfileComment        guifg=' . s:dark_comment  . ' ctermfg=59'
augroup END

"── Shell (sh) ─────────────────────────────────────────────────────────────
augroup ft_highlight_sh
  autocmd!
  autocmd FileType sh          execute 'highlight shFunction       guifg=' . s:dark_function . ' ctermfg=225'
  autocmd FileType sh          execute 'highlight shStatement      guifg=' . s:dark_keyword  . ' ctermfg=203'
  autocmd FileType sh          execute 'highlight shOption         guifg=' . s:dark_type     . ' ctermfg=214'
  autocmd FileType sh          execute 'highlight shString         guifg=' . s:dark_string   . ' ctermfg=75'
  autocmd FileType sh          execute 'highlight shNumber         guifg=' . s:dark_number   . ' ctermfg=71'
augroup END

"── Markdown ──────────────────────────────────────────────────────────────
augroup ft_highlight_markdown
  autocmd!
  autocmd FileType markdown    execute 'highlight markdownHeading   guifg=' . s:dark_keyword  . ' ctermfg=203'
  autocmd FileType markdown    execute 'highlight markdownBold      guifg=' . s:dark_constant . ' ctermfg=151'
  autocmd FileType markdown    execute 'highlight markdownItalic    guifg=' . s:dark_special  . ' ctermfg=205'
  autocmd FileType markdown    execute 'highlight markdownCode      guifg=' . s:dark_string   . ' ctermfg=75'
  autocmd FileType markdown    execute 'highlight markdownLinkText  guifg=' . s:dark_type     . ' ctermfg=214'
  autocmd FileType markdown    execute 'highlight markdownUrl       guifg=' . s:dark_blue    . ' ctermfg=75'
augroup END

"── Plain Text (.txt) ─────────────────────────────────────────────────────
" no syntax groups defined by default; falls back to Normal.
" If you wish to colorize e.g. TODOs or comments, you can add custom patterns here.

