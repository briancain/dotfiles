# Dotfiles

Here are my custom dotfiles with a new '[oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh)' flair. Complete overhaul of the theme and zsh backend. Code changed to be more readable and less confusing. Visually, it looks very similar to my old theme, however it is much easier to now modify and build upon.

## Setup

Clone my dotfiles into a directory

    $ git clone https://github.com/briancain/dotfiles.git ~/.dotfiles

Then run my simple install bash script

    $ ./install.sh

__Note:__

- On OSX, this script assumes you have XCode command line tools installed, and then homebrew installed. It should take care of the rest.
- If on linux, it assumes you are either using apt-get or yum as your package manager.


All vim bundles will be auto installed once you open vim.

### mutt

If you are interested in using mutt, these dotfiles will lay down some initial work to get that going for you. If you say no, the installer will go on its way and ignore any mutt related things.

## Updating oh-my-zsh

When you need to get the latest version of oh-my-zsh, just run the update script from the root directory of the project:

    $ ./update-zsh.sh

__WARNING__: This will completely replace your oh-my-zsh folder with the latest version from Github.

## Oh-My-Zsh Custom Theme

I wrote my own theme, which you can find within the oh-my-zsh folder under themes. It's basically the Linut Mint shell with some git helper magic. Here's a preview:

![zsh-theme](http://i.imgur.com/WdGWogr.png)

## Old Dotfiles

Originally forked from Dejital, however the only thing left from that is the handy Rakefile to link rcs to your homedir. Very very useful! That repo is now moved to `old_dotfiles` since it really isn't a fork anymore.

### Works great on....

Dotfile installation automation tested on operating systems such as....

- apt-get/yum package managers
- Mac OSX 10.X with Homebrew
  + ASSUMPTIONS: You need XCode command line tools before installing
