# beep
alias beep='echo -e "\a"'

# get ip addresses
alias myip='ipconfig getifaddr en0; curl ipecho.net/plain; echo'

# upgrade/update shortcuts
alias brew_upgrade='brew update; brew upgrade; brew cleanup'
alias nvm_upgrade='cd "$NVM_DIR" && git checkout master > /dev/null 2>&1 && git pull > /dev/null 2>&1 && git checkout $(git describe --abbrev=0 --tags) > /dev/null 2>&1; cd - > /dev/null; . "$NVM_DIR/nvm.sh";'
alias upgrade='brew_upgrade'

# Open up coverage report
alias coverage='open coverage/lcov-report/index.html'

# show/hide hidden files in finder
alias show='defaults write com.apple.finder AppleShowAllFiles -bool TRUE; killall Finder;'
alias hide='defaults write com.apple.finder AppleShowAllFiles -bool FALSE; killall Finder;'

# makes a directory and moves to it
function dir() { mkdir -p "${1}" && cd $_; }

# sets default ls action to have trailing slashes at the end of directories
alias ls='ls -p'
alias ll='ls -la'

# starts simple http server in current directory
alias static='python -m SimpleHTTPServer'

# Stop a docker image based on tag name
function docker_stop() { docker stop $(docker ps -ql -f ancestor=$1); }

# reverts to a given commit
function oh_crap() {
  if [ "$1" = "" ]; then
    echo 'You must pass in a commit id'
  fi
  git reset --hard $1
  git reset --soft HEAD@{1}
  git commit -m "Revert to $1"
}

# clone a repo
function clone() {
  local arr=(${1//\// })
  local length=${#arr[@]}
  local folder_name="$2"
  if [ "$length" != "2" ]; then
    echo 'Non-repo path given'
    return
  fi
  if [ "$2" = "" ]; then
    folder_name=${arr[1]}
  fi
  git clone "git@github.com:$1.git" "$folder_name"
  cd "$folder_name"
}

# dotfiles commands
function dotfiles() {
  case $1 in
    update)
      cd $DOTFILES
      git pull --rebase
      cd - > /dev/null
      ;;
    source)
      source ~/.bash_profile
      ;;
    *)
      cd $DOTFILES
      ;;
  esac
}
