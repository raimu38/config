" Name: GitHub Dark Default
" Description: A faithful reproduction of the official GitHub themes.
" Author: Raimu
" Maintainer: Riamu <https://github.com/raimu38>
" Website: https://www.github.com/vim/colorschemes
" Last Updated: Sat 29 Jun 2025

if exists('g:colors_name') && g:colors_name ==# 'github'
  finish
endif
hi clear
let g:colors_name = 'github'
let s:t_Co = has('gui_running') ? -1 : (&t_Co ?? 0)
" true-color 有効化
if has('termguicolors')
  set termguicolors
endif


"─ Primer Core Palette ────────────────────────────────────────────────────────

" Common
let s:black = '#000000'
let s:white = '#ffffff'

"─ GitHub Dark Default Palette ──────────────────────────────────────────────
let s:dark_fg               = '#e6edf3'
"let s:dark_bg               = '#0d1117'
let s:dark_bg               = 'NONE'
"let s:dark_bg_subtle        = '#161b22'
let s:dark_bg_subtle        = 'NONE'
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


"─ GitHub Light Default Palette ─────────────────────────────────────────────
let s:light_fg              = '#1f2328'
let s:light_bg              = '#ffffff'
let s:light_bg_subtle       = '#f6f8fa'
let s:light_border          = '#d0d7de'
let s:light_fg_subtle       = '#57606a'
let s:light_selection_bg    = '#0969da'
let s:light_find_match_bg   = '#fae17d'
let s:light_find_match_fg   = s:light_fg
let s:light_diff_add_bg     = '#ccffd8'
let s:light_diff_change_bg  = '#fff5cc'
let s:light_diff_delete_bg  = '#ffd8d3'

" Syntax (Light)
let s:light_comment         = '#57606a'
let s:light_keyword         = '#d73a49'
let s:light_string          = '#032f62'
let s:light_number          = '#005cc5'
let s:light_constant        = '#005cc5'
let s:light_function        = '#6f42c1'
let s:light_type            = '#e36209'
let s:light_operator        = '#d73a49'
let s:light_special         = '#005cc5'
let s:light_variable        = s:light_fg

" Feedback Colors (Light)
let s:light_blue            = '#0969da'
let s:light_green_fg        = '#1a7431'
let s:light_red_fg          = '#cf222e'
let s:light_yellow_fg       = '#953800'
let s:light_orange_fg       = '#e36209'
let s:light_purple_fg       = '#8250df'


"─ Terminal ANSI Colors ───────────────────────────────────────────────────────
let s:dark_terminal_ansi_colors = [
      \ s:dark_bg_subtle, s:dark_red_fg, s:dark_green_fg, s:dark_yellow_fg,
      \ s:dark_blue, s:dark_purple_fg, s:dark_operator, s:dark_fg,
      \ s:dark_fg_subtle, s:dark_red_fg, s:dark_green_fg, s:dark_yellow_fg,
      \ s:dark_blue, s:dark_purple_fg, s:dark_operator, s:white
      \ ]

let s:light_terminal_ansi_colors = [
      \ s:light_fg, s:light_red_fg, s:light_green_fg, s:light_yellow_fg,
      \ s:light_blue, s:light_purple_fg, s:light_string, s:light_fg_subtle,
      \ s:light_fg_subtle, s:light_red_fg, s:light_green_fg, s:light_yellow_fg,
      \ s:light_blue, s:light_purple_fg, s:light_string, s:black
      \ ]

" --- Link Common Highlight Groups ---
hi! link helpVim Title
hi! link helpHeader Title
hi! link helpHyperTextJump Underlined
hi! link fugitiveSymbolicRef PreProc
hi! link fugitiveHeading Statement
hi! link fugitiveStagedHeading Statement
hi! link fugitiveUnstagedHeading Statement
hi! link fugitiveUntrackedHeading Statement
hi! link fugitiveStagedModifier PreProc
hi! link fugitiveUnstagedModifier PreProc
hi! link fugitiveHash Constant
hi! link diffFile PreProc
hi! link markdownHeadingDelimiter Special
hi! link rstSectionDelimiter Statement
hi! link rstDirective PreProc
hi! link rstHyperlinkReference Special
hi! link rstFieldName Constant
hi! link rstDelimiter Special
hi! link rstInterpretedText Special
hi! link rstCodeBlock Normal
hi! link rstLiteralBlock rstCodeBlock
hi! link markdownUrl String
hi! link colortemplateKey Statement
hi! link xmlTagName Statement
hi! link javaScriptFunction Statement
hi! link javaScriptIdentifier Statement
hi! link sqlKeyword Statement
hi! link yamlBlockMappingKey Statement
hi! link rubyMacro Statement
hi! link rubyDefine Statement
hi! link vimGroup Normal
hi! link vimVar Normal
hi! link vimOper Normal
hi! link vimSep Normal
hi! link vimParenSep Normal
hi! link vimOption Normal
hi! link vimCommentString Comment
hi! link pythonInclude Statement
hi! link shQuote Constant
hi! link shNoQuote Normal
hi! link shTestOpr Normal
hi! link shOperator Normal
hi! link shSetOption Normal
hi! link shOption Normal
hi! link shCommandSub Normal
hi! link shDerefPattern shQuote
hi! link shDerefOp Special
hi! link phpStorageClass Statement
hi! link phpStructure Statement
hi! link phpInclude Statement
hi! link phpDefine Statement
hi! link phpSpecialFunction Normal
hi! link phpParent Normal
hi! link phpComparison Normal
hi! link phpOperator Normal
hi! link phpVarSelector Special
hi! link phpMemberSelector Special
hi! link phpDocCustomTags phpDocTags
hi! link javaExternal Statement
hi! link javaType Statement
hi! link javaScopeDecl Statement
hi! link javaClassDecl Statement
hi! link javaStorageClass Statement
hi! link javaDocParam PreProc
hi! link csStorage Statement
hi! link csAccessModifier Statement
hi! link csClass Statement
hi! link csModifier Statement
hi! link csAsyncModifier Statement
hi! link csLogicSymbols Normal
hi! link csClassType Normal
hi! link csType Statement
hi! link Terminal Normal
hi! link StatuslineTerm Statusline
hi! link StatuslineTermNC StatuslineNC
hi! link LineNrAbove LineNr
hi! link LineNrBelow LineNr
hi! link MessageWindow PMenu
hi! link PopupNotification Todo



