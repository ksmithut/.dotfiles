#!/usr/bin/env sh

# ==================================== git  ====================================
__powerline_git() {
  [ -x "$(which git)" ] || return # git not found

  local git_eng="env LANG=C git" # force git output in English to make our work easier
  # get current branch name or short SHA1 hash for detached head
  local branch="$($git_eng symbolic-ref --short HEAD 2>/dev/null || $git_eng describe --tags --always 2>/dev/null)"
  [ -n "$branch" ] || return # git branch not found

  local GIT_BRANCH_SYMBOL=''
  local GIT_BRANCH_CHANGED_SYMBOL='●'
  local GIT_NEED_PUSH_SYMBOL='⬆'
  local GIT_NEED_PULL_SYMBOL='⬇'
  local marks

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

# ==================================== cwd  ====================================
__powerline_cwd() {
  local escaped_home=$(printf $HOME | sed -e 's/[]\/$*.^|[]/\\&/g')
  printf $PWD | sed -e "s/^$escaped_home/~/"
}

# ==================================== node ====================================
__powerline_node() {
  node --version
}

  # local _DATE=' \d '
  # local _TIME=' \t '
  # local _USER=' \u '
  # local _HOST=' \h '
  # local _CWD=' \w '
  # local _GIT='$(__git_info)'
  # local _EXIT_ERROR='$(__exit_code $?)'

# ================================= powerline  =================================
__powerline() {
  local _DIVIDER_SYMBOL=''
  local _SOFT_DIVIDER_SYMBOL=''
  local segments
  local output=''
  local prev_background
  local parts

  IFS=',' read -r -a segments <<< "$POWERLINE_CONFIG"
  for segment in "${segments[@]}"; do
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


# __prompt_node='node:232:048'
__prompt_cwd='cwd:232:039'
__prompt_git='git:232:227'
POWERLINE_CONFIG="$__prompt_cwd,$__prompt_git"

PS1='$(__powerline)'

# export environment variables
export CLICOLOR=1
# http://geoff.greer.fm/lscolors/
export LS_COLORS='di=36:ln=35:so=32:pi=33:ex=37:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43'
export LSCOLORS='gxfxcxdxhxegedabagacad'

# Append to history instead of overriding
shopt -s histappend
