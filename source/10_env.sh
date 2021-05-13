#!/usr/bin/env bash

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
