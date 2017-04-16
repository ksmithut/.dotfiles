if [ "$(pgrep ssh-agent)" == "" ]; then
  echo "started ssh agent"
  eval $(ssh-agent -s > /dev/null 2>&1)
fi
