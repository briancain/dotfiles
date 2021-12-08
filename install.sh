#! /bin/bash

# Brian Cain
#
# WHAT'S THIS? A BASH FILE WITH FUNCTIONS?
#
# A simple bash script for setting up
# an Machine with my dotfiles

function determine_package_manager() {
  which yum > /dev/null && {
    echo "yum"
    export OSPACKMAN="yum"
    return;
  }
  which brew > /dev/null && {
    echo "homebrew"
    export OSPACKMAN="homebrew"
    return;
  }
  which apt > /dev/null && {
    echo "apt"
    export OSPACKMAN="apt"
    return;
  }
}

# Adds a symbolic link to files in ~/.dotfiles
# to your home directory.
function symlink_files() {
  ignoredfiles=(bin LICENSE readme.md install.sh get-omzsh.sh zsh-theme windows nvim)

  for f in $(ls -d *); do
    if [[ ${ignoredfiles[@]} =~ $f ]]; then
      echo "Skipping $f ..."
    else
      link_file $f
    fi
  done
}

# symlink a file
# arguments: filename
function link_file(){
  echo "linking ~/.$1"
  if ! $(ln -s "$PWD/$1" "$HOME/.$1");  then
    echo "Replace file '~/.$1'?"
    read -p "[Y/n]?: " Q_REPLACE_FILE
    if [[ $Q_REPLACE_FILE != 'n' ]]; then
      replace_file $1
    fi
  fi
}

# replace file
# arguments: filename
function replace_file() {
  echo "replacing ~/.$1"
  ln -sf "$PWD/$1" "$HOME/.$1"
}

function setup_git() {
  echo 'Setting up git config...'
  read -p 'Enter Github username: ' GIT_USER
  git config --global user.name "$GIT_USER"
  read -p 'Enter email: ' GIT_EMAIL
  git config --global user.email $GIT_EMAIL
  git config --global core.editor vim
  git config --global color.ui true
  git config --global color.diff auto
  git config --global color.status auto
  git config --global color.branch auto
  # extras
  git config --global alias.lg log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)%an%Creset' --abbrev-commit
}

cat << EOF

 _.........._
| | brians | |
| |dotfiles| |
| |        | |
| |        | |
| |________| |
|   ______   |
|  |    | |  |
|__|____|_|__|

EOF

set -e
(
  echo "Setting up Machine..."

  determine_package_manager

  # general package array
  declare -a packages=('vim' 'git' 'tree' 'htop' 'wget' 'curl')

  if [[ $OSPACKMAN == "homebrew" ]]; then
    echo "You are running homebrew."
    echo "Using Homebrew to install packages..."
    brew update
    declare -a macpackages=('macvim' 'the_silver_searcher')
    brew install "${packages[@]}" "${macpackages[@]}"
  elif [[ "$OSPACKMAN" == "yum" ]]; then
    echo "You are running yum."
    echo "Using yum to install packages...."
    sudo yum update
    sudo yum install "${packages[@]}" zsh
  elif [[ "$OSPACKMAN" == "apt" ]]; then
    echo "You are running apt"
    echo "Using apt to install packages...."
    declare -a ubuntupackages=('silversearcher-ag')
    sudo apt-get update
    sudo apt-get install "${packages[@]}" "${ubuntupackages[@]}" zsh
  else
    echo "Machine not supported. Exiting..."
    exit 1
  fi

  echo "Installing oh-my-zsh"
  source get-omzsh.sh
  echo "Installing dotfiles"
  symlink_files
  echo "Installing vim vundles..."
  vim +BundleInstall +qall

  echo "Setting up colors..."
  ln -sf ~/.vim/bundle/vim-colorschemes/colors ~/.vim/colors

  echo "Changing shells to ZSH"
  chsh -s /bin/zsh

  echo "Machine setup complete."
  echo "Reloading session"
  exec zsh
)
