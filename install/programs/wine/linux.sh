#!/usr/bin/env sh

# enable 32 bit architecture
sudo dpkg --add-architecture i386

# add the repository key:
wget -nc https://dl.winehq.org/wine-builds/winehq.key
sudo apt-key add winehq.key
rm winehq.key

case "$(lsb_release -a | grep 'Release:')" in
  *"18.04")
    sudo apt-add-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ bionic main'
    ;;
  *"18.10")
    sudo apt-add-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ cosmic main'
    ;;
  *"19.04")
    sudo apt-add-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ disco main'
    ;;
  *"19.10")
    sudo apt-add-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ eoan main'
    ;;
  *"20.04")
    sudo apt-add-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ focal main'
    ;;
  * )
    echo 'No supported version found'
    exit 1
esac

sudo apt-get update -y
sudo apt-get install -y --install-recommends winehq-stable
