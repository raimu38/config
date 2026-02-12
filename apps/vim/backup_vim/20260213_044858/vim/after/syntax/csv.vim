function! s:SetupCSVHighlight() abort
  let colors = [
        \ '#79c0ff',
        \ '#56d364',
        \ '#ff7b72',
        \ '#f0883e',
        \ '#d2a8ff',
        \ '#2f81f7',
        \ '#f78166'
        \ ]

  " 列の最大数を検出
  let max_cols = 0
  for line in getline(1, '$')
    let col_count = len(split(line, ',')) - 1
    if col_count > max_cols
      let max_cols = col_count
    endif
  endfor
  let num_cols = max_cols + 1

  " 各列にハイライトグループを割り当て
  for i in range(num_cols)
    let group = 'csvCol' . (i + 1)
    let pat   = '\v^([^,]*,){' . i . '}[^,]*'
    let color = colors[i % len(colors)]
    execute 'syntax match ' . group . ' /' . pat . '/ containedin=ALL'
    execute 'highlight ' . group . ' guifg=' . color . ' ctermfg=' . (160 + (i % len(colors)))
  endfor
endfunction

" CSVファイルを開いたときに関数を実行
call s:SetupCSVHighlight()
