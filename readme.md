# Dotfiles

Here are my custom dotfiles with a new '[oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh)' flair. Complete overhaul of the theme and zsh backend. Code changed to be more readable and less confusing. Visually, it looks very similar to my old theme, however it is much easier to now modify and build upon.

## Setup

Clone my dotfiles into a directory

        $ git clone https://github.com/briancain/dotfiles.git ~/.dotfiles

Once you have that, copy which theme you want into the zshrc. Or use my default.

Then use rake (in the .dotfiles/ folder) to link the config files to the homedir

        $ rake install

All vim bundles will be auto installed once you open vim.

## Old Dotfiles

Originally forked from Dejital, however the only thing left from that is the handy Rakefile to link rcs to your homedir. Very very useful!
