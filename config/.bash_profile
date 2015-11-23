# include .aliases
[[ -r ~/.dotfiles/config/.aliases ]] && . ~/.dotfiles/config/.aliases

# include local .bash_profile if needed
[[ -r ~/.bash_profile.local ]] && . ~/.bash_profile.local

# include all of the bash_completion stuff
for f in /usr/local/etc/bash_completion.d/*; do . $f; done;

# custom shell prefix
# function to get branch name of current directory
function parse_git_branch {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1) /'
}
# colors
fg_white="\[\033[37m\]"
fg_cyan="\[\033[36m\]"
fg_yellow="\[\033[33m\]"
reset="\[\033[00m\]"
# components to include
user_host="$fg_white\u@\h"
user_path="$fg_cyan\w"
git_branch="$fg_yellow\$(parse_git_branch)"
# actual export
export PS1="$user_host $user_path $git_branch$reset$ "
unset user_host user_path git_branch reset fg_white fg_cyan fg_yellow

# export environment variables
export PATH="/usr/local/bin:/usr/local/sbin:$PATH"
export NVM_DIR=~/.nvm
export ATOM_HOME=~/.dotfiles/config/.atom
export CLICOLOR=1
export LSCOLORS=gxfxcxdxhxegedabagacad # http://geoff.greer.fm/lscolors/

# Include nvm
source $(brew --prefix nvm)/nvm.sh
