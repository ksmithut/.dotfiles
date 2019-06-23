#!/usr/bin/env bash

# This file is for determining what you would like installed when `setup.sh` is
# run. All you need to do is `echo '{filename}'` to include it, where {filename}
# is a coresponding file in ./init/options/*.sh but without the file extension.

# This file will also receive args for various environments. Currently supported
# are `work` and `play`. To check if the argument was passed use:
#
# if [[ " $@ " =~ " work " ]]; then
#   echo 'corporate-thing'
# fi
#
# If the first argument is '_', it's looking for the different environment
# options so the setup script can know what to ask you for.

if [ "$1" == '_' ]; then
  echo 'work'
  echo 'play'
  exit
fi

echo 'base' # This is required for other installations to work
echo '1password'
echo 'apple-configurator'
echo 'balenaetcher'
echo 'bettertouchtool'
echo 'boostnote'
echo 'buku'
echo 'chromium'
echo 'discord'
echo 'firefox'
echo 'gpg'
echo 'keybase'
echo 'slack'
echo 'ssh'
echo 'yubikey'
echo 'zsh'

if [[ " $@ " =~ " work " ]]; then
  echo 'docker'
  echo 'elixir'
  echo 'figma'
  echo 'git'
  echo 'insomnia'
  echo 'kitematic'
  echo 'kubernetes'
  echo 'mongo-client'
  echo 'node'
  echo 'postgres-client'
  echo 'postman'
  echo 'vscode'
  echo 'zoom'
fi

if [[ " $@ " =~ " play " ]]; then
  echo 'battle-net'
  echo 'epic-games'
  echo 'gog-galaxy'
  echo 'league-of-legends'
  echo 'minecraft'
  echo 'steam'
fi