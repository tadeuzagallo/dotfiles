[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"  # This loads RVM into a shell session.

. /Users/tadeu/Library/Python/2.7/lib/python/site-packages/powerline/bindings/zsh/powerline.zsh
#
# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
export ZSH_THEME="awesomepanda"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want disable red dots displayed while waiting for completion
# DISABLE_COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git brew node npm osx ruby rails vi-mode zsh-syntax-highlighting zsh-history-substring-search)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
#export PATH=$PATH:/usr/local/bin:/bin:/usr/bin:/bin:/usr/sbin:/sbin

export CLASSPATH=~/www/coursera/Algorithms\ I/algs4.jar:~/www/coursera/Algorithms\ I/stdlib.jar:.

alias sz='source ~/.zshrc'
alias ez='vim ~/.zshrc'
alias ev='vim ~/.vimrc'

export EDITOR=/usr/local/bin/vim
export VISUAL=/usr/local/bin/vim

if [ $TERM != 'screen-256color' ]; then
  tmux new;
fi

#export CFLAGS="-Wall -W -Wshadow -Wcast-qual -Wwrite-strings" #-Wconversion -Werror -ansi -pedantic 
#export CC=gcc

unsetopt nomatch

export PYTHONPATH=/usr/local/lib/python2.7/site-packages:$PYTHONPATH
