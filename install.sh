#!/bin/bash

config_list=(
    vim
    tmux
    zsh
)

for dir in ${config_list[@]}; do
    cd $dir
    ./install.sh
    cd ..
done

