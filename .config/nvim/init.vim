" Initialize vim-plug and specify dependencies.
call plug#begin(stdpath('data') . '/plugged')

" Theme and Lightline
Plug 'haishanh/night-owl.vim'
Plug 'itchyny/lightline.vim'

" Non-theme plugins
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'ntpeters/vim-better-whitespace'
Plug 'tpope/vim-surround'

call plug#end()

"==============================================================================
"   NeoVim Settings
"==============================================================================

" Basic keymaps (plugin-specific keymaps may be defined elsewhere)
inoremap jk <esc>
nnoremap <silent> gW :tabclose!<cr>
nnoremap <silent> gw :tabclose<cr>
nnoremap <silent> gh :tabprev<cr>
nnoremap <silent> gj :tabnext<cr>
nnoremap <silent> gt :tabnew<cr>
nnoremap <silent> <space> za
noremap i gk
noremap j h
noremap k gj
noremap I {
noremap K }
noremap h i
noremap H I
" <C-I> is the same as <Tab> and <Tab> is configured for coc-rust-analyzer below.
" inoremap <C-K> <Down>

" Theme and syntax
if (has("termguicolors"))
    set termguicolors
endif

syntax enable
colorscheme night-owl
let g:lightline = { 'colorscheme': 'nightowl' }

" Indentation, spaces, tabs
filetype plugin indent on
set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=8

" User interface configurations
set colorcolumn=120  " Set vertical color line at this column
set cursorline       " Highlight the current row where the cursor is
set lazyredraw       " Screen will not be redrawn while running macros, it should update after
set nocompatible     " Legacy flag. vim runs in a mode not compatible with vi.  NeoVim is always nocompatible.
set noerrorbells     " Don't play a bell sound or flash the screen when there are errors.
set number           " Show line numbers
set ruler            " Show the line number and character column in the status line or last line of screen.
set scrolloff=5      " Minimum number of lines to show below and above the cursor.
set showcmd          " Shows the (partial) command recently run at the bottom of the screen.
set showmatch        " Show matches to brackets and parentheses.
set smartcase        " If you have a mIxEd case search term, automatically ignores any ignorecase setting.
set smarttab         " Sensible tab space handling.  Inserts/deletes a `shiftwidth` of spaces when using tab/backspace.
set textwidth=0      " Disable automatically wrapping text after reaching a margin

" Wildcard completion and wild menu
set wildignore=*.pyc,*.so,*.o,*.pkl,*.png,*.pdf
set wildignorecase
set wildmenu
set wildmode=list:longest,full

" Searching
nnoremap <Enter> :set hlsearch!<cr>
set hlsearch!                        " Start with search terms unhighlighted
set incsearch                        " Show search matches immediately as it is being typed

" Edit settings
set backspace=indent,eol,start   " Allows the backspace to work normally/as expected
set directory=/tmp               " Swapfiles go here
set swapfile                     " Enables vim to use a swapfile for the buffer
set pastetoggle=<F2><F2>         " Toggles PASTE mode
let &t_TI = "\<Esc>[>4;2m"
let &t_TE = "\<Esc>[>4;m"

" Clipboard settings
set clipboard^=unnamed,unnamedplus        " The unnamed register `+` is synchronized with the clipboard

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


"==============================================================================
"   Custom plugin settings
"==============================================================================

" *****************************************************************************
" Fzf
" *****************************************************************************
let g:fzf_action = { 'enter': 'tab split' }
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.9 } }

" My addition to the GGrep command from the FZF documentation.
" Git grep already ignores files specified in the .gitignore, but if you want
" to exclude additional paths, it must be added to the `git grep` call.
"
" When referring to exact files, add a wildcard to the end of the name.
" Each path should begin with `:!` or else git grep will treat it like 'includes'.
" If completely empty, remove the entire join() call in the GGrep command below.
let custom_fzf_ggrep_ignore = [
    \ ":!.github/*",
    \ ":!.gitattributes*",
    \ ":!.gitignore*",
    \ ]

command! -bang -nargs=* GGrep
    \ call fzf#vim#grep(
    \    "git grep --line-number -- " . shellescape(<q-args>) . " " .
    \    "'" . join(custom_fzf_ggrep_ignore, "' '") . "'",
    \    0,
    \    fzf#vim#with_preview({'dior': systemlist('git rev-parse --show-toplevel')[0]}), <bang>0
    \ )

nnoremap <C-P> :GFiles<cr>
nnoremap <C-F> :GGrep<cr>

" For navigating the Fzf finder window.
" Note that C-J cannot be remapped.  Don't even try.  See: https://vi.stackexchange.com/a/5255
tnoremap <C-n> <Down>
tnoremap <C-p> <Up>

" *****************************************************************************
" Coc and coc-rust-analyzer
" *****************************************************************************
" See: https://github.com/neoclide/coc.nvim
let g:node_client_debug=1
nmap ca <Plug>(coc-codeaction-cursor)

set encoding=utf-8
set hidden
set cmdheight=2
set updatetime=300
set shortmess+=c
if has("nvim-0.5.0") || has("patch-8.1.1564")
    " Recently vim can merge signcolumn and number column into one
    set signcolumn=number
else
    set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent> <expr> <TAB> pumvisible() ? "\<C-n>" : <SID>check_back_space() ? "\<TAB>" : coc#refresh()
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
    inoremap <silent> <expr> <c-space> coc#refresh()
else
    inoremap <silent> <expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent> <expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Highlight the symbol and its references when holding the cursor.
" autocmd CursorHold * silent call CocActionAsync('highlight')

" *****************************************************************************
" vim-better-whitespace
" *****************************************************************************
let g:strip_whitespace_on_save=1
let g:strip_whitespace_confirm=0