" ─ Theme Application Logic ──────────────────────────────────────────────────
if &background ==# 'dark'
  if (has('termguicolors') && &termguicolors) || has('gui_running')
    let g:terminal_ansi_colors = s:dark_terminal_ansi_colors
  endif

  " General UI
  execute 'hi Normal          guifg=' . s:dark_fg             . ' guibg=' . s:dark_bg . ' gui=NONE cterm=NONE'
  execute 'hi LineNr          guifg=' . s:dark_fg_subtle      . ' guibg=' . s:dark_bg
  execute 'hi CursorLineNr    guifg=' . s:dark_fg             . ' guibg=' . s:dark_bg_subtle . ' gui=bold'
  execute 'hi NonText         guifg=' . s:dark_fg_subtle      . ' guibg=NONE'
  execute 'hi EndOfBuffer     guifg=' . s:dark_bg             . ' guibg=NONE'
  execute 'hi SpecialKey      guifg=' . s:dark_fg_subtle      . ' guibg=NONE'
  execute 'hi SignColumn      guifg=' . s:dark_fg_subtle      . ' guibg=' . s:dark_bg

  " Status Line and Tab Line
  execute 'hi StatusLine      guifg=' . s:dark_fg_subtle      . ' guibg=' . s:dark_bg_sidebar . ' gui=NONE'
  execute 'hi StatusLineNC    guifg=' . s:dark_fg_subtle      . ' guibg=' . s:dark_bg_sidebar . ' gui=NONE'
  execute 'hi VertSplit       guifg=' . s:dark_border         . ' guibg=' . s:dark_bg_sidebar
  execute 'hi TabLine         guifg=' . s:dark_fg_subtle      . ' guibg=' . s:dark_bg_sidebar
  execute 'hi TabLineFill     guifg=NONE'                    . ' guibg=' . s:dark_bg_sidebar
  execute 'hi TabLineSel      guifg=' . s:dark_fg             . ' guibg=' . s:dark_bg . ' gui=bold'

  " Toolbar
  execute 'hi ToolbarLine     guifg=NONE'                    . ' guibg=' . s:dark_bg_subtle
  execute 'hi ToolbarButton   guifg=' . s:dark_fg             . ' guibg=' . s:dark_bg_subtle . ' gui=bold'

  " Popup / Completion Menu
  execute 'hi Pmenu           guifg=' . s:dark_fg             . ' guibg=' . s:dark_bg_subtle
  execute 'hi PmenuSel        guifg=' . s:white               . ' guibg=' . s:dark_blue
  execute 'hi PmenuThumb      guifg=NONE'                    . ' guibg=' . s:dark_fg_subtle
  execute 'hi PmenuSbar       guifg=NONE'                    . ' guibg=' . s:dark_border
  execute 'hi PmenuKind       guifg=' . s:dark_purple_fg      . ' guibg=' . s:dark_bg_subtle
  execute 'hi PmenuKindSel    guifg=' . s:dark_purple_fg      . ' guibg=' . s:dark_blue
  execute 'hi PmenuExtra      guifg=' . s:dark_comment        . ' guibg=' . s:dark_bg_subtle
  execute 'hi PmenuExtraSel   guifg=' . s:dark_comment        . ' guibg=' . s:dark_blue

  " Messaging and Errors
  execute 'hi QuickFixLine    guifg=NONE'                    . ' guibg=' . s:dark_bg_subtle . ' gui=NONE'
  execute 'hi Error           guifg=' . s:dark_red_fg         . ' guibg=NONE gui=bold'
  execute 'hi ErrorMsg        guifg=' . s:dark_red_fg         . ' guibg=NONE'
  execute 'hi WarningMsg      guifg=' . s:dark_yellow_fg      . ' guibg=NONE'
  execute 'hi ModeMsg         guifg=' . s:dark_fg             . ' guibg=NONE gui=bold'
  execute 'hi MoreMsg         guifg=' . s:dark_blue           . ' guibg=NONE'
  execute 'hi Question        guifg=' . s:dark_blue           . ' guibg=NONE gui=bold'
  execute 'hi Todo            guifg=' . s:dark_yellow_fg      . ' guibg=' . s:dark_bg . ' gui=bold'

  " Search and Cursor
  execute 'hi Search          guifg=' . s:dark_find_match_fg  . ' guibg=' . s:dark_find_match_bg
  execute 'hi IncSearch       guifg=' . s:black               . ' guibg=' . s:dark_orange_fg
  hi! link CurSearch Search
  execute 'hi WildMenu        guifg=' . s:white               . ' guibg=' . s:dark_blue . ' gui=bold'
  execute 'hi debugPC         guifg=' . s:white               . ' guibg=' . s:dark_green_fg
  execute 'hi debugBreakpoint guifg=' . s:white               . ' guibg=' . s:dark_red_fg . ' gui=bold'
  execute 'hi Cursor          guifg=' . s:dark_bg             . ' guibg=' . s:dark_blue
  execute 'hi lCursor         guifg=' . s:dark_bg             . ' guibg=' . s:dark_blue

  " Line/Column Highlights and Folds
  execute 'hi Visual          guifg=NONE'                    . ' guibg=' . s:dark_selection_bg
  execute 'hi MatchParen      guifg=' . s:dark_orange_fg      . ' guibg=NONE gui=bold'
  execute 'hi VisualNOS       guifg=NONE'                    . ' guibg=' . s:dark_selection_bg
  execute 'hi CursorLine      guifg=NONE'                    . ' guibg=' . s:dark_bg_subtle
  execute 'hi CursorColumn    guifg=NONE'                    . ' guibg=' . s:dark_bg_subtle
  execute 'hi Folded          guifg=' . s:dark_comment        . ' guibg=' . s:dark_bg_sidebar
  execute 'hi ColorColumn     guifg=NONE'                    . ' guibg=' . s:dark_bg_subtle

  " Spell Checking
  execute 'hi SpellBad        guisp=' . s:dark_red_fg
  execute 'hi SpellCap        guisp=' . s:dark_yellow_fg
  execute 'hi SpellLocal      guisp=' . s:dark_blue
  execute 'hi SpellRare       guisp=' . s:dark_purple_fg

  " Syntax Highlighting
  execute 'hi Comment         guifg=' . s:dark_comment        . ' gui=italic'
  execute 'hi Constant        guifg=' . s:dark_constant       . ' guibg=NONE'
  execute 'hi String          guifg=' . s:dark_string         . ' guibg=NONE'
  execute 'hi Character       guifg=' . s:dark_string         . ' guibg=NONE'
  execute 'hi Number          guifg=' . s:dark_number         . ' guibg=NONE'
  execute 'hi Boolean         guifg=' . s:dark_constant       . ' guibg=NONE'
  execute 'hi Float           guifg=' . s:dark_number         . ' guibg=NONE'
  execute 'hi Identifier      guifg=' . s:dark_variable       . ' guibg=NONE'
  execute 'hi Function        guifg=' . s:dark_function       . ' guibg=NONE'
  execute 'hi Statement       guifg=' . s:dark_keyword        . ' guibg=NONE gui=NONE'
  execute 'hi Conditional     guifg=' . s:dark_keyword        . ' guibg=NONE'
  execute 'hi Repeat          guifg=' . s:dark_keyword        . ' guibg=NONE'
  execute 'hi Label           guifg=' . s:dark_keyword        . ' guibg=NONE'
  execute 'hi Operator        guifg=' . s:dark_operator       . ' guibg=NONE'
  execute 'hi Keyword         guifg=' . s:dark_keyword        . ' guibg=NONE'
  execute 'hi Exception       guifg=' . s:dark_keyword        . ' guibg=NONE'
  execute 'hi PreProc         guifg=' . s:dark_keyword        . ' guibg=NONE'
  execute 'hi Include         guifg=' . s:dark_keyword        . ' guibg=NONE'
  execute 'hi Define          guifg=' . s:dark_keyword        . ' guibg=NONE'
  execute 'hi Macro           guifg=' . s:dark_keyword        . ' guibg=NONE'
  execute 'hi PreCondit       guifg=' . s:dark_keyword        . ' guibg=NONE'
  execute 'hi Type            guifg=' . s:dark_type           . ' guibg=NONE'
  execute 'hi StorageClass    guifg=' . s:dark_type           . ' guibg=NONE'
  execute 'hi Structure       guifg=' . s:dark_type           . ' guibg=NONE'
  execute 'hi Typedef         guifg=' . s:dark_type           . ' guibg=NONE gui=bold'
  execute 'hi Special         guifg=' . s:dark_special        . ' guibg=NONE'
  execute 'hi Underlined      guifg=NONE'                    . ' guibg=NONE gui=underline'
  execute 'hi Title           guifg=' . s:dark_blue           . ' guibg=NONE gui=bold'
  execute 'hi Directory       guifg=' . s:dark_blue           . ' guibg=NONE gui=bold'
  execute 'hi Conceal         guifg=' . s:dark_fg_subtle      . ' guibg=' . s:dark_bg

  " Diff Highlighting
  execute 'hi DiffAdd         guifg=NONE'                    . ' guibg=' . s:dark_diff_add_bg
  execute 'hi DiffChange      guifg=NONE'                    . ' guibg=' . s:dark_diff_change_bg
  execute 'hi DiffDelete      guifg=NONE'                    . ' guibg=' . s:dark_diff_delete_bg
  execute 'hi DiffText        guifg=NONE'                    . ' guibg=' . s:dark_selection_bg . ' gui=bold'
  execute 'hi diffAdded       guifg=' . s:dark_green_fg       . ' guibg=NONE'
  execute 'hi diffRemoved     guifg=' . s:dark_red_fg         . ' guibg=NONE'
  execute 'hi diffSubname     guifg=' . s:dark_purple_fg      . ' guibg=NONE'

  " Directory List
  execute 'hi dirType           guifg=' . s:dark_blue           . ' guibg=NONE'
  execute 'hi dirPermissionUser   guifg=' . s:dark_red_fg         . ' guibg=NONE'
  execute 'hi dirPermissionGroup  guifg=' . s:dark_purple_fg      . ' guibg=NONE'
  execute 'hi dirPermissionOther  guifg=' . s:dark_yellow_fg      . ' guibg=NONE'
  execute 'hi dirOwner            guifg=' . s:dark_comment        . ' guibg=NONE'
  execute 'hi dirGroup            guifg=' . s:dark_comment        . ' guibg=NONE'
  execute 'hi dirTime             guifg=' . s:dark_comment        . ' guibg=NONE'
  execute 'hi dirSize             guifg=' . s:dark_number         . ' guibg=NONE'
  execute 'hi dirSizeMod          guifg=' . s:dark_green_fg       . ' guibg=NONE'
  execute 'hi dirLink             guifg=' . s:dark_blue           . ' guibg=NONE gui=bold'
  execute 'hi dirFilterMenuBookmarkPath guifg=' . s:dark_comment . ' guibg=NONE'
  execute 'hi dirFilterMenuHistoryPath  guifg=' . s:dark_comment . ' guibg=NONE'
  execute 'hi FilterMenuDirectorySubtle guifg=' . s:dark_comment . ' guibg=NONE'
  execute 'hi FilterMenuLineNr          guifg=' . s:dark_comment . ' guibg=NONE'
  execute 'hi CocSearch                   guifg=' . s:dark_red_fg  . ' guibg=NONE'

