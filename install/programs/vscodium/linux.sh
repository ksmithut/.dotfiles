#!/usr/bin/env sh

# https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo
# Add vscodium gpg key:
wget -qO - https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/master/pub.gpg | sudo apt-key add -

# Add the Codium repository:
echo 'deb https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/repos/debs/ vscodium main' | sudo tee --append /etc/apt/sources.list

# Update then install vscodium:
sudo apt update && sudo apt install codium

# Checksum verification doesnt work cause GPG signature change the size of package. You can use diff -r for extracted packages or pkgdiff.

# https://code.visualstudio.com/docs/setup/linux#_visual-studio-code-is-unable-to-watch-for-file-changes-in-this-large-workspace-error-enospc
echo 'fs.inotify.max_user_watches=524288' | sudo tee -a /etc/sysctl.conf
sudo sysctl -p

# flatpak install flathub com.visualstudio.code.oss

codium --install-extension Shan.code-settings-sync
