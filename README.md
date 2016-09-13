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
# Change /Volumes/MyVolume to the volume you want it to be
sudo /Applications/Install\ OS\ X\ El\ Capitan.app/Contents/Resources/createinstallmedia --volume /Volumes/MyVolume --applicationpath /Applications/Install\ OS\ X\ El\ Capitan.app --nointeraction
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
into the .dotfiles directory and run `./backup.sh` and follow the prompts. You
must enter an absolute path to the directory/volume you wish to download to (no
`~` in the path).

# Aliases/Functions

- `myip` - Echoes the local ip address, then a more internet facing ip address.
- `brew-upgrade` - Upgrades brew, all of the outdates brew packages, then cleans
  up after itself.
- `nvm-upgrade` - Upgrades nvm.
- `upgrade` - For now, just runs `brew-upgrade`, but if there were more system
  upgrades to do, put them in here. `nvm` didn't quite qualify.
- `cask` - Shortcut for `brew cask`.
- `nvm-default` - Sets the currently selected version of node to the default.
- `fix-permissions` - Finds all of the directories under the cwd and sets their
  permissions to `0755` and then finds all of the files under cwd and sets their
  permissions to `0644`.
- `npen` - Open up a package's npm page on npm's website.
- `title` - Set the current terminal tab's title.
- `show` - Show hidden files in the finder.
- `hide` - Hide hidden files in the finder.
- `dir` - Like `mkdir -p`, but it moves you to the directory that was created.
- `ls` - Just automatically adds `-p` as an argument to `ls`, which adds
  trailing slashes to the end of directories.
- `mongo-up` - Starts up mongo with default config.
- `redis-up` - Starts up redis with default config.
- `postgres-up` - Starts up postgres with default config.
- `static` - Starts up a static http server in the current directory.
- `staticphp` - Starts up a static php server in the current directory.
- `resetprompt` - Resets prompt
- `clone <user/repo> [folder name]` - Clones a repo into the given folder name.
  If no folder name is given, the folder name will be the repository slug name.

# Commands (from bin/)

- `base [--from <x>] [--too <y>] <n ...>` - Converts numbers from base(x) to
  base(y).
- `github-create [repo_name]` - Creates a new public repository on github from
  the repository in the current directory.
- `npm-latest [--exact]` - Prints out a command to update all of the
  npm dependencies and devDependencies.
- `. prompt [date] [time] [user] [host] [path] [branch]` - Sets the the PS1 environment
  variable to change the prompt content. The flags indicate which components to
  include in the prompt, and the order of the flags are important to the order
  of the output.
- `ts [<timestamp ...>]` - If no argument is passed, gives you the current
  timestamp (in ms). If arguments are passed, it returns a formatted date.
- `cidr range [<cidr range ...>]` - Gives you the ip range and total addressable
  hosts of a given CIDR block

[cowboy]: https://github.com/cowboy/dotfiles
[createinstallmedia]: https://support.apple.com/en-us/HT201372