else
  " THIS LIGHT MODE SECTION IS NOW FULLY THEMED
  if (has('termguicolors') && &termguicolors) || has('gui_running')
    let g:terminal_ansi_colors = s:light_terminal_ansi_colors
  endif

  " General UI
  execute 'hi Normal          guifg=' . s:light_fg            . ' guibg=' . s:light_bg . ' gui=NONE cterm=NONE'
  execute 'hi LineNr          guifg=' . s:light_fg_subtle     . ' guibg=' . s:light_bg
  execute 'hi CursorLineNr    guifg=' . s:light_fg            . ' guibg=' . s:light_bg_subtle . ' gui=bold'
  execute 'hi NonText         guifg=' . s:light_fg_subtle     . ' guibg=NONE'
  execute 'hi FoldColumn      guifg=' . s:light_fg_subtle     . ' guibg=' . s:light_bg_subtle
  execute 'hi EndOfBuffer     guifg=' . s:light_bg            . ' guibg=NONE'
  execute 'hi SpecialKey      guifg=' . s:light_fg_subtle     . ' guibg=NONE'
  execute 'hi SignColumn      guifg=' . s:light_fg_subtle     . ' guibg=' . s:light_bg

  " Status Line and Tab Line
  execute 'hi StatusLine      guifg=' . s:light_fg_subtle     . ' guibg=' . s:light_bg_subtle . ' gui=NONE'
  execute 'hi StatusLineNC    guifg=' . s:light_fg_subtle     . ' guibg=' . s:light_bg_subtle . ' gui=NONE'
  execute 'hi VertSplit       guifg=' . s:light_border        . ' guibg=' . s:light_bg
  execute 'hi TabLine         guifg=' . s:light_fg_subtle     . ' guibg=' . s:light_bg_subtle
  execute 'hi TabLineFill     guifg=NONE'                    . ' guibg=' . s:light_bg_subtle
  execute 'hi TabLineSel      guifg=' . s:light_fg            . ' guibg=' . s:light_bg . ' gui=bold'

  " Toolbar
  execute 'hi ToolbarLine     guifg=NONE'                    . ' guibg=NONE'
  execute 'hi ToolbarButton   guifg=' . s:light_fg            . ' guibg=' . s:light_bg

  " Popup / Completion Menu
  execute 'hi Pmenu           guifg=' . s:light_fg            . ' guibg=' . s:light_bg_subtle
  execute 'hi PmenuSel        guifg=' . s:white               . ' guibg=' . s:light_blue
  execute 'hi PmenuThumb      guifg=NONE'                    . ' guibg=' . s:light_border
  execute 'hi PmenuSbar       guifg=NONE'                    . ' guibg=' . s:light_border
  execute 'hi PmenuKind       guifg=' . s:light_purple_fg     . ' guibg=' . s:light_bg_subtle
  execute 'hi PmenuKindSel    guifg=' . s:light_purple_fg     . ' guibg=' . s:light_blue
  execute 'hi PmenuExtra      guifg=' . s:light_comment       . ' guibg=' . s:light_bg_subtle
  execute 'hi PmenuExtraSel   guifg=' . s:light_comment       . ' guibg=' . s:light_blue

  " Messaging and Errors
  execute 'hi QuickFixLine    guifg=NONE'                    . ' guibg=' . s:light_bg_subtle . ' gui=NONE'
  execute 'hi Error           guifg=' . s:light_red_fg        . ' guibg=NONE gui=bold'
  execute 'hi ErrorMsg        guifg=' . s:light_red_fg        . ' guibg=NONE'
  execute 'hi WarningMsg      guifg=' . s:light_yellow_fg     . ' guibg=NONE'
  execute 'hi ModeMsg         guifg=' . s:light_fg            . ' guibg=NONE gui=bold'
  execute 'hi MoreMsg         guifg=' . s:light_blue          . ' guibg=NONE'
  execute 'hi Question        guifg=' . s:light_blue          . ' guibg=NONE gui=bold'
  execute 'hi Todo            guifg=' . s:light_yellow_fg     . ' guibg=' . s:light_bg . ' gui=bold'

  " Search and Cursor
  execute 'hi Search          guifg=' . s:light_find_match_fg . ' guibg=' . s:light_find_match_bg
  execute 'hi IncSearch       guifg=' . s:white               . ' guibg=' . s:light_orange_fg
  hi! link CurSearch Search
  execute 'hi WildMenu        guifg=' . s:white               . ' guibg=' . s:light_blue . ' gui=bold'
  execute 'hi debugPC         guifg=' . s:white               . ' guibg=' . s:light_green_fg
  execute 'hi debugBreakpoint guifg=' . s:white               . ' guibg=' . s:light_red_fg . ' gui=bold'
  execute 'hi Cursor          guifg=' . s:light_bg            . ' guibg=' . s:light_fg
  execute 'hi lCursor         guifg=' . s:light_bg            . ' guibg=' . s:light_fg

  " Line/Column Highlights and Folds
  execute 'hi Visual          guifg=NONE'                    . ' guibg=' . s:light_selection_bg
  execute 'hi MatchParen      guifg=' . s:light_orange_fg     . ' guibg=NONE gui=bold'
  execute 'hi VisualNOS       guifg=NONE'                    . ' guibg=' . s:light_selection_bg
  execute 'hi CursorLine      guifg=NONE'                    . ' guibg=' . s:light_bg_subtle
  execute 'hi CursorColumn    guifg=NONE'                    . ' guibg=' . s:light_bg_subtle
  execute 'hi Folded          guifg=' . s:light_comment       . ' guibg=' . s:light_bg_subtle
  execute 'hi ColorColumn     guifg=NONE'                    . ' guibg=' . s:light_bg_subtle

  " Spell Checking
  execute 'hi SpellBad        guisp=' . s:light_red_fg
  execute 'hi SpellCap        guisp=' . s:light_yellow_fg
  execute 'hi SpellLocal      guisp=' . s:light_blue
  execute 'hi SpellRare       guisp=' . s:light_purple_fg

  " Syntax Highlighting
  execute 'hi Comment         guifg=' . s:light_comment       . ' gui=italic'
  execute 'hi Constant        guifg=' . s:light_constant      . ' guibg=NONE'
  execute 'hi String          guifg=' . s:light_string        . ' guibg=NONE'
  execute 'hi Character       guifg=' . s:light_string        . ' guibg=NONE'
  execute 'hi Number          guifg=' . s:light_number        . ' guibg=NONE'
  execute 'hi Boolean         guifg=' . s:light_constant      . ' guibg=NONE'
  execute 'hi Float           guifg=' . s:light_number        . ' guibg=NONE'
  execute 'hi Identifier      guifg=' . s:light_variable      . ' guibg=NONE'
  execute 'hi Function        guifg=' . s:light_function      . ' guibg=NONE'
  execute 'hi Statement       guifg=' . s:light_keyword       . ' guibg=NONE'
  execute 'hi Conditional     guifg=' . s:light_keyword       . ' guibg=NONE'
  execute 'hi Repeat          guifg=' . s:light_keyword       . ' guibg=NONE'
  execute 'hi Label           guifg=' . s:light_keyword       . ' guibg=NONE'
  execute 'hi Operator        guifg=' . s:light_operator      . ' guibg=NONE'
  execute 'hi Keyword         guifg=' . s:light_keyword       . ' guibg=NONE'
  execute 'hi Exception       guifg=' . s:light_keyword       . ' guibg=NONE'
  execute 'hi PreProc         guifg=' . s:light_keyword       . ' guibg=NONE'
  execute 'hi Include         guifg=' . s:light_keyword       . ' guibg=NONE'
  execute 'hi Define          guifg=' . s:light_keyword       . ' guibg=NONE'
  execute 'hi Macro           guifg=' . s:light_keyword       . ' guibg=NONE'
  execute 'hi PreCondit       guifg=' . s:light_keyword       . ' guibg=NONE'
  execute 'hi Type            guifg=' . s:light_type          . ' guibg=NONE'
  execute 'hi StorageClass    guifg=' . s:light_type          . ' guibg=NONE'
  execute 'hi Structure       guifg=' . s:light_type          . ' guibg=NONE'
  execute 'hi Typedef         guifg=' . s:light_type          . ' guibg=NONE gui=bold'
  execute 'hi Special         guifg=' . s:light_special       . ' guibg=NONE'
  execute 'hi Underlined      guifg=NONE'                    . ' guibg=NONE gui=underline'
  execute 'hi Title           guifg=' . s:light_blue          . ' guibg=NONE gui=bold'
  execute 'hi Directory       guifg=' . s:light_blue          . ' guibg=NONE gui=bold'
  execute 'hi Conceal         guifg=' . s:light_fg_subtle     . ' guibg=' . s:light_bg

  " Diff Highlighting
  execute 'hi DiffAdd         guifg=NONE'                    . ' guibg=' . s:light_diff_add_bg
  execute 'hi DiffChange      guifg=NONE'                    . ' guibg=' . s:light_diff_change_bg
  execute 'hi DiffDelete      guifg=NONE'                    . ' guibg=' . s:light_diff_delete_bg
  execute 'hi DiffText        guifg=NONE'                    . ' guibg=' . s:light_selection_bg . ' gui=bold'
  execute 'hi diffAdded       guifg=' . s:light_green_fg      . ' guibg=NONE'
  execute 'hi diffRemoved     guifg=' . s:light_red_fg        . ' guibg=NONE'
  execute 'hi diffSubname     guifg=' . s:light_purple_fg     . ' guibg=NONE'

  " Directory List
  execute 'hi dirType           guifg=' . s:light_blue          . ' guibg=NONE'
  execute 'hi dirPermissionUser   guifg=' . s:light_red_fg        . ' guibg=NONE'
  execute 'hi dirPermissionGroup  guifg=' . s:light_purple_fg     . ' guibg=NONE'
  execute 'hi dirPermissionOther  guifg=' . s:light_yellow_fg     . ' guibg=NONE'
  execute 'hi dirOwner            guifg=' . s:light_comment       . ' guibg=NONE'
  execute 'hi dirGroup            guifg=' . s:light_comment       . ' guibg=NONE'
  execute 'hi dirTime             guifg=' . s:light_comment       . ' guibg=NONE'
  execute 'hi dirSize             guifg=' . s:light_number        . ' guibg=NONE'
  execute 'hi dirSizeMod          guifg=' . s:light_green_fg      . ' guibg=NONE'
  execute 'hi dirLink             guifg=' . s:light_blue          . ' guibg=NONE gui=bold'
  execute 'hi dirFilterMenuBookmarkPath guifg=' . s:light_comment . ' guibg=NONE'
  execute 'hi dirFilterMenuHistoryPath  guifg=' . s:light_comment . ' guibg=NONE'
  execute 'hi FilterMenuDirectorySubtle guifg=' . s:light_comment . ' guibg=NONE'
  execute 'hi FilterMenuLineNr          guifg=' . s:light_comment . ' guibg=NONE'
  execute 'hi CocSearch                   guifg=' . s:light_red_fg  . ' guibg=NONE'
endif




