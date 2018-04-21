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

(For Dell XPS 15 9560)

Add `nouveau.modeset=0` to boot options (by pressing `e` when selecting a boot
option and adding it before the `---` being sure to leave an extra space)

After installation:

```sh
# Remove dock
sudo apt-get remove gnome-shell-extension-ubuntu-dock

# configure required kernel parameter (https://github.com/Bumblebee-Project/bbswitch/issues/148)
sudo nano /etc/default/grub
# change this parameter to: GRUB_CMDLINE_LINUX_DEFAULT="quiet splash acpi_rev_override=1"
# Change grub background theme
# Login screen
# Make backup first before editing
sudo cp /etc/alternatives/gdm3.css /etc/alternatives/gdm3.css.backup
sudo nano /etc/alternatives/gdm3.css
# ^ Look for #lockDialogGroup and change color
# Grub Screen
sudo cp /usr/share/plymouth/themes/ubuntu-logo/ubuntu-logo.grub /usr/share/plymouth/themes/ubuntu-logo/ubuntu-logo.grub.backup
sudo cp /usr/share/plymouth/themes/ubuntu-logo/ubuntu-logo.script /usr/share/plymouth/themes/ubuntu-logo/ubuntu-logo.script.backup
sudo nano /usr/share/plymouth/themes/ubuntu-logo/ubuntu-logo.grub
# ^ Change rgb color as desired
sudo nano /usr/share/plymouth/themes/ubuntu-logo/ubuntu-logo.script
# ^ Look for Window.SetBackgroundTopColor and change the color
# rebuild the bootloader
sudo update-grub2

# install and configure TLP and PowerTOP
sudo apt-get install tlp tlp-rdw powertop
sudo tlp start
# PowerTOP should be reporting a battery discharge rate of ~8-12W
sudo powertop --auto-tune     # auto-tune parameter will configure some recommended power-saving tweaks

# install Nvidia 384.90 drivers
sudo add-apt-repository ppa:graphics-drivers/ppa
sudo apt update

# PowerTOP should now be reporting a battery discharge rate of ~15-20W
sudo powertop

# install Nvidia Prime: so we can disable the dedicated GPU when we don't want it
sudo apt-get install nvidia-prime
sudo prime-select intel
```

* [https://github.com/rcasero/doc/wiki/Ubuntu-linux-on-Dell-XPS-15-(9560)](<https://github.com/rcasero/doc/wiki/Ubuntu-linux-on-Dell-XPS-15-(9560)>)
* [https://gist.github.com/tomwwright/f88e2ddb344cf99f299935e1312da880](https://gist.github.com/tomwwright/f88e2ddb344cf99f299935e1312da880)

```
sudo apt update -y
sudo apt upgrade -y
sudo apt install git -y
git clone https://github.com/ksmithut/.dotfiles.git ~/.dotfiles
~/.dotfiles/scripts/setup.sh
```

```sh
# Fix firefox theming
sudo nano /usr/share/applications/firefox.desktop
# Change Exec='firefox %u' to Exec=bash -c 'GTK_THEME=" " firefox %u'
```

# Windows

Obviously, this is meant for mac/linux based on the bash usage, but I'd like to
have some scripts ready to setup my gaming machines as well. I don't know what
the best package manager to use is, but I here chocolatey is a thing, so that's
what I'll use here:

[Installation instructions][chocolatey]

```
choco install steam discord origin firefox 1password geforce-experience battle.net uplay logitechgaming -y
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
[chocolatey]: https://chocolatey.org/install
