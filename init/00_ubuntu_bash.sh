# Ubuntu-only stuff. Abort if not OSX.
is_ubuntu || return 1

# Load .bash_profile on load
echo 'source ~/.bash_profile' >> ~/.bashrc

chown -R $USER:$USER /usr/local/bin/

# Move dock to bottom
gsettings set com.canonical.Unity.Launcher launcher-position Bottom
