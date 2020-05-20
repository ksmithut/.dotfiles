#!/usr/bin/env bash

if is_macos; then
  brew install minikube
fi

if is_ubuntu; then
  curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
  chmod +x minikube
  sudo install minikube /usr/local/bin/
  rm minikube
fi

if is_windows; then
  choco install -y minikube
fi
