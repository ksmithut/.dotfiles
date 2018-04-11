# .dotfiles

This is for my personal use. Feel free to use any of these scripts, but run them
at your own discretion. I am not responsible for any effects of these scripts
on your machine.

The directory structure was mostly modeled after [cowboy's dotfiles][cowboy].

* `bin/` commands to be included in the path for custom scripts. You need to
  make sure you run `chmod a+x "${DOTFILES}/bin/*"` whenever you add a new file
  to this directory in order to have the correct permissions to run it.

* `copy/` All files in here will be copied over to `~`. Use this for files that
  will carry sensitive information, such as git credentials, or for files that
  you may want to override on your given installation, but not override for all
  of your computers.

* `init/` All files in here will be run upon running `./scripts/setup.sh`. Use this
  for things like installing homebrew or other applications that should only
  need to be run once.

* `link/` All files in here will be symlinked with `ln -s` to `~`. Use this for
  config dotfiles such as `.bash_profile`.

* `scripts/` Scripts used to install/setup the dotfiles.

* `source/` All files in here will be included upon every new terminal session.
  Use this for things like aliases, functions, and customizing the bash prompt.

# Mac Installation

If you want to create a bootable installer for macOS, follow the instructions
[here][createinstallmedia].

```sh
# Change /Volumes/Untitled to the volume you want it to be
sudo /Applications/Install\ macOS\ High\ Sierra.app/Contents/Resources/createinstallmedia --volume /Volumes/Untitled --applicationpath /Applications/Install\ macOS\ High\ Sierra.app --nointeraction
```

Then backup:

```sh
~/.dotfiles/scripts/backup.sh ~/Desktop
# after it's done, move the backup/ folder to removable media
```

Then boot into the install media holding down option key, format the drive, and
install the OS.

Once in the OS open up the terminal:

```sh
# installs the command-line tools
xcode-select --install
git clone https://github.com/ksmithut/.dotfiles.git ~/.dotfiles
~/.dotfiles/scripts/setup.sh
```

You need to manually move over your backup data.

# Ubuntu Installation

* [https://github.com/rcasero/doc/wiki/Ubuntu-linux-on-Dell-XPS-15-(9560)](<https://github.com/rcasero/doc/wiki/Ubuntu-linux-on-Dell-XPS-15-(9560)>)
* [https://gist.github.com/tomwwright/f88e2ddb344cf99f299935e1312da880](https://gist.github.com/tomwwright/f88e2ddb344cf99f299935e1312da880)

```
sudo apt update -y
sudo apt upgrade -y
sudo apt install git -y
git clone https://github.com/ksmithut/.dotfiles.git ~/.dotfiles
~/.dotfiles/scripts/setup.sh
```

# Backup

Before you begin a clean install, you may wish to backup other non-dotfile
related files (such as pictures and documents and such). There is a backup
script to help facilitate that in `./scripts/backup.sh`. Open that file and look at the
line that looks like this:

```sh
copy_dirs=(
  ~/Code
  ~/Pictures
)
```

Add or remove paths in that group as you wish. To run the back up, just `cd`
into the .dotfiles directory and run `./scripts/backup.sh [backup directory]`.

[cowboy]: https://github.com/cowboy/dotfiles
[createinstallmedia]: https://support.apple.com/en-us/HT201372
