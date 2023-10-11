#!/usr/bin/env bash
is-macos || is-linux || return

export HOMEBREW_NO_ANALYTICS=1

# Install Homebrew.
if [[ ! $(command -v brew) ]]; then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

eval "$(/opt/homebrew/bin/brew shellenv)"

# Exit if, for some reason, Homebrew is not installed.
[[ ! $(command -v brew) ]] && echo "Homebrew failed to install." && exit 1

echo "Updating Homebrew..."
brew doctor
brew update
brew cleanup
brew install mas
brew bundle install --global --cleanup
