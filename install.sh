#! /bin/bash

# Brian Cain
#
# A simple bash script for setting up
# an Operating System with my dotfiles

set OSDISTRO=''

# Function to determine package manager
function os_type() {
  which yum > /dev/null && {
    echo "yum"
    export OSDISTRO="centos"
    return;
  }
  which apt-get > /dev/null && {
    echo "apt-get"
    export OSDISTRO="debian"
    return;
  }
  which brew > /dev/null && {
    echo "homebrew"
    export OSDISTRO="homebrew"
    return;
  }
}

echo "Setting up Operating System..."

set -e
(
  os_type
  echo $DISTRO
  if [[ $OSDISTRO == "homebrew" ]]; then
    echo "You are running OSX: " $OSTYPE
    echo "Using Homebrew to install packages"
    brew install vim macvim git tree htop wget curl
  elif [[ "$OSDISTRO" == "centos" ]]; then
    echo "You are running yum."
    echo "Using apt-get to install packages...."
    sudo yum install vim rake git tree zsh htop wget curl
  elif [[ "$OSDISTRO" == "debian" ]]; then
    echo "You are running apt-get"
    echo "Using apt-get to install packages...."
    sudo apt-get install vim rake git tree zsh htop wget curl
  else
    echo "Could not determine OS. Exiting..."
    exit 1
  fi

  echo "Installing oh-my-zsh"
  source update-zsh.sh
  echo "Installing dotfiles"
  rake install
  echo "Installing vim vundles..."
  vim +BundleInstall +qall
  echo "Changing shells to ZSH"
  chsh -s /bin/zsh
  echo "Reloading session"
  exec zsh

  echo "Operating System setup complete."
)
