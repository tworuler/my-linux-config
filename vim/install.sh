#!/bin/bash

echo "Install Vundle..."
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim 
echo "Done!"

echo "Update vimrc..."
cp vimrc ~/.vimrc
echo "Done!"

echo "Install Vim Plugins..."
vim +PluginInstall +qall
echo "Done!"

