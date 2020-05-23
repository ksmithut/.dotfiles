#!/usr/bin/env sh

. $HOME/.asdf/asdf.sh

asdf plugin add minikube
asdf install minikube latest
asdf global minikube "$(asdf latest minikube)"
