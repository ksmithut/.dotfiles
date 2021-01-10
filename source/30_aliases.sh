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

# Type in filename.md or filename.js and it will open up in code
alias -s {md,js,css,html,json}=code

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
  alias brew-upgrade='brew update && brew upgrade && brew upgrade --cask --greedy && brew cleanup'
  alias upgrade='brew-upgrade'

  # show/hide hidden files in finder
  alias show='defaults write com.apple.finder AppleShowAllFiles -bool TRUE; killall Finder;'
  alias hide='defaults write com.apple.finder AppleShowAllFiles -bool FALSE; killall Finder;'

  alias uuid='printf "%s" "$(uuidgen | tr '"'"'[:upper:]'"'"' '"'"'[:lower:]'"'"')"'
fi

# Ubuntu/Debian/Pop!_OS aliases/functions
# =======================================
if is_ubuntu; then

  if is_wsl; then
    alias clipboard='clip.exe'
    alias open='wslview'
    alias xdg-open='wslview'
  else
    alias clipboard='xclip -selection clipboard'
    # open for linux
    function open() {
      xdg-open "$@" &>/dev/null
    }
  fi

  # upgrade/update shortcuts
  alias apt-upgrade='sudo apt-get update -y; sudo apt-get upgrade -y; sudo apt-get autoremove -y'
  alias upgrade='apt-upgrade; sudo snap refresh'

  # Clear back buffer (like cmd + k)
  alias clear='clear && echo -en "\e[3J"'

  # generates uuid
  alias uuid='printf "%s" $(cat /proc/sys/kernel/random/uuid)'
fi
