# A list of functions/aliases to use to make some things easier. Every software
# program ever. Except for PHP maybe.

# makes a directory and moves to it
function dir() { mkdir -p "${1}" && builtin cd $_; }

# gpg helpers
alias gpg-ls='gpg --list-secret-keys --keyid-format LONG'

# sets default ls action to have trailing slashes at the end of directories
alias ls='ls -p'
alias ll='ls -la'

# starts simple http server in current directory
alias static='python -m SimpleHTTPServer'

# start a node debugger in an existing process
alias node-debug='node -e "process.argv[1] && process._debugProcess(process.argv[1])" $(pgrep node | head -1)'

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
  cd $DOTFILES
}

# Sets up linting for a node project
function setup-linting() {
  yarn add -D standard;
  cat package.json \
    | jq -M '.scripts.lint = "standard"' \
    | jq -M '.eslintConfig.root = true' \
    | jq -M '.eslintConfig.extends = ["standard"]' \
    | tee package.json &>/dev/null
}
# Sets up linting for a react project
function setup-linting-react() {
  yarn add -D standard babel-eslint;
  cat package.json \
    | jq -M '.scripts.lint = "standard"' \
    | jq -M '.eslintConfig.root = true' \
    | jq -M '.eslintConfig.parser = "babel-eslint"' \
    | jq -M '.eslintConfig.extends = ["standard","standard-jsx"]' \
    | jq -M '.standard.parser = "babel-eslint"' \
    | tee package.json &>/dev/null
}
# Sets up testing for a typical javascript project
function setup-testing() {
  yarn add -D jest @types/jest;
  cat package.json \
    | jq -M '.jest.collectCoverage = true' \
    | jq -M '.jest.coverageThreshold.global.branches = 100' \
    | jq -M '.jest.coverageThreshold.global.functions = 100' \
    | jq -M '.jest.coverageThreshold.global.lines = 100' \
    | jq -M '.jest.coverageThreshold.global.statements = 100' \
    | tee package.json &>/dev/null
}

# Get git status of all projects in current directory
function git-super-status() {
  for d in *; do
    if [[ -d $d ]]; then
      builtin cd $d
      git fetch
      local directory="\033[0;36m${d}\033[00m"
      local rawBranch=$(git rev-parse --abbrev-ref HEAD)
      local status="\033[0;33m$(__git_info)\033[00m"

      printf "Status for ${directory}:\n"
      printf "Status: ${status}\n"
      echo
      builtin cd ..
    fi
  done
}

# Print out ansii grid colors
function colorgrid() {
  iter=16
  while [ $iter -lt 52 ]
  do
    second=$[$iter+36]
    third=$[$second+36]
    four=$[$third+36]
    five=$[$four+36]
    six=$[$five+36]
    seven=$[$six+36]
    if [ $seven -gt 250 ];then seven=$[$seven-251]; fi

    echo -en "\033[38;5;$(echo $iter)m█ "
    printf "%03d" $iter
    echo -en "   \033[38;5;$(echo $second)m█ "
    printf "%03d" $second
    echo -en "   \033[38;5;$(echo $third)m█ "
    printf "%03d" $third
    echo -en "   \033[38;5;$(echo $four)m█ "
    printf "%03d" $four
    echo -en "   \033[38;5;$(echo $five)m█ "
    printf "%03d" $five
    echo -en "   \033[38;5;$(echo $six)m█ "
    printf "%03d" $six
    echo -en "   \033[38;5;$(echo $seven)m█ "
    printf "%03d" $seven

    iter=$[$iter+1]
    printf '\r\n'
  done
  echo -en "\033[00m"
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

  # Opens current github repo in a browser
  alias git-open='open $(git remote get-url origin | sed "s/^git@\(.*\)\.com:\(.*\)\.git$/https:\/\/\1.com\/\2/g")'

  # MD5 Checksum
  alias checksum='openssl md5'
fi

# Ubuntu aliases/functions
# ========================
if is_ubuntu; then
  # upgrade/update shortcuts
  alias apt-upgrade='sudo apt-get update -y; sudo apt-get upgrade -y; sudo apt-get autoremove -y'
  alias upgrade='apt-upgrade'

  # MD5 Checksum
  alias checksum='md5sum'

  # Clear back buffer (like cmd + k)
  alias clear='clear && echo -en "\e[3J"'

  # vim over vi on linux
  alias vi='vim'

  # open for linux
  function open() {
    xdg-open "$*" &>/dev/null
  }
fi
