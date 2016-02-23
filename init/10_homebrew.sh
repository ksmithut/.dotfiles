# Install Homebrew.
if [[ ! "$type -P brew" ]]; then
  echo "Installing Homebrew..."
  true | ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Exit if, for some reason, Homebrew is not installed.
[[ ! "$(type -P brew)" ]] && e_error "Homebrew failed to install." && return 1

echo "Updating Homebrew..."
brew docter
brew update
brew cleanup

echo "Installing brew recipes..."

recipes=(
  git
  mongodb
  redix
  trash
  wget
  tree
  httpie
  siege
)

for recipe in "${recipes[@]}"; do
  brew install $recipe
done

echo "Installing brew taps..."

taps=(
  caskroom/cask
)

for tap in "${taps[@]}"; do
  brew tap $tap
done

brew doctor
brew update
brew upgrade `brew outdated`
brew cleanup
