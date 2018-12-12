# Start the gpg agent if it hasn't started

if [ "$(pgrep gpg-agent)" -eq 0 ]; then
  eval "$(gpg-agent --daemon > /dev/null 2>&1)"
  echo "started gpg agent"
fi

export GPG_TTY=$(tty)
