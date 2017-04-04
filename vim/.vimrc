call plug#begin('~/.vim/plugged')
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'scrooloose/syntastic'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'hynek/vim-python-pep8-indent', { 'for': 'python' }
Plug 'qpkorr/vim-bufkill'
Plug 'mileszs/ack.vim'
Plug 'tpope/vim-sensible'
Plug 'scrooloose/nerdcommenter'
Plug 'davidhalter/jedi-vim', { 'for': 'python' }
Plug 'ervandew/supertab'
Plug 'chriskempson/base16-vim'
Plug 'tmux-plugins/vim-tmux'
Plug 'hdima/python-syntax'
Plug 'christoomey/vim-tmux-navigator'
Plug 'tmhedberg/SimpylFold'
Plug 'fatih/vim-go'
Plug 'pearofducks/ansible-vim'
call plug#end()

let base16colorspace=256

let loaded_matchparen = 1

set hlsearch
set autoread
set expandtab
set tabstop=4
set softtabstop=4
set smarttab
set shiftwidth=4
set wrap
set fillchars=""
set background=dark
set hidden
set nu
set cursorline
set lazyredraw
set ttyfast
set timeoutlen=1000
set ttimeoutlen=0
set foldlevelstart=99
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc,*/__pycache__/*
set completeopt-=preview

nnoremap <BS> :noh<CR>

colorscheme base16-flat

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:ackprg = 'ag --vimgrep --smart-case'

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:syntastic_python_checkers = ['flake8']
let g:syntastic_go_checkers = ['golint']
let g:syntastic_ansible_checkers = ['ansible-lint']
let g:syntastic_javascript_checkers = ['jshint']

let g:go_fmt_command = 'goimports'

let g:NERDTreeWinSize = 33
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
let NERDTreeIgnore = ['\.pyc$', '__pycache__$', '.git$', '.tox$', '\.egg-info$', '.DS_Store$', '.cache$']

let mapleader = ","
nmap <leader>nt :NERDTreeToggle<cr>

map <C-n> :tabnew<CR>
map <leader>[ :bp<CR>
map <leader>] :bn<CR>
map <leader>x :BD<CR>
map <leader>m :CtrlPBuffer<CR>
map <leader>l :set wrap!<CR>
map <leader>; :Ack!<space>
nnoremap <leader>s :w<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>a :wq<CR>
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>
imap <up> <nop>
imap <down> <nop>
imap <left> <nop>
imap <right> <nop>
imap jj <Esc>

xnoremap < <gv
xnoremap > >gv

let NERDTreeShowHidden = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme = "base16"
let g:ag_working_path_mode = "r"
let g:ag_highlight = 1
let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabContextDefaultCompletionType = "<c-x><c-o>"

autocmd BufWritePre * :%s/\s\+$//e
autocmd BufLeave,FocusLost,VimResized * silent! wall

set undodir=$HOME/.vim/.undo//
set backupdir=$HOME/.vim/.backup//
set directory=$HOME/.vim/.swp//
