if [ "$(pgrep gpg-agent)" == "" ]; then
  echo "started gpg agent"
  eval $(gpg-agent --daemon > /dev/null 2>&1)
fi
