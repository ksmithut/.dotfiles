#!/usr/bin/env bash

if is_macos; then
  brew cask install visual-studio-code
fi

if is_ubuntu; then
  # sudo snap install code --classic
  # flatpak install -y flathub com.visualstudio.code
  wget 'https://go.microsoft.com/fwlink/?LinkID=760868' -O "$DOTFILES_INSTALLERS/vscode.deb"
  sudo dpkg -i "$DOTFILES_INSTALLERS/vscode.deb"
  sudo apt-get install -f -y

  # https://code.visualstudio.com/docs/setup/linux#_visual-studio-code-is-unable-to-watch-for-file-changes-in-this-large-workspace-error-enospc
  echo 'fs.inotify.max_user_watches=524288' | sudo tee -a /etc/sysctl.conf
  sudo sysctl -p
fi

if is_windows; then
  choco install -y vscode
fi

code --install-extension Shan.code-settings-sync
