#!/bin/bash

set -e

DIR=$(cd "$(dirname "$0")"; pwd)

#install ohmyzsh
if [[ ! -d ~/.oh-my-zsh ]]; then
    git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh
fi

ls ${DIR}/*.zsh-theme | xargs -I {} cp {} ~/.oh-my-zsh/themes/
cp ${DIR}/base.zsh ~/.oh-my-zsh/base.zsh

LOAD_ZSH="[[ -s ~/.oh-my-zsh/base.zsh ]] && source ~/.oh-my-zsh/base.zsh"
if [[ ! -e ~/.zshrc ]]; then
    echo -e "${LOAD_ZSH}\n" >  ~/.zshrc
elif [[ $(grep "${LOAD_ZSH}" ~/.zshrc) == "" ]]; then
    echo -e "${LOAD_ZSH}\n" | cat - ~/.zshrc > ${DIR}/tmp && mv ${DIR}/tmp ~/.zshrc
fi

