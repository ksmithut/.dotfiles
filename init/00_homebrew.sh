# Allow myself to use my software without asking myself for permission
sudo chown -R $(whoami) /usr/local

export HOMEBREW_NO_ANALYTICS=1

# Install Homebrew.
if [[ ! $(which brew) ]]; then
  echo "Installing Homebrew..."
  true | /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Exit if, for some reason, Homebrew is not installed.
[[ ! $(which brew) ]] && echo "Homebrew failed to install." && return 1

echo "Updating Homebrew..."
brew doctor
brew update
brew cleanup

echo "Installing Homebrew/bundle"
brew tap Homebrew/bundle

echo "Installing brew recipes..."
brew bundle --global

# Cleaning up again
brew doctor
brew update
brew upgrade
brew cleanup
