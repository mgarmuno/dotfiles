call plug#begin('~/.vim/plugged')

Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

call plug#end()

set tabstop=4
set softtabstop=0 noexpandtab
set shiftwidth=4
