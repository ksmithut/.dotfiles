#!/usr/bin/env bash

function e_header() {
  echo
  echo "======================================================================="
  echo -e "\033[1;36m$1\033[0m"
  echo "======================================================================="
}
function e_success()  { echo -e " \033[1;32m✔\033[0m  $*"; }
function e_error()    { echo -e " \033[1;31m✖\033[0m  $*"; }
function e_arrow()    { echo -e " \033[1;34m➜\033[0m  $*"; }

if [[ "${DOTFILES}" == "" ]]; then
  DOTFILES="$( cd "$(dirname "$0")/" || exit; pwd -P )"
fi

# Makes glob return dotfiles
if [ "$ZSH_NAME" != "" ]; then
  setopt dotglob
else
  shopt -s dotglob > /dev/null 2>&1
fi

function dotfiles_copy() {
  e_header "Copying files to $HOME"
  for file in "$DOTFILES"/copy/*; do
    echo "Copying $(basename "$file")..."
    dest="$HOME/$(basename "$file")"
    if test -f "$dest"; then
      echo "$dest already exists"
      echo -n 'Overwrite? (y/N) '; read -r overwrite
      case $overwrite in
        [Yy]* ) cp "$file" "$HOME/$(basename "$file")"; break;;
        * ) echo "Skipping copying $file"
      esac
    else
      cp "$file" "$HOME/$(basename "$file")"
    fi
  done
}

function dotfiles_link() {
  e_header "Linking files to $HOME"
  for file in "$DOTFILES"/link/*; do
    echo "Linking $(basename "$file")..."
    rm "$HOME/$(basename "$file")" 2> /dev/null
    ln -s "$file" "$HOME/$(basename "$file")"
  done
}

function dotfiles_install() {
  e_header "Initializing system"
  export DOTFILES_CACHE="$DOTFILES/caches"
  export DOTFILES_INSTALLERS="$DOTFILES_CACHE/installers"
  mkdir -p "$DOTFILES_INSTALLERS"

  for file in "$DOTFILES"/install/*.sh; do
    e_header "Installing $(basename ${file})"
    source "${file}"
    echo "done!"
  done

  rm -rf "$DOTFILES_CACHE"
}

# Keep-alive: update existing `sudo` time stamp until everything has finished
echo "Enter your password here. You should only have to enter it once through this whole process"
sudo -v
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

. "${DOTFILES}/source/00_dotfiles.sh"
dotfiles_copy
dotfiles_link
dotfiles_install

echo "Restart your computer when you get a chance."
exit
