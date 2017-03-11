execute pathogen#infect()

" Section: Options {{{1
" ---------------------

set nocompatible
set autoindent
set autoread
set autowrite
set backspace=2
set cmdheight=2
set dictionary+=/usr/share/dict/words
set display=lastline
set smartcase
set smarttab
set showmatch
set showcmd

syntax on
set number
set ruler
set tabstop=4
set shiftwidth=4
set expandtab
filetype plugin indent on

" }}}2
" Section: Mappings {{{1
" ----------------------

nnoremap i <Up>
nnoremap j <Left>
nnoremap k <Down>
nnoremap l <Right>
nnoremap J <Home>
nnoremap L <End>
nnoremap <Space> <Insert>
nnoremap U `{
nnoremap O `}

inoremap <C-i> <Up>
inoremap <C-J> <Left>
inoremap <C-k> <Down>
inoremap <C-L> <Right>
inoremap <C-Space> <Esc>
imap <C-@> <C-Space>

vnoremap i <Up>
vnoremap j <Left>
vnoremap k <Down>
vnoremap l <Right>

" }}}3

