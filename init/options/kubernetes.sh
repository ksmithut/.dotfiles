#!/usr/bin/env bash

if is_macos; then
  brew install \
    kubernetes-cli \
    kubernetes-helm \
    kubeseal \
    kustomize \
    skaffold
  brew cask install \
    minikube
fi

# I still haven't figured out all of the kinks involved with installing the
# kubernetes tools on linux

if is_ubuntu; then
  sudo snap install kubectl --classic
  sudo snap install helm --classic
  sudo snap install skaffold

  # Minikube
  wget https://github.com/kubernetes/minikube/releases/download/v1.2.0/minikube_1.2.0.deb -O "$DOTFILES/caches/installers/minikube.deb"
  sudo dpkg -i "$DOTFILES/caches/installers/minikube.deb"
  sudo apt-get install -f -y
fi

if is_windows; then
  choco install -y minikube
  choco install -y kubernetes-cli
  choco install -y kubernetes-helm
  choco install -y skaffold
  choco install -y kustomize
fi
