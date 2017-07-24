# include all of the bash_completion stuff
is_macos && for f in /usr/local/etc/bash_completion.d/*; do . $f; done;

# https://github.com/npm/npm/issues/11696
export COMP_WORDBREAKS=${COMP_WORDBREAKS//:}
