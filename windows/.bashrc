###############################################################################
# Aliases
###############################################################################

alias l='ls -lah'

###############################################################################
# Terminal Prompt
###############################################################################

git_stats() {
  local STATUS=$(git status -s 2> /dev/null)
  local ADDED=$(echo "$STATUS" | grep '??' | wc -l)
  local DELETED=$(echo "$STATUS" | grep ' D' | wc -l)
  local MODIFIED=$(echo "$STATUS" | grep ' M' | wc -l)
  local STATS=''

  if [ $ADDED != 0 ]; then
    STATS="\e[42m $ADDED "
  fi

  if [ $DELETED != 0 ]; then
    STATS="$STATS\e[101m $DELETED "
  fi

  if [ $MODIFIED != 0 ]; then
    STATS="$STATS\e[30;103m $MODIFIED "
  fi

  echo -e "\e[0m    $STATS\e[0m"
}

function origin_dist {
 local STATUS="$(git status 2> /dev/null)"
 local DIST_STRING=""
 local IS_AHEAD=$(echo -n "$STATUS" | grep "ahead")
 local IS_BEHIND=$(echo -n "$STATUS" | grep "behind")

 if [ ! -z "$IS_AHEAD" ]; then
  local DIST_VAL=$(echo "$IS_AHEAD" | sed 's/[^0-9]*//g')
  DIST_STRING="$DIST_VAL ››"
 elif [ ! -z "$IS_BEHIND" ]; then
  local DIST_VAL=$(echo "$IS_BEHIND" | sed 's/[^0-9]*//g')
  DIST_STRING="‹‹ $DIST_VAL"
 fi

 if [ ! -z "$DIST_STRING" ]; then
  echo -en "\e[1;7m $DIST_STRING "
 fi
}

__PS1_BEFORE='\n\n'
__PS1_USER='\[\e[97;104m\] \u@\h '
__PS1_LOCATION='\[\e[30;43m\] \w '
__PS1_GIT_BRANCH='\[\e[97;45m\] `__git_ps1` ' __PS1_GIT_STATS='`git_stats` '
__PS1_GIT_DIST='`origin_dist`'
__PS1_AFTER='\[\e[0m\]\n\n\$ '

export PS1="${__PS1_BEFORE}${__PS1_USER}${__PS1_LOCATION}${__PS1_GIT_BRANCH}${__PS1_GIT_DIST}${__PS1_GIT_STATS}${__PS1_AFTER}"
