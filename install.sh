#!/bin/bash

pushd "$(dirname "$0")" > /dev/null

config_list=(
    vim
    tmux
    zsh
)

for dir in ${config_list[@]}; do
    $dir/install.sh
done

popd > /dev/null
