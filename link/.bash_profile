# include local .bash_profile if needed
[[ -r ~/.bash_profile.local ]] && . ~/.bash_profile.local

export DOTFILES=~/.dotfiles

for file in $DOTFILES/source/*; do
  source "$file"
done
