set encoding=utf-8
scriptencoding utf-8

" indent
set smartindent
set autoindent
set smarttab
set shiftround

" TAB settings
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4

" textwrap
set wrap
set linebreak
set textwidth=0
set colorcolumn=80

" status line
set showcmd
set laststatus=2

" clipboard
set clipboard=unnamed

" max syntax highlight column
set synmaxcol=200

" make new split window on below(v) or right(s)
set splitbelow
set splitright

" zz with search result
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#zz

"colorscheme hybrid
syntax enable

" filetype settings
au BufRead,BufNewFile {*.coffee} set filetype=coffee
autocmd filetype coffee,javascript setlocal shiftwidth=2 softtabstop=2 tabstop=2 expandtab

" open with last cursor position
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\""


