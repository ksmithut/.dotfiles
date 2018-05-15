# Ubuntu-only stuff. Abort if macOS.
is_ubuntu || return 1

# Note that this is pretty fragile. This is basically going through and parsing
# a value out of an attribute on an html page and going through the versions and
# selecting the latest version. If there were a better cli for installing
# extensions, I would rather use that, but this will do for now.
function install-gnome-extension() {
  local url=$1
  local page_html=$(curl -s "$1")
  local versions=$(echo $page_html \
    | sed 's/^.*data-versions="\([^"]*\)".*$/\1/' \
    | sed 's/&quot;/"/g')
  local uuid=$(echo $page_html \
    | grep data-uuid \
    | sed 's/^.*data-uuid="\([^"]*\)".*$/\1/')
  local shell_version=$(echo $versions | jq -r 'keys[]' | sort --version-sort | tail -1)
  local extension_version=$(echo $versions | jq ".[\"$shell_version\"] | .[] | .version" | sort --version-sort | tail -1)
  local version_tag=$(echo $versions | jq ".[\"$shell_version\"] | .[] | select(.version==$extension_version) | .pk")
  local filename="$uuid.shell-extension.zip?version_tag=$version_tag"
  rm $filename
  wget "https://extensions.gnome.org/download-extension/$filename"
  rm -rf "$HOME/.local/share/gnome-shell/extensions/$uuid"
  mkdir -p "$HOME/.local/share/gnome-shell/extensions/"
  unzip "$filename" -d "$HOME/.local/share/gnome-shell/extensions/$uuid"
  rm $filename
}

sudo apt-get update -y
sudo apt-get upgrade -y

sudo apt-get install -y \
  build-essential \
  curl \
  gnome-shell-extensions \
  gnome-tweak-tool \
  gvfs-bin \
  jq \
  oathtool \
  python \
  ruby \
  trash-cli \
  tree \
  vim \
  wget \
  xclip

sudo apt-get purge -y \
  firefox

sudo snap install docker --classic
sudo addgroup --system docker
sudo adduser $USER docker
newgrp docker

if is_ubuntu_desktop; then
  # Remove dock
  sudo apt-get remove gnome-shell-extension-ubuntu-dock -y

  sudo snap install chromium
  sudo snap install firefox
  sudo snap install insomnia
  sudo snap install slack --classic
  sudo snap install vlc
  sudo snap install vscode --classic

  # Gnome extensions
  install-gnome-extension https://extensions.gnome.org/extension/484/workspace-grid/
  install-gnome-extension https://extensions.gnome.org/extension/28/gtile/
fi

# yarn
# https://yarnpkg.com/en/docs/install#debian-stable
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt-get update -y
sudo apt-get install yarn -y
