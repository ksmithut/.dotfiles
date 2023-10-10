#!/usr/bin/env bash
# This file is for aliases/functions/scripts that are to be used only by the
# the files in this repo, mostly just to detect platform differences.

# OS detection
is_macos () {
  [[ "$OSTYPE" =~ ^darwin ]] || return 1
}

is_apple_silicon () {
  is_macos && [[ "$(arch)" == "arm64" ]] || return 1
}

is_ubuntu () {
  [[ "$(cat /etc/issue 2> /dev/null)" =~ Ubuntu ]] || [[ "$(cat /etc/issue 2> /dev/null)" =~ "Pop!_OS" ]] || return 1
}

is_zsh () {
  [[ "${ZSH_NAME}" == "zsh" ]] || return 1
}

is_windows () {
  [[ "${OS}" == "Windows_NT" ]] || return 1
}

is_linux () {
  [[ "$(which_os)" == "linux" ]] || return 1
}

is_wsl () {
  [[ "$(cat /proc/version 2> /dev/null)" =~ microsoft ]] || return 1
}

which_os () {
  if is_macos; then
    echo 'macos'
  elif is_windows; then
    echo 'windows'
  else
    echo 'linux'
  fi
}

dotfiles () {
  cd "$DOTFILES" || exit
}
