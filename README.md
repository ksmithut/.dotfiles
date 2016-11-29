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

* `link/` All files in here will be symlinked with `ln -s` to `~`. Use this for
  config dotfiles such as `.bash_profile` and `.inputrc`.

* `source/` All files in here will be included upon every new terminal session.
  Use this for things like aliases, functions, and customizing the bash prompt.

* `init/` All files in here will be run upon running `./dotfiles.sh`. Use this
  for things like installing homebrew or other applications that should only
  need to be run once.

# Installation

If you want to create a bootable installer for macOS, follow the instructions
[here][createinstallmedia].

tl;dr
```sh
# Change /Volumes/Untitled to the volume you want it to be
sudo /Applications/Install\ macOS\ Sierra.app/Contents/Resources/createinstallmedia --volume /Volumes/Untitled --applicationpath /Applications/Install\ macOS\ Sierra.app --nointeraction
```

```sh
cd # Move to home directory
xcode-select --install # Install the XCode Command Line Utilities (mostly for git and other build tools that brew might use)
git clone https://github.com/ksmithut/.dotfiles.git
./.dotfiles/install.sh
```

# Backup

Before you begin a clean install, you may wish to backup other non-dotfile
related files (such as pictures and documents and such). There is a backup
script to help facilitate that in `./backup.sh`. Open that file and look at the
line that looks like this:

```sh
copy_dirs=(
  ~/Code
  ~/Documents
  ~/Pictures
)
```

Add or remove paths in that group as you wish. To run the back up, just `cd`
into the .dotfiles directory and run `./backup.sh [backup directory]`.

# Aliases/Functions

- `beep` - Makes a beep sound
- `myip` - Echoes the local ip address, then a more internet facing ip address.
- `brew-upgrade` - Upgrades brew, all of the outdates brew packages, then cleans
  up after itself.
- `nvm-upgrade` - Upgrades nvm.
- `upgrade` - For now, just runs `brew-upgrade`, but if there were more system
  upgrades to do, put them in here. `nvm` didn't quite qualify.
- `coverage` - Opens up the coverage report for istanbul coverage
- `fix-permissions` - Finds all of the directories under the cwd and sets their
  permissions to `0755` and then finds all of the files under cwd and sets their
  permissions to `0644`.
- `title` - Set the current terminal tab's title.
- `show` - Show hidden files in the finder.
- `hide` - Hide hidden files in the finder.
- `dir` - Like `mkdir -p`, but it moves you to the directory that was created.
- `ls` - Just automatically adds `-p` as an argument to `ls`, which adds
  trailing slashes to the end of directories.
- `mongo-up` - Starts up mongo with default config.
- `redis-up` - Starts up redis with default config.
- `postgres-up` - Starts up postgres with default config.
- `mongo-drop-all` - Drops all mongo databases
- `static` - Starts up a static http server in the current directory.
- `space` - Displays how much space the current repo takes up
- `docker-stop-all` - Stop all docker containers
- `rgb2hex <n> <n> <n>` - Returns hex code for given rgb values
- `hex2rgb <n>` - Returns the rgb values for the given hex code
- `clone <user/repo> [folder name]` - Clones a repo into the given folder name.
  If no folder name is given, the folder name will be the repository slug name.
- `dotfiles` - Moves to the dotfiles directory
- `dotfiles update` - updates the dotfiles repo
- `dotfiles source` - Resources the .bash_profile

# Commands (from bin/)

- `base [--from <x>] [--to <y>] <n ...>` - Converts numbers from base(x) to
  base(y).
- `cidr range [<cidr range ...>]` - Gives you the ip range and total addressable
  hosts of a given CIDR block
- `github-create [repo_name]` - Creates a new public repository on github from
  the repository in the current directory.
- `jwt` - A utility for signing/verifying jwts.
- `npm-latest [--exact]` - Prints out a command to update all of the
  npm dependencies and devDependencies.
- `ts [<timestamp ...>]` - If no argument is passed, gives you the current
  timestamp (in ms). If arguments are passed, it returns a formatted date.

[cowboy]: https://github.com/cowboy/dotfiles
[createinstallmedia]: https://support.apple.com/en-us/HT201372
