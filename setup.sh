#!/usr/bin/env bash

function e_header() {
  echo
  echo "======================================================================="
  echo -e "\033[1;36m$1\033[0m"
  echo "======================================================================="
}
function e_success()  { echo -e " \033[1;32m✔\033[0m  $*"; }
function e_error()    { echo -e " \033[1;31m✖\033[0m  $*"; }
function e_arrow()    { echo -e " \033[1;34m➜\033[0m  $*"; }

if [[ "${DOTFILES}" == "" ]]; then
  DOTFILES="$( cd "$(dirname "$0")/" || exit; pwd -P )"
fi

# Makes glob return dotfiles
if [ "$ZSH_NAME" != "" ]; then
  setopt dotglob
else
  shopt -s dotglob > /dev/null 2>&1
fi

function dotfiles_copy() {
  e_header "Copying files to $HOME"
  for file in "$DOTFILES"/copy/*; do
    echo "Copying $(basename "$file")..."
    dest="$HOME/$(basename "$file")"
    if test -f "$dest"; then
      echo "$dest already exists"
      echo -n 'Overwrite? (y/N) '; read -r overwrite
      case $overwrite in
        [Yy]* ) cp "$file" "$HOME/$(basename "$file")"; break;;
        * ) echo "Skipping copying $file"
      esac
    else
      cp "$file" "$HOME/$(basename "$file")"
    fi
  done
}

function dotfiles_link() {
  e_header "Linking files to $HOME"
  for file in "$DOTFILES"/link/*; do
    echo "Linking $(basename "$file")..."
    rm "$HOME/$(basename "$file")" 2> /dev/null
    ln -s "$file" "$HOME/$(basename "$file")"
  done
}

function dotfiles_options() {
  e_header "Searching for options file"

  if [[ -x $DOTFILES_OPTIONS_FILE ]]; then
    # Use readlink for Linux or realpath for mac_os
    if [[ -x "$(command -v readlink)" ]]; then
      DOTFILES_OPTIONS_FILE=$(readlink -f $DOTFILES_OPTIONS_FILE)
    elif [[ -x "$(command -v realpath)" ]]; then
      DOTFILES_OPTIONS_FILE=$(realpath $DOTFILES_OPTIONS_FILE)
    else
      echo 'Unable to determine path of options file, exiting.'
      exit 1
    fi
    echo "Using argment passed options file: ${DOTFILES_OPTIONS_FILE}"
  elif [[ -x "${DOTFILES}/options.sh" ]]; then
    echo "Using options file: ${DOTFILES}/options.sh"
    DOTFILES_OPTIONS_FILE="${DOTFILES}/options.sh"
  elif [[ -x "${DOTFILES}/options.template.sh" ]]; then
    echo "Using the default options template: ${DOTFILES}/options.template.sh"
    DOTFILES_OPTIONS_FILE="${DOTFILES}/options.template.sh"
  else
    echo "No executable option files found, exiting."
    exit 1
  fi
}

function dotfiles_init() {
  e_header "Initializing system"

  local selected_environments=()
  local environments=($($DOTFILES_OPTIONS_FILE _))
  for environment in "${environments[@]}"; do
    echo -n "Will this be a ${environment} environment? (y/N): "; read -r answer
    case $answer in
      [Yy]* ) selected_environments+=("$environment");;
    esac
  done

  local options=($($DOTFILES_OPTIONS_FILE ${selected_environments[@]}))

  mkdir -p "$DOTFILES/caches/installers"
  mkdir -p "$DOTFILES/caches/fonts"
  for file in "$DOTFILES"/init/*.sh; do
    e_header "Init $(basename $file)"
    # shellcheck disable=SC1090
    source $file
    echo "done!"
  done

  for option in "${options[@]}"; do
    e_header "Installing ${option}"
    # shellcheck disable=SC1090
    source "${DOTFILES}/init/options/${option}.sh"
    echo "done!"
  done

  mkdir -p "$DOTFILES/caches/installers"
}

# getopts
while getopts o:e:u: option; do
  case $option in
    o) DOTFILES_OPTIONS_FILE=${OPTARG};;
    e) DOTFILES_ENVIROMENT=${OPTARG};;
    u) DOTFILES_UPDATE=${OPTARG};;
  esac
done

# Keep-alive: update existing `sudo` time stamp until everything has finished
echo "Enter your password here. You should only have to enter it once through this whole process"
sudo -v
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

source "${DOTFILES}/source/00_dotfiles.sh"
dotfiles_copy
dotfiles_link
dotfiles_options
dotfiles_init

echo "Restart your computer when you get a chance."
exit
