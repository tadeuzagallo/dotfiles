export KEYTIMEOUT=1

#. ~/Library/Python/2.7/lib/python/site-packages/powerline/bindings/zsh/powerline.zsh
ZSH=~/.oh-my-zsh

export ZSH_THEME="../../my-custom"

CASE_SENSITIVE="true"

plugins=(git brew npm history-substring-search)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...

alias sz='source ~/.zshrc'
alias ez='vim ~/.zshrc'
alias ev='vim ~/.vimrc'
alias et='vim ~/.tmux.conf'

alias g='git'
alias v='vim'
alias c='clear'
alias e='exit'
alias l='ls -la'

export EDITOR=/usr/local/bin/vim
export VISUAL=/usr/local/bin/vim

if [ $TERM != 'screen-256color' ]; then
  tmux new;
fi

#export CFLAGS="-Wall -W -Wshadow -Wcast-qual -Wwrite-strings" #-Wconversion -Werror -ansi -pedantic 
#export CC=gcc

unsetopt nomatch
unsetopt correct_all

export PYTHONPATH=/usr/local/lib/python2.7/site-packages:$PYTHONPATH

export NODE_PATH=/usr/local/share/npm/lib/node_modules
export NODE_ENV=development

export GOPATH=~/www/go

source ~/dotfiles/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh

export PATH=/usr/local/bin:/usr/local/sbin:/bin:/usr/bin:/bin:/usr/sbin:/sbin:$HOME/.rvm/bin:/usr/local/share/npm/bin:/usr/local/heroku/bin:/usr/local/share/npm/bin:./node_modules/.bin:$GOPATH/bin

source $(brew --prefix nvm)/nvm.sh

[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" 
[[ -s `brew --prefix`/etc/autojump.sh ]] && . `brew --prefix`/etc/autojump.sh


. `brew --prefix`/etc/profile.d/z.sh

# reload current path to call rvm cd hook
cd ..;1

bindkey -v

bindkey '^P' history-substring-search-up
bindkey '^N' history-substring-search-down

bindkey -M vicmd '^P' history-substring-search-up
bindkey -M vicmd '^N' history-substring-search-down

function zle-line-init zle-keymap-select {
  VIM_PROMPT="%{$fg_bold[yellow]%} [% NORMAL]%  %{$reset_color%}"
  RPS1="${${KEYMAP/vicmd/$VIM_PROMPT}/(main|viins)/} $EPS1"
  zle reset-prompt
}

zle -N zle-line-init
zle -N zle-keymap-select