if s:t_Co >= 256
  hi! link helpVim Title
  hi! link helpHeader Title
  hi! link helpHyperTextJump Underlined
  hi! link fugitiveSymbolicRef PreProc
  hi! link fugitiveHeading Statement
  hi! link fugitiveStagedHeading Statement
  hi! link fugitiveUnstagedHeading Statement
  hi! link fugitiveUntrackedHeading Statement
  hi! link fugitiveStagedModifier PreProc
  hi! link fugitiveUnstagedModifier PreProc
  hi! link fugitiveHash Constant
  hi! link diffFile PreProc
  hi! link markdownHeadingDelimiter Special
  hi! link rstSectionDelimiter Statement
  hi! link rstDirective PreProc
  hi! link rstHyperlinkReference Special
  hi! link rstFieldName Constant
  hi! link rstDelimiter Special
  hi! link rstInterpretedText Special
  hi! link rstCodeBlock Normal
  hi! link rstLiteralBlock rstCodeBlock
  hi! link markdownUrl String
  hi! link colortemplateKey Statement
  hi! link xmlTagName Statement
  hi! link javaScriptFunction Statement
  hi! link javaScriptIdentifier Statement
  hi! link sqlKeyword Statement
  hi! link yamlBlockMappingKey Statement
  hi! link rubyMacro Statement
  hi! link rubyDefine Statement
  hi! link vimGroup Normal
  hi! link vimVar Normal
  hi! link vimOper Normal
  hi! link vimSep Normal
  hi! link vimParenSep Normal
  hi! link vimOption Normal
  hi! link vimCommentString Comment
  hi! link pythonInclude Statement
  hi! link shQuote Constant
  hi! link shNoQuote Normal
  hi! link shTestOpr Normal
  hi! link shOperator Normal
  hi! link shSetOption Normal
  hi! link shOption Normal
  hi! link shCommandSub Normal
  hi! link shDerefPattern shQuote
  hi! link shDerefOp Special
  hi! link phpStorageClass Statement
  hi! link phpStructure Statement
  hi! link phpInclude Statement
  hi! link phpDefine Statement
  hi! link phpSpecialFunction Normal
  hi! link phpParent Normal
  hi! link phpComparison Normal
  hi! link phpOperator Normal
  hi! link phpVarSelector Special
  hi! link phpMemberSelector Special
  hi! link phpDocCustomTags phpDocTags
  hi! link javaExternal Statement
  hi! link javaType Statement
  hi! link javaScopeDecl Statement
  hi! link javaClassDecl Statement
  hi! link javaStorageClass Statement
  hi! link javaDocParam PreProc
  hi! link csStorage Statement
  hi! link csAccessModifier Statement
  hi! link csClass Statement
  hi! link csModifier Statement
  hi! link csAsyncModifier Statement
  hi! link csLogicSymbols Normal
  hi! link csClassType Normal
  hi! link csType Statement
  hi! link Terminal Normal
  hi! link StatuslineTerm Statusline
  hi! link StatuslineTermNC StatuslineNC
  hi! link LineNrAbove LineNr
  hi! link LineNrBelow LineNr
  hi! link MessageWindow PMenu
  hi! link PopupNotification Todo

  if &background ==# 'dark'
    " GitHub Dark 256-color mapping
    hi Normal       ctermfg=248 ctermbg=16  cterm=NONE
    hi Statusline   ctermfg=248 ctermbg=16  cterm=bold,reverse
    hi StatuslineNC ctermfg=237 ctermbg=16  cterm=reverse
    hi VertSplit    ctermfg=237 ctermbg=237 cterm=NONE
    hi TabLine      ctermfg=16  ctermbg=248 cterm=NONE
    hi TabLineFill  ctermfg=NONE ctermbg=237 cterm=NONE
    hi TabLineSel   ctermfg=75  ctermbg=237 cterm=bold
    hi ToolbarLine  ctermfg=NONE ctermbg=NONE cterm=NONE
    hi ToolbarButton ctermfg=16 ctermbg=75 cterm=NONE
    hi QuickFixLine ctermfg=16  ctermbg=75  cterm=NONE
    hi CursorLineNr ctermfg=75  ctermbg=NONE cterm=bold
    hi LineNr       ctermfg=238 ctermbg=NONE cterm=NONE
    hi NonText      ctermfg=238 ctermbg=NONE cterm=NONE
    hi FoldColumn   ctermfg=238 ctermbg=NONE cterm=NONE
    hi SpecialKey   ctermfg=238 ctermbg=NONE cterm=NONE
    hi EndOfBuffer  ctermfg=238 ctermbg=NONE cterm=NONE

    hi Pmenu        ctermfg=NONE ctermbg=237 cterm=NONE
    hi PmenuSel     ctermfg=16   ctermbg=75  cterm=NONE
    hi PmenuThumb   ctermfg=NONE ctermbg=237 cterm=NONE
    hi PmenuSbar    ctermfg=NONE ctermbg=NONE cterm=NONE
    hi PmenuKind    ctermfg=203  ctermbg=237 cterm=NONE
    hi PmenuKindSel ctermfg=203  ctermbg=75  cterm=NONE
    hi PmenuExtra   ctermfg=238  ctermbg=237 cterm=NONE
    hi PmenuExtraSel ctermfg=238 ctermbg=75  cterm=NONE

    hi SignColumn   ctermfg=NONE ctermbg=NONE cterm=NONE

    hi Error        ctermfg=203 ctermbg=NONE cterm=NONE
    hi ErrorMsg     ctermfg=203 ctermbg=NONE cterm=NONE
    hi WarningMsg   ctermfg=178 ctermbg=NONE cterm=NONE   
    hi ModeMsg      ctermfg=237 ctermbg=NONE cterm=reverse
    hi MoreMsg      ctermfg=75  ctermbg=NONE cterm=NONE
    hi Question     ctermfg=75  ctermbg=NONE cterm=NONE
    hi Todo         ctermfg=178 ctermbg=16   cterm=reverse

    hi Search       ctermfg=16  ctermbg=57  cterm=NONE  
    hi IncSearch    ctermfg=16  ctermbg=57  cterm=NONE
    hi CurSearch    ctermfg=16  ctermbg=57  cterm=NONE
    hi WildMenu     ctermfg=16  ctermbg=57  cterm=bold

    hi debugPC      ctermfg=75  ctermbg=NONE cterm=reverse
    hi debugBreakpoint ctermfg=73 ctermbg=NONE cterm=reverse

    hi Visual       ctermfg=231 ctermbg=24  cterm=NONE
    hi MatchParen   ctermfg=199 ctermbg=NONE cterm=bold
    hi VisualNOS    ctermfg=16  ctermbg=73   cterm=NONE

    hi CursorLine   ctermfg=NONE ctermbg=235 cterm=NONE
    hi CursorColumn ctermfg=NONE ctermbg=235 cterm=NONE
    hi Folded       ctermfg=237 ctermbg=236 cterm=NONE
    hi ColorColumn  ctermfg=NONE ctermbg=236 cterm=NONE

    hi SpellBad     ctermfg=203 ctermbg=NONE cterm=underline
    hi SpellCap     ctermfg=73  ctermbg=NONE cterm=underline
    hi SpellLocal   ctermfg=73  ctermbg=NONE cterm=underline
    hi SpellRare    ctermfg=203 ctermbg=NONE cterm=underline

    hi Comment      ctermfg=238 ctermbg=NONE cterm=NONE
    hi Constant     ctermfg=178 ctermbg=NONE cterm=NONE
    hi String       ctermfg=222 ctermbg=NONE cterm=NONE
    hi Identifier   ctermfg=75  ctermbg=NONE cterm=NONE
    hi Statement    ctermfg=203 ctermbg=NONE cterm=bold
    hi PreProc      ctermfg=203 ctermbg=NONE cterm=NONE
    hi Type         ctermfg=141 ctermbg=NONE cterm=NONE  
    hi Special      ctermfg=75  ctermbg=NONE cterm=NONE
    hi Underlined   ctermfg=NONE ctermbg=NONE cterm=underline
    hi Title        ctermfg=75  ctermbg=NONE cterm=bold
    hi Directory    ctermfg=75  ctermbg=NONE cterm=bold

    hi DiffAdd      ctermfg=22 ctermbg=236 cterm=NONE
    hi DiffChange   ctermfg=NONE ctermbg=237 cterm=NONE
    hi DiffText     ctermfg=NONE ctermbg=235 cterm=NONE
    hi DiffDelete   ctermfg=203 ctermbg=NONE cterm=NONE
    hi diffAdded    ctermfg=22  ctermbg=NONE cterm=NONE
    hi diffRemoved  ctermfg=203 ctermbg=NONE cterm=NONE
    hi diffSubname  ctermfg=141 ctermbg=NONE cterm=NONE

    hi dirType                  ctermfg=75  ctermbg=NONE cterm=NONE
    hi dirPermissionUser        ctermfg=203 ctermbg=NONE cterm=NONE
    hi dirPermissionGroup       ctermfg=141 ctermbg=NONE cterm=NONE
    hi dirPermissionOther       ctermfg=178 ctermbg=NONE cterm=NONE
    hi dirOwner                 ctermfg=238 ctermbg=NONE cterm=NONE
    hi dirGroup                 ctermfg=238 ctermbg=NONE cterm=NONE
    hi dirTime                  ctermfg=238 ctermbg=NONE cterm=NONE
    hi dirSize                  ctermfg=178 ctermbg=NONE cterm=NONE
    hi dirSizeMod               ctermfg=75  ctermbg=NONE cterm=NONE
    hi dirLink                  ctermfg=75  ctermbg=NONE cterm=bold
    hi dirFilterMenuBookmarkPath ctermfg=238 ctermbg=NONE cterm=NONE
    hi dirFilterMenuHistoryPath ctermfg=238 ctermbg=NONE cterm=NONE
    hi FilterMenuDirectorySubtle ctermfg=238 ctermbg=NONE cterm=NONE
    hi FilterMenuLineNr         ctermfg=238 ctermbg=NONE cterm=NONE
    hi CocSearch                ctermfg=203 ctermbg=NONE cterm=NONE
  else
    hi Normal         ctermfg=237 ctermbg=231 cterm=NONE
    hi Statusline     ctermfg=237 ctermbg=231 cterm=bold
    hi StatuslineNC   ctermfg=240 ctermbg=254 cterm=NONE
    hi VertSplit      ctermfg=240 ctermbg=254 cterm=NONE
    hi TabLine        ctermfg=237 ctermbg=254 cterm=NONE
    hi TabLineFill    ctermfg=NONE ctermbg=254 cterm=NONE
    hi TabLineSel     ctermfg=231 ctermbg=237 cterm=bold,reverse
    hi ToolbarLine    ctermfg=NONE ctermbg=NONE cterm=NONE
    hi ToolbarButton  ctermfg=231 ctermbg=237 cterm=NONE

    hi QuickFixLine   ctermfg=237 ctermbg=254 cterm=NONE
    hi CursorLineNr   ctermfg=16  ctermbg=NONE cterm=bold
    hi LineNr         ctermfg=240 ctermbg=NONE cterm=NONE
    hi NonText        ctermfg=240 ctermbg=NONE cterm=NONE
    hi FoldColumn     ctermfg=240 ctermbg=NONE cterm=NONE
    hi EndOfBuffer    ctermfg=240 ctermbg=NONE cterm=NONE
    hi SpecialKey     ctermfg=240 ctermbg=NONE cterm=NONE

    hi Pmenu          ctermfg=237 ctermbg=254 cterm=NONE
    hi PmenuSel       ctermfg=231 ctermbg=237 cterm=NONE
    hi PmenuThumb     ctermfg=NONE ctermbg=254 cterm=NONE
    hi PmenuSbar      ctermfg=NONE ctermbg=NONE cterm=NONE
    hi PmenuKind      ctermfg=124 ctermbg=254 cterm=NONE
    hi PmenuKindSel   ctermfg=124 ctermbg=237 cterm=NONE
    hi PmenuExtra     ctermfg=240 ctermbg=254 cterm=NONE
    hi PmenuExtraSel  ctermfg=240 ctermbg=237 cterm=NONE

    hi SignColumn     ctermfg=NONE ctermbg=NONE cterm=NONE

    hi Error          ctermfg=160 ctermbg=NONE cterm=NONE
    hi ErrorMsg       ctermfg=160 ctermbg=NONE cterm=NONE
    hi ModeMsg        ctermfg=237 ctermbg=16   cterm=reverse
    hi MoreMsg        ctermfg=26  ctermbg=NONE cterm=bold
    hi Question       ctermfg=141 ctermbg=NONE cterm=bold
    hi WarningMsg     ctermfg=178 ctermbg=NONE cterm=bold
    hi Todo           ctermfg=71  ctermbg=231 cterm=reverse

    hi Search         ctermfg=237 ctermbg=130 cterm=NONE
    hi IncSearch      ctermfg=237 ctermbg=71  cterm=NONE
    hi CurSearch      ctermfg=237 ctermbg=71  cterm=NONE
    hi WildMenu       ctermfg=237 ctermbg=130 cterm=bold

    hi debugPC        ctermfg=26  ctermbg=NONE cterm=reverse
    hi debugBreakpoint ctermfg=23 ctermbg=NONE cterm=reverse

    hi Visual         ctermfg=231 ctermbg=254 cterm=NONE
    hi MatchParen     ctermfg=141 ctermbg=NONE cterm=bold
    hi VisualNOS      ctermfg=16  ctermbg=71  cterm=NONE

    hi CursorLine     ctermfg=NONE ctermbg=254 cterm=NONE
    hi CursorColumn   ctermfg=NONE ctermbg=254 cterm=NONE
    hi Folded         ctermfg=240 ctermbg=254 cterm=NONE
    hi ColorColumn    ctermfg=NONE ctermbg=254 cterm=NONE

    hi SpellBad       ctermfg=124 ctermbg=NONE cterm=underline
    hi SpellCap       ctermfg=23  ctermbg=NONE cterm=underline
    hi SpellLocal     ctermfg=71  ctermbg=NONE cterm=underline
    hi SpellRare      ctermfg=141 ctermbg=NONE cterm=underline

    hi Comment        ctermfg=240 ctermbg=NONE cterm=NONE
    hi Constant       ctermfg=141 ctermbg=NONE cterm=NONE
    hi String         ctermfg=178 ctermbg=NONE cterm=NONE
    hi Identifier     ctermfg=235 ctermbg=NONE cterm=NONE
    hi Statement      ctermfg=16  ctermbg=NONE cterm=bold
    hi PreProc        ctermfg=141 ctermbg=NONE cterm=NONE
    hi Type           ctermfg=141 ctermbg=NONE cterm=NONE
    hi Special        ctermfg=26  ctermbg=NONE cterm=NONE
    hi Underlined     ctermfg=NONE ctermbg=NONE cterm=underline
    hi Title          ctermfg=26  ctermbg=NONE cterm=bold
    hi Directory      ctermfg=26  ctermbg=NONE cterm=bold

    hi DiffAdd        ctermfg=22  ctermbg=NONE cterm=NONE
    hi DiffChange     ctermfg=NONE ctermbg=254 cterm=NONE
    hi DiffText       ctermfg=NONE ctermbg=71  cterm=NONE
    hi DiffDelete     ctermfg=160 ctermbg=NONE cterm=NONE
    hi diffAdded      ctermfg=22  ctermbg=NONE cterm=NONE
    hi diffRemoved    ctermfg=160 ctermbg=NONE cterm=NONE
    hi diffSubname    ctermfg=141 ctermbg=NONE cterm=NONE

    hi dirType                   ctermfg=26  ctermbg=NONE cterm=NONE
    hi dirPermissionUser         ctermfg=71  ctermbg=NONE cterm=NONE
    hi dirPermissionGroup        ctermfg=178 ctermbg=NONE cterm=NONE
    hi dirPermissionOther        ctermfg=141 ctermbg=NONE cterm=NONE
    hi dirOwner                  ctermfg=240 ctermbg=NONE cterm=NONE
    hi dirGroup                  ctermfg=240 ctermbg=NONE cterm=NONE
    hi dirTime                   ctermfg=240 ctermbg=NONE cterm=NONE
    hi dirSize                   ctermfg=178 ctermbg=NONE cterm=NONE
    hi dirSizeMod                ctermfg=26  ctermbg=NONE cterm=NONE
    hi dirLink                   ctermfg=26  ctermbg=NONE cterm=bold
    hi dirFilterMenuBookmarkPath ctermfg=240 ctermbg=NONE cterm=NONE
    hi dirFilterMenuHistoryPath  ctermfg=240 ctermbg=NONE cterm=NONE
    hi FilterMenuDirectorySubtle ctermfg=240 ctermbg=NONE cterm=NONE
    hi FilterMenuLineNr          ctermfg=240 ctermbg=NONE cterm=NONE
    hi CocSearch                 ctermfg=124 ctermbg=NONE cterm=NONE
  endif
  unlet s:t_Co
  finish
