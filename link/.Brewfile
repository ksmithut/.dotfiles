features = (File.read("#{Dir.home}/.config/brew-features") rescue "").split

def feature?(name, features)
  features.include?(name)
end

brew "autojump"
brew "bash"
brew "coreutils"
brew "curl"
brew "git"
brew "grep"
brew "jq"
brew "python"
brew "tmux"
brew "trash"
brew "tree"
brew "watch"
brew "watchman"
brew "wget"
brew "zsh-completions"
brew "zsh"

# fonts
cask "font-cascadia-code"
cask "font-cascadia-code-pl"
cask "font-cascadia-mono"
cask "font-cascadia-mono-pl"
cask "font-hack-nerd-font"

# Browsers
cask "zen"
cask "firefox"
cask "google-chrome" if features.include?("chrome")

# apps
cask "1password"
cask "discord"
cask "slack"
cask "kap"
cask "nikitabobko/tap/aerospace"
cask "tailscale-app" if features.include?("chrome")

# development tools
brew "mise"
brew "starship"
brew "flyctl"
cask "tableplus"
cask "ghostty"
cask "zed"
brew "gh"

if features.include?("virtualization")
  cask "utm" if OS.mac?
  cask "crystalfetch" if OS.mac?
end

if features.include?("mongo")
  brew "mongosh"
  tap "mongodb/brew"
  brew "mongodb/brew/mongodb-database-tools"
  cask "mongodb-compass"
end

if features.include?("docker")
  brew "lazydocker"
  cask "docker-desktop" if OS.mac?
end

if features.include?("elixir")
  brew "autoconf"
  brew "openssl"
  brew "wxwidgets"
  brew "libxslt"
  brew "fop"
end

if features.include?("games")
  cask "battle-net" if OS.mac?
  cask "minecraft" if OS.mac?
  cask "steam"
end
