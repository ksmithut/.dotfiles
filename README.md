# .dotfiles

This is for my personal use. Feel free to use any of these scripts, but run them
at your own discretion. I am not responsible for any effects of these scripts
on your machine.

The directory structure was mostly modeled after [cowboy's dotfiles][cowboy].

* `bin/` All files in here will be available as commands in your terminal. If
  you add files here, you'll need to run
  `[[ -r $DOTFILES ]] && chmod a+x $DOTFILES/bin/*` in order to
  execute them.

* `copy/` All files in here will be copied over to `~`. Use this for files that
  will carry sensitive information, such as git credentials.

* `init/` All files in here will be run upon running `./scripts/setup.sh`. Use this
  for things like installing homebrew or other applications that should only
  need to be run once.

* `link/` All files in here will be symlinked with `ln -s` to `~`. Use this for
  config dotfiles such as `.bash_profile` and `.inputrc`.

* `scripts/` Scripts used to install/setup the dotfiles.

* `source/` All files in here will be included upon every new terminal session.
  Use this for things like aliases, functions, and customizing the bash prompt.

# Installation

If you want to create a bootable installer for macOS, follow the instructions
[here][createinstallmedia].

```sh
# Change /Volumes/Untitled to the volume you want it to be
sudo /Applications/Install\ macOS\ Sierra.app/Contents/Resources/createinstallmedia --volume /Volumes/Untitled --applicationpath /Applications/Install\ macOS\ Sierra.app --nointeraction
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

# Fonts

- I like the [Noto Mono Font](https://www.google.com/get/noto/#mono-mono)

# SSH/GPG keys

```sh
# generate ssh key
# https://help.github.com/articles/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent/"
ssh-keygen -t rsa -b 4096 -C '<your email>'
eval "$(ssh-agent -s)"
ssh-add -K ~/.ssh/id_rsa
pbcopy < ~/.ssh/id_rsa.pub
open https://github.com/settings/keys
```

```sh
# add gpg key
# https://help.github.com/articles/generating-a-new-gpg-key/
# https://github.com/pstadler/keybase-gpg-github#optional-dont-ask-for-password-every-time
gpg --gen-key
gpg --list-secret-keys --keyid-format LONG
git config --global user.signingkey '<secret key id>'
gpg --armor --export '<secret key id>' | pbcopy
open https://github.com/settings/keys
```

[cowboy]: https://github.com/cowboy/dotfiles
[createinstallmedia]: https://support.apple.com/en-us/HT201372
