set mouse=a
set clipboard+=unnamedplus
"set clipboard=unnamed
syntax on
set number
set ts=4 sw=4
set wrap
set relativenumber

" Settings tabs to space
:set tabstop=4
:set shiftwidth=4
:set expandtab

set ttimeoutlen=5

" Specify a directory for plugins
" Install plugins:  :PlugInstall
call plug#begin('~/.vim/plugged')

Plug 'vim-airline/vim-airline'				 " Staus bar
Plug 'https://github.com/neoclide/coc.nvim'  " Auto Completion
Plug 'https://github.com/preservim/nerdtree' " NerdTree


" Initialize plugin system
call plug#end()

nnoremap <C-d> :NERDTreeToggle<CR>

" Map autocomplete to tab
inoremap <silent><expr> <tab> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<TAB>"

" Tmux tab names
autocmd BufReadPost,FileReadPost,BufNewFile * call system("tmux rename-window " . expand("%"))
autocmd VimLeave * call system("tmux setw automatic-rename")


