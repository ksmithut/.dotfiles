# This file is for aliases/functions/scripts that are to be used only by the
# the files in this repo, mostly just to detect platform differences.

# OS detection
function is_macos() {
  [[ "$OSTYPE" =~ ^darwin ]] || return 1
}
function is_ubuntu() {
  [[ "$(cat /etc/issue 2> /dev/null)" =~ Ubuntu ]] || return 1
}
function is_debian() {
  [[ "$(cat /etc/issue 2> /dev/null)" =~ Debian ]] || return 1
}
function is_ubuntu_desktop() {
  dpkg -l ubuntu-desktop >/dev/null 2>&1 || return 1
}
function get_os() {
  for os in macos ubuntu ubuntu_desktop debian; do
    is_$os; [[ $? == ${1:-0} ]] && echo $os
  done
}

function is_zsh() {
  [[ "${ZSH_NAME}" != "" ]] || return 1
}
