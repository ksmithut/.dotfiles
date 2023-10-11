#!/usr/bin/env bash
set -e
is-macos || is-linux || return

mv ~/.zshrc ~/.zshrc.pre-oh-my-zsh

echo 'Installing oh-my-zsh'
echo 'It is going to put you in a zsh shell session, but you will need to exit out of it to continue with the dotfiles scripts.'
echo 'So after it is done, just type "exit" and press enter.'
echo 'press enter to continue'
# shellcheck disable=SC2034
read -r CONTINUE

# Gotta find a more secure way of doing this... perhaps clone and run?
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

rm ~/.zshrc
mv ~/.zshrc.pre-oh-my-zsh ~/.zshrc
