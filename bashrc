# launch tmux if it's not a tmux session already

if [ $TERM != 'screen-256color' ]; then
  tmux new;
fi

# colors
source ~/dotfiles/my_custom_theme.sh

# nvm

export NVM_DIR=~/.nvm
source $(brew --prefix nvm)/nvm.sh

# PATH

export PATH=/usr/local/opt/ccache/libexec:~/devtools/arcanist/bin:~/devtools/buck/bin:$HOME/.rvm/bin:/opt/facebook/bin:/usr/local/bin:/usr/local/sbin:/opt/facebook/bin:./node_modules/.bin:$GOPATH/bin:$PATH

# editor

export EDITOR=/usr/local/bin/vim
export REACT_EDITOR=atom
export VISUAL=/usr/local/bin/vim

# aliases

alias sb='source ~/.bashrc'
alias eb='vim ~/.bashrc'
alias ev='vim ~/.vimrc'
alias et='vim ~/.tmux.conf'
alias rn=react-native
alias g='git'
alias v='vim'
alias c='clear'
alias e='exit'
alias l='ls -la'
alias :e=cd
