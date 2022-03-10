#!/usr/bin/env zsh

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

# next.js telemetry optout
export NEXT_TELEMETRY_DISABLED=1

is_macos && export KERL_CONFIGURE_OPTIONS="--without-javac --with-ssl=$(brew --prefix openssl@1.1)"
