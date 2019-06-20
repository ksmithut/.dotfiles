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

- Ubuntu

  ```sh
  sudo apt update -y
  sudo apt upgrade -y
  ```

- Pop!\_OS

  ```sh
  sudo apt update -y
  sudo apt upgrade -y
  ```

```sh
# Clone it anywhere you want, it should symlink things correctly
git clone https://github.com/ksmithut/.dotfiles
.dotfiles/setup.sh
```

## Project structure

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

### Windows

Follow the instructions [here](https://support.microsoft.com/en-us/help/15088/windows-10-create-installation-media)

Obviously, this project is meant for mac/linux based on the bash usage, but I'd
like to have some scripts ready to setup my gaming machines as well.
Unfortunately, I've failed to find a package manager that has the things I want
to install (mostly gaming software since I don't do any development on windows).

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
- [Gog Galaxy](https://www.gog.com/galaxy)

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
