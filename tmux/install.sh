#!/bin/bash

tmux_version=$(tmux -V | cut -f2 -d ' ')

pushd "$(dirname "$0")"

echo "$tmux_version"
echo "Update tmux config..."
if [[ $tmux_version == 2.* ]]; then
    cp tmux.conf ~/.tmux.conf
else
    sed 's/ -c "#{pane_current_path}"//' tmux.conf > ~/.tmux.conf
fi
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

popd

