call plug#begin('~/.vim/plugged')

Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'SirVer/ultisnips'
Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-fugitive'
Plug 'editorconfig/editorconfig-vim'
Plug 'dracula/vim'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
"Plug 'neoclide/coc.nvim', {'branch': 'release'}
"Plug 'ycm-core/YouCompleteMe'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
"Plug 'xolox/vim-easytags'
Plug 'xolox/vim-misc'
Plug 'PhilRunninger/bufselect.vim'

call plug#end()

"Switch between different windows by their direction`
no <C-j> <C-w>j| "switching to below window
no <C-k> <C-w>k| "switching to above window
no <C-l> <C-w>l| "switching to right window
no <C-h> <C-w>h| "switching to left window

inoremap <C-@> <C-x><C-o>
"inoremap <C-@> <C-Space>

map <C-n> :NERDTreeToggle<CR>
map <C-m> :ShowBufferList<CR>
map <C-f> :Ag<CR>

set clipboard=unnamed
set tabstop=4
set softtabstop=0 noexpandtab
set shiftwidth=4
set relativenumber
setlocal omnifunc=go#complete#Complete

let g:dracula_colorterm = 0
let g:dracula_italic = 0
let g:go_highlight_structs = 1
let g:go_highlight_methods = 1
let g:go_highlight_functions = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
set encoding=utf-8

let g:go_def_mode='gopls'
let g:go_info_mode='gopls'

set termguicolors
syntax on
set ruler
set number
color dracula
colorscheme dracula

"autocmd vimenter * NERDTree
