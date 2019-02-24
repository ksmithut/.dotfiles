#!/usr/bin/env bash
# oh-my-zsh

mv ~/.zshrc ~/.zshrc.pre-oh-my-zsh
# Gotta find a more secure way of doing this... perhaps clone and run?
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

rm ~/.zshrc
mv ~/.zshrc.pre-oh-my-zsh ~/.zshrc
