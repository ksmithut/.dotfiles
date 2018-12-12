# Initialize the DOTFILES variable so other scripts can use it
pushd . > /dev/null
SCRIPT_PATH="${(%):-%N}";
if [ -h "${SCRIPT_PATH}" ]; then
  while [ -h "${SCRIPT_PATH}" ]; do
    cd "$(dirname "${SCRIPT_PATH}")" || exit;
    SCRIPT_PATH="$(readlink "${SCRIPT_PATH}")";
  done
fi
builtin cd "$(dirname "${SCRIPT_PATH}")" > /dev/null
export DOTFILES="$( builtin cd "$(dirname "$SCRIPT_PATH")/../"; pwd -P )"
popd  > /dev/null

# Source all of the files in ~/.dotfiles/source
for file in $DOTFILES/source/*.sh; do source "$file"; done

# include local .bash_profile if it's there
[[ -r ~/.bashrc.local ]] && . ~/.bashrc.local

# REMOVE/REPURPOSE EVERYTHING BELOW HERE (except for the comment)
# Often, install scripts will append commands to the end of your .bash_profile
# to add things to your $PATH or initialize any scripts. This is dandy, but
# you should probably reposition it in the appropriate place in your sourced
# scripts in "$DOTFILES/source"
