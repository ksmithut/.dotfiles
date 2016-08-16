#!/usr/bin/env bash


copy_dirs=(
  ~/Code
  ~/Documents
  ~/Pictures
)



read -e -p "Volume to Backup to: " DIRECTORY

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
  rsync -rv --exclude=*.DS_Store --exclude=*/node_modules --exclude=*/bower_components "$copy_dir" "$DIRECTORY"
done

echo "done!"
