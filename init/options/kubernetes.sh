#!/usr/bin/env bash

if is_macos; then
  brew install \
    kubernetes-cli \
    helm \
    kubeseal \
    kustomize \
    skaffold
  brew cask install \
    minikube
fi

# I still haven't figured out all of the kinks involved with installing the
# kubernetes tools on linux

if is_ubuntu; then
  # kubectl
  sudo apt-get update && sudo apt-get install -y apt-transport-https
  curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
  echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list
  sudo apt-get update
  sudo apt-get install -y kubectl

  # helm
  curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash

  # skaffold
  curl -Lo skaffold https://storage.googleapis.com/skaffold/releases/latest/skaffold-linux-amd64
  chmod +x skaffold
  sudo mv skaffold /usr/local/bin

  # Minikube
  wget https://github.com/kubernetes/minikube/releases/download/v1.6.1/minikube_1.6.1.deb -O "$DOTFILES/caches/installers/minikube.deb"
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
