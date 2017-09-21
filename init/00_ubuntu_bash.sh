# Ubuntu-only stuff. Abort if not Ubuntu.
is_ubuntu || return 1

# Load .bash_profile on load
echo 'source ~/.bash_profile' >> ~/.bashrc

chown -R $USER:$USER /usr/local/bin/
echo 'pinentry-program /usr/bin/pinentry-curses' >  ~/.gnupg/gpg-agent.conf

# Move dock to bottom
gsettings set com.canonical.Unity.Launcher launcher-position Bottom
