#!/usr/bin/env bash
# Most environment variables should be placed here, unless they're specific for
# some other piece of software, like NVM

# Paths: Should add one per line to make it easy to add/remove/change/read

# I'm not sure why I can comment all these out, but it appears that all of these
# are already added to the path. Maybe zsh is already adding them?

PATH="/usr/local/sbin:$PATH"
PATH="$HOME/.config/yarn/global/node_modules/.bin:$PATH"
PATH="$DOTFILES/bin:$PATH"
PATH="/usr/local/opt/grep/libexec/gnubin:$PATH"
PATH="$HOME/.local/bin:$PATH"
PATH="/opt/homebrew/bin:$PATH"
export PATH

# Elixir history
export ERL_AFLAGS="-kernel shell_history enabled"

# Shell config
export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_NO_AUTO_UPDATE=1
export EDITOR=vi
# https://github.com/npm/npm/issues/11696
export COMP_WORDBREAKS=${COMP_WORDBREAKS//:}

# dotnet telemetry optout
export DOTNET_CLI_TELEMETRY_OPTOUT=1