endif

if s:t_Co >= 16
  if &background ==# 'dark'
    " Basic UI
    hi Normal           ctermfg=white    ctermbg=black    cterm=NONE
    hi Statusline       ctermfg=white    ctermbg=black    cterm=bold,reverse
    hi StatuslineNC     ctermfg=darkgrey  ctermbg=black    cterm=reverse
    hi VertSplit        ctermfg=darkgrey  ctermbg=darkgrey  cterm=NONE
    hi TabLine          ctermfg=black    ctermbg=grey      cterm=NONE
    hi TabLineFill      ctermfg=NONE     ctermbg=darkgrey  cterm=NONE
    hi TabLineSel       ctermfg=white    ctermbg=black    cterm=bold
    hi ToolbarLine      ctermfg=NONE     ctermbg=NONE      cterm=NONE
    hi ToolbarButton    ctermfg=black    ctermbg=white    cterm=NONE

    " QuickFix / Line numbers
    hi QuickFixLine     ctermfg=black    ctermbg=blue     cterm=NONE
    hi CursorLineNr     ctermfg=white    ctermbg=NONE     cterm=bold
    hi LineNr           ctermfg=grey     ctermbg=NONE     cterm=NONE
    hi NonText          ctermfg=grey     ctermbg=NONE     cterm=NONE
    hi FoldColumn       ctermfg=grey     ctermbg=NONE     cterm=NONE
    hi SpecialKey       ctermfg=grey     ctermbg=NONE     cterm=NONE
    hi EndOfBuffer      ctermfg=darkgrey ctermbg=NONE     cterm=NONE

    " Popup menu
    hi Pmenu            ctermfg=black    ctermbg=grey      cterm=NONE
    hi PmenuThumb       ctermfg=NONE     ctermbg=darkgreen cterm=NONE
    hi PmenuSbar        ctermfg=NONE     ctermbg=NONE      cterm=NONE
    hi PmenuSel         ctermfg=black    ctermbg=darkcyan  cterm=NONE
    hi PmenuKind        ctermfg=darkred  ctermbg=grey      cterm=NONE
    hi PmenuKindSel     ctermfg=darkred  ctermbg=darkcyan  cterm=NONE
    hi PmenuExtra       ctermfg=black    ctermbg=grey      cterm=NONE
    hi PmenuExtraSel    ctermfg=black    ctermbg=darkcyan  cterm=NONE

    " Messages / Errors
    hi Error            ctermfg=white    ctermbg=red      cterm=NONE
    hi ErrorMsg         ctermfg=white    ctermbg=red      cterm=NONE
    hi WarningMsg       ctermfg=red      ctermbg=NONE     cterm=NONE
    hi ModeMsg          ctermfg=yellow   ctermbg=NONE     cterm=reverse
    hi MoreMsg          ctermfg=green    ctermbg=NONE     cterm=NONE
    hi Question         ctermfg=magenta  ctermbg=NONE     cterm=NONE
    hi Todo             ctermfg=cyan     ctermbg=black    cterm=reverse

    " Search highlights
    hi Search           ctermfg=black    ctermbg=yellow   cterm=NONE
    hi IncSearch        ctermfg=black    ctermbg=green    cterm=NONE
    hi CurSearch        ctermfg=black    ctermbg=green    cterm=NONE
    hi WildMenu         ctermfg=black    ctermbg=yellow   cterm=bold

    " Debugging
    hi debugPC          ctermfg=blue     ctermbg=NONE     cterm=reverse
    hi debugBreakpoint  ctermfg=darkcyan ctermbg=NONE     cterm=reverse

    " Matching parentheses / Visual
    hi MatchParen       ctermfg=NONE     ctermbg=NONE     cterm=bold,underline
    hi VisualNOS        ctermfg=black    ctermbg=darkcyan cterm=NONE
    hi CursorLine       ctermfg=NONE     ctermbg=NONE     cterm=underline
    hi CursorColumn     ctermfg=black    ctermbg=yellow   cterm=NONE

    " Spell checking
    hi SpellBad         ctermfg=red      ctermbg=NONE     cterm=underline
    hi SpellCap         ctermfg=darkcyan ctermbg=NONE     cterm=underline
    hi SpellLocal       ctermfg=green    ctermbg=NONE     cterm=underline
    hi SpellRare        ctermfg=magenta  ctermbg=NONE     cterm=underline

    " Syntax groups
    hi Comment          ctermfg=blue     ctermbg=NONE     cterm=NONE
    hi Constant         ctermfg=magenta  ctermbg=NONE     cterm=NONE
    hi String           ctermfg=yellow   ctermbg=NONE     cterm=NONE
    hi Identifier       ctermfg=NONE     ctermbg=NONE     cterm=NONE
    hi Statement        ctermfg=grey     ctermbg=NONE     cterm=bold
    hi PreProc          ctermfg=cyan     ctermbg=NONE     cterm=NONE
    hi Type             ctermfg=green    ctermbg=NONE     cterm=NONE
    hi Special          ctermfg=darkcyan ctermbg=NONE     cterm=NONE
    hi Title            ctermfg=white    ctermbg=NONE     cterm=bold
    hi Directory        ctermfg=blue     ctermbg=NONE     cterm=bold

    " Diff highlighting
    hi DiffAdd          ctermfg=white    ctermbg=darkmagenta cterm=NONE
    hi DiffChange       ctermfg=white    ctermbg=darkgreen   cterm=NONE
    hi DiffText         ctermfg=black    ctermbg=cyan        cterm=NONE
    hi DiffDelete       ctermfg=darkred   ctermbg=NONE        cterm=NONE
    hi diffAdded        ctermfg=green    ctermbg=NONE        cterm=NONE
    hi diffRemoved      ctermfg=red      ctermbg=NONE        cterm=NONE
    hi diffSubname      ctermfg=magenta  ctermbg=NONE        cterm=NONE

    " netrw and others
    hi dirType                  ctermfg=magenta  ctermbg=NONE cterm=NONE
    hi dirPermissionUser        ctermfg=green    ctermbg=NONE cterm=NONE
    hi dirPermissionGroup       ctermfg=yellow   ctermbg=NONE cterm=NONE
    hi dirPermissionOther       ctermfg=darkcyan ctermbg=NONE cterm=NONE
    hi dirOwner                 ctermfg=darkgrey ctermbg=NONE cterm=NONE
    hi dirGroup                 ctermfg=darkgrey ctermbg=NONE cterm=NONE
    hi dirTime                  ctermfg=darkgrey ctermbg=NONE cterm=NONE
    hi dirSize                  ctermfg=yellow   ctermbg=NONE cterm=NONE
    hi dirSizeMod               ctermfg=magenta  ctermbg=NONE cterm=NONE
    hi FilterMenuDirectorySubtle ctermfg=white   ctermbg=NONE cterm=NONE
    hi dirFilterMenuBookmarkPath ctermfg=white   ctermbg=NONE cterm=NONE
    hi dirFilterMenuHistoryPath  ctermfg=white   ctermbg=NONE cterm=NONE
    hi FilterMenuLineNr         ctermfg=white   ctermbg=NONE cterm=NONE
    hi CocSearch                ctermfg=blue    ctermbg=NONE cterm=NONE

  else
    " Basic UI
    hi Normal            ctermfg=black     ctermbg=white     cterm=NONE
    hi Statusline        ctermfg=white     ctermbg=black     cterm=bold
    hi StatuslineNC      ctermfg=white     ctermbg=darkgrey  cterm=NONE
    hi VertSplit         ctermfg=darkgrey  ctermbg=darkgrey  cterm=NONE
    hi TabLine           ctermfg=black     ctermbg=lightgrey cterm=NONE
    hi TabLineFill       ctermfg=NONE      ctermbg=darkgrey  cterm=NONE
    hi TabLineSel        ctermfg=white     ctermbg=black     cterm=bold,reverse
    hi ToolbarLine       ctermfg=NONE      ctermbg=NONE      cterm=NONE
    hi ToolbarButton     ctermfg=white     ctermbg=black     cterm=NONE

    " QuickFix / Line numbers
    hi QuickFixLine      ctermfg=white     ctermbg=blue      cterm=NONE
    hi CursorLineNr      ctermfg=black     ctermbg=NONE      cterm=bold
    hi LineNr            ctermfg=darkgrey  ctermbg=NONE      cterm=NONE
    hi NonText           ctermfg=darkgrey  ctermbg=NONE      cterm=NONE
    hi FoldColumn        ctermfg=darkgrey  ctermbg=NONE      cterm=NONE
    hi SpecialKey        ctermfg=darkgrey  ctermbg=NONE      cterm=NONE
    hi EndOfBuffer       ctermfg=darkgrey  ctermbg=NONE      cterm=NONE

    " Popup menu
    hi Pmenu             ctermfg=black     ctermbg=grey      cterm=NONE
    hi PmenuThumb        ctermfg=NONE      ctermbg=darkgreen cterm=NONE
    hi PmenuSbar         ctermfg=NONE      ctermbg=NONE      cterm=NONE
    hi PmenuSel          ctermfg=black     ctermbg=darkcyan  cterm=NONE
    hi PmenuKind         ctermfg=darkred   ctermbg=grey      cterm=NONE
    hi PmenuKindSel      ctermfg=darkred   ctermbg=darkcyan  cterm=NONE
    hi PmenuExtra        ctermfg=black     ctermbg=grey      cterm=NONE
    hi PmenuExtraSel     ctermfg=black     ctermbg=darkcyan  cterm=NONE

    " Messages / Errors
    hi Error             ctermfg=white     ctermbg=red       cterm=NONE
    hi ErrorMsg          ctermfg=white     ctermbg=red       cterm=NONE
    hi WarningMsg        ctermfg=red       ctermbg=NONE      cterm=bold
    hi ModeMsg           ctermfg=yellow    ctermbg=black     cterm=reverse
    hi MoreMsg           ctermfg=darkgreen ctermbg=NONE      cterm=bold
    hi Question          ctermfg=darkmagenta ctermbg=NONE    cterm=bold
    hi Todo              ctermfg=cyan      ctermbg=white     cterm=reverse

    " Search highlights
    hi Search            ctermfg=black     ctermbg=yellow    cterm=NONE
    hi IncSearch         ctermfg=black     ctermbg=green     cterm=NONE
    hi CurSearch         ctermfg=black     ctermbg=green     cterm=NONE
    hi WildMenu          ctermfg=black     ctermbg=yellow    cterm=bold

    " Debugging
    hi debugPC           ctermfg=darkblue  ctermbg=NONE      cterm=reverse
    hi debugBreakpoint   ctermfg=darkcyan  ctermbg=NONE      cterm=reverse

    " Matching parentheses / Visual
    hi MatchParen        ctermfg=NONE      ctermbg=NONE      cterm=bold,underline
    hi VisualNOS         ctermfg=black     ctermbg=cyan      cterm=NONE
    hi CursorLine        ctermfg=NONE      ctermbg=NONE      cterm=underline
    hi CursorColumn      ctermfg=black     ctermbg=yellow    cterm=NONE

    " Spell checking
    hi SpellBad          ctermfg=darkred   ctermbg=NONE      cterm=underline
    hi SpellCap          ctermfg=darkcyan  ctermbg=NONE      cterm=underline
    hi SpellLocal        ctermfg=darkgreen ctermbg=NONE      cterm=underline
    hi SpellRare         ctermfg=magenta   ctermbg=NONE      cterm=underline

    " Syntax groups
    hi Comment           ctermfg=darkblue  ctermbg=NONE      cterm=NONE
    hi Constant          ctermfg=darkmagenta ctermbg=NONE    cterm=NONE
    hi String            ctermfg=darkyellow ctermbg=NONE     cterm=NONE
    hi Identifier        ctermfg=NONE      ctermbg=NONE      cterm=NONE
    hi Statement         ctermfg=black     ctermbg=NONE      cterm=bold
    hi PreProc           ctermfg=darkcyan  ctermbg=NONE      cterm=NONE
    hi Type              ctermfg=darkgreen ctermbg=NONE      cterm=NONE
    hi Special           ctermfg=cyan      ctermbg=NONE      cterm=NONE
    hi Title             ctermfg=black     ctermbg=NONE      cterm=bold
    hi Directory         ctermfg=darkblue  ctermbg=NONE      cterm=bold

    " Diff highlighting
    hi DiffAdd           ctermfg=black     ctermbg=darkmagenta cterm=NONE
    hi DiffChange        ctermfg=black     ctermbg=lightgrey   cterm=NONE
    hi DiffText          ctermfg=black     ctermbg=cyan        cterm=NONE
    hi DiffDelete        ctermfg=darkred   ctermbg=NONE        cterm=NONE
    hi diffAdded         ctermfg=darkgreen ctermbg=NONE        cterm=NONE
    hi diffRemoved       ctermfg=red       ctermbg=NONE        cterm=NONE
    hi diffSubname       ctermfg=darkmagenta ctermbg=NONE      cterm=NONE

    " netrw and others
    hi dirType                   ctermfg=darkcyan    ctermbg=NONE cterm=NONE
    hi dirPermissionUser         ctermfg=darkyellow  ctermbg=NONE cterm=NONE
    hi dirPermissionGroup        ctermfg=darkgreen   ctermbg=NONE cterm=NONE
    hi dirPermissionOther        ctermfg=darkmagenta ctermbg=NONE cterm=NONE
    hi dirOwner                  ctermfg=grey        ctermbg=NONE cterm=NONE
    hi dirGroup                  ctermfg=grey        ctermbg=NONE cterm=NONE
    hi dirTime                   ctermfg=grey        ctermbg=NONE cterm=NONE
    hi dirSize                   ctermfg=darkred     ctermbg=NONE cterm=NONE
    hi dirSizeMod                ctermfg=darkcyan    ctermbg=NONE cterm=NONE
    hi FilterMenuDirectorySubtle ctermfg=darkgrey    ctermbg=NONE cterm=NONE
    hi dirFilterMenuBookmarkPath ctermfg=darkgrey    ctermbg=NONE cterm=NONE
    hi dirFilterMenuHistoryPath  ctermfg=darkgrey    ctermbg=NONE cterm=NONE
    hi FilterMenuLineNr          ctermfg=darkgrey    ctermbg=NONE cterm=NONE
    hi CocSearch                 ctermfg=darkred     ctermbg=NONE cterm=NONE
  endif
  unlet s:t_Co
  finish
