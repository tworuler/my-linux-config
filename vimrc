"Install Vundle
"git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

"Plugin 'Valloric/YouCompleteMe'
Plugin 'ctrlP.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'taglist.vim'
Plugin 'majutsushi/tagbar'
Plugin 'Auto-Pairs'
"Plugin 'tmhedberg/SimpylFold'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
"Plugin 'Lokaltog/vim-powerline'
"Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'Yggdroot/indentLine'
Plugin 'sickill/vim-monokai'
Plugin 'altercation/vim-colors-solarized'

" All of your Plugins must be added before the following line
call vundle#end()            " required
"filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

nnoremap <silent> <f2> :NERDTree<CR>
"let NERDTreeShowLineNumbers=1
let NERDTreeIgnore=['\.o']

"nnoremap <silent> <F8> :TlistToggle<CR>
"let Tlist_Show_One_File=1    " 只展示一个文件的taglist
"let Tlist_Exit_OnlyWindow=1  " 当taglist是最后以个窗口时自动退出
"let Tlist_Use_Right_Window=1 " 在右边显示taglist窗口
"let Tlist_Sort_Type='name'   " tag按名字排序

nnoremap <silent> <F3> :TagbarToggle<CR>  

let g:ctrlp_map='<c-p>'
let g:ctrlp_cmp='CtrlP'

let g:SimpylFold_docstring_preview=1

" Vim
let g:indentLine_color_term = 239
" GVim
let g:indentLine_color_gui = '#A4E57E'
" use one of ¦, ┆, or │
"let g:indentLine_char = '|'
" disable by defualt
"let g:indentLine_enabled = 0

" 随 vim 自启动
"let g:indent_guides_enable_on_vim_startup=1
" 从第二层开始可视化显示缩进
"let g:indent_guides_start_level=2
" 色块宽度
"let g:indent_guides_guide_size=1

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

set splitbelow
set splitright

"split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
imap <C-W> <ESC><C-W>

" Enable folding
"set foldmethod=indent
set foldmethod=syntax
set foldlevel=99

" Enable folding with the spacebar
nnoremap <space> za
