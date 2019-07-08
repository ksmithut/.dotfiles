# .dotfiles

This is for my personal use. Feel free to use any of these scripts, but run them
at your own discretion. I am not responsible for any effects of these scripts
on your machine.

## Supported Operating Systems

- macOS

  Install XCode in it's fullest :(

  ```sh
  xcode-select --install
  ```

- Ubuntu (Desktop)

  ```sh
  sudo apt update -y
  sudo apt upgrade -y
  ```

- Pop!\_OS (Desktop)

  ```sh
  sudo apt update -y
  sudo apt upgrade -y
  ```

```sh
cd ~ && git clone https://github.com/ksmithut/.dotfiles.git && .dotfiles/setup.sh
```

> Or by using a custom `options.sh` template not in the .dotfiles directory
>
> ```sh
> cd ~ && git clone https://github.com/ksmithut/.dotfiles.git && .dotfiles/setup.sh ~/.my-options-file.sh
> ```
>
> If no custom options file argument is given, it will look for a `options.sh` in the `.dotfiles` folder or use the `options.template.sh`.

## Project structure

- `bin/` Anything in here gets added to your path. Make sure you `chmod a+x`
  anything you add so that it's executable.

- `copy/` Anything in here gets copied to your home directory. This would be for
  things that you would end up changing post-install, such as adding username
  or machine specific stuff to.

- `init/` All of the `.sh` files in this directory get run on initialization.
  There is also an `options/` directory in here that we'll explain down further.

- `link/` All of the files here get symlinked to your home directory.

- `source/` All the files in here get run when you start a new shell, but this
  is really only sourced because of the `link/.zshrc` file.

- `backup.sh` A script to quickly backup your files.

- `setup.sh` The script to run when setting up your system.

- `options.template.sh` This is where customization comes in. Using this template, copy
  the file and rename it to just `options.sh`. This is how you select how you want your
  system setup with various environment options.

## Environment Options structure

```sh
# If the first argument is '_', then the setup script is trying to determine
# the possible environments for this script. You want to
# `echo '{environment}'` for each kind of environment you want to support.
if [ "$1" == '_' ]; then
  echo 'work'
  echo 'play'
  exit
fi

# Every `echo` after this should corespond to a file in `./init/options`
echo 'base'
echo 'chromium'
echo 'zsh'

if [[ " $@ " =~ " work " ]]; then
  echo 'docker'
  echo 'node'
  echo 'vscode'
fi

if [[ " $@ " =~ " play " ]]; then
  echo 'steam'
fi
```

## Create Installation Media

### macOS

[Apple Docs](https://support.apple.com/en-us/HT201372)

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

### Windows

Follow the instructions [here](https://support.microsoft.com/en-us/help/15088/windows-10-create-installation-media)

Although the setup script should work for windows, it's still experimental.
Well, the whole project is, but this even more so.

First, you'll need to install [`git`](https://git-scm.com/downloads). When you
get to the "Adjusting your PATH environment" section, select the option "Use Git
and optional Unix tools from the command Prompt". All the other options you can
change or leave as needed.

Next, open up Powershell as Administrator. It is suggested that you move to your
home directory or a directory within your home directory.

Next, clone this onto your machine:

```sh
git clone https://github.com/ksmithut/.dotfiles.git
cd .dotfiles
```

Then run:

```sh
Set-ExecutionPolicy Bypass -Scope Process -Force; . .\\setup.ps1
```

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
