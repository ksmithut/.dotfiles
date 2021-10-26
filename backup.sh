#!/usr/bin/env bash

copy_dirs=(
  ~/.gnupg
  ~/.ssh
  ~/.aws
  ~/.npmrc
  ~/.now
  ~/.zshrc.local
  ~/.kube
  ~/Code
  ~/Documents
  ~/Pictures
)
DIRECTORY=$1

if [[ "$DIRECTORY" == "" ]]; then
  echo "You must put in an argument to where to backup. ~/Desktop is a common one"
  exit 1
fi

if [ ! -d "$DIRECTORY" ]; then
  echo "$DIRECTORY is not a valid directory"
  exit 1
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
    --exclude=*/_build \
    --exclude=*/.elixir_ls \
    --exclude=*/coverage \
    --exclude=*/.data \
    --exclude=*/dump.rdb \
    --exclude=*/*.log \
    --exclude=*/*.photoslibrary/* \
    "$copy_dir" "$DIRECTORY"
done
