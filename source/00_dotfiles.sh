#!/usr/bin/env bash
# This file is for aliases/functions/scripts that are to be used only by the
# the files in this repo, mostly just to detect platform differences.

# OS detection
function is_macos() {
  [[ "$OSTYPE" =~ ^darwin ]] || return 1
}

function is_ubuntu() {
  [[ "$(cat /etc/issue 2> /dev/null)" =~ Ubuntu ]] || return 1
}

function is_debian() {
  [[ "$(cat /etc/issue 2> /dev/null)" =~ Debian ]] || return 1
}

function is_ubuntu_desktop() {
  dpkg -l ubuntu-desktop >/dev/null 2>&1 || return 1
}

function is_pop_desktop() {
  dpkg -l pop-default-settings >/dev/null 2>&1 || return 1
}

function is_linux() {
  return is_ubuntu || is_debian
}

function is_zsh() {
  [[ "${ZSH_NAME}" == "zsh" ]] || return 1
}
