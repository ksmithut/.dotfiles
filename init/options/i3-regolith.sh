#!/usr/bin/env bash

if is_macos; then
  echo 'Not available on Mac OSX'
fi

if is_ubuntu; then
  # https://regolith-linux.org/
  # Add the regolith PPA repository:
  sudo add-apt-repository -y ppa://kgilmer/regolith-stable

  # Update then install regolith-desktop which includes i3-gaps & more
  sudo apt install regolith-desktop

  echo 'After finishing the setup, Reboot.'
  echo 'At the login screen, select the “gear” icon and select Regolith from the list, and then login.'

  # Removing the default config from regolith and Symbolic Linking ours.
  echo 'Setting up your custom settings now.'
  rm "$HOME/.config/i3-regolith/config" 2> /dev/null
  ln -s "$HOME/.dotfiles/link/.i3config" "~/.i3config"

  ## Uninstall
  # sudo apt remove regolith-desktop
  # sudo add-apt-repository --remove ppa://kgilmer/regolith-stable

fi
