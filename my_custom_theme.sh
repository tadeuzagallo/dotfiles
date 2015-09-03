RED="\[\033[1;31m\]"
ORANGE="\[\033[33m\]"
GREEN="\[\033[1;32m\]"
BLUE="\[\033[1;34m\]"
YELLOW="\[\033[1;33m\]"
BLACK="\[\033[30m\]"
GREY="\[\033[0m\]"

function _git_status() {
  git status | ack -i untr > /dev/null 2>&1
  if [ $? -eq 0 ]; then
    echo -e $RED
    return
  fi

  git status | ack -i "not sta" > /dev/null 2>&1
  if [ $? -eq 0 ]; then
    echo -e $ORANGE
    return
  fi

  git status | ack -i "to be" > /dev/null 2>&1
  if [ $? -eq 0 ]; then
    echo -e $BLUE
    return
  fi

  echo -e $GREY
}

function prompt_char {
  git branch >/dev/null 2>/dev/null && echo -e " $(_git_status)git[$(git branch | ack '^\*' | sed -E 's/^\* //')]" && return
  hg root >/dev/null 2>/dev/null && echo -e " ${GREY}hg[$(hg branch)]" && return
}

function ssh_connection() {
  if [[ -n $SSH_CONNECTION ]]; then
    echo -e "${YELLOW}ssh${GREY}:"
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

function update_ps1 {
  PS1="\\[${BLUE}\u${GREY} on `ssh_connection`${GREEN}\$(collapse_pwd)`prompt_char``_bg_jobs`${GREY}> "
}

PROMPT_COMMAND=update_ps1
