# Ubuntu-only stuff. Abort if macOS.
is_ubuntu || return 1

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
  unzip "$filename" -d "$HOME/.local/share/gnome-shell/extensions/$uuid"
  rm $filename
}

sudo apt-get update -y
sudo apt-get upgrade -y

sudo apt-get install -y \
  curl \
  wget \
  build-essential \
  python \
  jq \
  tree \
  oathtool \
  vim \
  xclip \
  gnome-tweak-tool \
  gnome-shell-extensions \
  pass

sudo apt-get purge -y firefox

mkdir -p "$DOTFILES/caches/installers/"

if is_ubuntu_desktop; then
  # Remove dock
  sudo apt-get remove gnome-shell-extension-ubuntu-dock -y

  sudo snap install vscode --classic
  sudo snap install chromium
  sudo snap install insomnia
  sudo snap install docker
  sudo snap install vlc
  sudo snap install slack --classic
  sudo snap install firefox --channel=beta

  # Gnome extensions
  # install-gnome-extension command in source/30_aliases.sh
  install-gnome-extension https://extensions.gnome.org/extension/484/workspace-grid/
  install-gnome-extension https://extensions.gnome.org/extension/28/gtile/

  # docker permissions
  sudo snap connect docker:home
  sudo groupadd docker || true
  sudo gpasswd -a $USER docker
  sudo usermod -aG docker $USER
fi

# yarn
# https://yarnpkg.com/en/docs/install#linux-tab
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt-get update -y && sudo apt-get install yarn -y

# pass otp
# https://github.com/tadfisher/pass-otp
git clone https://github.com/tadfisher/pass-otp "$DOTFILES/caches/installers/pass-otp"
builtin cd "$DOTFILES/caches/installers/pass-otp"
sudo make install
builtin cd -
