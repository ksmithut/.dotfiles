export EDITOR=vi
export DOTFILES=~/.dotfiles # TODO make this more dynamic
# Shell config
export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_NO_AUTO_UPDATE=1
# Paths: Should add one per line to make it easy to add/remove/change/read
export PATH="~/.config/yarn/global/node_modules/.bin:$PATH"
export PATH="$DOTFILES/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"
export PATH="/usr/local/bin:$PATH"

# Source all of the files in ~/.dotfiles/source
for file in $DOTFILES/source/*; do source "$file"; done

# include local .bash_profile if it's there
[[ -r ~/.bash_profile.local ]] && . ~/.bash_profile.local
