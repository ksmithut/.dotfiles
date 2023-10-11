#!/usr/bin/env bash
set -e
is-macos || return

# Turn off "Play sound on startup"
sudo nvram StartupMute=%01

# Unhide ~/Library
chflags nohidden ~/Library

# Turn off "Play user interface sound effects"
defaults write -g com.apple.sound.beep.feedback -bool false

# 24-hour time
defaults write -g AppleICUForce24HourTime -bool true
defaults write com.apple.menuextra.clock Show24Hour -bool true
# Turn on seconds in menu
defaults write com.apple.menuextra.clock ShowSeconds -bool true
# Turn on day of the week
defaults write com.apple.menuextra.clock ShowDayOfWeek -bool true

# Dark Mode
defaults write -g AppleInterfaceStyle -string Dark

# Disable shake mouse pointer
defaults write -g CGDisableCursorLocationMagnification -bool true

# Enable 3-finger drag
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerDrag -bool true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerDrag -bool true

# Control Center
defaults write com.apple.controlcenter "NSStatusItem Visible Battery" -bool true
defaults write com.apple.controlcenter "NSStatusItem Visible Bluetooth" -bool true
defaults write com.apple.controlcenter "NSStatusItem Visible Sound" -bool true
defaults write com.apple.controlcenter "NSStatusItem Visible WiFi" -bool true
# defaults delete com.apple.controlcenter "NSStatusItem Visible Item-0"

# Auto-hide Dock
defaults write com.apple.dock autohide -bool true
# Do not show recents
defaults write com.apple.dock show-recents -bool false
# disable automatically rearranging spaces
defaults write com.apple.dock mru-spaces -bool false

# Key repeat rate fast
defaults write -g KeyRepeat -int 2
defaults write -g InitialKeyRepeat -int 15

# Trackpad Silent Clicking
defaults write com.apple.AppleMultitouchTrackpad ActuationStrength -int 0

# Show all filename extensions
defaults write -g AppleShowAllExtensions

# Set default new finder window
defaults write com.apple.finder NewWindowTarget -string PfHm
echo $HOME
echo "file://${HOME}/"
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/"
echo "after"

# Disable warning before changing an extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Disable warning before emptying trash
defaults write com.apple.finder WarnOnEmptyTrash -bool false

# Search current folder when performing a search
defaults write com.apple.finder FXDefaultSearchScope -string SCcf

# Save to disk by default
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

# Disable Creation of Metadata Files
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# Enable Develop Menu and Web Inspector
defaults write com.apple.Safari IncludeInternalDebugMenu -bool true && \
defaults write com.apple.Safari IncludeDevelopMenu -bool true && \
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true && \
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true && \
defaults write -g WebKitDeveloperExtras -bool true
# Disable Java in Safari
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2JavaEnabled -bool false
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2JavaEnabledForLocalFiles -bool false
