if has('python3')
  silent! python3 1
endif

call plug#begin('~/.vim/plugged')
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'w0rp/ale'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'hynek/vim-python-pep8-indent', { 'for': 'python' }
Plug 'qpkorr/vim-bufkill'
Plug 'mileszs/ack.vim'
Plug 'tpope/vim-sensible'
Plug 'scrooloose/nerdcommenter'
Plug 'davidhalter/jedi-vim', { 'for': 'python' }
Plug 'ervandew/supertab'
Plug 'danielwe/base16-vim'
Plug 'tmux-plugins/vim-tmux'
Plug 'christoomey/vim-tmux-navigator'
Plug 'tmhedberg/SimpylFold'
Plug 'Konfekt/FastFold'
Plug 'fatih/vim-go'
Plug 'pearofducks/ansible-vim'
Plug 'tpope/vim-dispatch'
Plug 'vim-python/python-syntax'
Plug 'derekwyatt/vim-scala'
Plug 'pedrohdz/vim-yaml-folds'
Plug 'scrooloose/vim-slumlord'
Plug 'kchmck/vim-coffee-script'
Plug 'editorconfig/editorconfig-vim'
Plug 'elzr/vim-json'
Plug 'rust-lang/rust.vim'
Plug 'racer-rust/vim-racer'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-fugitive'
Plug 'Chiel92/vim-autoformat'
Plug 'christoomey/vim-system-copy'
"Plug 'TaDaa/vimade'
call plug#end()

set undodir=$HOME/.vim/.undo//
set backupdir=$HOME/.vim/.backup//
set directory=$HOME/.vim/.swp//

let base16colorspace=256

let loaded_matchparen = 1

