if [ "$(pgrep ssh-agent)" == "" ]; then
  echo "started ssh agent"
  eval $(ssh-agent -s > /dev/null 2>&1)
  # adds all of the private keys to the agent
  find ~/.ssh -type f ! -name "*.*" -name id_* -exec ssh-add -K {} \;
fi
