"--------------------------
"|        Mappings        |
"--------------------------
" Map leader to space key
let mapleader = " "
" Swap K with % in [v]isual mode
vnoremap K %
" Swap % with K in [v]isual mode
vnoremap % K
" Swap K with % in [n]ormal mode
nnoremap K %
" Swap % with K in [n]ormal mode
nnoremap % K

" Re-runs the macro recorded at q on every line in the selection
vnoremap <leader>q :'<,'>normal @q<CR>




"--------------------------
"|        Settings        |
"--------------------------
" Ignore case-sensivity on searches
set ignorecase
" Use case sensitive search if there is a capital letter in the search
set smartcase
" Don't highlight search results
set nohlsearch
" Use system clipboard by default in Windows
set clipboard=unnamed
" Use system clipboard by default in Linux
set clipboard=unnamedplus
" Enable relative numbers 
set relativenumber
" Enable numbers for the currentline
set number

" Make the yanked region apparent (100ms highlight)
au TextYankPost * silent! lua vim.highlight.on_yank{timeout=100}




"--------------------------
"|         Plugins        |
"--------------------------
call plug#begin(stdpath('data') . '/plugged')

" Make sure you use single quotes
Plug 'michaeljsmith/vim-indent-object'
Plug 'tpope/vim-surround'
Plug 'justinmk/vim-sneak'

" Initialize plugin system
call plug#end()