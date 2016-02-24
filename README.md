# .dotfiles

This is for my personal use. Feel free to use any of these scripts, but run them
at your own discretion. I am not responsible for any effects of these scripts
on your machine.

The directory structure was mostly modeled after [cowboy's dotfiles][cowboy].

* `copy/` All files in here will be copied over to `~`. Use this for files that
  will carry sensitive information, such as git credentials

* `link/` All files in here will be symlinked with `ln -s` to `~`

* `source/` All files in here will be included upon startup

To initialize the machine, run `./dotfiles.sh` from the root of this project.

[cowboy]: https://github.com/cowboy/dotfiles
