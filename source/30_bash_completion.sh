# Mac bash completion
if [ -d /usr/local/etc/bash_completion.d ]; then
  for f in /usr/local/etc/bash_completion.d/*; do . $f; done;
fi

# Ubuntu bash completion
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
  . /etc/bash_completion
fi

function _dock_complete() {
  local cur
  COMPREPLY=()
  cur=${COMP_WORDS[COMP_CWORD]}
  COMPREPLY=( $( compgen -W "$(dock ls)" -- "$cur" ) )
  return 0
}
complete -F _dock_complete dock

# https://github.com/npm/npm/issues/11696
export COMP_WORDBREAKS=${COMP_WORDBREAKS//:}
