#!/usr/bin/env bash
# Initialize the DOTFILES variable so other scripts can use it
# TODO make this dynamic?
DOTFILES="$HOME/.dotfiles"
export DOTFILES

# Source all of the files in ~/.dotfiles/source
# shellcheck disable=SC1090
for file in "$DOTFILES"/source/*.sh; do source "$file"; done

# include local .bash_profile if it's there
# shellcheck disable=SC1090
[[ -r ~/.bashrc.local ]] && . ~/.bashrc.local

# REMOVE/REPURPOSE EVERYTHING BELOW HERE (except for the comment)
# Often, install scripts will append commands to the end of your .bash_profile
# to add things to your $PATH or initialize any scripts. This is dandy, but
# you should probably reposition it in the appropriate place in your sourced
# scripts in "$DOTFILES/source"
