# A list of functions/aliases to use to make some things easier.
# - every software program ever. except for PHP maybe.

# makes a directory and moves to it
function dir() { mkdir -p "${1}" && builtin cd $_; }

# gpg helpers
alias gpg-ls='gpg --list-secret-keys --keyid-format LONG'

# starts simple http server in current directory
alias static='npx serve --open'

# start a node debugger in an existing process
alias node-debug='node -e "process.argv[1] && process._debugProcess(process.argv[1])" $(pgrep node | head -1)'

# docker helpers
alias docker-stop-containers='docker stop $(docker ps -a -q)'
alias docker-remove-containers='docker rm $(docker ps -a -q)'
alias docker-remove-images='docker rmi $(docker images -a -q)'
alias docker-remove-volumes='docker volume rm $(docker volume ls -f dangling=true -q)'
alias docker-clean='docker-stop-containers; docker-remove-containers; docker-remove-images; docker-remove-volumes;'

alias slack-theme='echo "#1f1f1f,#303030,#21859c,#FFFFFF,#303030,#FFFFFF,#85d14b,#DB6668" | pbcopy; echo "copied!"'

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

# clone a repo
function clone() {
  local arr=(${1//\// })
  local length=${#arr[@]}
  local folder_name="$2"
  if [ "$length" != "2" ]; then
    echo 'Non-repo path given'
    return 1
  fi
  if [ "$2" = "" ]; then
    folder_name=${arr[1]}
  fi
  git clone "git@github.com:$1.git" "$folder_name"
  cd "$folder_name"
}

# dotfiles commands
function dotfiles() { cd $DOTFILES; }

# Print out ansii grid colors
function colorgrid() {
  local iter=16
  while [ $iter -lt 52 ]
  do
    local second=$[$iter+36]
    local third=$[$second+36]
    local four=$[$third+36]
    local five=$[$four+36]
    local six=$[$five+36]
    local seven=$[$six+36]
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
alias upgrade-interactive='npx npm-check'

# dock
# a cli to run software using docker
# ==================================
function dock () {
  local compose_file=~/.dock.docker-compose.yaml
  case $1 in
    -h|--help|help)
      echo "Run docker containers with a single word command using a"
      echo "docker-compose file in your home directory. This file should be"
      echo "placed at $compose_file, and should conform to the docker-compose"
      echo "format that your version of docker-compose supports."
      echo
      echo "You must have ruby and jq installed for `dock list` and `dock ls`"
      echo "to work."
      ;;
    ls|list)
      echo "$(ruby -ryaml -rjson -e 'puts JSON.pretty_generate(YAML.load(ARGF))' $compose_file | jq -r '.services | keys[]')"
      ;;
    *)
      docker-compose --file $compose_file --project-name dock up --build $1
      docker-compose --file $compose_file --project-name dock rm --stop --force $1
      ;;
  esac
}
function _dock_complete() {
  local cur
  COMPREPLY=()
  cur=${COMP_WORDS[COMP_CWORD]}
  COMPREPLY=( $( compgen -W "$(dock ls)" -- "$cur" ) )
  return 0
}
complete -F _dock_complete dock

# project boilerplate snippets
# ============================
function setup-gitignore() {
  echo '.DS_Store
*.log*
node_modules
coverage
config/local*
.env
.cache
dist
build' > .gitignore
}

function setup-linting() {
  yarn add -D prettier-eslint-cli standard
  cat package.json \
    | jq '.scripts.format = "prettier-eslint '"'"'**/*.js'"'"' --write"' \
    | jq '.scripts.lint = "prettier-eslint '"'"'**/*.js'"'"' --list-different && standard"' \
    | tee package.json 2>&1 >/dev/null
  echo '{}' \
    | jq '.extends = ["standard"]' \
    | tee .eslintrc 2>&1 >/dev/null
}

function setup-linting-babel() {
  setup-linting
  yarn add -D babel-eslint
  cat .eslintrc \
    | jq '.parser = "babel-eslint"' \
    | tee .eslintrc 2>&1 >/dev/null
}

function setup-linting-jsx() {
  setup-linting-babel
  cat .eslintrc \
    | jq '.extends = .extends + ["standard-jsx"]' \
    | tee .eslintrc 2>&1 >/dev/null
}

function setup-node() {
  mkdir -p src
  echo "'use strict'" > src/index.js
  yarn init --private --yes
  cat package.json \
    | jq '.main = "src/index.js"' \
    | jq '.scripts = .scripts? + {}' \
    | jq '.dependencies = .dependencies? + {}' \
    | jq '.devDependencies = .devDependencies? + {}' \
    | tee package.json 2>&1 >/dev/null
  setup-linting
  setup-gitignore
}

# macOS aliases/functions
# =======================
if is_macos; then
  alias chime-off='sudo nvram SystemAudioVolume=%80'
  alias chime-on='sudo nvram -d SystemAudioVolume'

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

  # sets default ls action to have trailing slashes at the end of directories
  alias ls='ls -p'
  alias ll='ls -la'
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

  # sets default ls action to have trailing slashes at the end of directories
  alias ls='ls -p --color=auto'
  alias ll='ls -la --color=auto'

  # open for linux
  function open() {
    xdg-open "$*" &>/dev/null
  }
fi
