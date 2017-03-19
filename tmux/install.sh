#!/bin/bash

echo "Update tmux config..."
cp tmux.conf ~/.tmux.conf
tmux source ~/.tmux.conf
echo "Done!"
