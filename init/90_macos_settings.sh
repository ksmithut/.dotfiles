# macOS-only stuff. Abort if not macOS.
is_macos || return 1

# Prevent Photos from opening automatically
defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true
# to Revert
# defaults -currentHost delete com.apple.ImageCapture disableHotPlug

################################################################################
# Terminal
################################################################################

# Change default shell to use updated bash
echo "/usr/local/bin/bash" | sudo tee -a /etc/shells
sudo chsh -s /usr/local/bin/bash
sudo chsh -s /usr/local/bin/bash $USER

################################################################################
# Safari
################################################################################

# Enable Develop Menu and Web Inspector
defaults write com.apple.Safari IncludeInternalDebugMenu -bool true && \
defaults write com.apple.Safari IncludeDevelopMenu -bool true && \
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true && \
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true && \
defaults write -g WebKitDeveloperExtras -bool true
# Disable Java in Safari
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2JavaEnabled -bool false
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2JavaEnabledForLocalFiles -bool false

################################################################################
# Time Machine
################################################################################

# Don't prompt new hard drives as backup
sudo defaults write /Library/Preferences/com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

################################################################################
# Finder
################################################################################

# Unhide ~/Library
chflags nohidden ~/Library

# Show path in Finder
defaults write com.apple.finder ShowPathbar -bool true

# Show status bar in Finder
defaults write com.apple.finder ShowStatusBar -bool true

################################################################################
# System Preferences
################################################################################

# Makes window resize time instant
defaults write -g NSWindowResizeTime -float 0.001

# Turn off startup chime
sudo nvram SystemAudioVolume=%80

################################################################################
# SECURITY/PRIVACY
################################################################################

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

################################################################################
# Kill affected applications
################################################################################

# Do a restart instead
echo ""
echo "Restart your computer when you get a chance"
