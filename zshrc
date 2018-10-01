# ENV VARS
export EDITOR='vim'
export GPG_TTY=$(tty)
export PATH="$HOME/bin:$HOME/.bin:/usr/local/homebrew/bin:/usr/local/bin:/usr/local/sbin:/usr/local/git/bin:$PATH"
# ENV VARS

# Work stuff
export VAGRANT_INSTALLER_ENV=1
# vmware vagrant plugin helper functions
function vmware () {
  sudo $HOME/go/src/github.com/hashicorp/vagrant-vmware-desktop/go_src/vagrant-vmware-utility/vagrant-vmware-utility api
}

function killvmware () {
  sudo kill -9 $(ps aux | grep -v sudo | grep -v grep | grep 'vagrant-vmware-utility api' | awk '{print $2}')
}
# end

# RVM
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" # Load RVM function
PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

# Golang
PATH=$PATH:$HOME/go/bin:/usr/lib/go-1.10/bin

# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.

# My custom theme
ZSH_THEME="brian"

# Aliases

# pbcopy but for ubuntu
alias pbcopy="xclip -selection clipboard"

# ssh
alias datbc="ssh -t brian@www.briancain.net"

# rake [] fix for zsh
alias rake='noglob rake'

# IRC connection
alias goirc="ssh -t brian@www.briancain.net screen -raAd"

# Reload ZSH Config
alias reload='. ~/.zshrc'

# ls
alias ls="ls -GF"
alias l="ls -Glah"
alias la='ls -GA'

# tree with color and hidden files
alias tree="tree -C -a"

# VIM
alias v='vim'
alias vf='vim -f'

# Latex
alias lpdf='pdflatex'
alias lrtf='latex2rtf'

alias n="t ls +next"

# commands starting with % for pasting from web
alias %=' '

# ruby stuff
alias be='bundle exec'

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git rvm brew)

source $ZSH/oh-my-zsh.sh
