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

if [[ "$1" == '_' ]]; then
  if is-linux; then
    echo 'gui'
  fi
  echo 'work'
  echo 'games'
  echo 'kubernetes'
  exit
fi

echo 'git-config'
echo 'ssh-config'
echo 'gpg-config'
echo 'yubikey'
echo 'oh-my-zsh'

if [[ " $@ " =~ " gui " ]] || is-macos || is-windows; then
  echo '1password'
  echo 'arc'
  echo 'balenaetcher'
  echo 'chromium'
  echo 'discord'
  echo 'firefox'
  echo 'keybase'
  echo 'slack'
  echo 'dracula-terminal-theme'
  echo 'cascadia-font'
  # Linux specific things
  echo 'vlc'
  # Apple specific things
  echo 'apple-configurator'
  echo 'better-touch-tool'
  # windows specific things
  echo 'power-toys'
  echo 'nvidia'
fi

if [[ " $@ " =~ " kubernetes " ]]; then
  echo 'asdf-helm'
  echo 'asdf-krew'
  echo 'asdf-kubectl'
  echo 'asdf-kubectx'
  echo 'asdf-minikube'
  echo 'asdf-skaffold'
fi

if [[ " $@ " =~ " work " ]]; then
  echo 'docker'
  echo 'asdf'
  echo 'asdf-awscli'
  echo 'asdf-mongo-tools'
  echo 'asdf-node'
  echo 'asdf-elixir'
  echo 'asdf-deno'
  echo 'asdf-golang'
  echo 'asdf-lazydocker'
  if [[ " $@ " =~ " gui " ]] || is-macos || is-windows; then
    echo 'figma'
    echo 'robo-3t'
    echo 'vscode'
    echo 'tableplus'
    echo 'windows-terminal'
    echo 'ubuntu-wsl'
  fi
fi

if [[ " $@ " =~ " games " ]] && ([[ " $@ " =~ " gui " ]] || is-macos || is-windows); then
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
