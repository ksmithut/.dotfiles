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
  dirname="${1##*/}"
  git clone git@github.com:"$1" || return 1
  cd "$dirname" || return 1
}
