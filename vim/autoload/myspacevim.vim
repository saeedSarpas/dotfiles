function! myspacevim#before() abort
  let g:loaded_golden_ratio = 1
  nnoremap <space>gr :GoldenRatioResize<CR>
  nnoremap <space>gt :GoldenRatioToggle<CR>
endfunction

function! myspacevim#after() abort
endfunction
