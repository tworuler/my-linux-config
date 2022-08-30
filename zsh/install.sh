#!/bin/bash

pushd "$(dirname "$0")"

if [[ -d ~/.oh-my-zsh ]]; then
    echo "~/.oh-my-zsh exists."
else
    echo "Install oh-my-zsh..."
    git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh
    echo "Done!"
fi

echo "update oh-my-zsh themes..."
ls | grep "\.zsh-theme" | xargs -I {} bash -c 'echo "copy {}" && cp {} ~/.oh-my-zsh/themes/'
echo "Done!"

echo "update .zshrc"
cp my.zshrc ~/.oh-my-zsh/my.zshrc
add_source=$(cat << EOM
# Load my common config
[[ -s ~/.oh-my-zsh/my.zshrc ]] && source ~/.oh-my-zsh/my.zshrc
EOM
)
if [[ ! -e ~/.zshrc ]]; then
    echo -e "$add_source\n" >  ~/.zshrc
elif [[ "$(grep 'source ~/.oh-my-zsh/my.zshrc' ~/.zshrc)" == "" ]]; then
    echo -e "$add_source\n" | cat - ~/.zshrc > tmp && mv tmp ~/.zshrc
fi
echo "Done!"

# if [[ -d ~/.autojump ]]; then
#     echo "~/.autojump exists."
# else
#     echo "Install autojump..."
#     git clone https://github.com/joelthelion/autojump.git
#     cd autojump
#     ./install.py
#     cd ..
#     echo "Done!"
# fi

if [[ ! -e ~/.oh-my-zsh/z.sh ]]; then
    echo "Install z.sh..."
    git clone https://github.com/rupa/z.git
    cp z/z.sh ~/.oh-my-zsh/z.sh
    echo "Done!"
fi

popd

