" My vim config notes: https://tworuler.github.io/notes/vim-config

set nocompatible

call plug#begin('~/.vim/plugged')
Plug 'Valloric/YouCompleteMe'
"Plug 'scrooloose/syntastic'
Plug 'Chiel92/vim-autoformat'
Plug 'rhysd/vim-clang-format'
Plug 'kana/vim-textobj-user'
Plug 'sgur/vim-textobj-parameter'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim'
Plug 'airblade/vim-gitgutter'
Plug 'Yggdroot/LeaderF', { 'do': './install.sh' }
"Plug 'ctrlpvim/ctrlp.vim'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
Plug 'fholgado/minibufexpl.vim'
"Plug 'taglist.vim'
"Plug 'majutsushi/tagbar'
Plug 'tpope/vim-surround'
"Plug 'Auto-Pairs'
"Plug 'tmhedberg/SimpylFold'
"Plug 'nathanaelkane/vim-indent-guides'
Plug 'Yggdroot/indentLine'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'elzr/vim-json'
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
"Plug 'Lokaltog/vim-powerline'
"Plug 'chriskempson/base16-vim'
"Plug 'joshdick/onedark.vim'
"Plug 'dracula/vim', { 'as': 'dracula' }
"Plug 'rakr/vim-one'
"Plug 'sickill/vim-monokai'
"Plug 'tomasr/molokai'
Plug 'crusoexia/vim-monokai'
Plug 'tomasiser/vim-code-dark'
Plug 'altercation/vim-colors-solarized'
call plug#end()

"filetype indent off

let g:ycm_python_binary_path = 'python'
"let g:ycm_min_num_of_chars_for_completion=2
let g:ycm_complete_in_comments = 1
let g:ycm_complete_in_strings = 1
let g:ycm_autoclose_preview_window_after_completion=1
nnoremap <leader>jd :YcmCompleter GoToDefinitionElseDeclaration<CR>

" vim-autoformat config
let g:formatters_python = ['yapf', 'autopep8', 'black']
let g:formatter_yapf_style = 'pep8'

" vim-clang-format config
let g:clang_format#code_style = 'google'
let g:clang_format#style_options = {
            \ "IndentWidth" : 2}

"nerdtree config
nnoremap <silent> <f2> :NERDTreeToggle<CR>
nnoremap <silent> <c-e> :NERDTreeToggle<CR>
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

" LeaderF config
let g:Lf_ShortcutF = '<c-p>'
noremap <c-n> :LeaderfMru<cr>
noremap <c-m> :LeaderfFunction!<cr>

" ctrlp config
" let g:ctrlp_map='<c-p>'
" let g:ctrlp_cmp='CtrlP'

" vim-cpp-enhanced-highlight config
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1

" Vim
let g:indentLine_color_term = 239
" use one of ¦, ¿, or ¿
"let g:indentLine_char = '|'
" disable by defualt
"let g:indentLine_enabled = 0

let g:airline#extensions#tabline#enabled = 1

let g:vim_markdown_conceal = 0
let g:vim_json_syntax_conceal = 0

syntax enable
syntax on
set nu
set encoding=utf-8
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1
set ruler  "show position of cursor
set laststatus=2

set autoindent
set smartindent
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
autocmd FileType cpp setl ts=2 sts=2 sw=2

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

" mainly for gitgutter
set updatetime=500

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
  colorscheme codedark
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
command! Strip :%s/\s\+$//e

" Copy Paste on System Clipboard
vnoremap <C-c> :<C-u>silent '<,'>w !xsel -ib<CR>

