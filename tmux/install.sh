#!/bin/bash

echo "Update tmux config..."
cp tmux.conf ~/.tmux.conf
tmux source ~/.tmux.conf
echo "Done!"

if [[ -d ~/.tmux/tmux-powerline ]]; then
    echo "~/.tmux/tmux-powerline exist"
else
    echo "Install tmux powerline"
    git clone https://github.com/erikw/tmux-powerline.git ~/.tmux/tmux-powerline
    echo "Done!"
fi
echo "Update tmux powerline config..."
cp my-tmux-powerline-themes.sh ~/.tmux/tmux-powerline/themes/default.sh
echo "Done!"

