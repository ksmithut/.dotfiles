export EDITOR=vi
export DOTFILES=~/.dotfiles # TODO make this more dynamic
export YARN_GLOBAL_BIN=~/.config/yarn/global/node_modules/.bin
export HOMEBREW_NO_ANALYTICS=1
export PATH="/usr/local/bin:/usr/local/sbin:$DOTFILES/bin:$YARN_GLOBAL_BIN:$PATH"

for file in $DOTFILES/source/*; do source "$file"; done

# include local .bash_profile if it's there
[[ -r ~/.bash_profile.local ]] && . ~/.bash_profile.local
