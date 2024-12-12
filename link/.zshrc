#!/usr/bin/env zsh
# Initialize the DOTFILES variable so other scripts can use it

pushd . > /dev/null || exit
DOTFILES="$(builtin cd "$(dirname "$(readlink "${(%):-%N}")")/../" || exit; pwd -P)"
export DOTFILES
popd > /dev/null || exit

# OS detection
is-macos () { [[ "$OSTYPE" =~ ^darwin ]] || return 1; }
is-apple-silicon () { is-macos && [[ "$(arch)" == "arm64" ]] || return 1; }
is-ubuntu () { [[ "$(cat /etc/issue 2> /dev/null)" =~ Ubuntu ]] || [[ "$(cat /etc/issue 2> /dev/null)" =~ "Pop!_OS" ]] || return 1; }
is-zsh () { [[ "${ZSH_NAME}" == "zsh" ]] || return 1; }
is-windows () { [[ "${OS}" == "Windows_NT" ]] || return 1; }
is-linux () { [[ "$(which_os)" == "linux" ]] || return 1; }
is-wsl () { [[ "$(cat /proc/version 2> /dev/null)" =~ microsoft ]] || return 1; }
dotfiles () { cd "${DOTFILES}"; }

# ===============================================
# env
# ===============================================
PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"
PATH="/opt/homebrew/opt/curl/bin:$PATH"
PATH="$HOME/.docker/bin:$PATH"
export PATH
# Shell config
export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_NO_AUTO_UPDATE=1
export HOMEBREW_NO_ENV_HINTS=1
export EDITOR=vi
# dotnet telemetry optout
export DOTNET_CLI_TELEMETRY_OPTOUT=1
# next.js telemetry optout
export NEXT_TELEMETRY_DISABLED=1
# Elixir history
export ERL_AFLAGS="-kernel shell_history enabled"
export KERL_CONFIGURE_OPTIONS="--without-javac"
# https://github.com/npm/npm/issues/11696
# export COMP_WORDBREAKS=${COMP_WORDBREAKS//:}

ulimit -n 8192

# ===============================================
# zsh config
# ===============================================
ZSH_DISABLE_COMPFIX=true
export ZSH="${HOME}/.oh-my-zsh"
export ZSH_THEME="agnoster"
export DEFAULT_USER=${USER}

plugins=(
  # git
  # node
  # yarn
  # docker
  # vscode
  # tmux
  # gpg-agent
  ssh-agent
  # kubectl
  # kubectx
  autojump
  # web-search
  mix-fast
  # mise
)

# shellcheck disable=SC1090
source "$ZSH/oh-my-zsh.sh"

autoload -U add-zsh-hook
add-zsh-hook -Uz chpwd (){ la; }

if [ -f ~/.zshrc.local ]; then
  . ~/.zshrc.local
fi

# ===============================================
# functions/aliases
# ===============================================

# base64 encode
function be() {
  printf "%s" "$1" | base64
}

# base64 decode
if is-macos; then
  function bd() {
    printf "%s" "$1" | base64 -D
  }
else
  function bd() {
    printf "%s" "$1" | base64 -d
  }
fi

if is-macos; then
  function whos-using-my-port {
    lsof -i -P | grep LISTEN | grep ":$1 "
  }
fi

# gpg helpers
alias gpg-ls='gpg --list-secret-keys --keyid-format LONG'

# Change all permissions to 755 for directories and 644 for files
alias fix-permissions='find . -type d -exec chmod 755 {} \; && find . -type f -exec chmod 644 {} \;'

# starts simple http server in current directory
alias static='python3 -m http.server'

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
function coverage {
  if [[ -f 'coverage/lcov-report/index.html' ]]; then
    open coverage/lcov-report/index.html
  elif [[ -f 'coverage/index.html' ]]; then
    open coverage/index.html
  elif [[ -f 'cover/excoveralls.html' ]]; then
    open cover/excoveralls.html
  else
    echo 'No coverage html file found'
  fi
}

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

function dotenv () {
  env $(cat .env | xargs) $@
}

alias rgb-to-hex='node -p "process.argv.slice(1).flatMap(i=>i.split(\",\")).map(n=>parseInt(n,10).toString(16)).join(\"\")"'
alias hex-to-rgb='node -p "process.argv[1].replace(/[^0-9a-f]/gi,\"\").split(\"\").reduce((a,x,i)=>{i=Math.floor(i/2);a[i]??=[];a[i].push(x);return a},[]).map(c=>parseInt(c.join(\"\"),16)).join(\",\")"'
alias decode-jwt='node -e "process.argv[1].split(\".\").slice(0, 2).map(p=>JSON.parse(Buffer.from(p,\"base64\"))).forEach(p=>console.log(p))"'
alias jwt-decode='decode-jwt'

# Type in filename.md or filename.js and it will open up in code
alias -s {md,js,css,html,json,graphql,http,jsx,prisma}=zed

