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

function ssh_connection() {
  if [[ -n $SSH_CONNECTION ]]; then
    echo -e "${ORANGE}ssh${GREY}:"
  fi
}

function _bg_jobs() {
  JC=$(jobs | grep '^\[[0-9]' | wc -l | xargs echo)
  if [ $JC -gt 0 ]; then
    echo -e "${GREY}:${RED}$JC"
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

# notify_me: http://frantic.im/notify-on-completion
function f_notifyme {
  # only run if $NOTIFY_ME is set
  [ -z "$NOTIFY_ME" ] && return

  LAST_EXIT_CODE=$?
  CMD=$(fc -ln -1)
  # No point in waiting for the command to complete
  ~/.notify_me "$CMD" "$LAST_EXIT_CODE" &
}

PS1='$(f_notifyme)$(ssh_connection)${GREEN}$(collapse_pwd)$(_bg_jobs) ${BLUE}=> ${GREY}'

setopt promptsubst
