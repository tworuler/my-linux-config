#!/bin/bash

set -ex

pushd "$(dirname "$0")"

if [[ ! -e ~/.vim/autoload/plug.vim ]]; then
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

cp my.vim ~/.vim/my.vim
cp -r my_header ~/.vim

LOAD="source ~/.vim/my.vim"

if [[ ! -e ~/.vimrc ]]; then
    echo -e "${LOAD}\n" > ~/.vimrc
elif [[ "$(grep "${LOAD}" ~/.vimrc)" == "" ]]; then
    echo -e "${LOAD}\n" | cat - ~/.vimrc > vimrc.tmp && mv vimrc.tmp ~/.vimrc
fi

line=$(grep -n "call plug#end()" my.vim | cut -f1 -d ":")
vim -u <(head -$line ~/.vim/my.vim) +PlugInstall +qall
# install ycm
# cd ~/.vim/plugged/YouCompleteMe && python install.py --clang-completer

popd

