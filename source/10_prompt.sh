#!/usr/bin/env sh

__powerline() {

  __git_info() {
    [ -x "$(which git)" ] || return # git not found

    local git_eng="env LANG=C git" # force git output in English to make our work easier
    # get current branch name or short SHA1 hash for detached head
    local branch="$($git_eng symbolic-ref --short HEAD 2>/dev/null || $git_eng describe --tags --always 2>/dev/null)"
    [ -n "$branch" ] || return # git branch not found

    local GIT_BRANCH_SYMBOL='⑂'
    local GIT_BRANCH_CHANGED_SYMBOL='+'
    local GIT_NEED_PUSH_SYMBOL='⇡'
    local GIT_NEED_PULL_SYMBOL='⇣'
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
    printf "$GIT_BRANCH_SYMBOL $branch$marks "
  }

  local _RESET='\[\033[00m\]'
  local _BLACK='\[\033[0;30m\]'
  local _RED='\[\033[0;31m\]'
  local _GREEN='\[\033[0;32m\]'
  local _YELLOW='\[\033[0;33m\]'
  local _BLUE='\[\033[0;34m\]'
  local _PURPLE='\[\033[0;35m\]'
  local _CYAN='\[\033[0;36m\]'
  local _WHITE='\[\033[0;37m\]'
  local _BOLD_BLACK='\[\033[1;30m\]'
  local _BOLD_RED='\[\033[1;31m\]'
  local _BOLD_GREEN='\[\033[1;32m\]'
  local _BOLD_YELLOW='\[\033[1;33m\]'
  local _BOLD_BLUE='\[\033[1;34m\]'
  local _BOLD_PURPLE='\[\033[1;35m\]'
  local _BOLD_CYAN='\[\033[1;36m\]'
  local _BOLD_WHITE='\[\033[1;37m\]'
  local _UNDERLINE_BLACK='\[\033[4;30m\]'
  local _UNDERLINE_RED='\[\033[4;31m\]'
  local _UNDERLINE_GREEN='\[\033[4;32m\]'
  local _UNDERLINE_YELLOW='\[\033[4;33m\]'
  local _UNDERLINE_BLUE='\[\033[4;34m\]'
  local _UNDERLINE_PURPLE='\[\033[4;35m\]'
  local _UNDERLINE_CYAN='\[\033[4;36m\]'
  local _UNDERLINE_WHITE='\[\033[4;37m\]'
  local _BG_BLACK='\[\033[40m\]'
  local _BG_RED='\[\033[41m\]'
  local _BG_GREEN='\[\033[42m\]'
  local _BG_YELLOW='\[\033[43m\]'
  local _BG_BLUE='\[\033[44m\]'
  local _BG_PURPLE='\[\033[45m\]'
  local _BG_CYAN='\[\033[46m\]'
  local _BG_WHITE='\[\033[47m\]'

  local _DATE="\d "
  local _TIME="\t "
  local _USER="\u "
  local _HOST="\h "
  local _CWD="\w "
  local _GIT="\$(__git_info)"
  local _PROMPT="\$ "

  local DATE="$_WHITE$_DATE_$_RESET"
  local TIME="$_WHITE$_TIME$_RESET"
  local USER="$_WHITE$_USER$_RESET"
  local DIR="$_CYAN$_CWD$_RESET"
  local GIT="$_YELLOW$_GIT$_RESET"
  local PS_SYMBOL="$_WHITE$_PROMPT$_RESET"

  PS1=""
  # PS1+="$DATE"
  # PS1+="$TIME"
  # PS1+="$USER"
  PS1+="$DIR"
  PS1+="$GIT"
  PS1+="$PS_SYMBOL"
}

__powerline
unset __powerline

# export environment variables
export CLICOLOR=1
export LSCOLORS=gxfxcxdxhxegedabagacad # http://geoff.greer.fm/lscolors/
