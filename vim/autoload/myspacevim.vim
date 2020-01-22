function! myspacevim#before() abort
  let g:vimfiler_ignore_pattern = [
    \ '^\.',
    \ '^\.git$',
    \ '^\.DS_Store$',
    \ '^__pycache__$',
    \ '\.pyc$'
  \ ]

  let $FZF_DEFAULT_COMMAND = 'ag -g ""'

  let g:loaded_golden_ratio = 1
  nnoremap <space>gr :GoldenRatioResize<CR>
  nnoremap <space>gt :GoldenRatioToggle<CR>
endfunction

function! myspacevim#after() abort
endfunction
