#!/usr/bin/env bash

local copy_dirs=(
  ~/.local/share/buku
  ~/.gnupg
  ~/.ssh
  ~/.aws
  ~/.npmrc
  ~/.now
  ~/.bashrc.local
  ~/Code
  ~/Documents
  ~/Pictures
)
local DIRECTORY=$1
if [ ! -d "$DIRECTORY" ]; then
  echo "$DIRECTORY is not a valid directory"
  return
fi
# Add /backup to the end of the directory
local DIRECTORY="$DIRECTORY"/backup
# remove any duplicate / from the path for visual reasons
local DIRECTORY=${DIRECTORY//\/\//\/}

for copy_dir in "${copy_dirs[@]}"; do
  echo "Copying $copy_dir"
  rsync -rv \
    --exclude=*.DS_Store \
    --exclude=*/node_modules \
    --exclude=*/bower_components \
    --exclude=*/coverage \
    --exclude=*/.data \
    --exclude=*/dump.rdb \
    --exclude=*/*.log \
    --exclude=*/*.photoslibrary/* \
    "$copy_dir" "$DIRECTORY"
done
