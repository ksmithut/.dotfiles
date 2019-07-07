

if is_macos; then
  brew cask install virtualbox
fi

if is_ubuntu; then
  sudo add-apt-repository multiverse
  sudo apt-get update -y
  sudo apt-get install -y virtualbox
fi

if is_windows; then
  choco install -y virtualbox
fi
