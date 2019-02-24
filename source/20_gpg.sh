#!/usr/bin/env bash

# Skip gpg until I figure out how to do subkeys properly

# Start the gpg agent if it hasn't started

# if [[ "$(pgrep gpg-agent)" == "" ]]; then
#   eval "$(gpg-agent --daemon > /dev/null 2>&1)"
#   echo "started gpg agent"
# fi

# GPG_TTY=$(tty)
# export GPG_TTY
