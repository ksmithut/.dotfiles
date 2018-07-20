# A list of functions/aliases to use to make some things easier.
# - every software program ever. except for PHP maybe.

alias ..='cd ../'
alias ...='cd ../../'
alias .3='cd ../../../'
alias .4='cd ../../../../'
alias .5='cd ../../../../../'
alias .6='cd ../../../../../../'

# makes a directory and moves to it
function dir() { mkdir -p "${1}" && builtin cd $_; }

# gpg helpers
alias gpg-ls='gpg --list-secret-keys --keyid-format LONG'

# starts simple http server in current directory
alias static='python -m SimpleHTTPServer'

# docker helpers
alias docker-stop-containers='docker stop $(docker ps -a -q)'
alias docker-remove-containers='docker rm $(docker ps -a -q)'
alias docker-remove-images='docker rmi $(docker images -a -q)'
alias docker-remove-volumes='docker volume rm $(docker volume ls -f dangling=true -q)'
alias docker-clean='docker-stop-containers; docker-remove-containers; docker-remove-images; docker-remove-volumes;'

# reverts to a given commit
function oh-crap() {
  if [ "$1" = "" ]; then
    echo 'You must pass in a commit id'
    return 1
  fi
  git reset --hard $1
  git reset --soft HEAD@{1}
  git commit -m "Revert to $1"
}

# removes branches that are no longer in origin
function git-prune-local() {
  git checkout master
  git fetch -p
  local branches="$(git branch -vv | awk '/: gone]/{print $1}')"
  if [ "$branches" = "" ]; then
    echo "All up to date"
    return 0
  fi
  echo -e "\nThis will remove the following branches locally:\n"
  printf '%s\n' "${branches[@]}"
  echo ''
  read -e -p 'Proceed? ' remove_branches
  case $remove_branches in
    [Yy]*)
      echo "$branches" | xargs git branch -D
      ;;
    *)
      echo "Alrighty then"
      ;;
  esac
}

# Open up coverage report
alias coverage='open coverage/lcov-report/index.html'

# Opens current github repo in a browser
alias github-open='open $(git remote get-url origin | sed "s/^git@\(.*\)\.com:\(.*\)\.git$/https:\/\/\1.com\/\2/g")'

# MD5 Checksum
alias checksum='openssl md5'

# sets default ls action to have trailing slashes at the end of directories
alias ls='ls -p'
alias la='ls -FGlAhp'
alias ll='la'

# dotfiles commands
function dotfiles() { cd $DOTFILES; }

# boilerplate
function setup-package() {
  yarn init -y -p
  cat package.json \
    | jq '.scripts = {}' \
    | jq '.dependencies = {}' \
    | jq '.devDependencies = {}' \
    | tee package.json 2>&1 >/dev/null
}

function setup-linting() {
  yarn add -D prettier-eslint-cli standard
  cat package.json \
    | jq '.scripts.format = "prettier-eslint '**/*.js' --write"' \
    | jq '.scripts.lint = "standard && prettier-eslint '**/*.js' --list-different"' \
    | tee package.json 2>&1 >/dev/null
  echo '{}' \
    | jq '.extends = "standard"' \
    | tee .eslintrc 2>&1 >/dev/null
}

function setup-gitignore() {
  echo '.DS_Store
*.log*
node_modules
coverage
config/local*
.env
!.env.example
.cache
dist
build' > .gitignore
}

function setup-config() {
  yarn add config dotenv
  mkdir -p config
  echo "'use strict'

module.exports = {}" > config/default.js
  echo "'use strict'

module.exports = {}" > config/production.js
  echo "'use strict'

require('dotenv').config()

module.exports = {}" > config/custom-environment-variables.js
}

function setup-project() {
  git init
  setup-package
  setup-gitignore
  setup-linting
  mkdir -p src
  echo "'use strict'" > src/index.js
  yarn add -D nodemon
  cat package.json \
    | jq '.main = "src/index.js"' \
    | jq '.scripts.start = "node $npm_package_main"' \
    | jq '.scripts["start.dev"] = "nodemon $npm_package_main --inspect=0.0.0.0:9229"' \
    | tee package.json 2>&1 >/dev/null
}

# macOS aliases/functions
# =======================
if is_macos; then
  alias slack-theme='echo "#1f1f1f,#303030,#21859c,#FFFFFF,#303030,#FFFFFF,#85d14b,#DB6668" | pbcopy; echo "copied!"'
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
fi

# Ubuntu aliases/functions
# ========================
if is_ubuntu; then
  alias slack-theme='echo "#1f1f1f,#303030,#21859c,#FFFFFF,#303030,#FFFFFF,#85d14b,#DB6668" | xclip -selection clipboard; echo "copied!"'
  # upgrade/update shortcuts
  alias apt-upgrade='sudo apt-get update -y; sudo apt-get upgrade -y; sudo apt-get autoremove -y'
  alias upgrade='apt-upgrade; sudo snap refresh'

  # Clear back buffer (like cmd + k)
  alias clear='clear && echo -en "\e[3J"'

  # sets default ls action to have trailing slashes at the end of directories
  alias ls='ls -p --color=auto'
  alias la='ls -FGlAhp --color=auto'

  # open for linux
  function open() {
    xdg-open "$*" &>/dev/null
  }
fi
