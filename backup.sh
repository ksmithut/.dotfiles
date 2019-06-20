#!/usr/bin/env bash

copy_dirs=(
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
DIRECTORY=$1
if [ ! -d "$DIRECTORY" ]; then
  echo "$DIRECTORY is not a valid directory"
  return
fi
# Add /backup to the end of the directory
DIRECTORY="$DIRECTORY"/backup
# remove any duplicate / from the path for visual reasons
DIRECTORY=${DIRECTORY//\/\//\/}

for copy_dir in "${copy_dirs[@]}"; do
  echo "Copying $copy_dir to $DIRECTORY"
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
