#!/usr/bin/env bash

set -e

# Keep-alive: update existing `sudo` time stamp until everything has finished
echo "Enter your password here. You should only have to enter it once through this whole process"
sudo -v
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Set a reference to where dotfiles is.
export DOTFILES=$( cd "$(dirname "$0")/../"; pwd -P )

# Helper util to make headers more readable
function e_header() {
  echo
  echo "======================================================================="
  echo -e "\033[1;36m$1\033[0m"
  echo "======================================================================="
}
function e_success()  { echo -e " \033[1;32m✔\033[0m  $@"; }
function e_error()    { echo -e " \033[1;31m✖\033[0m  $@"; }
function e_arrow()    { echo -e " \033[1;34m➜\033[0m  $@"; }

# Makes glob return dotfiles
shopt -s dotglob

# 1. Copy Files
# =============
e_header "Copying files to $HOME"
for file in $DOTFILES/copy/*; do
  echo "Copying $(basename $file)..."
  dest="$HOME/$(basename $file)"
  if test -f $dest; then
    echo "$dest already exists"
    read -p "Overwrite? (y/N)" overwrite
    case $overwrite in
      [Yy]* ) cp "$file" "$HOME/$(basename $file)"; break;;
      * ) echo "Skipping copying $file"
    esac
  else
    cp "$file" "$HOME/$(basename $file)"
  fi
done

# 2. Link Files
# =============
e_header "Linking files to $HOME"
for file in $DOTFILES/link/*; do
  echo "Linking $(basename $file)..."
  rm "$HOME/$(basename $file)" 2> /dev/null
  ln -s "$file" "$HOME/$(basename $file)"
done

# 3. System Initialization
# ========================
for file in $DOTFILES/init/*; do
  e_header "Init $(basename $file)"
  source "$file"
  echo "done!"
done