# Generate a .gitignore file
function gitignore () {
  curl -sLw "\n" https://www.toptal.com/developers/gitignore/api/$@ ;
}
function gitignore-node () {
  gitignore macos,windows,linux,node,react
}
function gitignore-elixir () {
  gitignore macos,windows,linux,elixir,phoenix
}

function template() {
  if [ "$1" = "" ]; then
    ls "${DOTFILES}/templates" | cut -f1
    return 0
  fi
  if [ "$2" = "" ]; then
    echo 'You must pass in two arguments'
    echo 'template <template> <name>'
    return 1
  fi
  local template_path="${DOTFILES}/templates/$1"
  if [ -d "${template_path}" ]; then
    cp -R "${template_path}/" "$2"
    cd "$2"
    local init_script_path="./.template.sh"
    if [ -f "${init_script_path}" ]; then
      sh "${init_script_path}"
      rm "${init_script_path}"
    fi
  else
    echo "No template with name '${1}' found"
    return 1
  fi
}

function cidr {
  node -e '
    const assert = (condition, message) => condition || (console.error(message) || process.exit(1))
    const chunk = (array, size) => Array(Math.ceil(array.length / size)).fill().map((_, index) => index * size).map(begin => array.slice(begin, begin + size))
    const arg = process.argv[1]
    assert(typeof arg === "string", "You must pass in a valid ip v4 cidr")
    const [ip, range] = arg.split("/", 2)
    assert(net.isIPv4(ip), "Not a valid ip v4 cidr")
    const rangeNumber = Number.parseInt(range, 10)
    assert(rangeNumber >= 0 && rangeNumber <= 32, "Not a valid ip v4 cidr")
    const binary = ip.split(".", 4).map(n => Number.parseInt(n, 10).toString(2).padStart(8, "0")).join("")
    const start = chunk(binary.split("").fill("0", rangeNumber), 8).map(bits => Number.parseInt(bits.join(""), 2)).join(".")
    const end = chunk(binary.split("").fill("1", rangeNumber), 8).map(bits => Number.parseInt(bits.join(""), 2)).join(".")
    console.log(start)
    console.log(end)
  ' $1
}

# macOS aliases/functions
# =======================
if is-macos; then
  alias clipboard='pbcopy'

  # beep
  alias beep='echo -e "\a"'

  # get ip addresses
  alias myip='ipconfig getifaddr en0; curl icanhazip.com; echo'

  # upgrade/update shortcuts
  alias brew-upgrade='brew update && brew upgrade && brew upgrade --cask --greedy && brew cleanup'
  alias upgrade='brew-upgrade'

  # show/hide hidden files in finder
  alias uuid='printf "%s" "$(uuidgen | tr '"'"'[:upper:]'"'"' '"'"'[:lower:]'"'"')"'
fi

# Ubuntu/Debian/Pop!_OS aliases/functions
# =======================================
if is-ubuntu; then
  if is-wsl; then
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

  alias myip='curl icanhazip.com; echo'
fi

# ===============================================
# Docker functions aliases
# ===============================================

# docker cleanup helpers
alias docker-containers-stop='[[ "$(docker ps -a -q)" != "" ]] && docker stop $(docker ps -a -q); true'
alias docker-containers-remove='docker-containers-stop && [[ "$(docker ps -a -q)" != "" ]] && docker rm --volumes $(docker ps -a -q); true'
alias docker-volumes-remove='docker-containers-remove && [[ "$(docker volume ls -f dangling=true -q)" != "" ]] && docker volume rm $(docker volume ls -f dangling=true -q); true'
alias docker-images-remove='[[ "$(docker images -a -q)" != "" ]] && docker rmi -f $(docker images -a -q); true'
alias docker-clean='docker-containers-stop; docker-containers-remove; docker-volumes-remove; docker-images-remove; docker system prune -f -a; true'

function docker-restart () {
  docker container restart $(docker ps -a | grep $1 | awk '{print $1}')
}

function docker-logs () {
  docker logs -f $(docker ps -a | grep $1 | awk '{print $1}') --tail 100
}

function docker-image-extract () {
  docker create --name "$1" "$2"
  take "$1"
  docker export "$1" > "$1".tar
  tar xvf "$1".tar
  docker rm "$1"
}

