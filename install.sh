#! /bin/bash

# Brian Cain
#
# A simple bash script for setting up
# an Operating System with my dotfiles

# Function to determine package manager
function os_type() {
  which yum > /dev/null && {
    echo "yum"
    export OSPACKMAN="yum"
    return;
  }
  which apt-get > /dev/null && {
    echo "apt-get"
    export OSPACKMAN="aptget"
    return;
  }
  which brew > /dev/null && {
    echo "homebrew"
    export OSPACKMAN="homebrew"
    return;
  }
}

# symlink a file
# arguments: filename
function link_file(){
  echo "linking ~/.$1"
  ln -s "$PWD/$1" "$HOME/.$1"
}

# replace file
# arguments: filename
function replace_file() {
  rm -rf "$HOME/.$1"
  link_file "$1"
}

# install files to $HOME
function install_dotfiles() {
  echo "Fix me"
}

echo "Setting up Operating System..."

set -e
(
  os_type

  # general package array
  declare -a packages=('vim' 'git' 'tree' 'htop' 'wget' 'curl')

  if [[ $OSPACKMAN == "homebrew" ]]; then
    echo "You are running homebrew."
    echo "Using Homebrew to install packages..."
    brew update && brew upgrade
    declare -a macpackages=('findutils' 'macvim' 'the_silver_searcher')
    brew install "${packages[@]}" "${macpackages[@]}"
    brew cleanup
  elif [[ "$OSPACKMAN" == "yum" ]]; then
    echo "You are running yum."
    echo "Using apt-get to install packages...."
    sudo yum update
    sudo yum install "${packages[@]}" rake zsh
  elif [[ "$OSPACKMAN" == "aptget" ]]; then
    echo "You are running apt-get"
    echo "Using apt-get to install packages...."
    sudo apt-get update && sudo apt-get upgrade
    sudo apt-get install "${packages[@]}" rake zsh
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

  echo "Operating System setup complete."
  echo "Reloading session"
  exec zsh
)
