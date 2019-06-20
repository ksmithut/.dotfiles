#!/usr/bin/env bash

if is_macos; then
  brew install \
    autojump \
    bash \
    ffmpeg \
    git \
    gpg \
    grep \
    imagemagick \
    jq \
    neofetch \
    pinentry-mac \
    python \
    python@2 \
    shellcheck \
    siege \
    tmux \
    trash \
    tree \
    watch \
    watchman \
    wget \
    zsh \
    zsh-completions

  # Prevent Photos from opening automatically
  defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true
  # to Revert
  # defaults -currentHost delete com.apple.ImageCapture disableHotPlug

  # Enable Develop Menu and Web Inspector
  defaults write com.apple.Safari IncludeInternalDebugMenu -bool true && \
  defaults write com.apple.Safari IncludeDevelopMenu -bool true && \
  defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true && \
  defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true && \
  defaults write -g WebKitDeveloperExtras -bool true
  # Disable Java in Safari
  defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2JavaEnabled -bool false
  defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2JavaEnabledForLocalFiles -bool false

  # Don't prompt new hard drives as backup
  sudo defaults write /Library/Preferences/com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

  # Unhide ~/Library
  chflags nohidden ~/Library

  # Show path in Finder
  defaults write com.apple.finder ShowPathbar -bool true

  # Show status bar in Finder
  defaults write com.apple.finder ShowStatusBar -bool true

  # Makes window resize time instant
  defaults write -g NSWindowResizeTime -float 0.001

  # Turn off startup chime
  sudo nvram SystemAudioVolume=%80

  # Destroy Filevault keys
  # sudo pmset -a destroyfvkeyonstandby 1

  # Disable Creation of Metadata Files
  defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
  defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

  # Power off memory during standby
  # sudo pmset -a hibernatemode 25
  # sudo pmset -a powernap 0
  # sudo pmset -a standby 0
  # sudo pmset -a standbydelay 0
  # sudo pmset -a autopoweroff 0

  # Save to disk by default
  defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false
fi

if is_ubuntu; then
  sudo apt-get install -y \
    autojump \
    build-essential \
    curl \
    gnupg2 \
    gvfs-bin \
    jq \
    libgconf-2-4 \
    neofetch \
    python \
    ruby \
    tmux \
    trash-cli \
    tree \
    vim \
    wget \
    xclip \
    zsh

  sudo snap install htop
fi

if is_ubuntu_desktop || is_pop_desktop; then
  sudo apt-get install -y \
    gnome-shell-extensions \
    gnome-tweak-tool

  function install-gnome-extension() {
    local major_version
    local minor_version
    local patch_version
    local version
    local extension_info
    local download_path
    local uuid
    major_version="$(grep '<platform>' /usr/share/gnome/gnome-version.xml | sed -n 's/.*>\([0-9]*\)<.*/\1/p')"
    minor_version="$(grep '<minor>' /usr/share/gnome/gnome-version.xml | sed -n 's/.*>\([0-9]*\)<.*/\1/p')"
    patch_version="$(grep '<micro>' /usr/share/gnome/gnome-version.xml | sed -n 's/.*>\([0-9]*\)<.*/\1/p')"
    version="$major_version.$minor_version.$patch_version"
    extension_info="$(curl -s "https://extensions.gnome.org/extension-info/?pk=$1&shell_version=$version" | jq 'del(.description)')"
    download_path="$(echo "$extension_info" | jq -r '.download_url')"
    uuid="$(echo "$extension_info" | jq -r '.uuid')"
    wget "https://extensions.gnome.org$download_path" -O "$uuid.zip"
    rm -rf "$HOME/.local/share/gnome-shell/extensions/$uuid"
    mkdir -p "$HOME/.local/share/gnome-shell/extensions"
    unzip "$uuid.zip" -d "$HOME/.local/share/gnome-shell/extensions/$uuid"
    rm "$uuid.zip"
  }

  # Gnome extensions
  install-gnome-extension 484 # workspace-grid
  install-gnome-extension 28 # gtile

  # Remove dock
  sudo apt-get remove gnome-shell-extension-ubuntu-dock -y
  # flatpak gnome software
  sudo apt install -y gnome-software-plugin-flatpak

  sudo snap install vlc
  # flatpak install -y flathub org.videolan.VLC
fi

echo 'Installing powerline fonts...'
mkdir -p "$DOTFILES/caches/fonts"
git clone https://github.com/powerline/fonts.git --depth=1 "$DOTFILES/caches/fonts/powerline-fonts"
"$DOTFILES/caches/fonts/powerline-fonts/install.sh"
