# get ip addresses
alias ip='ipconfig getifaddr en0; curl ipecho.net/plain; echo'

# upgrade/update shortcuts
alias brew-upgrade='brew update; brew upgrade --all; brew cleanup'
alias nvm-upgrade='PREV_DIR=$(pwd) && cd "$NVM_DIR" && git checkout master && git pull && git checkout $(git describe --abbrev=0 --tags); cd $PREV_DIR; unset PREV_DIR;'
alias upgrade='brew-upgrade'

# cask shortcut
alias cask='brew cask'

# nvm set current version as default
alias nvm-default='nvm alias default $(nvm current)'

# Open up coverage report
alias coverage='open coverage/lcov-report/index.html'

# Make all directories 755 and files 644
alias fix-permissions='find * -type d -print0 | xargs -0 chmod 0755 && find . -type f -print0 | xargs -0 chmod 0644'

# Open up npm package on npmjs.com
function npen() { open "https://www.npmjs.com/packages/$1"; }

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

# starts simple http server in current directory
alias static='python -m SimpleHTTPServer'
alias staticphp='php -S localhost:8000'

# makes it possible to switch to shorter prompt
alias resetprompt='. prompt path branch'

# display size of directory
alias space='du -sh'

function dotfiles() {
  case $1 in
    update)
      local prev_pwd="$(pwd)"
      cd $DOTFILES
      git pull --rebase
      cd "$prev_pwd"
      ;;
    source)
      source ~/.bash_profile
      ;;
    *)
      cd $DOTFILES
      ;;
  esac
}
