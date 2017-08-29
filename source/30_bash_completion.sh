# Mac bash completion
if [ -d /usr/local/etc/bash_completion ]; then
  for f in /usr/local/etc/bash_completion.d/*; do . $f; done;
fi

# Ubuntu bash completion
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
  . /etc/bash_completion
fi

# https://github.com/npm/npm/issues/11696
export COMP_WORDBREAKS=${COMP_WORDBREAKS//:}
