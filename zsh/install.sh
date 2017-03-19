#!/bin/bash

if [[ -d ~/.oh-my-zsh ]]
then
    echo "~/.oh-my-zsh exists."
else
    echo "Install oh-my-zsh..."
    git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
    echo "Done!"
fi

echo "update oh-my-zsh themes..."
ls | grep "\.zsh-theme" | xargs -i bash -c 'echo "copy {}" && cp {} ~/.oh-my-zsh/themes/'
echo "Done!"

echo "update .zshrc"
cp zshrc ~/.zshrc
echo "Done!"

if [[ -d ~/.autojump ]]
then
    echo "~/.autojump exists."
else
    echo "Install autojump..."
    git clone git://github.com/joelthelion/autojump.git
    cd autojump
    ./install.py
    cd ..
    echo "Done!"
fi

