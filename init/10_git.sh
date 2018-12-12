# sets up the git config
read -e -p "github username: " GITHUB_USER
read -e -p "github email: " GITHUB_EMAIL
gpg --list-secret-keys --keyid-format LONG
read -e -p "gpg signing key: " GPG_SIGNING_KEY
echo

[[ $GITHUB_USER != "" ]] && git config --global user.name $GITHUB_USER
[[ $GITHUB_EMAIL != "" ]] && git config --global user.email $GITHUB_EMAIL
[[ $GPG_SIGNING_KEY != "" ]] && git config --global user.signingkey $GPG_SIGNING_KEY
