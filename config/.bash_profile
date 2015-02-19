[[ -r ~/.dotfiles/config/.aliases ]] && . ~/.dotfiles/config/.aliases
[[ -r ~/.bash_profile.local ]] && . ~/.bash_profile.local
for f in /usr/local/etc/bash_completion.d/*; do . $f; done;
export PATH="/usr/local/bin:/usr/local/sbin:$PATH"
export NVM_DIR=~/.nvm
export ATOM_HOME=~/.dotfiles/.atom
source $(brew --prefix nvm)/nvm.sh
