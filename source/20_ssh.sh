# Start the ssh agent if it hasn't started

if [ "$(pgrep ssh-agent)" == "" ]; then
  eval $(ssh-agent -s > /dev/null 2>&1)
  # adds all of the private keys to the agent
  eval $(find ~/.ssh -type f ! -name "*.*" -name id_* -exec ssh-add -K {} \; > /dev/null 2>&1)
  echo "started ssh agent"
fi
