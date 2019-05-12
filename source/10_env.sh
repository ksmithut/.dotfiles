#!/usr/bin/env bash
# Most environment variables should be placed here, unless they're specific for
# some other piece of software, like NVM

# Paths: Should add one per line to make it easy to add/remove/change/read
PATH="/usr/local/sbin:$PATH"
PATH="/usr/local/bin:$PATH"
PATH="$HOME/.config/yarn/global/node_modules/.bin:$PATH"
PATH="$DOTFILES/bin:$PATH"
PATH="/usr/local/opt/grep/libexec/gnubin:$PATH"
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
