# include .aliases
[[ -r ~/.dotfiles/config/.aliases ]] && . ~/.dotfiles/config/.aliases
# include local .bash_profile if needed
[[ -r ~/.bash_profile.local ]] && . ~/.bash_profile.local
# include all of the bash_completion stuff
for f in /usr/local/etc/bash_completion.d/*; do . $f; done;
# put the git branch name in the terminal
parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
export PS1="\u@\h \W\[\033[32m\]\$(parse_git_branch)\[\033[00m\] $ "
# export environment variables
export PATH="/usr/local/bin:/usr/local/sbin:$PATH"
export NVM_DIR=~/.nvm
export ATOM_HOME=~/.dotfiles/config/.atom
# Include nvm
source $(brew --prefix nvm)/nvm.sh
