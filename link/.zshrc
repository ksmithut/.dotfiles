#!/usr/bin/env zsh
# Initialize the DOTFILES variable so other scripts can use it

if [ -f ~/.zshrc.local ]; then
  # shellcheck disable=SC1090
  . ~/.zshrc.local
fi

pushd . > /dev/null || exit
SCRIPT_PATH="${(%):-%N}"
if [ -h "${SCRIPT_PATH}" ]; then
  while [ -h "${SCRIPT_PATH}" ]; do
    cd "$(dirname "${SCRIPT_PATH}")" || exit;
    SCRIPT_PATH="$(readlink "${SCRIPT_PATH}")";
  done
fi
cd "$(dirname "${SCRIPT_PATH}")" > /dev/null || exit
DOTFILES="$( cd "$(dirname "$SCRIPT_PATH")/../" || exit; pwd -P )"
export DOTFILES
popd > /dev/null || exit

# Source all of the files in ~/.dotfiles/source
# shellcheck disable=SC1090
for file in "$DOTFILES"/source/*.sh; do source "$file"; done

# REMOVE/REPURPOSE EVERYTHING BELOW HERE (except for the comment)
# Often, install scripts will append commands to the end of your .bash_profile
# to add things to your $PATH or initialize any scripts. This is dandy, but
# you should probably reposition it in the appropriate place in your sourced
# scripts in "$DOTFILES/source"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/Users/ksmithut/.sdkman"
[[ -s "/Users/ksmithut/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/ksmithut/.sdkman/bin/sdkman-init.sh"