endif

if s:t_Co >= 8
  if &background ==# 'dark'
    hi Normal ctermfg=grey ctermbg=black cterm=NONE
    hi Statusline ctermfg=grey ctermbg=black cterm=bold,reverse
    hi StatuslineNC ctermfg=black ctermbg=grey cterm=NONE
    hi VertSplit ctermfg=grey ctermbg=grey cterm=NONE
    hi TabLine ctermfg=grey ctermbg=black cterm=reverse
    hi TabLineFill ctermfg=NONE ctermbg=grey cterm=NONE
    hi TabLineSel ctermfg=grey ctermbg=black cterm=NONE
    hi ToolbarLine ctermfg=NONE ctermbg=NONE cterm=NONE
    hi ToolbarButton ctermfg=grey ctermbg=black cterm=bold,reverse
    hi QuickFixLine ctermfg=grey ctermbg=darkblue cterm=bold
    hi CursorLineNr ctermfg=black ctermbg=NONE cterm=bold
    hi LineNr ctermfg=darkyellow ctermbg=NONE cterm=NONE
    hi NonText ctermfg=grey ctermbg=NONE cterm=NONE
    hi FoldColumn ctermfg=grey ctermbg=NONE cterm=NONE
    hi EndOfBuffer ctermfg=grey ctermbg=NONE cterm=NONE
    hi SpecialKey ctermfg=grey ctermbg=NONE cterm=NONE
    hi Pmenu ctermfg=black ctermbg=grey cterm=NONE
    hi PmenuThumb ctermfg=NONE ctermbg=darkgreen cterm=NONE
    hi PmenuSbar ctermfg=NONE ctermbg=NONE cterm=NONE
    hi PmenuSel ctermfg=black ctermbg=darkcyan cterm=NONE
    hi PmenuKind ctermfg=darkred ctermbg=grey cterm=NONE
    hi PmenuKindSel ctermfg=darkred ctermbg=darkcyan cterm=NONE
    hi PmenuExtra ctermfg=black ctermbg=grey cterm=NONE
    hi PmenuExtraSel ctermfg=black ctermbg=darkcyan cterm=NONE
    hi SignColumn ctermfg=NONE ctermbg=NONE cterm=NONE
    hi Error ctermfg=grey ctermbg=darkred cterm=NONE
    hi ErrorMsg ctermfg=grey ctermbg=darkred cterm=NONE
    hi ModeMsg ctermfg=darkyellow ctermbg=black cterm=reverse
    hi MoreMsg ctermfg=darkgreen ctermbg=NONE cterm=NONE
    hi Question ctermfg=darkmagenta ctermbg=NONE cterm=NONE
    hi WarningMsg ctermfg=darkred ctermbg=NONE cterm=NONE
    hi Todo ctermfg=darkcyan ctermbg=black cterm=reverse
    hi Search ctermfg=darkyellow ctermbg=black cterm=reverse
    hi IncSearch ctermfg=darkgreen ctermbg=black cterm=reverse
    hi CurSearch ctermfg=darkgreen ctermbg=black cterm=reverse
    hi WildMenu ctermfg=black ctermbg=darkyellow cterm=bold
    hi debugPC ctermfg=darkblue ctermbg=NONE cterm=reverse
    hi debugBreakpoint ctermfg=darkcyan ctermbg=NONE cterm=reverse
    hi Visual ctermfg=NONE ctermbg=NONE cterm=reverse
    hi MatchParen ctermfg=magenta ctermbg=NONE cterm=bold
    hi VisualNOS ctermfg=black ctermbg=darkcyan cterm=NONE
    hi CursorLine ctermfg=NONE ctermbg=NONE cterm=underline
    hi CursorColumn ctermfg=black ctermbg=darkyellow cterm=NONE
    hi Folded ctermfg=black ctermbg=darkyellow cterm=NONE
    hi ColorColumn ctermfg=black ctermbg=darkyellow cterm=NONE
    hi SpellBad ctermfg=darkred ctermbg=NONE cterm=reverse,underline
    hi SpellCap ctermfg=darkcyan ctermbg=NONE cterm=reverse,underline
    hi SpellLocal ctermfg=darkgreen ctermbg=black cterm=reverse,underline
    hi SpellRare ctermfg=darkmagenta ctermbg=NONE cterm=reverse,underline
    hi Comment ctermfg=darkblue ctermbg=NONE cterm=NONE
    hi Constant ctermfg=darkred ctermbg=NONE cterm=NONE
    hi Identifier ctermfg=NONE ctermbg=NONE cterm=NONE
    hi Statement ctermfg=grey ctermbg=NONE cterm=bold
    hi Type ctermfg=darkgreen ctermbg=NONE cterm=NONE
    hi PreProc ctermfg=darkcyan ctermbg=NONE cterm=NONE
    hi Special ctermfg=darkcyan ctermbg=NONE cterm=NONE
    hi Underlined ctermfg=NONE ctermbg=NONE cterm=underline
    hi Title ctermfg=NONE ctermbg=NONE cterm=bold
    hi Directory ctermfg=darkblue ctermbg=NONE cterm=bold
    hi Conceal ctermfg=NONE ctermbg=NONE cterm=NONE
    hi Ignore ctermfg=NONE ctermbg=NONE cterm=NONE
    hi DiffAdd ctermfg=white ctermbg=darkmagenta cterm=NONE
    hi DiffChange ctermfg=white ctermbg=darkgreen cterm=NONE
    hi DiffText ctermfg=black ctermbg=grey cterm=NONE
    hi DiffDelete ctermfg=darkred ctermbg=NONE cterm=NONE
  else
    " Light background
    hi Normal ctermfg=black ctermbg=grey cterm=NONE
    hi Statusline ctermfg=grey ctermbg=black cterm=bold
    hi StatuslineNC ctermfg=grey ctermbg=darkgrey cterm=NONE
    hi VertSplit ctermfg=black ctermbg=black cterm=NONE
    hi TabLine ctermfg=black ctermbg=grey cterm=reverse
    hi TabLineFill ctermfg=NONE ctermbg=darkgrey cterm=NONE
    hi TabLineSel ctermfg=black ctermbg=grey cterm=NONE
    hi ToolbarLine ctermfg=NONE ctermbg=NONE cterm=NONE
    hi ToolbarButton ctermfg=grey ctermbg=black cterm=bold
    hi QuickFixLine ctermfg=grey ctermbg=darkblue cterm=bold
    hi CursorLineNr ctermfg=black ctermbg=NONE cterm=bold
    hi LineNr ctermfg=darkyellow ctermbg=NONE cterm=NONE
    hi NonText ctermfg=black ctermbg=NONE cterm=NONE
    hi FoldColumn ctermfg=black ctermbg=NONE cterm=NONE
    hi EndOfBuffer ctermfg=black ctermbg=NONE cterm=NONE
    hi SpecialKey ctermfg=black ctermbg=NONE cterm=NONE
    hi Pmenu ctermfg=grey ctermbg=black cterm=NONE
    hi PmenuThumb ctermfg=NONE ctermbg=darkgreen cterm=NONE
    hi PmenuSbar ctermfg=NONE ctermbg=NONE cterm=NONE
    hi PmenuSel ctermfg=NONE ctermbg=darkcyan cterm=NONE
    hi PmenuKind ctermfg=darkred ctermbg=black cterm=NONE
    hi PmenuKindSel ctermfg=darkred ctermbg=darkcyan cterm=NONE
    hi PmenuExtra ctermfg=grey ctermbg=black cterm=NONE
    hi PmenuExtraSel ctermfg=black ctermbg=darkcyan cterm=NONE
    hi SignColumn ctermfg=NONE ctermbg=NONE cterm=NONE
    hi Error ctermfg=grey ctermbg=darkred cterm=NONE
    hi ErrorMsg ctermfg=grey ctermbg=darkred cterm=NONE
    hi ModeMsg ctermfg=darkyellow ctermbg=black cterm=reverse
    hi MoreMsg ctermfg=darkgreen ctermbg=NONE cterm=NONE
    hi Question ctermfg=darkmagenta ctermbg=NONE cterm=NONE
    hi WarningMsg ctermfg=darkred ctermbg=NONE cterm=NONE
    hi Todo ctermfg=darkcyan ctermbg=black cterm=reverse
    hi Search ctermfg=black ctermbg=darkyellow cterm=NONE
    hi IncSearch ctermfg=black ctermbg=darkgreen cterm=NONE
    hi CurSearch ctermfg=black ctermbg=darkgreen cterm=NONE
    hi WildMenu ctermfg=black ctermbg=darkyellow cterm=bold
    hi debugPC ctermfg=darkblue ctermbg=NONE cterm=reverse
    hi debugBreakpoint ctermfg=darkcyan ctermbg=NONE cterm=reverse
    hi Visual ctermfg=NONE ctermbg=NONE cterm=reverse
    hi MatchParen ctermfg=magenta ctermbg=NONE cterm=bold
    hi VisualNOS ctermfg=black ctermbg=darkcyan cterm=NONE
    hi CursorLine ctermfg=NONE ctermbg=NONE cterm=underline
    hi CursorColumn ctermfg=black ctermbg=darkyellow cterm=NONE
    hi Folded ctermfg=black ctermbg=darkyellow cterm=NONE
    hi ColorColumn ctermfg=black ctermbg=darkyellow cterm=NONE
    hi SpellBad ctermfg=darkred ctermbg=NONE cterm=reverse,underline
    hi SpellCap ctermfg=darkcyan ctermbg=NONE cterm=reverse,underline
    hi SpellLocal ctermfg=darkgreen ctermbg=black cterm=reverse,underline
    hi SpellRare ctermfg=darkmagenta ctermbg=NONE cterm=reverse,underline
    hi Comment ctermfg=darkblue ctermbg=NONE cterm=NONE
    hi Constant ctermfg=darkred ctermbg=NONE cterm=NONE
    hi Identifier ctermfg=NONE ctermbg=NONE cterm=NONE
    hi Statement ctermfg=black ctermbg=NONE cterm=bold
    hi Type ctermfg=darkgreen ctermbg=NONE cterm=NONE
    hi PreProc ctermfg=darkcyan ctermbg=NONE cterm=NONE
    hi Special ctermfg=darkcyan ctermbg=NONE cterm=NONE
    hi Underlined ctermfg=NONE ctermbg=NONE cterm=underline
    hi Title ctermfg=black ctermbg=NONE cterm=bold
    hi Directory ctermfg=darkblue ctermbg=NONE cterm=bold
    hi Conceal ctermfg=NONE ctermbg=NONE cterm=NONE
    hi Ignore ctermfg=NONE ctermbg=NONE cterm=NONE
    hi DiffAdd ctermfg=black ctermbg=darkmagenta cterm=NONE
    hi DiffChange ctermfg=black ctermbg=darkcyan cterm=NONE
    hi DiffText ctermfg=grey ctermbg=black cterm=NONE
    hi DiffDelete ctermfg=darkred ctermbg=NONE cterm=NONE
  endif
  unlet s:t_Co
  finish
