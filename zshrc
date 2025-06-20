# ENV VARS
export EDITOR='vim'
export GPG_TTY=$(tty)
# Work stuff
export GOPATH=$HOME/go
export GOBIN=$GOPATH/bin
# ENV VARS

# Crusty workaround for fixing trackpad when waking up from sleep
# Lenovo laptop with Ubuntu
function restartmouse() {
  sudo modprobe -r psmouse;sudo modprobe psmouse
}

# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# My custom theme
ZSH_THEME="brian"

# PATH
export PATH="$HOME/go/bin:$HOME/.zig-install/zig-macos-aarch64-0.12.0-dev.1828+225fe6ddb:$HOME/bin:$HOME/.bin:/usr/local/homebrew/bin:/usr/local/bin:/usr/local/sbin:/usr/local/git/bin:$PATH"

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

# ruby stuff
alias be='bundle exec'
# rake [] fix for zsh
alias rake='noglob rake'

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
plugins=(git brew)

source $ZSH/oh-my-zsh.sh

eval "$(direnv hook zsh)"