"set undofile
set hlsearch
set autoread
set expandtab
set modeline
set tabstop=4
set softtabstop=4
set smarttab
set shiftwidth=4
set wrap
set fillchars=""
set background=dark
set hidden
"set nu
set cursorline
set lazyredraw
set ttyfast
set timeoutlen=1000
set ttimeoutlen=0
set foldlevelstart=99
set foldmethod=syntax
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc,*/__pycache__/*
set completeopt-=preview
set clipboard=
set guicursor=
"autocmd FileType python setlocal completeopt-=preview
set textwidth=90
set colorcolumn=90



colorscheme base16-flat

set statusline+=%#warningmsg#
set statusline+=%*

set re=1

"let g:vimade = {
"  \ "basebg": [255,255,255],
"  \ "basefg": [0,0,0],
"  \}

let g:vim_json_syntax_conceal = 0

"let g:ackprg = 'ag --vimgrep --smart-case'
let g:ackprg = 'ag --vimgrep --case-sensitive'
let g:ack_use_dispatch = 1
let g:ctrlp_working_path_mode = 'a'
let g:ctrlp_custom_ignore = ''

let g:python_highlight_all = 1
let g:python_highlight_operators = 0
let g:python_highlight_func_calls = 0

let g:go_highlight_functions = 1
let g:go_highlight_types = 1
let g:go_highlight_format_strings = 1

let g:jedi#popup_on_dot = 0
let g:jedi#popup_select_first = 0
let g:jedi#smart_auto_mappings = 0
let g:jedi#show_call_signatures = 2
let g:jedi#goto_stubs_command = ''

let g:go_fmt_command = 'goimports'

let g:racer_cmd = "$HOME/.cargo/bin/racer"
au FileType rust nmap <leader>d <Plug>(rust-def)

let g:NERDTreeWinSize = 33
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
let NERDTreeIgnore = ['\.pyc$', '__pycache__$', '.git$', '.tox$', '\.egg-info$', '.DS_Store$', '.cache$', 'direnv', '.envrc', 'python-version']

let mapleader = ","
nmap <leader>nt :NERDTreeToggle<cr>

map <C-n> :tabnew<CR>
map <leader>[ :bp<CR>
map <leader>] :bn<CR>
map <leader>x :BD<CR>
map <leader>l :set wrap!<CR>
map <leader>w ggVGgq<C-o><C-o>
map <leader>; :Ack!<space>
"nnoremap <leader>s :w<CR>
map <leader>s :w<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>z :qa<CR>
nnoremap <leader>a :wq<CR>
nnoremap <leader>. :%bdelete<CR>
nnoremap <leader>v :vsplit<CR>
nnoremap <leader>h :split<CR>
nnoremap <leader>/ :e $MYVIMRC<CR>
"nnoremap <leader>o :so $MYVIMRC<CR>
nnoremap <leader>' *:Ack!<C-r><C-w><CR>
nnoremap <leader>o :!echo `git url`/blob/`git rev-parse --abbrev-ref HEAD`/%\#L<C-R>=line('.')<CR><CR>
noremap <leader>y "+y
noremap <leader>Y "+yy
noremap <leader>p "+p
"nnoremap * *#

au FileType scala nnoremap <leader>d :EnDeclaration<CR>
au FileType go nnoremap <leader>d :GoDef<CR>

map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>
imap <up> <nop>
imap <down> <nop>
imap <left> <nop>
imap <right> <nop>
imap § <Esc>
nnoremap <BS> :noh<CR>
"inoremap <BS> <nop>

nmap <leader>t o__import__("pdb").set_trace()<Esc>
nmap <leader>u ofrom celery.contrib import rdb; rdb.set_trace()  # noqa E702<Esc>

xnoremap < <gv
xnoremap > >gv

"let g:ale_sign_column_always = 1
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 0
let g:ale_linters = {
\   'python': ['flake8', 'mypy'],
\   'json': ['jsonlint'],
\}

let g:ale_python_mypy_options = '--ignore-missing-imports'

nmap <silent> <leader>9 <Plug>(ale_previous_wrap)
nmap <silent> <leader>0 <Plug>(ale_next_wrap)

let g:go_fmt_fail_silently = 1

let NERDTreeShowHidden = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#ale#enabled = 1
let g:airline_theme = "base16"
let g:ag_working_path_mode = "r"
let g:ag_highlight = 1
let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabContextDefaultCompletionType = "<c-x><c-o>"

let g:tmux_navigator_disable_when_zoomed = 1
let g:tmux_navigator_save_on_switch = 2

let g:gh_gitlab_domain = "gitlab.blockport.tech"

"let g:python_host_prog = '/home/linuxbrew/.linuxbrew/bin/python'
"let g:python3_host_prog = '/home/linuxbrew/.linuxbrew/bin/python3'

let g:formatdef_multiple = '"isort - | black -q -"'
let g:formatters_python = ['multiple']

let tw_blacklist = ['js']
autocmd BufWritePre * if index(tw_blacklist, &ft) < 0 | :%s/\s\+$//e
autocmd BufWritePre * if index(tw_blacklist, &ft) < 0 | :%s/\($\n\)\+\%$//e
autocmd BufWrite *.py :Autoformat
autocmd BufWrite *.go :GoDiagnostics

" Disable default mapping since we are overriding it with our command
let g:ctrlp_map = ''

" CtrlP
" Use this function to prevent CtrlP opening files inside non-writeable buffers, e.g. NERDTree
function! SwitchToWriteableBufferAndExec(command)
    let c = 0
    let wincount = winnr('$')
    " Don't open it here if current buffer is not writable (e.g. NERDTree)
    while !empty(getbufvar(+expand("<abuf>"), "&buftype")) && c < wincount
        exec 'wincmd w'
        let c = c + 1
    endwhile
    exec a:command
endfunction

nnoremap <C-p> :call SwitchToWriteableBufferAndExec('CtrlP')<CR>
nnoremap <leader>k :call SwitchToWriteableBufferAndExec('CtrlPMRUFiles')<CR>
nnoremap <leader>m :call SwitchToWriteableBufferAndExec('CtrlPBuffer')<CR>

autocmd BufLeave,FocusLost,VimResized * silent! wall
autocmd BufRead,BufNewFile .envrc set filetype=sh
autocmd BufRead,BufNewFile requirements* set filetype=conf
