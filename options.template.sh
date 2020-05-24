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
  echo 'base'
  echo 'work'
  echo 'games'
  echo 'wsl'
  echo 'windows'
  exit
fi

if [[ " $@ " =~ " base " ]]; then
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
  echo 'vlc'
  echo 'yubikey'
  echo 'zsh'
  echo 'dracula-terminal-theme'
fi

if [[ " $@ " =~ " work " ]]; then
  echo 'docker'
  echo 'lazydocker'
  echo 'figma'
  echo 'robo-3t'
  echo 'virtualbox'
  echo 'vscode'
  echo 'tableplus'
  echo 'awscli'
  echo 'asdf'
  echo 'asdf-node'
  echo 'asdf-elixir'
  echo 'asdf-deno'
  echo 'asdf-golang'
  echo 'asdf-eksctl'
  echo 'asdf-fluxctl'
  echo 'asdf-helm'
  echo 'asdf-kops'
  echo 'asdf-kubectl'
  echo 'asdf-kubeseal'
  echo 'asdf-kustomize'
  echo 'asdf-minikube'
  echo 'asdf-skaffold'
fi

if [[ " $@ " =~ " games " ]]; then
  echo 'battle-net'
  echo 'epic-games'
  echo 'gog-galaxy'
  echo 'league-of-legends'
  echo 'lutris'
  echo 'minecraft'
  echo 'origin'
  echo 'steam'
  echo 'uplay'
  echo 'wine'
fi

if [[ " $@ " =~ " wsl " ]]; then
  echo 'gpg-config'
  echo 'ssh-config'
  echo 'yubikey'
  echo 'oh-my-zsh'
  echo 'docker'
  echo 'lazydocker'
  echo 'awscli'
  echo 'asdf'
  echo 'asdf-node'
  echo 'asdf-elixir'
  echo 'asdf-deno'
  echo 'asdf-golang'
  echo 'asdf-eksctl'
  echo 'asdf-fluxctl'
  echo 'asdf-helm'
  echo 'asdf-kops'
  echo 'asdf-kubectl'
  echo 'asdf-kubeseal'
  echo 'asdf-kustomize'
  echo 'asdf-minikube'
  echo 'asdf-skaffold'
fi

if [[ " $@ " =~ " windows " ]]; then
  echo 'discord'
  echo 'firefox'
  echo 'slack'
  echo '1password'
  echo 'steam'
  echo 'battle-net'
  echo 'epic-games'
  echo 'gog-galaxy'
  echo 'league-of-legends'
  echo 'minecraft'
  echo 'origin'
  echo 'uplay'
  echo 'windows-terminal'
  echo 'ubuntu-wsl'
  echo 'vscode'
  echo 'power-toys'
fi
