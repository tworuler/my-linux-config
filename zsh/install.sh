#!/bin/bash

set -e

DIR=$(cd "$(dirname "$0")"; pwd)

if [[ ! -d ~/.oh-my-zsh ]]; then
    git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh
fi

ls ${DIR}/*.zsh-theme | xargs -I {} cp {} ~/.oh-my-zsh/themes/
cp ${DIR}/my.zshrc ~/.oh-my-zsh/my.zshrc

LOAD_ZSH="[[ -s ~/.oh-my-zsh/my.zshrc ]] && source ~/.oh-my-zsh/my.zshrc"
if [[ ! -e ~/.zshrc ]]; then
    echo -e "${LOAD_ZSH}\n" >  ~/.zshrc
elif [[ $(grep "${LOAD_ZSH}" ~/.zshrc) == "" ]]; then
    echo -e "${LOAD_ZSH}\n" | cat - ~/.zshrc > ${DIR}/tmp && mv ${DIR}/tmp ~/.zshrc
fi

if [[ ! -e ~/.oh-my-zsh/z.sh ]]; then
    curl -fLo ~/.oh-my-zsh/z.sh https://raw.githubusercontent.com/rupa/z/master/z.sh
fi

