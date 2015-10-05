"80 characters line wrap
set colorcolumn=80
set textwidth=80

"Colorscheme
colo wombat256mod
set background=dark

"Key binding
imap jj <ESC>

"Fonts
set guifont:Inconsolata\ 13

"GUI window maps
nmap <tab> <C-w>
nmap <tab><tab> <C-w><C-w>
nmap tt :tabe<CR>
nmap 0 ^

"LaTeX and PdfLaTeX
nmap comp :!pdflatex %<CR>

"NerdTree maps
nmap - :NERDTree<SPACE>.<CR>
nmap no :NERDTreeTabsOpen<CR>

"Save and Exit
nmap qq :q<CR>
nmap sav :w<CR>

"Align
vmap t :'<,'>Tab /=<CR>

"Tab and indentation
filetype plugin indent on
set tabstop=2
set shiftwidth=2
set expandtab

"Vimrc
nmap vim :so $MYVIMRC<CR>

"ng attribute in HTML
"let g:syntastic_html_tidy_ignore_errors=[" proprietary attribute \"ng-"]

"Line number
function! NumberToggle()
    if(&relativenumber == 1)
        set number
    else
        set relativenumber
    endif
endfunc
nnoremap <C-n> :call NumberToggle()<cr>
