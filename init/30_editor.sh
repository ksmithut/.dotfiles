code --install-extension Shan.code-settings-sync

if is_ubuntu; then
  # https://code.visualstudio.com/docs/setup/linux#_visual-studio-code-is-unable-to-watch-for-file-changes-in-this-large-workspace-error-enospc
  echo 'fs.inotify.max_user_watches=524288' | sudo tee -a /etc/sysctl.conf
  sudo sysctl -p
fi
