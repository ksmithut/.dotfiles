#!/usr/bin/env bash

# sets up the git config
read -e -p "github username: " GITHUB_USER
read -e -p "github email: " GITHUB_EMAIL
read -e -p "github token: " GITHUB_TOKEN

git config --global user.name $GITHUB_USER
git config --global user.email $GITHUB_EMAIL
git config --global github.user $GITHUB_USER
git config --global github.token $GITHUB_TOKEN
