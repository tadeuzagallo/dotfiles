RED="%F{red}"
ORANGE="%F{166}"
GREEN="%F{green}"
BLUE="%F{blue}"
YELLOW="%F{yellow}"
GREY="%F{grey}"

function _git_status() {
  git status | ack -i untr > /dev/null 2>&1
  if [ $? -eq 0 ]; then
    echo $RED
    return
  fi

  git status | ack -i "not sta" > /dev/null 2>&1
  if [ $? -eq 0 ]; then
    echo $ORANGE
    return
  fi

  git status | ack -i "to be" > /dev/null 2>&1
  if [ $? -eq 0 ]; then
    echo $YELLOW
    return
  fi

  echo $GREY
}

function prompt_char {
  git branch >/dev/null 2>/dev/null && echo "$(_git_status) ±$(git branch | ack '^\*' | sed -E 's/^\* //')%f" && return
  # hg root >/dev/null 2>/dev/null && echo ' ☿' && return
}

function ssh_connection() {
  if [[ -n $SSH_CONNECTION ]]; then
    echo "${YELLOW}ssh%f${GREY}:%f"
  fi
}

function _bg_jobs() {
  JC=$(jobs | ack '^\[[0-9]' | wc -l | xargs echo)
  if [ $JC -gt 0 ]; then
    echo "${GREY}:%f${BLUE}$JC%f"
  fi
}

function collapse_pwd {
    PWD=$(pwd | sed -e "s,^$HOME,~,")
    echo -n "$(echo $PWD | sed -E 's/\/(.)[^/]+/\/\1/g; s/.$//')$(echo $PWD | sed -E 's/^.+\/([^\/]+)$/\1/g')" | sed 's/\/\//\//g'
}

PROMPT='${BLUE}%n%f${GREY}%f ${GRAY}on%f ${GREEN}$(collapse_pwd)%f$(_bg_jobs)${GREY}$(prompt_char)%f%(?.. %{${RED}%}[%?]%{$reset_color%})${GREY}>%f '
RPROMPT=""
