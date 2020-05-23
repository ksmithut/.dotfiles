#!/usr/bin/env sh

# UPDATE_VERSION

wget https://packages.erlang-solutions.com/erlang-solutions_2.0_all.deb -O "$TEMP_DIR/caches/installers/erlang.deb"
sudo dpkg -i "$TEMP_DIR/caches/installers/erlang.deb"
sudo apt-get update
sudo apt-get install -y esl-erlang
sudo apt-get install -y elixir