endif

if s:t_Co >= 0
  hi Normal term=NONE
  hi ColorColumn term=reverse
  hi Conceal term=NONE
  hi Cursor term=reverse
  hi CursorColumn term=NONE
  hi CursorLine term=underline
  hi CursorLineNr term=bold
  hi DiffAdd term=reverse
  hi DiffChange term=NONE
  hi DiffDelete term=reverse
  hi DiffText term=reverse
  hi Directory term=NONE
  hi EndOfBuffer term=NONE
  hi ErrorMsg term=bold,reverse
  hi FoldColumn term=NONE
  hi Folded term=NONE
  hi IncSearch term=bold,reverse,underline
  hi LineNr term=NONE
  hi MatchParen term=bold,underline
  hi ModeMsg term=bold
  hi MoreMsg term=NONE
  hi NonText term=NONE
  hi Pmenu term=reverse
  hi PmenuSbar term=reverse
  hi PmenuSel term=bold
  hi PmenuThumb term=NONE
  hi Question term=standout
  hi Search term=reverse
  hi SignColumn term=reverse
  hi SpecialKey term=bold
  hi SpellBad term=underline
  hi SpellCap term=underline
  hi SpellLocal term=underline
  hi SpellRare term=underline
  hi StatusLine term=bold,reverse
  hi StatusLineNC term=bold,underline
  hi TabLine term=bold,underline
  hi TabLineFill term=NONE
  hi Terminal term=NONE
  hi TabLineSel term=bold,reverse
  hi Title term=NONE
  hi VertSplit term=NONE
  hi Visual term=reverse
  hi VisualNOS term=NONE
  hi WarningMsg term=standout
  hi WildMenu term=bold
  hi CursorIM term=NONE
  hi ToolbarLine term=reverse
  hi ToolbarButton term=bold,reverse
  hi CurSearch term=reverse
  hi CursorLineFold term=underline
  hi CursorLineSign term=underline
  hi Comment term=bold
  hi Constant term=NONE
  hi Error term=bold,reverse
  hi Identifier term=NONE
  hi Ignore term=NONE
  hi PreProc term=NONE
  hi Special term=NONE
  hi Statement term=NONE
  hi Todo term=bold,reverse
  hi Type term=NONE
  hi Underlined term=underline
  unlet s:t_Co
  finish
