#!/usr/bin/env bash
# A list of functions/aliases to use to make some things easier.
# - every software program ever. except for PHP maybe.

alias nowish='date +%Y-%m-%dT%H:%M:%S%z'

# makes a directory and moves to it
function dir() { mkdir -p "${1}" && cd "$_" || exit; }

# gpg helpers
alias gpg-ls='gpg --list-secret-keys --keyid-format LONG'

# starts simple http server in current directory
alias static='python -m SimpleHTTPServer'

# docker helpers
alias docker-stop-containers='[[ "$(docker ps -a -q)" != "" ]] && docker stop $(docker ps -a -q)'
alias docker-remove-containers='docker-stop-containers && [[ "$(docker ps -a -q)" != "" ]] && docker rm $(docker ps -a -q)'
alias docker-remove-volumes='docker-remove-containers && [[ "$(docker volume ls -f dangling=true -q)" != "" ]] && docker volume rm $(docker volume ls -f dangling=true -q)'
alias docker-remove-images='[[ "$(docker images -a -q)" != "" ]] && docker rmi -f $(docker images -a -q)'
alias docker-clean='docker-stop-containers; docker-remove-containers; docker-remove-volumes; docker-remove-images; docker system prune -f'

function extract () {
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

# Open up coverage report
alias coverage='open coverage/lcov-report/index.html'

# MD5 Checksum
alias checksum='openssl md5'

# Generates some self-signed certificates
alias generate-certs='openssl req -x509 -newkey rsa:2048 -nodes -sha256 -days 9999 -subj "/CN=localhost" -keyout localhost.key -out localhost.cert'

alias slack-theme='echo "#1f1f1f,#303030,#21859c,#FFFFFF,#303030,#FFFFFF,#85d14b,#DB6668" | clipboard; echo "copied!"'

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
  alias brew-upgrade='brew update; brew upgrade; brew cleanup'
  alias upgrade='brew-upgrade'

  # show/hide hidden files in finder
  alias show='defaults write com.apple.finder AppleShowAllFiles -bool TRUE; killall Finder;'
  alias hide='defaults write com.apple.finder AppleShowAllFiles -bool FALSE; killall Finder;'

  alias uuid='printf "%s" "$(uuidgen | tr '"'"'[:upper:]'"'"' '"'"'[:lower:]'"'"')"'
fi

# Ubuntu/Debian aliases/functions
# ========================
if is_ubuntu || is_debian; then
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
  alias uuid='printf "%s" "$(cat /proc/sys/kernel/random/uuid)"'

  # open for linux
  function open() {
    xdg-open "$*" &>/dev/null
  }
fi

function ksmithut () {
  echo -e '
  \033[38;5;247m⣿⣿⣿⣿⣿⣿⣿⡇⠀\033[38;5;075m⢀⣼⣿⣿⣿⣿⣿⣿⣿⣿⠋
  \033[38;5;247m⣿⣿⡏⠉⠉⣿⡟⠁\033[38;5;075m⣠⣿⣿⠟⠉⠉⣩⣿⣿⡟⠁⠀
  \033[38;5;247m⣿⣿⡇⠀⠀⠋\033[38;5;075m⢀⣴⣿⣿⠋⠀⠀⣴⣿⣿⠏⠀⠀⠀
  \033[38;5;247m⣿⣿⡇⠀⠀\033[38;5;075m⢠⣾⣿⡿⠁⠀⢀⣾⣿⡿⠁⠀⠀⠀⠀
  \033[38;5;247m⣿⣿⡇⠀\033[38;5;075m⣰⣿⣿⠏⠀⠀⣰⣿⣿⠟⠀⠀⠀⠀⠀⠀
  \033[38;5;247m⣿⣿⡇⠀\033[38;5;075m⠹⣿⣿⣆⠀⠀⠹⣿⣿⣦⠀⠀⠀⠀⠀⠀
  \033[38;5;247m⣿⣿⡇⠀⠀\033[38;5;075m⠘⢿⣿⣷⡀⠀⠘⢿⣿⣷⡀⠀⠀⠀⠀
  \033[38;5;247m⣿⣿⡇⠀⠀⣄\033[38;5;075m⠈⠻⣿⣿⣄⠀⠀⠻⣿⣿⣆⠀⠀⠀
  \033[38;5;247m⣿⣿⡇⠀⠀⣿⣦⡀\033[38;5;075m⠙⣿⣿⣧⡀⠀⠙⢿⣿⣧⡀⠀
  \033[38;5;247m⣿⣿⡇⠀⠀⣿⣿⡇⠀\033[38;5;075m⠈⢻⣿⣷⡄⠀⠈⢻⣿⣿⣄
  \033[00m'
}
