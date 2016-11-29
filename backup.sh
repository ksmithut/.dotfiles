#!/usr/bin/env bash

copy_dirs=(
  ~/.ssh
  ~/Code
  ~/Documents
  ~/Pictures
)

DIRECTORY=$1

if [ ! -d "$DIRECTORY" ]; then
  echo "$DIRECTORY is not a valid directory"
  exit
fi

# Add /backup to the end of the directory
DIRECTORY="$DIRECTORY"/backup

# remove any duplicate / from the path for visual reasons
DIRECTORY=${DIRECTORY//\/\//\/}

for copy_dir in "${copy_dirs[@]}"; do
  echo "Copying $copy_dir"
  rsync -rv \
    --exclude=*.DS_Store \
    --exclude=*/node_modules \
    --exclude=*/bower_components \
    --exclude=*/coverage \
    --exclude=*/.data \
    --exclude=*/dump.rdb \
    --excluce=*/*.log \
    "$copy_dir" "$DIRECTORY"
done

echo "done!"
