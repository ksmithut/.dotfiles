#!/usr/bin/env bash

echo "Enter your password here. You should only have to enter it once through this whole process"
sudo -v
# Keep-alive: update existing `sudo` time stamp until `.osx` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

export DOTFILES=~/.dotfiles

function e_header() {
  echo
  echo "======================================================================="
  echo -e "\033[1;36m$1\033[0m"
  echo "======================================================================="
}

# Makes glob return dotfiles
shopt -s dotglob

# Copy Files
e_header "Copying files to $HOME"

for file in $DOTFILES/copy/*; do
  echo "Copying $(basename $file)..."
  dest="$HOME/$(basename $file)"
  if test -f $dest; then
    echo "$dest already exists"
  else
    cp "$file" "$HOME/$(basename $file)"
  fi
done

# Link Files
e_header "Linking files to $HOME"

for file in $DOTFILES/link/*; do
  echo "Linking $(basename $file)..."
  rm -rf "$HOME/$(basename $file)"
  ln -s "$file" "$HOME/$(basename $file)"
done

# System Initialization
for file in $DOTFILES/init/*; do
  e_header "Init $(basename $file)"
  source "$file"
  echo "done!"
done
