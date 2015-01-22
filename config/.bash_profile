#ulimit -n 65536
#ulimit -u 2048

[[ -r ~/.dotfiles/config/.aliases ]] && . ~/.dotfiles/config/.aliases
[[ -r ~/.dotfiles/config/.git-completion.bash ]] && . ~/.dotfiles/config/.git-completion.bash
[[ -r ~/.bash_profile.local ]] && . ~/.bash_profile.local
export PATH="/usr/local/bin:/usr/local/sbin:$PATH"
export NVM_DIR=~/.nvm
source $(brew --prefix nvm)/nvm.sh
