# Ubuntu-only stuff. Abort if not Ubuntu.
is_ubuntu || return 1

sudo chown -R $USER:$USER /usr/local/bin/
echo 'pinentry-program /usr/bin/pinentry-curses' >  ~/.gnupg/gpg-agent.conf
