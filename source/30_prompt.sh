#!/usr/bin/env sh

# ==============================================================================
# ==================================== git =====================================
# ==============================================================================
__powerline_git() {
  # Config
  local GIT_BRANCH_SYMBOL=''
  local GIT_BRANCH_CHANGED_SYMBOL='●'
  local GIT_NEED_PUSH_SYMBOL='⬆'
  local GIT_NEED_PULL_SYMBOL='⬇'
  local marks

  [ -x "$(which git)" ] || return # git not found

  local git_eng="env LANG=C git" # force git output in English to make our work easier
  # get current branch name or short SHA1 hash for detached head
  local branch="$($git_eng symbolic-ref --short HEAD 2>/dev/null || $git_eng describe --tags --always 2>/dev/null)"
  [ -n "$branch" ] || return # git branch not found

  # branch is modified?
  [ -n "$($git_eng status --porcelain)" ] && marks+=" $GIT_BRANCH_CHANGED_SYMBOL"

  # how many commits local branch is ahead/behind of remote?
  local stat="$($git_eng status --porcelain --branch | grep '^##' | grep -o '\[.\+\]$')"
  local aheadN="$(echo $stat | grep -o 'ahead [[:digit:]]\+' | grep -o '[[:digit:]]\+')"
  local behindN="$(echo $stat | grep -o 'behind [[:digit:]]\+' | grep -o '[[:digit:]]\+')"
  [ -n "$aheadN" ] && marks+=" $GIT_NEED_PUSH_SYMBOL$aheadN"
  [ -n "$behindN" ] && marks+=" $GIT_NEED_PULL_SYMBOL$behindN"

  # print the git branch segment without a trailing newline
  printf "$GIT_BRANCH_SYMBOL $branch$marks"
}

# ==============================================================================
# ==================================== cwd =====================================
# ==============================================================================
__powerline_cwd() {
  local escaped_home=$(printf $HOME | sed -e 's/[]\/$*.^|[]/\\&/g')
  printf $PWD | sed -e "s/^$escaped_home/~/"
}

# ==============================================================================
# ==================================== node ====================================
# ==============================================================================
__powerline_node() {
  if test -f "$PWD/package.json"; then
    node --version
  fi
}

# ==============================================================================
# ================================== battery ===================================
# ==============================================================================
__powerline_battery() {
  # Config
  local gamify=0
  local empty_heart='o'
  local filled_heart='♥'
  local num_hearts=10
  local percent
  # If Mac, get percentage a different way
  if [[ "$OSTYPE" =~ ^darwin ]]; then
    percent=$(pmset -g batt | grep '\d%' | sed -E "s/.*$(printf '\t')([0-9]+)%.*/\1/")
  else
    percent=$(upower -i $(upower -e | grep BAT) | grep --color=never -E percentage|xargs|cut -d' ' -f2|sed s/%//)
  fi

  if [ "$gamify" -eq "1" ]; then
    local filled_hearts=$(expr $percent / $num_hearts)
    for i in $(seq 0 $num_hearts); do
      printf $([ "$i" -le "$filled_hearts" ] && echo "$filled_heart" || echo "$empty_heart")
    done
  else
    printf "${percent}%%"
  fi
}

# ==============================================================================
# ==================================== time ====================================
# ==============================================================================
__powerline_time() {
  # Config
  local format='+%Y-%m-%dT%H:%M:%S%z'
  date $format
}

# ==============================================================================
# ================================= powerline  =================================
# ==============================================================================
__powerline() {
  # Config
  local _DIVIDER_SYMBOL=''
  local _SOFT_DIVIDER_SYMBOL=''
  local segments
  local output=''
  local prev_background
  local parts

  for segment in "${POWERLINE_CONFIG[@]}"; do
    IFS=':' read -r -a parts <<< "$segment"
    local function_name=${parts[0]}
    local foreground=${parts[1]}
    local background=${parts[2]}

    local segment_output="$(__powerline_${function_name})"
    if [ "$segment_output" != "" ]; then
      if [ "$prev_background" != "" ]; then
        output+="\001\033[38;5;${prev_background};48;5;${background}m\002${_DIVIDER_SYMBOL}"
      fi
      output+="\001\033[38;5;${foreground};48;5;${background}m\002 ${segment_output} "
      prev_background="$background"
    fi
  done

  if [ "$prev_background" != "" ]; then
    output+="\001\033[0m\033[38;5;${prev_background}m\002${_DIVIDER_SYMBOL}"
  fi

  output+='\001\033[0m\002 '

  echo -e "$output"
}

# Configuration goes as follows:
# {function}:{foreground}:{background}
#
# {function} is the function to run to get the output. The function should
# be exported as __powerline_{function}
#
# {foreground} and {background} are colors are ascii color codes. In the aliases
# file there is a function `colorgrid` which prints out the 256 color codes and
# what they look like in the terminal. Use that to determine the number you put
# in here.
POWERLINE_CONFIG=(
  # 'time:170:016'
  # 'battery:196:235'
  'cwd:232:039'
  'node:232:048'
  'git:232:227'
)

PS1='$(__powerline)'

# export environment variables
export CLICOLOR=1
# http://geoff.greer.fm/lscolors/
export LS_COLORS='di=36:ln=35:so=32:pi=33:ex=37:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43'
export LSCOLORS='gxfxcxdxhxegedabagacad'

# Append to history instead of overriding
shopt -s histappend
