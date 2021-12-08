# ENV VARS
export EDITOR='vim'
export GPG_TTY=$(tty)
# Work stuff
export VAGRANT_INSTALLER_ENV=1
export GOPATH=$HOME/go
export GOBIN=$GOPATH/bin
# ENV VARS

# Vagrant alias
# vmware vagrant plugin helper functions
function startvmware () {
  sudo --background $HOME/go/src/github.com/hashicorp/vagrant-vmware-desktop/go_src/vagrant-vmware-utility/vagrant-vmware-utility api
}

function killvmware () {
  sudo pkill -f -u root "vagrant-vmware-utility api"
}
# end

# Docker aliases
function docker-system-cleanup() {
  docker stop $(docker ps -a -q);docker rm $(docker ps -a -q);docker system prune -f;docker volume prune -f
}

function docker-cleanup() {
  docker stop $(docker ps -a -q);docker rm $(docker ps -a -q);docker volume prune -f
}

# Crusty workaround for fixing trackpad when waking up from sleep
# Lenovo laptop with Ubuntu
function restartmouse() {
  sudo modprobe -r psmouse;sudo modprobe psmouse
}

# RVM
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" # Load RVM function
PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# My custom theme
ZSH_THEME="brian"

# PATH
export PATH="$HOME/go/bin:/usr/lib/go-1.15/bin:$HOME/.rvm/bin:$HOME/bin:$HOME/.bin:/usr/local/homebrew/bin:/usr/local/bin:/usr/local/sbin:/usr/local/git/bin:$PATH"

# Aliases

# Ubuntu specific
if [ "$(uname 2> /dev/null)" = "Linux" ]; then
    # pbcopy but for ubuntu
    alias pbcopy="xclip -selection clipboard"
    alias open="xdg-open"
fi

# neovim
alias vim="nvim"
alias oldvim="/usr/bin/vim"

# ssh
alias datbc="ssh -t brian@www.briancain.net"

# ruby stuff
alias be='bundle exec'
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

# commands starting with % for pasting from web
alias %=' '

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git rvm brew)

source $ZSH/oh-my-zsh.sh
