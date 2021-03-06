"==============================================================================
"   Pathogen
"==============================================================================

let g:pathogen_disabled = ["black"] " for debugging
execute pathogen#infect()


"==============================================================================
"   Vim Settings
"==============================================================================

" Color Scheme
let g:solarized_termcolors = 256
let g:solarized_termtrans  = 1
let g:solarized_degrade    = 0
let g:solarized_bold       = 1
let g:solarized_underline  = 1
let g:solarized_italic     = 1
let g:solarized_contrast   = "high"
let g:solarized_visibility = "high"
set background=dark
colorscheme solarized
syntax enable

" Indentation, Spaces, and Tabs
filetype plugin indent on
set autoindent
set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=8

" UI Config
set colorcolumn=88
set cursorline
set lazyredraw
set nocompatible
set noerrorbells
set number
set ruler
set scrolloff=5
set showcmd
set showmatch
set smartcase
set smarttab
" set tw=88
set wildignore=*.pyc,*.so,*.o,*.pkl,*.png,*.pdf
set wildignorecase
set wildmenu
set wildmode=list:longest,full

" Searching
nnoremap <Enter> :set hlsearch!<CR>
set hlsearch!
set incsearch

" Movement
inoremap jk <esc>
nnoremap gW :tabclose!<cr>
nnoremap gh :tabprev<cr>
nnoremap gj :tabnext<cr>
nnoremap gt :tabnew<cr>
nnoremap gw :tabclose<cr>
nnoremap <space> za
noremap H I
noremap I {
noremap K }
noremap h <insert>
noremap h i
noremap i gk
noremap j <Left>
noremap k gj

" Edit Settings
set backspace=indent,eol,start
set directory=/tmp
set pastetoggle=<F2><F2>
set swapfile

" Netrw Settings (netrw is the default file explorer in vim)
" The - key will open a new tab with the full explorer
nnoremap - :Texplore<cr>
let g:netrw_banner = 0
let g:netrw_browse_split = 0 " open new files in the current window
let g:netrw_liststyle = 1 " open netrw in a tree format
let g:netrw_preview = 1
" netrw sets its own mappings in the <buffer> which overrides our settings. We need to reset it again
augroup netrw_mappings
    autocmd!
    autocmd filetype netrw call Set_netrw_bindings()
augroup END
function! Set_netrw_bindings()
    noremap <buffer> h i
    noremap <buffer> i gk
    noremap <buffer> j <Left>
    noremap <buffer> k gj
    noremap <buffer> I 5gk
    noremap <buffer> K 5gj
    noremap <buffer> gh :tabprev<cr>
    nmap <buffer> o <cr>
endfunction

" Clipboard Settings
set clipboard=unnamedplus

" Python Syntax for pyi files
au BufRead,BufNewFile *.pyi set filetype=python

"==============================================================================
"   Plugin Settings
"==============================================================================

" black
" let g:black_virtualenv = '~/.local'  " pip install --user black is expected to install here
" autocmd BufWritePre *.py execute ':Black'
" autocmd BufWritePre *.pyi execute ':Black'

" rustfmt
let g:rustfmt_autosave = 1

" ctrlp
cnoremap %% <C-R>=expand('%:h').'/'<cr>
map <leader>F :CtrlP %%<cr>

if executable('rg')
    let g:ctrlp_user_command = 'rg --files %s'
    let g:ctrlp_use_caching = 0
endif

let g:ctrlp_match_window = 'bottom,order:ttb'
let g:ctrlp_switch_buffer = 'Et'
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_prompt_mappings = {
    \ 'PrtSelectMove("j")':   ['<c-k>', '<down>'],
    \ 'PrtSelectMove("k")':   ['<c-i>', '<up>'],
    \ 'AcceptSelection("e")': ['<2-LeftMouse>'],
    \ 'AcceptSelection("t")': ['<cr>', '<c-j>'],
    \ }
let g:ctrlp_show_hidden = 1
let g:ctrlp_custom_ignore = '\v[\/](dist/|node_modules/|*.pyc|_book/|.git/*|static/|.mypy_cache/)'

" lightline-vim
set laststatus=2
let g:lightline = {
    \ 'colorscheme': 'powerline',
    \ 'component': {
    \   'readonly': '%{&readonly?"⭤":""}',
    \ }
    \ }

" tmuxline
let g:tmuxline_powerline_separators = 0
let g:tmuxline_preset = {
    \ 'a' : '#(whoami)',
    \ 'x' : '%l:%M%P',
    \ 'y' : [ '%a %-e %b %Y'],
    \ 'z' : '#H'
    \ }

" vim-better-whitespace
let g:strip_whitespace_on_save = 1
let g:strip_whitespace_confirm=0

" vim-notes
let g:notes_tab_indents = 0

" youcompleteme
let g:ycm_python_binary_path = 'python'
let g:ycm_autoclose_preview_window_after_insertion = 1
nnoremap <C-K> :YcmCompleter GoToDeclaration<cr>

" simpylfold
let g:SimpylFold_docstring_preview = 1
let g:SimpylFold_fold_import = 0

" typescript-vim
let g:typescript_indent_disable = 0

" vim-polyglot
let g:polyglot_disabled = ['javascript', 'json5', 'json', 'jst', 'jsx', 'markdown', 'typescript' ]

set clipboard^=unnamed,unnamedplus

" vim-prettier
let g:prettier#autoformat = 0
" autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.yaml,*.html Prettier

"==============================================================================
"   Useful Functions
"==============================================================================

function Tab2to4()
    set tabstop=2
    set softtabstop=2
    set noexpandtab
    retab!
    set tabstop=4
    set softtabstop=4
    set expandtab
    retab
endfunction

function Tab4to2()
    set tabstop=4
    set softtabstop=4
    set noexpandtab
    retab!
    set tabstop=2
    set softtabstop=2
    set expandtab
    retab
endfunction

map t4 :call Tab2to4() <CR>
map t2 :call Tab4to2() <CR>

"==============================================================================
"==============================================================================
