# Prevent Photos from opening automatically
defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true
# to Revert
# defaults -currentHost delete com.apple.ImageCapture disableHotPlug

################################################################################
# DEFAULTS
################################################################################

# Makes window resize time instant
defaults write -g NSWindowResizeTime -float 0.001

################################################################################
# Kill affected applications
################################################################################

# Do a restart instead
echo ""
echo "Restart your computer when you get a chance"
