"--------------------------
"|        Mappings        |
"--------------------------
let mapleader = " "        " Map leader to space key
vnoremap K %               " Swap K with % in [v]isual mode
vnoremap % K               " Swap % with K in [v]isual mode
nnoremap K %               " Swap K with % in [n]ormal mode
nnoremap % K               " Swap % with K in [n]ormal mode

" For some reason the above keybindings don't work in the initial run
" So this is a shortcut to run all those remappings again by pressing <leader>,
nnoremap <leader>, :vnoremap K %<CR>:vnoremap % K<CR>:nnoremap K %<CR>:nnoremap % K<CR>

" Re-runs the macro recorded at q on every line in the selection
vnoremap <leader>q :'<,'>normal @q<CR>




"--------------------------
"|        Settings        |
"--------------------------
set ignorecase            " Ignore case on searches
set smartcase             " Use case sensitive search if there is a capital letter in the search
set nohlsearch            " Don't highlight search results
set clipboard=unnamed     " Use system clipboard by default in Windows
set clipboard=unnamedplus " Use system clipboard by default in Linux

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