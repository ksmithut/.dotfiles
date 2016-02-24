# Allow myself to use my software without asking myself for permission
sudo chown -R `whoami` /usr/local

# Install Homebrew.
if [[ ! "$type -P brew" ]]; then
  echo "Installing Homebrew..."
  true | ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Exit if, for some reason, Homebrew is not installed.
[[ ! "$(type -P brew)" ]] && e_error "Homebrew failed to install." && return 1

echo "Updating Homebrew..."
brew doctor
brew update
brew cleanup


echo "Installing brew recipes..."

recipes=($(setdiff "${recipes[*]}" "$(brew list)"))
for recipe in "${recipes[@]}"; do
  brew install $recipe
done

echo "Installing brew taps..."

kegs=($(setdiff "${kegs[*]}" "$(brew tap)"))
for keg in "${kegs[@]}"; do
  brew tap $keg
done

# Cleaning up again
brew doctor
brew update
brew upgrade `brew outdated`
brew cleanup
