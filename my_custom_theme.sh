if [ ${ZSH_VERSION} ]; then
  RED="%{%B%F{red}%}"
  ORANGE="%{%B%F{orange}%}"
  GREEN="%{%B%F{green}%}"
  BLUE="%{%B%F{blue}%}"
  GREY="%{%f%b%}"
else
  RED="\[\033[1;31m\]"
  ORANGE="\[\033[33m\]"
  GREEN="\[\033[1;32m\]"
  BLUE="\[\033[1;34m\]"
  GREY="\[\033[0m\]"
fi

function prompt_char {
  git branch >/dev/null 2>/dev/null && echo -e " ${BLUE}[git]" && return
  hg root >/dev/null 2>/dev/null && echo -e " ${BLUE}[hg]" && return
}

function ssh_connection() {
  if [[ -n $SSH_CONNECTION ]]; then
    echo -e "${ORANGE}ssh${GREY}:"
  fi
}

function _bg_jobs() {
  JC=$(jobs | ack '^\[[0-9]' | wc -l | xargs echo)
  if [ $JC -gt 0 ]; then
    echo -e "${GREY}:${BLUE}$JC"
  fi
}

function collapse_pwd {
    PWD=$(pwd | sed -e "s,^$HOME,~,")
    echo -n "$(echo $PWD | sed -E 's/\/(.)[^/]+/\/\1/g; s/.$//')$(echo $PWD | sed -E 's/^.+\/([^\/]+)$/\1/g')" | sed 's/\/\//\//g'
}

function username() {
  if [ ${ZSH_VERSION} ]; then
    echo "%n"
  else
    echo "\u"
  fi
}

function update_ps1 {
  PS1="${BLUE}`username`${GREY} on `ssh_connection`${GREEN}`collapse_pwd``prompt_char``_bg_jobs`${GREY}> "
}

PROMPT_COMMAND=update_ps1

[ ${ZSH_VERSION} ] && precmd() { update_ps1; }
