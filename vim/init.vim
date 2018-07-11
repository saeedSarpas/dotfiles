"=============================================================================
" dark_powered.vim --- Dark powered mode of SpaceVim
" Copyright (c) 2016-2017 Wang Shidong & Contributors
" Author: Wang Shidong < wsdjeg at 163.com >
" URL: https://spacevim.org
" License: GPLv3
"=============================================================================


" SpaceVim Options: {{{
let g:spacevim_enable_debug = 1
let g:spacevim_realtime_leader_guide = 1
let g:spacevim_buffer_index_type = 1

" Smart close
let g:spacevim_windows_smartclose = ''

" VimFiler
let g:spacevim_enable_vimfiler_welcome = 1

" Font
let g:spacevim_guifont = 'Inconsolata\ 14'

" Theme
let g:spacevim_enable_guicolors = 0
let g:spacevim_colorscheme = 'onedark'
let g:spacevim_statusline_separator = 'fire'
let g:spacevim_enable_os_fileformat_icon = 1
let g:spacevim_enable_tabline_filetype_icon = 1
let g:spacevim_enable_statusline_display_mode = 1

" Neomake C/C++
let g:neomake_c_enabled_neomake = 1
let g:neomake_c_enabled_makers = ['gcc']

let g:neomake_cpp_enabled_neomake = 1
let g:neomake_cpp_enabled_makers = ['g++']

let g:neomake_c_clang_args = ['-Wall', '-std=c11']
let g:neomake_cpp_clang_args = ['-Wall', '-std=c++11']

for dir in split(globpath('./lib', '*'))
  let g:neomake_c_clang_args = [
        \ '-I', './lib/' . substitute(dir, './lib/', '', '') . '/include'
        \ ] + g:neomake_c_clang_args
  let g:neomake_cpp_clang_args = [
        \ '-I', './lib/' . substitute(dir, './lib/', '', '') . '/include'
        \ ] + g:neomake_c_clang_args
endfor

" Neomake Fortran
let g:neomake_fortran_enabled_makers = ['gfortran']
let g:neomake_fortran_gfortran_args = [
      \ '-fsyntax-only',
      \ '-Wall', '-Wextra',
      \ '-J ./include',
      \ '-ffree-line-length-none'
      \ ]

" Custom plugins
let g:spacevim_custom_plugins = [
      \ ['joshdick/onedark.vim'],
      \ ['ryanoasis/vim-devicons'],
      \ ]
" }}}

" SpaceVim Layers: {{{
call SpaceVim#layers#load('default')
call SpaceVim#layers#load('autocomplete')
call SpaceVim#layers#load('checkers')
call SpaceVim#layers#load('ctrlp')
call SpaceVim#layers#load('git')
call SpaceVim#layers#load('shell')
call SpaceVim#layers#load('lang')
call SpaceVim#layers#load('lang#c')
call SpaceVim#layers#load('lang#haskell')
call SpaceVim#layers#load('lang#javascript')
call SpaceVim#layers#load('lang#json')
call SpaceVim#layers#load('lang#markdown')
call SpaceVim#layers#load('lang#python')
call SpaceVim#layers#load('lang#rust')
call SpaceVim#layers#load('lang#vim')
" }}}

