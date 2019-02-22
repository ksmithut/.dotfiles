#!/usr/bin/env bash
# Start the ssh agent if it hasn't started
# TODO add .ssh config file, generate new key on install
if [[ "$(pgrep ssh-agent | head -n 1)" == "" ]]; then
  eval "$(ssh-agent -s > /dev/null 2>&1)"
  # adds all of the private keys to the agent
  # if is_macos; then
  #   eval $(find ~/.ssh -type f ! -name "*.*" -name "id_*" -exec ssh-add -K {} \; > /dev/null 2>&1)
  # else
  #   eval $(find ~/.ssh -type f ! -name "*.*" -name "id_*" -exec ssh-add {} \; > /dev/null 2>&1)
  # fi
  echo "started ssh agent"
fi
