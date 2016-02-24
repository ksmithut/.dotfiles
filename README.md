# .dotfiles

This is for my personal use. Feel free to use any of these scripts, but run them
at your own discretion. I am not responsible for any effects of these scripts
on your machine.

The directory structure was mostly modeled after [cowboy's dotfiles][cowboy].

* `copy/` All files in here will be copied over to `~`. Use this for files that
  will carry sensitive information, such as git credentials.

* `link/` All files in here will be symlinked with `ln -s` to `~`. Use this for
  config dotfiles such as `.bash_profile` and `.inputrc`.

* `source/` All files in here will be included upon every new terminal session.
  Use this for things like aliases, functions, and customizing the bash prompt.

* `init/` All files in here will be run upon running `./dotfiles.sh`. Use this
  for things like installing homebrew or other applications that should only
  need to be run once.

# Installation

```
cd # Move to home directory
xcode-select --install # Install the XCode Command Line Utilities (mostly for git and other build tools that brew might use)
git clone https://github.com/ksmithut/.dotfiles.git
./.dotfiles/.dotfiles.sh
```

[cowboy]: https://github.com/cowboy/dotfiles
