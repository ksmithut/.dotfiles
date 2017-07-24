# Ubuntu-only stuff. Abort if not OSX.
is_ubuntu || return 1

sudo apt update -y
sudo apt upgrade -y

sudo apt install -y \
  build-essential \
  jq \
  tree

# Create installers foler
mkdir -p "$DOTFILES/caches/installers/"

# Remove LibreOffice
sudo apt-get remove --purge libreoffice*
sudo apt-get clean
sudo apt-get autoremove

# Visual Studio Code
# https://code.visualstudio.com/docs/setup/linux
wget -O "$DOTFILES/caches/installers/vscode.deb" https://vscode-update.azurewebsites.net/latest/linux-deb-x64/stable
sudo dpkg -i "$DOTFILES/caches/installers/vscode.deb"
sudo apt-get install -fy

# Chrome
# wget -O "$DOTFILES/caches/installers/chrome.deb" https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
# sudo dpkg -i "$DOTFILES/caches/installers/chrome.deb"
# sudo apt-get install -fy

# yarn
# https://yarnpkg.com/en/docs/install#linux-tab
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt-get update -y && sudo apt-get install yarn -y

# docker
# https://docs.docker.com/engine/installation/linux/docker-ce/ubuntu/#install-docker-ce
# https://download.docker.com/linux/ubuntu/dists/zesty/pool/stable/amd64/
wget -O "$DOTFILES/caches/installers/docker.deb" "https://download.docker.com/linux/ubuntu/dists/$(lsb_release -cs)/pool/stable/amd64/docker-ce_17.06.0~ce-0~ubuntu_amd64.deb"
sudo dpkg -i "$DOTFILES/caches/installers/docker.deb"
sudo apt-get install -fy

# Slack
wget -O "$DOTFILES/caches/installers/slack.deb" https://downloads.slack-edge.com/linux_releases/slack-desktop-2.6.3-amd64.deb
sudo dpkg -i "$DOTFILES/caches/installers/slack.deb"
sudo apt-get install -fy
