# include all of the bash_completion stuff
for f in /usr/local/etc/bash_completion.d/*; do . $f; done;

# npm auto complete
npm completion
