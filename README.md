# .dotfiles

This is for my personal use. Feel free to use any of these scripts, but run them
at your own discretion. I am not responsible for any effects of these scripts
on your machine.

## Installation

Each "supported" platform has things you need to run before you clone and run
things.

- macOS

  Install XCode in it's fullest :(

  ```sh
  # Install xcode command line tools
  xcode-select --install
  ```

- Ubuntu and Pop!\_OS

  ```sh
  sudo apt update -y
  sudo apt upgrade -y
  ```

- Debian (Linux on ChromeOS)

  ```sh
  sudo apt update -y
  sudo apt upgrade -y
  sudo passwd "${USER}"
  ```

```sh
# Clone it anywhere you want, it should symlink things correctly
git clone https://github.com/ksmithut/.dotfiles
.dotfiles/bin/dotfiles setup
```

## Supported/Tested installations

- macOS
- Ubuntu (On Dell XPS)
- Pop!\_OS (On Dell XPS)
- Debian (Linux on ChromeOS)

## Create Installation Media

### macOS

[Apple Docs](createinstallmedia)

Download the version of macOS you want to install directly from the App Store.
When the download completes, it will prompt you to install/upgrade in a dialog.
Just `cmd + Q` out of that. You'll also want to have a USB Drive that has been
formated and named `Untitled` plugged into your computer. Then run the following
command:

```sh
# Change /Volumes/Untitled to the volume you want it to be
# Or change the "Install\ macOS\ Mojave.app" to the version of mac you want to
# install
sudo /Applications/Install\ macOS\ Mojave.app/Contents/Resources/createinstallmedia --volume /Volumes/Untitled --nointeraction
```

After that finishes (it will be a while, 20 minutes to an hour maybe?) you'll
want to back up all your stuff and shutdown the computer. When you restart, hold
down the option key with the USB drive plugged in and select your install media
as the boot drive and continue with installation there.

### Ubuntu and Pop!\_OS

