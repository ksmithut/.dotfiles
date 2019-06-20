#!/usr/bin/env bash

if is_macos; then
  brew cask install visual-studio-code
fi

if is_ubuntu; then
  sudo snap install code --classic
  # flatpak install -y com.visualstudio.code

  # https://code.visualstudio.com/docs/setup/linux#_visual-studio-code-is-unable-to-watch-for-file-changes-in-this-large-workspace-error-enospc
  echo 'fs.inotify.max_user_watches=524288' | sudo tee -a /etc/sysctl.conf
  sudo sysctl -p
fi

code --install-extension Shan.code-settings-sync
