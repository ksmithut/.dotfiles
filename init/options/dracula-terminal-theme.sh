

if is_macos; then
  git clone https://github.com/dracula/terminal-app.git "$DOTFILES_INSTALLERS/dracula-terminal-app"
  open "$DOTFILES_INSTALLERS/dracula-terminal-app/Dracula.terminal"
fi

if is_ubuntu; then
  sudo apt-get install dconf-cli
  git clone https://github.com/dracula/gnome-terminal "$DOTFILES_INSTALLERS/dracula-gnome-terminal"
  cd "$DOTFILES_INSTALLERS/dracula-gnome-terminal"
  ./install.sh
  cd -
fi
