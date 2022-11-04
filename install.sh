#!/bin/bash

CURDIR=$(cd $(dirname $0); pwd)

${CURDIR}/vim/install.sh
${CURDIR}/tmux/install.sh
${CURDIR}/zsh/install.sh

ENABLE_Z=0
ENABLE_FZF=1

if [[ ${ENABLE_Z} == 1 ]]; then
    if [[ ! -e ~/.oh-my-zsh/z.sh ]]; then
        curl -fLo ~/.oh-my-zsh/z.sh https://raw.githubusercontent.com/rupa/z/master/z.sh
    fi
fi

if [[ ${ENABLE_FZF} == 1 ]]; then
    if [[ ! -e ~/.fzf ]]; then
        git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
        yes | ~/.fzf/install
    fi
fi

