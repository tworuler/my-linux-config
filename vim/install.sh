#!/bin/bash

pushd "$(dirname "$0")"

if [[ -d ~/.vim/bundle/Vundle.vim ]]; then
    echo "Vundle has already been installed."
else
    echo "Install Vundle..."
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim 
    echo "Done!"
fi

echo "Update vimrc..."
cp my.vim ~/.vim/my.vim

read -r -d '' add_source << EOM
" Load my common config
source ~/.vim/my.vim
EOM

if [[ ! -e ~/.vimrc ]]; then
    echo -e "$add_source\n" > ~/.vimrc
elif [[ "$(grep 'source ~/.vim/my.vim' ~/.vimrc)" == "" ]]; then
    echo -e "$add_source\n" | cat - ~/.vimrc > vimrc.tmp && mv vimrc.tmp ~/.vimrc
fi
echo "Done!"

echo "Install Vim Plugins..."
line=$(grep -n "filetype plugin on" my.vim | cut -f1 -d ":")
vim -u <(head -$line ~/.vim/my.vim) +PluginInstall +qall
echo "Done!"

popd

