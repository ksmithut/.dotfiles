if [ "$(pgrep ssh-agent)" == "" ]; then
  eval $(ssh-agent -s > /dev/null 2>&1)
fi
