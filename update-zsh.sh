#! /bin/bash

# Brian Cain 2014
# Set up oh-my-zsh

echo 'Adding oh-my-zsh to dotfiles...'

echo 'Removing old oh-my-zsh files...'
rm -rf oh-my-zsh

echo 'Cloning updated version...'
git clone https://www.github.com/robbyrussell/oh-my-zsh.git

echo 'Moving theme into oh-my-zsh'
cp zsh-theme/brian.zsh-theme oh-my-zsh/themes

echo 'Complete Update!'
