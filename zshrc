export KEYTIMEOUT=1

autoload -U zutil      # [1]
autoload -U compinit   # [2]
autoload -U complist   # [3]
compinit

ZSH=~/.oh-my-zsh

plugins=(git brew history-substring-search)

source ~/dotfiles/my_custom_theme.sh

# Customize to your needs...

alias sz='source ~/.zshrc'
alias ez='vim ~/.zshrc'
alias ev='vim ~/.vimrc'
alias et='vim ~/.tmux.conf'
alias rn=react-native

alias :e=cd
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

TIMEFMT=$'\nreal\t%E\nuser\t%U\nsys\t%S'

unsetopt nomatch
unsetopt correct_all

export NODE_PATH=/usr/local/share/npm/lib/node_modules
export NODE_ENV=development

fpath=(/usr/local/share/zsh-completions $fpath)
source /usr/local/opt/zsh-syntax-highlighting/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/local/opt/zsh-history-substring-search/zsh-history-substring-search.zsh

export PATH=/usr/local/opt/ccache/libexec:~/devtools/arcanist/bin:~/devtools/buck/bin:$HOME/.rvm/bin:/opt/facebook/bin:/usr/local/bin:/usr/local/sbin:/opt/facebook/bin:./node_modules/.bin:$GOPATH/bin:$PATH

export NVM_DIR=~/.nvm
source $(brew --prefix nvm)/nvm.sh

[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"
[[ -s `brew --prefix`/etc/autojump.sh ]] && . `brew --prefix`/etc/autojump.sh

bindkey -v

bindkey '^P' history-substring-search-up
bindkey '^N' history-substring-search-down

bindkey -M vicmd '^P' history-substring-search-up
bindkey -M vicmd '^N' history-substring-search-down

alias ip="ipconfig getifaddr en0"

###-begin-npm-completion-###
#
# npm command completion script
#
# Installation: npm completion >> ~/.bashrc  (or ~/.zshrc)
# Or, maybe: npm completion > /usr/local/etc/bash_completion.d/npm
#

COMP_WORDBREAKS=${COMP_WORDBREAKS/=/}
COMP_WORDBREAKS=${COMP_WORDBREAKS/@/}
export COMP_WORDBREAKS

if type complete &>/dev/null; then
  _npm_completion () {
    local si="$IFS"
    IFS=$'\n' COMPREPLY=($(COMP_CWORD="$COMP_CWORD" \
                           COMP_LINE="$COMP_LINE" \
                           COMP_POINT="$COMP_POINT" \
                           npm completion -- "${COMP_WORDS[@]}" \
                           2>/dev/null)) || return $?
    IFS="$si"
  }
  complete -F _npm_completion npm
elif type compdef &>/dev/null; then
  _npm_completion() {
    si=$IFS
    compadd -- $(COMP_CWORD=$((CURRENT-1)) \
                 COMP_LINE=$BUFFER \
                 COMP_POINT=0 \
                 npm completion -- "${words[@]}" \
                 2>/dev/null)
    IFS=$si
  }
  compdef _npm_completion npm
elif type compctl &>/dev/null; then
  _npm_completion () {
    local cword line point words si
    read -Ac words
    read -cn cword
    let cword-=1
    read -l line
    read -ln point
    si="$IFS"
    IFS=$'\n' reply=($(COMP_CWORD="$cword" \
                       COMP_LINE="$line" \
                       COMP_POINT="$point" \
                       npm completion -- "${words[@]}" \
                       2>/dev/null)) || return $?
    IFS="$si"
  }
  compctl -K _npm_completion npm
fi
###-end-npm-completion-###
