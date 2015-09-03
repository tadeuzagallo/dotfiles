RED="\e[31m"
ORANGE="\e[33m"
GREEN="\e[32m"
BLUE="\e[34m"
YELLOW="\e[93m"
BLACK="\e[30m"
GREY="\e[m"

function _git_status() {
  git status | ack -i untr > /dev/null 2>&1
  if [ $? -eq 0 ]; then
    printf $RED
    return
  fi

  git status | ack -i "not sta" > /dev/null 2>&1
  if [ $? -eq 0 ]; then
    printf $ORANGE
    return
  fi

  git status | ack -i "to be" > /dev/null 2>&1
  if [ $? -eq 0 ]; then
    printf $YELLOW
    return
  fi

  printf $GREY
}

function prompt_char {
  git branch >/dev/null 2>/dev/null && echo " $(_git_status)git[$(git branch | ack '^\*' | sed -E 's/^\* //')]" && return
  hg root >/dev/null 2>/dev/null && printf " ${GREY}hg[$(hg branch)]" && return
}

function ssh_connection() {
  if [[ -n $SSH_CONNECTION ]]; then
    echo "${YELLOW}ssh${GREY}:"
  fi
}

function _bg_jobs() {
  JC=$(jobs | ack '^\[[0-9]' | wc -l | xargs echo)
  if [ $JC -gt 0 ]; then
    echo "${GREY}:${BLUE}$JC"
  fi
}

function collapse_pwd {
    PWD=$(pwd | sed -e "s,^$HOME,~,")
    echo -n "$(echo $PWD | sed -E 's/\/(.)[^/]+/\/\1/g; s/.$//')$(echo $PWD | sed -E 's/^.+\/([^\/]+)$/\1/g')" | sed 's/\/\//\//g'
}

PS1="${BLUE}\u${GREY} on ${GREEN}\$(collapse_pwd)\$(_bg_jobs)\$(prompt_char)${GREY}> "
