#!/usr/bin/env bash
# Start the gpg agent if it hasn't started

if [[ "$(pgrep gpg-agent)" == "" ]]; then
  eval "$(gpg-agent --daemon > /dev/null 2>&1)"
  echo "started gpg agent"
fi

GPG_TTY=$(tty)
export GPG_TTY
