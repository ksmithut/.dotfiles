#!/usr/bin/env bash

# base64 encode
function be() {
  printf "%s" "$1" | base64
}


if is_macos; then
  # base64 decode
  function bd() {
    printf "%s" "$1" | base64 -D
  }
else
  # base64 decode
  function bd() {
    printf "%s" "$1" | base64 -d
  }
fi

# makes a directory and moves to it
function dir() {
  mkdir -p "${1}" && cd "$_" || exit;
}

# gpg helpers
alias gpg-ls='gpg --list-secret-keys --keyid-format LONG'

# starts simple http server in current directory
alias static='python -m SimpleHTTPServer'

# Extract contents from zipped/compressed file
function extract() {
  if [ -f "$1" ] ; then
    case "$1" in
      *.tar.bz2)   tar xvjf "$1"    ;;
      *.tar.gz)    tar xvzf "$1"    ;;
      *.bz2)       bunzip2 "$1"     ;;
      *.rar)       rar x "$1"       ;;
      *.gz)        gunzip "$1"      ;;
      *.tar)       tar xvf "$1"     ;;
      *.tbz2)      tar xvjf "$1"    ;;
      *.tgz)       tar xvzf "$1"    ;;
      *.zip)       unzip "$1"       ;;
      *.Z)         uncompress "$1"  ;;
      *.7z)        7z x "$1"        ;;
      *)           echo "don't know '$1'..." ;;
    esac
  else
    echo "'$1' is not a valid file!"
  fi
}

# Open up coverage report
alias coverage='open coverage/lcov-report/index.html'

# MD5 Checksum
alias checksum='openssl md5'

# Generates some self-signed certificates
alias generate-certs='openssl req -x509 -newkey rsa:2048 -nodes -sha256 -days 9999 -subj "/CN=localhost" -keyout localhost.key -out localhost.cert'

# A slack them I use commonly
alias slack-theme='echo "#1f1f1f,#303030,#21859c,#FFFFFF,#303030,#FFFFFF,#85d14b,#DB6668" | clipboard; echo "copied!"'

# Get the terminal colors and their numbers
function colorgrid() {
  iter=16
  while [ $iter -lt 52 ]
  do
    second=$((iter+36))
    third=$((second+36))
    four=$((third+36))
    five=$((four+36))
    six=$((five+36))
    seven=$((six+36))
    if [ $seven -gt 250 ];then seven=$((seven-251)); fi

    echo -en "\033[38;5;${iter}m█ "
    printf "%03d" $iter
    echo -en "   \033[38;5;${second}m█ "
    printf "%03d" $second
    echo -en "   \033[38;5;${third}m█ "
    printf "%03d" $third
    echo -en "   \033[38;5;${four}m█ "
    printf "%03d" $four
    echo -en "   \033[38;5;${five}m█ "
    printf "%03d" $five
    echo -en "   \033[38;5;${six}m█ "
    printf "%03d" $six
    echo -en "   \033[38;5;${seven}m█ "
    printf "%03d" $seven

    iter=$((iter+1))
    printf '\r\n'
  done
  echo -en "\033[00m"
}

alias neo='clear && neofetch'

function asdf-upgrade () {
  if [[ $(command -v asdf) ]]; then
    asdf plugin update --all
    local IFS=$'\n'
    local plugins=($(asdf plugin list))
    for plugin in "${plugins[@]}"; do
      asdf install "${plugin}" latest
      asdf global "${plugin}" "$(asdf latest ${plugin})"
    done
  fi
}

function asdf-install () {
  if [[ $(command -v asdf) ]]; then
    asdf plugin add "$1"
    asdf install "$1" latest
    asdf global "$1" "$(asdf latest "$1")"
  fi
}

function dotenv () {
  env $(cat .env | xargs) $@
}

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
  alias uuid='printf "%s" $(cat /proc/sys/kernel/random/uuid)'

  # open for linux
  function open() {
    xdg-open "$@" &>/dev/null
  }
fi
