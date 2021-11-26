#!/usr/bin/env bash

# reverts to a given commit
function oh-crap() {
  if [[ "$1" == "" ]]; then
    echo 'You must pass in a commit id'
    return 1
  fi
  git reset --hard "$1"
  git reset --soft "HEAD@{1}"
  git commit -m "Revert to $1"
}

function ghclone() {
  local dirname
  local dirname="${1##*/}"
  git clone git@github.com:"$1" || return 1
  cd "$dirname" || return 1
}

function clone() {
  if [[ "$1" == "" ]]; then
    echo 'You must pass in a repo name'
    return 1
  fi
  if [[ "$1" != git@* ]] && [[ "$1" != https://* ]]; then
    1="git@github.com:${1}"
  fi
  if [[ "$2" != "" ]]; then
    git clone $1 $2
    return 0
  fi
  local folder_name="$(node -p "process.argv[1].replace(/^(git@|https:\/\/)/, '').replace(/\.git$/, '').split(/[:\/]/).join(path.sep)" $1)"
  local full_path=~/Code/"$folder_name"
  mkdir -p "$full_path"
  git clone "$1" "$full_path"
  cd "$full_path"
}

alias -s git=clone
