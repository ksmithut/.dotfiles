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

# apps
cask "1password"
cask "discord"
cask "slack"
cask "kap"
cask "nikitabobko/tap/aerospace"

# development tools
brew "mongosh"
tap "mongodb/brew"
brew "mongodb/brew/mongodb-database-tools"
cask "mongodb-compass"
brew "lazydocker"
cask "docker-desktop" if OS.mac?
brew "mise"
brew "starship"
brew "flyctl"
cask "tableplus"
cask "utm" if OS.mac?
cask "crystalfetch" if OS.mac?
cask "ghostty"
cask "zed"
brew "gh"
cask "tailscale-app"

# elixir/erlang
brew "autoconf"
brew "openssl"
brew "wxwidgets"
brew "libxslt"
brew "fop"

# Games
if feature?("games", features)
  cask "battle-net" if OS.mac?
  cask "minecraft" if OS.mac?
  cask "steam"
end
