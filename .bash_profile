#ulimit -n 65536
#ulimit -u 2048

[[ -r ~/.dotfiles/.aliases ]] && . ~/.dotfiles/.aliases
[[ -r ~/.dotfiles/.git-completion.bash ]] && . ~/.dotfiles/.git-completion.bash
[[ -r ~/.bash_profile.local ]] && . ~/.bash_profile.local
export PATH=/usr/local/bin:/usr/local/sbin:$PATH
