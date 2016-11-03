# beep
alias beep='echo -e "\a"'

# get ip addresses
alias myip='ipconfig getifaddr en0; curl ipecho.net/plain; echo'

# upgrade/update shortcuts
alias brew-upgrade='brew update; brew upgrade; brew cleanup'
alias nvm-upgrade='cd "$NVM_DIR" && git checkout master && git pull && git checkout $(git describe --abbrev=0 --tags); cd - > /dev/null; . "$NVM_DIR/nvm.sh";'
alias upgrade='brew-upgrade'

# cask shortcut
alias cask='brew cask'

# nvm set current version as default
alias nvm-default='nvm alias default $(nvm current)'

# Open up coverage report
alias coverage='open coverage/lcov-report/index.html'

# Make all directories 755 and files 644
alias fix-permissions='find * -type d -print0 | xargs -0 chmod 0755 && find . -type f -print0 | xargs -0 chmod 0644'

# Set the terminal title
function title() { echo -n -e "\033]0;$1\007"; }

# show/hide hidden files in finder
alias show='defaults write com.apple.finder AppleShowAllFiles -bool TRUE; killall Finder;'
alias hide='defaults write com.apple.finder AppleShowAllFiles -bool FALSE; killall Finder;'

# makes a directory and moves to it
function dir() { mkdir -p "${1}" && cd $_; }

# sets default ls action to have trailing slashes at the end of directories
alias ls='ls -p'

# database startups
alias mongo-up='mongod --config /usr/local/etc/mongod.conf'
alias redis-up='redis-server /usr/local/etc/redis.conf'
alias postgres-up='postgres -D /usr/local/var/postgres'

function mongo-drop-all() {
  read -p "Press Enter to delete all databases (or ctrl+c to cancel)"
  mongo --quiet --eval 'db.getMongo().getDBNames().forEach(function(i){db.getSiblingDB(i).dropDatabase()})'
  echo 'Done!'
}

# starts simple http server in current directory
alias static='python -m SimpleHTTPServer'
alias staticphp='php -S localhost:8000'

# display size of directory
alias space='du -sh'

# Stops all docker containers
alias docker-stop-all='docker stop $(docker ps -a -q)'

function rgb2hex() {
  local first=$(base -f 10 -t 16 $1)
  local second=$(base -f 10 -t 16 $2)
  local third=$(base -f 10 -t 16 $3)
  echo $first$second$third
}

function hex2rgb() {
  local first=$(base -f 16 -t 10 $1)
  local second=$(base -f 16 -t 10 $2)
  local third=$(base -f 16 -t 10 $3)
  echo "$first $second $third"
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
