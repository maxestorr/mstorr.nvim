"           ██
"          ░░
"  ██    ██ ██ ██████████  ██████  █████
" ░██   ░██░██░░██░░██░░██░░██░░█ ██░░░██
" ░░██ ░██ ░██ ░██ ░██ ░██ ░██ ░ ░██  ░░
"  ░░████  ░██ ░██ ░██ ░██ ░██   ░██   ██
"   ░░██   ░██ ███ ░██ ░██░███   ░░█████
"    ░░    ░░ ░░░  ░░  ░░ ░░░     ░░░░░
"
" Config for Neovim
" Author: maxestorr@github.com

"--------------------------------------------------------------------------
" General settings
"--------------------------------------------------------------------------

set mouse=a
set number
set relativenumber
set splitright
set splitbelow
set scrolloff=8
set sidescrolloff=8
set tabstop=8
set shiftwidth=4
set expandtab
set nowrap
set showmatch
set colorcolumn=80
set noerrorbells
set ignorecase
set smartcase
"set clipboard=unnamedplus " Started disliking this setting
set undofile
set undolevels=1000
set undoreload=1000
set dir=~/.cache/vim/swaps
set undodir=~/.cache/vim/undodir
filetype on
filetype plugin on
syntax on

set hidden
set wildmode=longest:full,full
set signcolumn=yes:2

"--------------------------------------------------------------------------
" Key maps
"--------------------------------------------------------------------------

" Leader and easier to access command mode
let mapleader = "\<space>"
nmap <leader>ve :edit ~/.config/nvim/init.vim<cr>
nmap <leader>vc :edit ~/.config/nvim/plugins/coc.vim<cr>
nmap <leader>vr :source ~/.config/nvim/init.vim<cr>
nmap <leader>k :nohlsearch<CR>

" Cntrl + vim directional key to navigate splits
nnoremap <C-J> <C-W><C-j>
nnoremap <C-K> <C-W><C-k>
nnoremap <C-L> <C-W><C-l>
nnoremap <C-H> <C-W><C-h>


" Sensible operations
nnoremap Y y$
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap J mzJ`z
vnoremap < <gv
vnoremap > >gv

" jk to exit insert mode
inoremap jk <esc>

" When text is wrapped, move by terminal rows lines, unless a count is provided
noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')

" Allow gf to open non-existent files
map gf :edit <cfile><cr>

" Maintain the cursor position when yanking a visual selection
vnoremap y myy`y
vnoremap Y myY`y

"--------------------------------------------------------------------------
" Plugins
"--------------------------------------------------------------------------

" Auto-installation for vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Begin plugins
call plug#begin('~/.config/nvim/plugged/')

" source ~/.config/nvim/plugins/vim-surround.vim
" source ~/.config/nvim/plugins/vim-commentary.vim
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-obsession'

source ~/.config/nvim/plugins/gruvbox.vim
source ~/.config/nvim/plugins/vim-airline.vim
source ~/.config/nvim/plugins/vim-slime.vim
source ~/.config/nvim/plugins/coc.vim
source ~/.config/nvim/plugins/fzf.vim
source ~/.config/nvim/plugins/nerdtree.vim
source ~/.config/nvim/plugins/undotree.vim

call plug#end()
doautocmd User PlugLoaded


"--------------------------------------------------------------------------
" Miscellaneous
"--------------------------------------------------------------------------

" Stop colourscheme from altering terminal opacity settings
"highlight Normal ctermbg=none
"highlight NonText ctermbg=none

" Netrw settings
let g:netrw_banner = 0          " Hide the banner in netrw file explorer
let g:netrw_liststyle = 3
let g:netrw_winsize = 15        " Netrw takes up 15% of the current split
let g:netrw_altv = 1
let g:netrw_browse_split = 4    " Opened files go to new vertical split
let g:netrw_keepdir = 0

" WSL yank support
let s:clip = '/mnt/c/Windows/System32/clip.exe'
if executable(s:clip)
    augroup WSLYank
        autocmd!
        autocmd TextYankPost * if v:event.operator ==# 'y' | call system(s:clip, @0) | endif
    augroup END
endif 

