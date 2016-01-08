# include .aliases
[[ -r ~/.dotfiles/config/.aliases ]] && . ~/.dotfiles/config/.aliases

# include local .bash_profile if needed
[[ -r ~/.bash_profile.local ]] && . ~/.bash_profile.local

# include all of the bash_completion stuff
for f in /usr/local/etc/bash_completion.d/*; do . $f; done;

# Get current get branch
function _parse_git_branch {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1) /'
}
# custom shell prefix
# function to get branch name of current directory
function get_prompt {
  # colors
  local black="\[\033[30m\]"
  local red="\[\033[31m\]"
  local green="\[\033[32m\]"
  local yellow="\[\033[33m\]"
  local blue="\[\033[34m\]"
  local purple="\[\033[35m\]"
  local cyan="\[\033[36m\]"
  local white="\[\033[37m\]"

  # http://www.cyberciti.biz/tips/howto-linux-unix-bash-shell-setup-prompt.html
  # vars
  local user="\u" # the username of the current user
  local host="\h" # the hostname up to the first '.'
  local cwd="\w" # the current working directory, with $HOME abbreviated with a tilde
  local git_branch="\$(_parse_git_branch)"

  # print colors
  function color { echo "$1$2\[\033[00m\]"; }

  # sections
  local user_host="$(color $white $user@$host)"
  local path="$(color $cyan $cwd)"
  local branch="$(color $yellow $git_branch)"

  echo "$user_host $path $branch$ "
}
# actual export
export PS1="$(get_prompt)"
unset get_prompt

# export environment variables
export PATH="/usr/local/bin:/usr/local/sbin:$PATH"
export ATOM_HOME=~/.dotfiles/config/.atom
export CLICOLOR=1
export LSCOLORS=gxfxcxdxhxegedabagacad # http://geoff.greer.fm/lscolors/

# Include nvm
export NVM_DIR=~/.nvm
[[ -r $NVM_DIR/bash_completion ]] && . $NVM_DIR/bash_completion
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
