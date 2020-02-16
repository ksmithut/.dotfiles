

if is_macos; then
  git clone https://github.com/dracula/terminal-app.git "$DOTFILES/caches/installers/dracula-terminal-app"
  open "$DOTFILES/caches/installers/dracula-terminal-app/Dracula.terminal"
fi

if is_ubuntu; then
  sudo apt-get install dconf-cli
  git clone https://github.com/dracula/gnome-terminal "$DOTFILES/caches/installers/dracula-gnome-terminal"
  cd "$DOTFILES/caches/installers/dracula-gnome-terminal"
  ./install.sh
  cd -
fi
