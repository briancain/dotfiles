#! /bin/bash

# A simple bash script for setting up
# an Operating System with my dotfiles

echo "Setting up Operating System..."

if [[ $OSTYPE == darwin* ]]; then
  echo "You are running OSX: " $OSTYPE
  echo "Using Homebrew to install packages"
  brew install vim git tree
  echo "Installing dotfiles"
  rake install
else
  echo "You are running Linux" $OSTYPE
  echo "Using apt-get to install packages"
  sudo apt-get install vim rake git tree
  echo "Installing dotfiles"
  rake install
fi

echo "Operating System setup complete"
