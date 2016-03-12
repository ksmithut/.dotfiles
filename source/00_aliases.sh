# get ip addresses
alias ip='ipconfig getifaddr en0 && curl ipecho.net/plain; echo'

# update brew
alias brew-upgrade='brew update; brew upgrade --all; brew cleanup'
alias atom-upgrade='apm upgrade --confirm false'
alias nvm-upgrade='cd "$NVM_DIR" && git pull origin master && git checkout `git describe --abbrev=0 --tags` && cd'
alias upgrade='brew-upgrade; atom-upgrade'

# Open up npm package on npmjs.com
function nopen { open "https://www.npmjs.com/packages/$1"; }

# cask shortcut
alias cask='brew cask'

# show hidden files in finder
alias show='defaults write com.apple.finder AppleShowAllFiles -bool TRUE; killall Finder;'

# hide hidden files in finder
alias hide='defaults write com.apple.finder AppleShowAllFiles -bool FALSE; killall Finder;'

# makes a directory and moves to it
function dir { mkdir $1 && cd $_; }

# sets default ls action to have trailing slashes at the end of directories
alias ls='ls -p'

# database startups
alias mongo-up='mongod --config /usr/local/etc/mongod.conf'
alias redis-up='redis-server /usr/local/etc/redis.conf'

# starts simple http server in current directory
alias static='python -m SimpleHTTPServer'
alias staticphp='php -S localhost:8000'

# Get current get branch
function _parse_git_branch {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1) / '
}
# custom shell prefix
# function to get branch name of current directory
function setprompt {
  # colors
  local black="\[\033[1;30m\]"
  local red="\[\033[1;31m\]"
  local green="\[\033[1;32m\]"
  local yellow="\[\033[1;33m\]"
  local blue="\[\033[1;34m\]"
  local purple="\[\033[1;35m\]"
  local cyan="\[\033[1;36m\]"
  local white="\[\033[1;37m\]"

  # http://www.cyberciti.biz/tips/howto-linux-unix-bash-shell-setup-prompt.html
  # vars
  local user="\u" # the username of the current user
  local host="\h" # the hostname up to the first '.'
  local cwd="\w" # the current working directory, with $HOME abbreviated with a tilde
  local git_branch="\$(_parse_git_branch)"

  # print colors
  function color { echo "$1$2\[\033[00m\]"; }

  local output=""

  # arguments
  for i in "$@"
  do
    case $i in
      -u|--user)
        output+="$(color $white $user@$host) "
        ;;
      -p|--path)
        output+="$(color $cyan $cwd) "
        ;;
      -b|--branch)
        output+="$(color $yellow $git_branch)"
        ;;
    esac
  done

  output+="$ "

  export PS1=$output
}

# makes it possible to switch to shorter prompt
alias shortprompt='setprompt --path --branch'
alias longprompt='setprompt --user --path --branch'
alias resetprompt='shortprompt'

# creates a github repo from a local git repository
function github-create {
  local invalid_credentials=0
  local repo_name=$1

  local dir_name=`basename $(pwd)`

  if [ "$repo_name" = "" ]; then
    echo "Repo name (hit enter to use '$dir_name')?"
    read repo_name
  fi

  if [ "$repo_name" = "" ]; then
    local repo_name=$dir_name
  fi

  local username=`git config github.user`
  if [ "$username" = "" ]; then
    echo "Could not find username, run 'git config --global github.user <username>'"
    local invalid_credentials=1
  fi

  local token=`git config github.token`
  if [ "$token" = "" ]; then
    echo "Could not find token, run 'git config --global github.token <token>'"
    local invalid_credentials=1
  fi

  if [ "$invalid_credentials" == "1" ]; then
    return 1
  fi

  echo -n "Creating Github repository '$repo_name' ..."
  curl -u "$username:$token" https://api.github.com/user/repos -d '{"name":"'$repo_name'"}' > /dev/null 2>&1
  echo " done."

  echo -n "Pushing local code to remote ..."
  git remote add origin git@github.com:$username/$repo_name.git > /dev/null 2>&1
  git push -u origin master > /dev/null 2>&1
  echo " done."
}
