#!/usr/bin/env sh

sudo chown -R "$(whoami)" /usr/local

export HOMEBREW_NO_ANALYTICS=1

# Install Homebrew.
if [[ ! $(command -v brew) ]]; then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi

# Exit if, for some reason, Homebrew is not installed.
[[ ! $(command -v brew) ]] && echo "Homebrew failed to install." && return 1

echo "Updating Homebrew..."
brew doctor
brew update
brew cleanup

brew install mas
brew tap homebrew/services

brew install \
  autojump \
  bash \
  ffmpeg \
  git \
  gnupg \
  grep \
  imagemagick \
  jq \
  neofetch \
  pinentry-mac \
  python \
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
# sudo defaults write /Library/Preferences/com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

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
