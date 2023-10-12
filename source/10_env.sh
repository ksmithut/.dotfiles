#!/usr/bin/env zsh

PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"
PATH="/opt/homebrew/opt/curl/bin:$PATH"
PATH="$HOME/.docker/bin:$PATH"
export PATH

# Shell config
export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_NO_AUTO_UPDATE=1
export HOMEBREW_NO_ENV_HINTS=1
export EDITOR=vi

# dotnet telemetry optout
export DOTNET_CLI_TELEMETRY_OPTOUT=1
# next.js telemetry optout
export NEXT_TELEMETRY_DISABLED=1

# Elixir history
export ERL_AFLAGS="-kernel shell_history enabled"

# https://github.com/npm/npm/issues/11696
export COMP_WORDBREAKS=${COMP_WORDBREAKS//:}

export ASDF_NODEJS_LEGACY_FILE_DYNAMIC_STRATEGY=latest_available

export KERL_CONFIGURE_OPTIONS="--without-javac"
