#!/usr/bin/env bash

# sudo snap install code --classic
# flatpak install -y flathub com.visualstudio.code
wget 'https://go.microsoft.com/fwlink/?LinkID=760868' -O "$DOTFILES_INSTALLERS/vscode.deb"
sudo dpkg -i "$DOTFILES_INSTALLERS/vscode.deb"
sudo apt-get install -f -y

# https://code.visualstudio.com/docs/setup/linux#_visual-studio-code-is-unable-to-watch-for-file-changes-in-this-large-workspace-error-enospc
echo 'fs.inotify.max_user_watches=524288' | sudo tee -a /etc/sysctl.conf
sudo sysctl -p