endif

" Background: any
" Background: dark
" Color: color00                 #000000        16             black
" Color: color08                 #767676        243            darkgrey
" Color: color01                 #AF5F5F        131            darkred
" Color: color09                 #FF5F5F        203            red
" Color: color02                 #5FAF5F        71             darkgreen
" Color: color10                 #5FD75F        77             green
" Color: color03                 #AF875F        137            darkyellow
" Color: color11                 #FFD787        222            yellow
" Color: color04                 #5F87AF        67             darkblue
" Color: color12                 #5FAFFF        75             blue
" Color: color05                 #D787D7        176            darkmagenta
" Color: color13                 #FF87FF        213            magenta
" Color: color06                 #5FAFAF        73             darkcyan
" Color: color14                 #5FD7D7        116            cyan
" Color: color07                 #C6C6C6        251            grey
" Color: color15                 #FFFFFF        231            white
" Color: colorDimWhite           #E4E4E4        254            grey
" Color: colorLine               #262626        235            darkgrey
" Color: colorB                  #303030        236            darkgrey
" Color: colorNonT               #585858        240            grey
" Color: colorTab                #585858        240            grey
" Color: colorC                  #FFFFFF        231            white
" Color: colorlC                 #FF5FFF        207            magenta
" Color: colorV                  #005F87        24             darkblue
" Color: colorMP                 #ff00af        199            magenta
" Color: colorPMenuSel           #4e4e4e        239            darkcyan
" Color: colorDim                #878787        102            grey
" Color: diffAdd                 #875f87        96             darkmagenta
" Color: diffDelete              #D78787        174            darkred
" Color: diffChange              #5f5f5f        59             darkgreen
" Color: diffText                #5f8787        66             cyan
" Color: fgDiffText              #afffff        159            black
" Color: fgDiff                  #C6C6C6        251            white
" Term colors: color00 color01 color02 color03 color04 color05 color06 color07
" Term colors: color08 color09 color10 color11 color12 color13 color14 color15
" Background: light
" Color: color00                 #000000        16             black
" Color: color08                 #767676        243            darkgrey
" Color: color01                 #AF0000        124            darkred
" Color: color09                 #D70000        160            red
" Color: color02                 #008700        28             darkgreen
" Color: color10                 #87D787        114            green
" Color: color03                 #AF5F00        130            darkyellow
" Color: color11                 #FFD787        222            yellow
" Color: color04                 #005FD7        26             darkblue
" Color: color12                 #0087D7        32             blue
" Color: color05                 #AF00AF        127            darkmagenta
" Color: color13                 #FF00FF        133            magenta
" Color: color06                 #005F5F        23             darkcyan
" Color: color14                 #008787        30             cyan
" Color: color07                 #808080        244            grey
" Color: color15                 #FFFFFF        231            white
" Color: colorLine               #EEEEEE        255            grey
" Color: colorB                  #E4E4E4        254            grey
" Color: colorNonT               #9E9E9E        247            darkgrey
" Color: colorTab                #BCBCBC        250            lightgrey
" Color: colorC                  #000000        16             black
" Color: colorlC                 #FF00FF        201            magenta
" Color: colorV                  #5F87AF        67             darkblue
" Color: colorMP                 #ff00af        199            magenta
" Color: colorPMenuSel           #C6C6C6        251            darkcyan
" Color: colorDim                #626262        241            darkgrey
" Color: diffAdd                 #D7AFD7        182            darkmagenta
" Color: diffDelete              #870000        88             darkred
" Color: diffChange              #D0D0D0        252            lightgray
" Color: diffText                #5FD7D7        80             cyan
" Color: fgDiff                  #000000        16             black
" Term colors: color00 color01 color02 color03 color04 color05 color06 color07
" Term colors: color08 color09 color10 color11 color12 color13 color14 color15
" Background: any
" vim: et ts=8 sw=2 sts=2
"
"

