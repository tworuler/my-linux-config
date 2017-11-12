" My vim config notes: https://tworuler.github.io/notes/vim-config

set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
"Plugin 'Valloric/YouCompleteMe'
"Plugin 'scrooloose/syntastic'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/nerdcommenter'
Plugin 'fholgado/minibufexpl.vim'
"Plugin 'taglist.vim'
Plugin 'majutsushi/tagbar'
Plugin 'tpope/vim-surround'
"Plugin 'Auto-Pairs'
"Plugin 'tmhedberg/SimpylFold'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
"Plugin 'Lokaltog/vim-powerline'
"Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'Yggdroot/indentLine'
Plugin 'elzr/vim-json'
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
"Plugin 'sickill/vim-monokai'
Plugin 'crusoexia/vim-monokai'
Plugin 'tomasr/molokai'
Plugin 'altercation/vim-colors-solarized'

call vundle#end()
filetype plugin on

"nerdtree config
nnoremap <silent> <f2> :NERDTreeToggle<CR>
"let NERDTreeShowLineNumbers=1
let NERDTreeIgnore=['\.o', '\.pyc']
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

"nerdcommenter config
let g:NERDSpaceDelims=1
let g:NERDCustomDelimiters = { 'python': { 'left': '#' } }
let g:NERDDefaultAlign = 'left'
" <C-_> means ctrl+/
nnoremap <C-_> :call NERDComment(0,"toggle")<CR>
vnoremap <C-_> :call NERDComment(0,"toggle")<CR>

let g:miniBufExplBRSplit = 0

nnoremap <silent> <F3> :TagbarToggle<CR>

let g:ctrlp_map='<c-p>'
let g:ctrlp_cmp='CtrlP'

" Vim
let g:indentLine_color_term = 239
" use one of ¦, ┆, or │
"let g:indentLine_char = '|'
" disable by defualt
"let g:indentLine_enabled = 0

let g:airline#extensions#tabline#enabled = 1

let g:vim_markdown_conceal = 0
let g:vim_json_syntax_conceal = 0

syntax enable
syntax on
set nu
set autoindent
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1
set ruler  "show position of cursor
set laststatus=2

"set ignorecase "ignore case when search
set hlsearch "highlight search word
set incsearch

set splitbelow
set splitright

set history=200

" Enable folding
"set foldmethod=indent
set foldmethod=syntax
set foldlevel=99

" zsh mode tab
set wildmenu
set wildmode=full

set pastetoggle=<F5>

nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k
"set whichwrap+=h,l
"set whichwrap+=<,>,[,]

"split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

nnoremap [b :bp<CR>
nnoremap ]b :bn<CR>

cnoremap <C-p> <Up>
cnoremap <C-n> <Down>

" Enable folding with the spacebar
"nnoremap <space> za

" autoload my.vim
autocmd! bufwritepost my.vim source %

if $TERM == 'screen-256color' || $TERM == 'xterm-256color'
  set t_Co=256
  colorscheme monokai
  set cursorline
endif

function! BashHeader()
    call setline(1, "#!/bin/bash")
    normal o
    normal o
    normal G
endf

function! PythonHeader()
    0r ~/.vim/my_header/py_header.py
    normal G
endf

autocmd bufnewfile *.sh call BashHeader()
autocmd bufnewfile *.py call PythonHeader()

function! FileTypeDetect()
    if match(getline(1), "C++") >= 0
        set filetype=cpp
    elseif match(getline(1), "python") >= 0
        set filetype=python
    elseif match(getline(1), "bash") >= 0
        set filetype=sh
    endif
endf

autocmd BufNewFile,BufRead * if expand('%:e') == '' | call FileTypeDetect() | endif

autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" json format
command! JsonFomat :%!python -m json.tool

" Copy Paste on System Clipboard
vnoremap <C-c> :<C-u>silent '<,'>w !xsel -ib<CR>

