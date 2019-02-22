#!/usr/bin/env bash
# Start the ssh agent if it hasn't started
if [[ "$(pgrep ssh-agent | head -n 1)" == "" ]]; then
  eval "$(ssh-agent -s > /dev/null 2>&1)"
  echo "started ssh agent"
fi
