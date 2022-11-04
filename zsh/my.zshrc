# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=$HOME/.local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# load ohmyzsh
# template configuration file: ~/.oh-my-zsh/templates/zshrc.zsh-template
ZSH_THEME="my_ys"
plugins=(git)
source $ZSH/oh-my-zsh.sh

# ls color
# export LSCOLORS=exfxcxdxbxegedabagacad
export LSCOLORS=ExFxBxDxCxegedabagacad # like Ubuntu

# auto jump
# [[ -s ~/.autojump/etc/profile.d/autojump.sh ]] && source ~/.autojump/etc/profile.d/autojump.sh
# [[ -s ~/.oh-my-zsh/z.sh ]] && source ~/.oh-my-zsh/z.sh
command -v zoxide &> /dev/null && eval "$(zoxide init zsh)"

#====== fzf =======
export FZF_DEFAULT_OPTS='--layout=reverse --inline-info --ansi'
export FZF_DEFAULT_COMMAND='fd --type f --color always --strip-cwd-prefix --hidden --follow --exclude .git'

_fzf_compgen_path() {
    fd --type f --color always --strip-cwd-prefix --hidden --follow --exclude .git
}

_fzf_compgen_dir() {
    fd --type d --hidden --follow --exclude .git . "$1"
}

files() {
    fzf --height 70% --layout reverse --info inline --border \
        --preview 'file {}' --preview-window up,1,border-horizontal
}

#====== bat =======
export BAT_THEME='Visual Studio Dark+'

# aliases
alias zshconfig="vim ~/.zshrc"
alias ohmyzsh="cd ~/.oh-my-zsh"
alias ll="ls -alh"
alias l="ls -lh"
alias gitomz="command git config --unset-all oh-my-zsh.hide-status && git config --unset-all oh-my-zsh.hide-dirty"
alias gitomzd="command git config --add oh-my-zsh.hide-status 1 && git config --add oh-my-zsh.hide-dirty 1"

Rg() {
    rg --column --line-number --no-heading --color=always --smart-case "$1" 2>/dev/null \
    | fzf --ansi -d: \
        --preview 'bat --style=full --color=always --theme="Monokai Extended" --highlight-line={2} --pager=always {1}' \
        --preview-window='~4,+{2}+4/2' \
        --bind=enter:toggle-preview \
        --bind=j:down --bind=k:up \
        --bind=J:preview-down --bind=K:preview-up \
        --bind='i:unbind(j)+unbind(k)+unbind(J)+unbind(K)+unbind(i)' \
        --bind='tab:rebind(j)+rebind(k)+rebind(J)+rebind(K)+rebind(i)'
}
