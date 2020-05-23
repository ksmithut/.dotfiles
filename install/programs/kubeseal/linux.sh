#!/usr/bin/env sh

# UPDATE_VERSION

wget https://github.com/bitnami-labs/sealed-secrets/releases/download/v0.12.3/kubeseal-linux-amd64 -O kubeseal
sudo install -m 755 kubeseal /usr/local/bin/kubeseal
rm kubeseal
