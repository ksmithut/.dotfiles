#!/usr/bin/env bash
# This file is for aliases/functions/scripts that are to be used only by the
# the files in this repo, mostly just to detect platform differences.

# OS detection
function is_macos() {
  [[ "$OSTYPE" =~ ^darwin ]] || return 1
}

function is_ubuntu() {
  [[ "$(cat /etc/issue 2> /dev/null)" =~ Ubuntu ]] || [[ "$(cat /etc/issue 2> /dev/null)" =~ "Pop!_OS" ]] || return 1
}

function is_zsh() {
  [[ "${ZSH_NAME}" == "zsh" ]] || return 1
}

function is_windows() {
  [[ "${OS}" == "Windows_NT" ]] || return 1
}

function is_linux() {
  [[ "$(which_os)" == "linux" ]] || return 1
}

function which_os() {
  if is_macos; then
    echo 'macos'
  elif is_windows; then
    echo 'windows'
  else
    echo 'linux'
  fi
}

function dotfiles {
  cd "$DOTFILES"
}
