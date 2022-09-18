#!/bin/bash

set -ex

DIR=$(cd "$(dirname "$0")"; pwd)

cp ${DIR}/tmux.conf ~/.tmux.conf
tmux source ~/.tmux.conf

if [[ ! -d ~/.tmux/tmux-powerline ]]; then
    git clone https://github.com/erikw/tmux-powerline.git ~/.tmux/tmux-powerline
fi

cp my-tmux-powerline-themes.sh ~/.tmux/tmux-powerline/themes/default.sh

