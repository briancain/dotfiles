#! /bin/bash

# Brian Cain
#
# A simple bash script for setting up
# an Operating System with my dotfiles

echo "Setting up Operating System..."

set -e
(
  if [[ $OSTYPE == darwin* ]]; then
    echo "You are running OSX: " $OSTYPE
    echo "Using Homebrew to install packages"
    brew install vim git tree htop
  else
    echo "You are running Linux: " $OSTYPE
    echo "Using apt-get to install packages...I hope you're using debian based repos."
    sudo apt-get install vim rake git tree zsh htop
  fi

  echo "Installing dotfiles"
  rake install
  echo "Changing shells to ZSH"
  chsh -s /bin/zsh
  echo "Reloading session"
  exec zsh

  echo "Operating System setup complete"
)
