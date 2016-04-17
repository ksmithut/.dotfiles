# sets up the git config
read -e -p "github username: " GITHUB_USER
read -e -p "github email: " GITHUB_EMAIL
read -es -p "github token: " GITHUB_TOKEN
echo

git config --global user.name $GITHUB_USER
git config --global user.email $GITHUB_EMAIL
git config --global github.user $GITHUB_USER
git config --global github.token $GITHUB_TOKEN

ssh-keygen -t rsa -b 4096 -C "$GITHUB_EMAIL"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa
pbcopy < ~/.ssh/id_rsa.pub

echo "Paste in your public key in the opened window"
open "https://github.com/settings/keys"
