# sets up the git config
read -e -p "github username: " GITHUB_USER
read -e -p "github email: " GITHUB_EMAIL
read -e -p "gpg signing key: " GPG_SIGNING_KEY
echo

git config --global user.name $GITHUB_USER
git config --global user.email $GITHUB_EMAIL
git config --global user.signingkey $GPG_SIGNING_KEY
