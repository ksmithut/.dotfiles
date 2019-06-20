#!/usr/bin/env bash

function minikube-hosts() {
  local CONTEXT=minikube
  local MINIKUBE_IP=$(minikube ip)
  local HOSTS=$(kubectl --context $CONTEXT --all-namespaces=true get ingress -o=jsonpath='{.items[*].spec.rules[*].host}')

  for h in $HOSTS; do
    # remove entries
    sudo sed -i".bak" "/$h/d" /etc/hosts

    # add entries
    echo "${MINIKUBE_IP} ${h}" | sudo tee -a /etc/hosts
  done
}
