#!/bin/bash

if [[ -d ~/.vim/bundle/Vundle.vim ]]
then
    echo "Vundle has already been installed."
else
    echo "Install Vundle..."
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim 
    echo "Done!"
fi

echo "Update vimrc..."
cp vimrc ~/.vimrc
echo "Done!"

echo "Install Vim Plugins..."
vim +PluginInstall +qall
echo "Done!"

