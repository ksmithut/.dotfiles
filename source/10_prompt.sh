#!/usr/bin/env sh

__powerline() {

    __git_info() {
        [ -x "$(which git)" ] || return    # git not found

        local git_eng="env LANG=C git"   # force git output in English to make our work easier
        # get current branch name or short SHA1 hash for detached head
        local branch="$($git_eng symbolic-ref --short HEAD 2>/dev/null || $git_eng describe --tags --always 2>/dev/null)"
        [ -n "$branch" ] || return  # git branch not found

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
        printf "$GIT_BRANCH_SYMBOL $branch$marks"
    }

    local RESET='\[\033[00m\]'
    local BLACK='\[\033[0;30m\]'
    local RED='\[\033[0;31m\]'
    local GREEN='\[\033[0;32m\]'
    local YELLOW='\[\033[0;33m\]'
    local BLUE='\[\033[0;34m\]'
    local PURPLE='\[\033[0;35m\]'
    local CYAN='\[\033[0;36m\]'
    local WHITE='\[\033[0;37m\]'
    local BOLD_BLACK='\[\033[1;30m\]'
    local BOLD_RED='\[\033[1;31m\]'
    local BOLD_GREEN='\[\033[1;32m\]'
    local BOLD_YELLOW='\[\033[1;33m\]'
    local BOLD_BLUE='\[\033[1;34m\]'
    local BOLD_PURPLE='\[\033[1;35m\]'
    local BOLD_CYAN='\[\033[1;36m\]'
    local BOLD_WHITE='\[\033[1;37m\]'
    local UNDERLINE_BLACK='\[\033[4;30m\]'
    local UNDERLINE_RED='\[\033[4;31m\]'
    local UNDERLINE_GREEN='\[\033[4;32m\]'
    local UNDERLINE_YELLOW='\[\033[4;33m\]'
    local UNDERLINE_BLUE='\[\033[4;34m\]'
    local UNDERLINE_PURPLE='\[\033[4;35m\]'
    local UNDERLINE_CYAN='\[\033[4;36m\]'
    local UNDERLINE_WHITE='\[\033[4;37m\]'
    local BG_BLACK='\[\033[40m\]'
    local BG_RED='\[\033[41m\]'
    local BG_GREEN='\[\033[42m\]'
    local BG_YELLOW='\[\033[43m\]'
    local BG_BLUE='\[\033[44m\]'
    local BG_PURPLE='\[\033[45m\]'
    local BG_CYAN='\[\033[46m\]'
    local BG_WHITE='\[\033[47m\]'

    local DATE="\d"
    local TIME="\t"
    local USER="\u"
    local HOST="\h"
    local CWD="\w"

    local _USER="$BLACK$BG_WHITE $USER $RESET"
    local _TIME="$CYAN$TIME $RESET"
    local _DIR="$CYAN$CWD $RESET"
    local _GIT="$YELLOW\$(__git_info)$RESET"
    local _PS_SYMBOL="$WHITE \$ $RESET"

    PS1=""
    # PS1+="$_TIME"
    # PS1+="$_USER"
    PS1+="$_DIR"
    PS1+="$_GIT"
    PS1+="$_PS_SYMBOL"
}

__powerline
unset __powerline

# export environment variables
export CLICOLOR=1
export LSCOLORS=gxfxcxdxhxegedabagacad # http://geoff.greer.fm/lscolors/
