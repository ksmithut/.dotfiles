# Ubuntu-only stuff. Abort if not OSX.
is_ubuntu || return 1

sudo apt update -y
sudo apt upgrade -y

# Create installers foler
mkdir -p "$DOTFILES/caches/installers/"

# https://code.visualstudio.com/docs/setup/linux
curl -L -o "$DOTFILES/caches/installers/vscode.deb" https://vscode-update.azurewebsites.net/latest/linux-deb-x64/stable
sudo dpkg -i "$DOTFILES/caches/installers/vscode.deb"
sudo apt-get install -fy
