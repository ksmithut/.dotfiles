#!/usr/bin/env bash

# reverts to a given commit
function oh-crap() {
  if [[ "$1" == "" ]]; then
    echo 'You must pass in a commit id'
    return 1
  fi
  git reset --hard "$1"
  git reset --soft "HEAD@{1}"
  git commit -m "Revert to $1"
}

function ghclone() {
  local dirname
  dirname="${1##*/}"
  git clone git@github.com:"$1" || return 1
  cd "$dirname" || return 1
}

# show off
alias neo='clear && neofetch'

# macOS aliases/functions
# =======================
if is_macos; then
  alias clipboard='pbcopy'
  alias chime-off='sudo nvram SystemAudioVolume=%80'
  alias chime-on='sudo nvram -d SystemAudioVolume'

  # beep
  alias beep='echo -e "\a"'

  # get ip addresses
  alias myip='ipconfig getifaddr en0; curl ipecho.net/plain; echo'

  # upgrade/update shortcuts
  alias brew-upgrade='brew update && brew upgrade && brew cask upgrade && brew cleanup'
  alias upgrade='brew-upgrade'

  # show/hide hidden files in finder
  alias show='defaults write com.apple.finder AppleShowAllFiles -bool TRUE; killall Finder;'
  alias hide='defaults write com.apple.finder AppleShowAllFiles -bool FALSE; killall Finder;'

  alias uuid='printf "%s" "$(uuidgen | tr '"'"'[:upper:]'"'"' '"'"'[:lower:]'"'"')"'
fi

# Ubuntu/Debian/Pop!_OS aliases/functions
# =======================================
if is_ubuntu; then

  alias clipboard='xclip -selection clipboard'

  # upgrade/update shortcuts
  alias apt-upgrade='sudo apt-get update -y; sudo apt-get upgrade -y; sudo apt-get autoremove -y'

  if is_ubuntu; then
    alias upgrade='apt-upgrade; sudo snap refresh'
  else
    alias upgrade='apt-upgrade'
  fi

  # Clear back buffer (like cmd + k)
  alias clear='clear && echo -en "\e[3J"'

  # generates uuid
  alias uuid='printf "%s" "$(cat /proc/sys/kernel/random/uuid)'

  # open for linux
  function open() {
    xdg-open "$@" &>/dev/null
  }
fi
