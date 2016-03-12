# Install cask apps
echo "Installing apps..."

read -p "Do you want to include games? " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
  casks=("${casks[@]}" "${game_casks[@]}")
fi

casks=($(setdiff "${casks[*]}" "$(brew cask list 2>/dev/null)"))
for cask in "${casks[@]}"; do
  echo $cask
  brew cask install --appdir="/Applications" $cask
done

brew cask cleanup