Download the ISOs from their respective sites and write the images to a bootable
USB drive using something like [balenaEtcher](https://www.balena.io/etcher/).

### Debian (ChromeOS)

Just enable Linux App (Beta) in the settings

## Structure

The directory structure was mostly modeled after [cowboy's dotfiles][cowboy].

- `bin/` commands to be included in the path for custom scripts. You need to
  make sure you run `chmod a+x "${DOTFILES}"/bin/*` whenever you add a new file
  to this directory in order to have the correct permissions to run it.

- `copy/` All files in here will be copied over to `~`. Use this for files that
  will carry sensitive information, such as git credentials, or for files that
  you may want to override on your given installation, but not override for all
  of your computers.

- `init/` All files in here will be run upon running `./bin/dotfiles setup`. Use
  this for things like installing homebrew or other applications that should
  only need to be run once.

- `link/` All files in here will be symlinked with `ln -s` to `~`. Use this for
  config dotfiles such as `.bash_profile`.

- `source/` All files in here will be included upon every new terminal session.
  Use this for things like aliases, functions, and customizing the bash prompt.

## Notes

### Dell XPS 15 9560 for Ubuntu (Not Pop!\_OS)

If you're installing Ubuntu, you'll need to add a boot flag on install.
Add `nouveau.modeset=0` to boot options (by pressing `e` when selecting a boot
option and adding it before the `---` being sure to leave an extra space).

To update graphics drivers:

```sh
sudo add-apt-repository ppa:graphics-drivers/ppa
sudo apt-get update
```

To change grub background from that ugly purple color to a dull gray:

```sh
# configure required kernel parameter (https://github.com/Bumblebee-Project/bbswitch/issues/148)
sudo nano /etc/default/grub
# change this parameter to: GRUB_CMDLINE_LINUX_DEFAULT="quiet splash acpi_rev_override=1"
# Change grub background theme
# Login screen
# Make backup first before editing
sudo cp /etc/alternatives/gdm3.css /etc/alternatives/gdm3.css.backup
sudo nano /etc/alternatives/gdm3.css
# ^ Look for #lockDialogGroup and change color to #191919
# Grub Screen
sudo cp /usr/share/plymouth/themes/ubuntu-logo/ubuntu-logo.grub /usr/share/plymouth/themes/ubuntu-logo/ubuntu-logo.grub.backup
sudo cp /usr/share/plymouth/themes/ubuntu-logo/ubuntu-logo.script /usr/share/plymouth/themes/ubuntu-logo/ubuntu-logo.script.backup
sudo nano /usr/share/plymouth/themes/ubuntu-logo/ubuntu-logo.grub
# ^ Change rgb color to 25,25,25,0
sudo nano /usr/share/plymouth/themes/ubuntu-logo/ubuntu-logo.script
# ^ Look for Window.SetBackgroundTopColor and change the color to (0.10, 0.10, 0.10)
# rebuild the bootloader
sudo update-grub2
```

Preferred keyboard shortcuts (Might apply to Pop!\_OS)

```sh
# Keyboard shortcuts
# ==================
# Prevent gnome resetting keyboard setting in X
gsettings set org.gnome.settings-daemon.plugins.keyboard active false

# change workspace movement to ctrl + <- and ctrl + ->
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-left "['<Control>Left']"
# Undo gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-left "['<Control><Alt>Left']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-right "['<Control>Right']"
# Undo gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-right "['<Control><Alt>Right']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-up "['<Control>Up']"
# Undo gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-left "['<Control><Alt>Up']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-down "['<Control>Down']"
# Undo gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-right "['<Control><Alt>Down']"

gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-left "['<Control><Shift>Left']"
# Undo gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-left "['<Control><Shift>Left']"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-right "['<Control><Shift>Right']"
# Undo gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-right "['<Control><Shift>Right']"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-up "['<Control><Shift>Up']"
# Undo gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-up "['<Control><Shift>Up']"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-down "['<Control><Shift>Down']"
# Undo gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-down "['<Control><Shift>Down']"


# swap super and alt
# setxkbmap -option altwin:swap_lalt_lwin # TODO make this permanent
# Undo setxkbmap -option
```

- [https://github.com/rcasero/doc/wiki/Ubuntu-linux-on-Dell-XPS-15-(9560)](<https://github.com/rcasero/doc/wiki/Ubuntu-linux-on-Dell-XPS-15-(9560)>)
- [https://gist.github.com/tomwwright/f88e2ddb344cf99f299935e1312da880](https://gist.github.com/tomwwright/f88e2ddb344cf99f299935e1312da880)

Fix for firefox scaling:

Open up about:config

- change 'layout.css.devPixelsPerPx' to 1.25 for global scaling

## Pixelbook

I also like to change the terminal configuration to work with powerline fonts:

1. When in the terminal, press `ctrl + shift + p`
2. Change `font-family` to `"Source Code Pro", monospace`
3. Change `user-css` to `https://cdn.rawgit.com/wernight/powerline-web-fonts/e4d967ca4f95d9fa0cf1d51afed2e5a5927d759e/PowerlineFonts.css`

## Windows

Obviously, this is meant for mac/linux based on the bash usage, but I'd like to
have some scripts ready to setup my gaming machines as well. Unfortunately, I've
failed to find a package manager that has the things I want to install
(mostly gaming software since I don't do any development on windows).

Here's my list of apps and the locations to download them manually:

- [Firefox](https://www.mozilla.org/en-US/firefox/new/)
- [1Password](https://1password.com/downloads/)
- [Discord](https://discordapp.com/download)
- [Uplay](https://uplay.ubi.com/)
- [Steam](https://store.steampowered.com/)
- [Battle.net](https://us.battle.net/account/download/)
- [Origin](https://www.origin.com/usa/en-us/store/download)
- [Epic Launcher](https://www.epicgames.com/unrealtournament/download)
- [GeForce Experience](https://www.nvidia.com/en-us/geforce/geforce-experience/)
- [Minecraft](https://minecraft.net/en-us/download/)

Also, in order to play with with time, Windows should be made to use UTC rather
than local time.

[https://askubuntu.com/questions/169376/clock-time-is-off-on-dual-boot#169384](https://askubuntu.com/questions/169376/clock-time-is-off-on-dual-boot#169384)

> Create a file named WindowsTimeFixUTC.reg with the following contents and then double click on it to merge the contents with the registry:
>
>     Windows Registry Editor Version 5.00
>     [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\TimeZoneInformation]
>          "RealTimeIsUniversal"=dword:00000001
>
> Note: Windows Time service will still write local time to the RTC regardless of the registry setting above on shutdown, so it is handy to disable Windows Time service with this command (if time sync is still required while in Windows use any third-party time sync solution):
>
>     sc config w32time start= disabled

## Backup

Before you begin a clean install, you may wish to backup other non-dotfile
related files (such as pictures and documents and such). There is a backup
script to help facilitate that in `~/.dotfiles/bin/dotfiles`. Open that
file and look at the line that looks like this:

```sh
copy_dirs=(
  ~/Code
  ~/Pictures
)
```

Add or remove paths in that group as you wish. To run the back up, just `cd`
into the .dotfiles directory and run `~/.dotfiles/bin/dotfiles backup [backup directory]`.

[cowboy]: https://github.com/cowboy/dotfiles
[createinstallmedia]: https://support.apple.com/en-us/HT201372
