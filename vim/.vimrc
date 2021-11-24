call plug#begin('~/.vim/plugged')

Plug 'chriskempson/base16-vim'
Plug 'itchyny/lightline.vim'
Plug 'mike-hearn/base16-vim-lightline'
Plug 'preservim/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'preservim/nerdcommenter'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release' }
Plug 'qpkorr/vim-bufkill'
Plug 'mileszs/ack.vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'tpope/vim-sensible'
Plug 'rust-lang/rust.vim', { 'for': 'rust' }
Plug 'hashivim/vim-terraform'

call plug#end()

colorscheme base16-flat
let loaded_matchparen = 1

set termguicolors
set undodir=$HOME/.vim/.undo//
set backupdir=$HOME/.vim/.backup//
set directory=$HOME/.vim/.swp//
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
set hidden
set cursorline
set lazyredraw
set ttyfast
set timeoutlen=1000
set ttimeoutlen=0
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc,*/__pycache__/*
set clipboard=
set updatetime=300
set noshowmode
"set re=1

let g:python3_host_prog = '~/.pyenv/versions/3.7.9/bin/python'

if filereadable(expand("~/.vimrc_background"))
    let base16colorspace=256
    source ~/.vimrc_background
endif

let g:lightline = {
    \ 'colorscheme': 'base16_flat',
    \ 'active': {
    \   'left': [ [ 'mode' ], [ 'filename' ] ],
    \   'right': [ [ 'lineinfo' ], [ 'percent' ], [ 'cocstatus' ] ]
    \ },
    \ 'component_function': {
    \   'filename': 'LightlineFilename',
    \   'cocstatus': 'coc#status'
    \ },
\ }

function! LightlineFilename()
    return expand('%:t') !=# '' ? @% : '[No Name]'
endfunction

autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:tmux_navigator_disable_when_zoomed = 1
let g:tmux_navigator_save_on_switch = 2

let g:ackprg = 'ag --vimgrep --case-sensitive'

let g:ctrlp_working_path_mode = 'a'
let g:ctrlp_user_command = 'ag %s -l --nocolor --nogroup --hidden -g ""'

let g:NERDTreeWinSize = 33
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
let NERDTreeIgnore = ['\.pyc$', '__pycache__$', '.git$', '.tox$', '\.egg-info$', '.DS_Store$', '.cache$', 'direnv', '.envrc', 'python-version']
let NERDTreeMinimalUI = 1
let NERDTreeShowHidden = 1

let mapleader = ","
nnoremap <leader>nt :NERDTreeToggle<cr>
nnoremap <leader>x :BD<CR>
nnoremap <leader>l :set wrap!<CR>
nnoremap <leader>j :set number!<CR>
nnoremap <leader>w ggVGgq<C-o><C-o>
nnoremap <leader>' *:Ack!<C-r><C-w><CR>
nnoremap <leader>; :Ack!<space>
nnoremap <leader>s :w<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>z :qa<CR>
nnoremap <leader>a :wq<CR>
nnoremap <leader>. :%bdelete<CR>
nnoremap <leader>v :vsplit<CR>
nnoremap <leader>h :split<CR>
vnoremap <leader>y "+y
nnoremap <leader>Y "+yy
nnoremap <leader>p "+p
nnoremap <leader>c ggVG
nnoremap <leader>t o__import__("pdb").set_trace()<Esc>
nnoremap <leader>k oprintln!("{:#?}", );<Esc>hi
nnoremap <leader>o :!echo `git url`/blob/`git rev-parse --abbrev-ref HEAD`/%\#L<C-R>=line('.')<CR><CR>
nnoremap <leader>m :CtrlPBuffer<CR>
nnoremap <leader>ln :set number!<CR>
nnoremap <BS> :noh<CR>
nnoremap * *``
nnoremap <silent> <leader>f :Format<CR>

nmap <leader>r <Plug>(coc-rename)
nmap <silent> <leader>d <Plug>(coc-definition)
nmap <silent> <leader>9 <Plug>(coc-diagnostic-prev)
nmap <silent> <leader>0 <Plug>(coc-diagnostic-next)

map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>
imap <up> <nop>
imap <down> <nop>
imap <left> <nop>
imap <right> <nop>
imap § <Esc>

xnoremap < <gv
xnoremap > >gv

let tw_blacklist = ['js']
autocmd BufWritePre * if index(tw_blacklist, &ft) < 0 | :%s/\s\+$//e
autocmd BufWritePre * if index(tw_blacklist, &ft) < 0 | :%s/\($\n\)\+\%$//e
"autocmd BufWrite *.go :GoDiagnostics
"autocmd BufWritePre *.go CocCommand editor.action.organizeImport
"autocmd BufWrite *.py :CocCommand editor.action.organizeImport
au BufWritePre *.py :silent call CocAction('runCommand', 'editor.action.organizeImport')
autocmd BufLeave,FocusLost,VimResized * silent! wall
autocmd BufRead,BufNewFile .envrc set filetype=sh
autocmd BufRead,BufNewFile requirements* set filetype=conf
autocmd InsertEnter,InsertLeave * set cul!

augroup vimrc_todo
    au!
    au Syntax * syn match MyTodo
        \ /\v<(FIXME|NOTE|TODO|XXX|fixme|note|todo|xxx)/
        \ contained containedin=.*Comment.*
augroup END
hi def link MyTodo Todo
