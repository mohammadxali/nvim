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
" Make the yanked region apparent (200ms highlight)
au TextYankPost * silent! lua vim.highlight.on_yank{ timeout=200 }

if (!exists('g:vscode'))
    " Enable relative numbers
    set relativenumber
    set number
endif


"--------------------------
"|        Mappings        |
"--------------------------

" Map leader to space key
" https://stackoverflow.com/a/446293/6622233
nnoremap <SPACE> <Nop>
let mapleader=" "
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
" Enable camelCaseMotion for Leader key
let g:camelcasemotion_key = '<leader>'


"--------------------------
"|         Plugins        |
"--------------------------
call plug#begin(stdpath('data') . '/plugged')

Plug 'michaeljsmith/vim-indent-object'
Plug 'tpope/vim-surround'
Plug 'justinmk/vim-sneak'
Plug 'bkad/CamelCaseMotion'

if (!exists('g:vscode'))
    Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    Plug 'neovim/nvim-lspconfig'
endif

call plug#end()

" Attach `init.lua` inside `lua` folder
lua require("init")