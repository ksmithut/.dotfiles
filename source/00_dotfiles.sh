#!/usr/bin/env bash
# This file is for aliases/functions/scripts that are to be used only by the
# the files in this repo, mostly just to detect platform differences.

# OS detection
is-macos () {
  [[ "$OSTYPE" =~ ^darwin ]] || return 1
}

is-apple-silicon () {
  is-macos && [[ "$(arch)" == "arm64" ]] || return 1
}

is-ubuntu () {
  [[ "$(cat /etc/issue 2> /dev/null)" =~ Ubuntu ]] || [[ "$(cat /etc/issue 2> /dev/null)" =~ "Pop!_OS" ]] || return 1
}

is-zsh () {
  [[ "${ZSH_NAME}" == "zsh" ]] || return 1
}

is-windows () {
  [[ "${OS}" == "Windows_NT" ]] || return 1
}

is-linux () {
  [[ "$(which_os)" == "linux" ]] || return 1
}

is-wsl () {
  [[ "$(cat /proc/version 2> /dev/null)" =~ microsoft ]] || return 1
}

dotfiles () {
  cd "$DOTFILES" || exit
}
