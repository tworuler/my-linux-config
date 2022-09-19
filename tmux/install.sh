#!/bin/bash

set -e

DIR=$(cd "$(dirname "$0")"; pwd)

cp ${DIR}/tmux.conf ~/.tmux.conf

if [[ ! -d ~/.tmux/tmux-powerline ]]; then
    git clone https://github.com/erikw/tmux-powerline.git ~/.tmux/tmux-powerline
    cp ${DIR}/my-tmux-powerline-themes.sh ~/.tmux/tmux-powerline/themes/default.sh
fi

tmux source ~/.tmux.conf

