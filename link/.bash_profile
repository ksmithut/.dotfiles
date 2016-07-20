export DOTFILES=~/.dotfiles
export HOMEBREW_NO_ANALYTICS=1
export PATH="/usr/local/bin:/usr/local/sbin:$DOTFILES/bin:$PATH"
export EDITOR="code"

for file in $DOTFILES/source/*; do
  source "$file"
done

# include local .bash_profile if needed
[[ -r ~/.bash_profile.local ]] && . ~/.bash_profile.local
