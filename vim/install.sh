#!/bin/bash

set -ex

pushd "$(dirname "$0")"

if [[ ! -e ~/.vim/autoload/plug.vim ]]; then
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

cp my.vim ~/.vim/my.vim
cp -r my_header ~/.vim

add_source=$(cat << EOM
" Load my common config
source ~/.vim/my.vim
EOM
)

if [[ ! -e ~/.vimrc ]]; then
    echo -e "$add_source\n" > ~/.vimrc
elif [[ "$(grep 'source ~/.vim/my.vim' ~/.vimrc)" == "" ]]; then
    echo -e "$add_source\n" | cat - ~/.vimrc > vimrc.tmp && mv vimrc.tmp ~/.vimrc
fi

line=$(grep -n "call plug#end()" my.vim | cut -f1 -d ":")
vim -u <(head -$line ~/.vim/my.vim) +PlugInstall +qall
# install ycm
# cd ~/.vim/plugged/YouCompleteMe && python install.py --clang-completer

popd

