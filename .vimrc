set nocompatible

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'bling/vim-airline'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'rizzatti/dash.vim'
Plugin 'hynek/vim-python-pep8-indent'
Plugin 'octol/vim-cpp-enhanced-highlight'
Plugin 'qpkorr/vim-bufkill'
Plugin 'rking/ag.vim'
Plugin 'majutsushi/tagbar'
Plugin 'tpope/vim-sensible'
Plugin 'scrooloose/nerdcommenter'
Plugin 'nvie/vim-flake8'
Plugin 'davidhalter/jedi-vim'
Plugin 'ervandew/supertab'
Plugin 'chriskempson/base16-vim'
Plugin 'tmux-plugins/vim-tmux'
Plugin 'hdima/python-syntax'
Plugin 'christoomey/vim-tmux-navigator'
call vundle#end()

let loaded_matchparen = 1
set hlsearch
set autoread
set expandtab
set tabstop=4
set softtabstop=4
set smarttab
set shiftwidth=4
set textwidth=101
set wrap
set colorcolumn=101
set fillchars=""
set background=dark
set hidden
set nu
set cursorline
set lazyredraw
set ttyfast
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc,*/__pycache__/*

noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>
inoremap <Up> <NOP>
inoremap <Down> <NOP>
inoremap <Left> <NOP>
inoremap <Right> <NOP>

colorscheme base16-flat

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

autocmd BufNewFile,BufRead *.yml,*.yaml
    \ set tabstop=2 |
    \ set shiftwidth=2 |

let g:NERDTreeWinSize = 34

let mapleader = ","
nmap <leader>nt :NERDTreeToggle<cr>
nmap <leader>tb :TagbarToggle<cr>

map <C-l> :tabn<CR>
map <C-h> :tabp<CR>
map <C-n> :tabnew<CR>
map <leader>[ :bp<CR>
map <leader>] :bn<CR>
map <leader>x :BD<CR>
nnoremap <leader>s :w<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>a :wq<CR>

let NERDTreeShowHidden = 1
let g:airline#extensions#tabline#enabled = 1
let g:ag_working_path_mode = "r"
let g:ag_highlight = 1
let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabContextDefaultCompletionType = "<c-x><c-o>"
let python_highlight_all = 1

autocmd FileType python setlocal completeopt-=preview
autocmd BufWritePre * :%s/\s\+$//e

set undodir=$HOME/.vim/.undo//
set backupdir=$HOME/.vim/.backup//
set directory=$HOME/.vim/.swp//
