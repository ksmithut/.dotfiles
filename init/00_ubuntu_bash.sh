# Ubuntu-only stuff. Abort if not OSX.
is_ubuntu || return 1

echo 'source ~/.bash_profile' >> ~/.bashrc
