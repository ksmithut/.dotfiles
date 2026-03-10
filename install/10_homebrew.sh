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

features=()

read -p "Install games? [y/N] " -n 1 -r
[[ $REPLY =~ ^[Yy]$ ]] && features+=("games")

read -p "Install docker? [y/N] " -n 1 -r
[[ $REPLY =~ ^[Yy]$ ]] && features+=("docker")

read -p "Install mongo tools? [y/N] " -n 1 -r
[[ $REPLY =~ ^[Yy]$ ]] && features+=("mongo")

read -p "Install virtualization tools? [y/N] " -n 1 -r
[[ $REPLY =~ ^[Yy]$ ]] && features+=("virtualization")

read -p "Install elixir tools? [y/N] " -n 1 -r
[[ $REPLY =~ ^[Yy]$ ]] && features+=("elixir")

read -p "Install Google Chrome? [y/N] " -n 1 -r
[[ $REPLY =~ ^[Yy]$ ]] && features+=("chrome")

read -p "Install Tailscale? [y/N] " -n 1 -r
[[ $REPLY =~ ^[Yy]$ ]] && features+=("tailscale")

# Or save to file for future runs
echo "${features[*]}" > ~/.config/brew-features

echo "Installing Brew bundle"
brew bundle install --global --cleanup
