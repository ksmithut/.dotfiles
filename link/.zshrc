#!/usr/bin/env zsh
# Initialize the DOTFILES variable so other scripts can use it

pushd . > /dev/null || exit
DOTFILES="$(builtin cd "$(dirname "$(readlink "${(%):-%N}")")/../" || exit; pwd -P)"
export DOTFILES
popd > /dev/null || exit

# Source all of the files in ~/.dotfiles/source
for file in "$DOTFILES"/source/*.sh; do source "$file"; done

if [ -f ~/.zshrc.local ]; then
  . ~/.zshrc.local
fi

# REMOVE/REPURPOSE EVERYTHING BELOW HERE (except for the comment)
# Often, install scripts will append commands to the end of your .bash_profile
# to add things to your $PATH or initialize any scripts. This is dandy, but
# you should probably reposition it in the appropriate place in your sourced
# scripts in "$DOTFILES/source"
