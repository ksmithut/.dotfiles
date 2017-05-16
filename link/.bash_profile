export DOTFILES=$(cd "$(dirname "$(readlink "${BASH_SOURCE[0]}")" )/../"; pwd -P)

# Source all of the files in ~/.dotfiles/source
for file in $DOTFILES/source/*; do source "$file"; done

# include local .bash_profile if it's there
[[ -r ~/.bash_profile.local ]] && . ~/.bash_profile.local
