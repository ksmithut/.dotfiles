# include .aliases
[[ -r ~/.dotfiles/config/.aliases ]] && . ~/.dotfiles/config/.aliases

# include local .bash_profile if needed
[[ -r ~/.bash_profile.local ]] && . ~/.bash_profile.local

# include all of the bash_completion stuff
for f in /usr/local/etc/bash_completion.d/*; do . $f; done;

# export custom prompt string. @see .aliases
resetprompt

# export environment variables
export PATH="/usr/local/bin:/usr/local/sbin:$PATH"
export ATOM_HOME=~/.dotfiles/config/.atom
export CLICOLOR=1
export LSCOLORS=gxfxcxdxhxegedabagacad # http://geoff.greer.fm/lscolors/

# Include nvm
export NVM_DIR=~/.nvm
[[ -r $NVM_DIR/bash_completion ]] && . $NVM_DIR/bash_completion
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
