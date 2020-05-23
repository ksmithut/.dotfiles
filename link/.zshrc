#!/usr/bin/env zsh
# Initialize the DOTFILES variable so other scripts can use it

if [ -f ~/.zshrc.local ]; then
  # shellcheck disable=SC1090
  . ~/.zshrc.local
fi

eval "$(~/.local/bin/doted env)"

# Source all of the files in ~/.dotfiles/source
# shellcheck disable=SC1090
for file in "$DOTFILES_DIR"/source/*.sh; do source "$file"; done

# REMOVE/REPURPOSE EVERYTHING BELOW HERE (except for the comment)
# Often, install scripts will append commands to the end of your .bash_profile
# to add things to your $PATH or initialize any scripts. This is dandy, but
# you should probably reposition it in the appropriate place in your sourced
# scripts in "$DOTFILES/source"
