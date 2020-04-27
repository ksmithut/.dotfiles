#!/usr/bin/env bash

if is_macos || is_ubuntu; then
  asdf plugin add helm
  asdf install helm latest
  asdf global helm "$(asdf latest helm)"

  asdf plugin add kops
  asdf install kops latest
  asdf global kops "$(asdf latest kops)"

  asdf plugin add kubectl
  asdf install kubectl latest
  asdf global kubectl "$(asdf latest kubectl)"

  asdf plugin add kubeseal
  asdf install kubeseal latest
  asdf global kubeseal "$(asdf latest kubeseal)"

  asdf plugin add kustomize
  asdf install kustomize latest
  asdf global kustomize "$(asdf latest kustomize)"

  asdf plugin add minikube
  asdf install minikube latest
  asdf global minikube "$(asdf latest minikube)"

  asdf plugin add skaffold
  asdf install skaffold latest
  asdf global skaffold "$(asdf latest skaffold)"
fi