function dock() {
  case $1 in
    # https://hub.docker.com/_/mongo/
    mongo)
      echo 'mongodb://localhost:27017'
      echo ''
      docker run --name 'dock_mongo' --publish '27017:27017' mongo:latest
      docker stop 'dock_mongo'
      docker rm --volumes 'dock_mongo'
      ;;
    mongo-store)
      echo 'mongodb://localhost:27017'
      echo ''
      docker run --name 'dock_mongo' --publish '27017:27017' --volume "$(pwd)/.data/mongo:/data/db" mongo:latest
      docker stop 'dock_mongo'
      docker rm --volumes 'dock_mongo'
      ;;

    # https://hub.docker.com/_/redis/
    redis)
      echo 'redis://127.0.0.1:6379'
      echo ''
      docker run --name 'dock_redis' --publish '6379:6379' redis:alpine
      docker stop 'dock_redis'
      docker rm --volumes 'dock_redis'
      ;;
    redis-store)
      echo 'redis://127.0.0.1:6379'
      echo ''
      docker run --name 'dock_redis' --publish '6379:6379' --volume "$(pwd)/.data/redis:/data" redis:alpine
      docker stop 'dock_redis'
      docker rm --volumes 'dock_redis'
      ;;

    # https://hub.docker.com/_/postgres/
    postgres)
      echo 'postgres://postgres:postgres@localhost:5432/postgres'
      echo ''
      docker run --name 'dock_postgres' --publish '5432:5432' --env 'POSTGRES_USER=postgres' --env 'POSTGRES_PASSWORD=postgres' --env 'POSTGRES_DB=postgres' postgres:alpine
      docker stop 'dock_postgres'
      docker rm --volumes 'dock_postgres'
      ;;
    postgres-store)
      echo 'postgres://postgres:postgres@localhost:5432/postgres'
      echo ''
      docker run --name 'dock_postgres' --publish '5432:5432' --env 'POSTGRES_USER=postgres' --env 'POSTGRES_PASSWORD=postgres' --env 'POSTGRES_DB=postgres' --volume "$(pwd)/.data/postgres:/var/lib/postgresql/data" postgres:alpine
      docker stop 'dock_postgres'
      docker rm --volumes 'dock_postgres'
      ;;

    # https://maildev.github.io/maildev/
    maildev)
      echo 'smtp://localhost:1025/?ignoreTLS=true'
      echo ''
      docker run --name 'dock_maildev' --publish '1080:1080' --publish '1025:1025' maildev/maildev
      docker stop 'dock_maildev'
      docker rm --volumes 'dock_maildev'
      ;;

    *)
      echo "Unknown dock: '${1}'"
      echo "supported docks:"
      echo "  localstack"
      echo "  mongo"
      echo "  mongo-store"
      echo "  redis"
      echo "  redis-store"
      echo "  postgres"
      echo "  postgres-store"
      echo "  nats-streaming"
      echo "  nats-streaming-store"
      echo "  elasticsearch"
      echo "  elasticsearch-store"
      echo "  maildev"
      echo ""
      ;;
  esac
}

# ===============================================
# Elixir aliases
# ===============================================

alias install_phx='mix archive.install hex phx_new'
alias mixy='mix do deps.get, deps.compile'

# ===============================================
# git aliases
# ===============================================

# reverts to a given commit
oh-crap () {
  if [[ "$1" == "" ]]; then
    echo 'You must pass in a commit id'
    return 1
  fi
  git reset --hard "$1"
  git reset --soft "HEAD@{1}"
  git commit -m "Revert to $1"
}

clone () {
  if [[ "$1" == "" ]]; then
    echo 'You must pass in a repo name'
    return 1
  fi
  if [[ "$1" != git@* ]] && [[ "$1" != https://* ]]; then
    1="git@github.com:${1}"
  fi
  if [[ "$2" != "" ]]; then
    git clone $1 $2
    return 0
  fi
  local folder_name="$(node -p "process.argv[1].replace(/^(git@|https:\/\/)/, '').replace(/\.git$/, '').split(/[:\/]/).join(path.sep)" $1)"
  local full_path=~/Code/"$folder_name"
  mkdir -p "$full_path"
  git clone "$1" "$full_path"
  cd "$full_path"
}

alias -s git=clone

git-user () {
  if [[ "$#" -eq 3 ]]; then
    local filename=".gitconfig.${1}"
    local org_config_path="${HOME}/${filename}"
    touch "${org_config_path}"
    git config --file "${org_config_path}" user.name "${2}"
    git config --file "${org_config_path}" user.email "${3}"
    echo "[includeIf \"gitdir:$(pwd)/\"]
	path = ${org_config_path}
" >> ~/.gitconfig.local
  else
    echo 'Usage: git-user <org> <user-name> <user-email>'
    return 1
  fi
}

# ===============================================
# node aliases
# ===============================================

alias npm-upgrade-interactive='npx -y npm-check-updates@latest --interactive'
alias run='node --run'


# # Source all of the files in ~/.dotfiles/source
# for file in "$DOTFILES"/source/*.sh; do source "$file"; done

# if [ -f ~/.zshrc.local ]; then
#   . ~/.zshrc.local
# fi

# REMOVE/REPURPOSE EVERYTHING BELOW HERE (except for the comment)
# Often, install scripts will append commands to the end of your .bash_profile
# to add things to your $PATH or initialize any scripts. This is dandy, but
# you should probably reposition it in the appropriate place in your sourced
# scripts in "$DOTFILES/source"
