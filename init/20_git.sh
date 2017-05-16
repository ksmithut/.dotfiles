# sets up the git config
read -e -p "github username: " GITHUB_USER
read -e -p "github email: " GITHUB_EMAIL
echo

git config --global user.name $GITHUB_USER
git config --global user.email $GITHUB_EMAIL
