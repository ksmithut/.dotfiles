[[ -r ~/.dotfiles/config/.aliases ]] && . ~/.dotfiles/config/.aliases
[[ -r /usr/local/etc/bash_completion.d/git-completion.bash ]] && . /usr/local/etc/bash_completion.d/git-completion.bash
[[ -r /usr/local/etc/bash_completion.d/nvm ]] && . /usr/local/etc/bash_completion.d/nvm
[[ -r ~/.bash_profile.local ]] && . ~/.bash_profile.local
export PATH="/usr/local/bin:/usr/local/sbin:$PATH"
export NVM_DIR=~/.nvm
export ATOM_HOME=~/.dotfiles/.atom
source $(brew --prefix nvm)/nvm.sh
