# makes a directory and moves to it
function dir() { mkdir -p "${1}" && cd $_; }

# sets default ls action to have trailing slashes at the end of directories
alias ls='ls -p'
alias ll='ls -la'

# starts simple http server in current directory
alias static='python -m SimpleHTTPServer'

# Stop a docker image based on tag name
function docker-stop() { docker stop $(docker ps -ql -f ancestor=$1); }

# reverts to a given commit
function oh-crap() {
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

# Sets up linting for a node project
function setup-linting() {
  yarn add -D standard;
  cat package.json \
    | jq -M '.eslintConfig.root = true' \
    | jq -M '.eslintConfig.extends = ["standard"]' \
    | tee package.json &>/dev/null
}
# Sets up linting for a react project
function setup-linting-react() {
  yarn add -D standard babel-eslint;
  cat package.json \
    | jq -M '.eslintConfig.root = true' \
    | jq -M '.eslintConfig.parser = "babel-eslint"' \
    | jq -M '.eslintConfig.extends = ["standard","standard-jsx"]' \
    | tee package.json &>/dev/null
}
# Sets up testing for a typical javascript project
function setup-testing() {
  yarn add -D jest @types/jest;
  cat package.json \
    | jq -M '.jest.collectCoverage = true' \
    | tee package.json &>/dev/null
}

# Upgrade local packages interactively
alias upgrade-interactive='npx npm-upgrade'

# macOS aliases/functions
# =======================
if is_macos; then
  # beep
  alias beep='echo -e "\a"'

  # get ip addresses
  alias myip='ipconfig getifaddr en0; curl ipecho.net/plain; echo'

  # upgrade/update shortcuts
  alias brew-upgrade='brew update; brew upgrade; brew cleanup'
  alias upgrade='brew-upgrade'

  # Open up coverage report
  alias coverage='open coverage/lcov-report/index.html'

  # show/hide hidden files in finder
  alias show='defaults write com.apple.finder AppleShowAllFiles -bool TRUE; killall Finder;'
  alias hide='defaults write com.apple.finder AppleShowAllFiles -bool FALSE; killall Finder;'
fi

# Ubuntu aliases/functions
# ========================
if is_ubuntu; then
  # upgrade/update shortcuts
  alias apt-upgrade='sudo apt-get update -y; sudo apt-get upgrade -y'
  alias upgrade='apt-upgrade'
fi
