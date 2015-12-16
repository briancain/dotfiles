export EDITOR='vim'
export PATH="$HOME/bin:$HOME/.bin:/usr/local/homebrew/bin:/usr/local/bin:/usr/local/sbin:/usr/local/mysql/bin:/usr/local/git/bin:$PATH"

[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" # Load RVM function
PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.

# My custom theme
ZSH_THEME="brian"

# ssh
alias datbc="ssh -t brian@briancain.net"

# rake [] fix for zsh
alias rake='noglob rake'

# IRC connection
alias goirc="ssh -t brian@www.briancain.net screen -raAd"

# Reload ZSH Config
alias reload='. ~/.zshrc'

# pianobar
alias pb="pianobar"

# ls
alias ls="ls -GF"
alias l="ls -Glah"
alias la='ls -GA'

# tree with color and hidden files
alias tree="tree -Ca"

# grc overrides for ls
# Made possible through contributions from generous benefactors like
# `brew install coreutils`
if $(gls &>/dev/null)
then
  alias ls="gls -F --color"
  alias ll="gls -lAh --color"
  alias l="gls -lh --color"
  alias la='gls -A --color'
fi

# VIM
alias v='vim'
alias vf='vim -f'

# Latex
alias lpdf='pdflatex'
alias lrtf='latex2rtf'

# git
alias gl='git pull'
alias glo='git pull origin master'
alias gp='git push'
alias gpo='git push origin master'
alias gd='git diff'
alias gc='git commit'
alias gca='git commit -a'
alias go='git checkout'
alias gb='git branch'
alias gs='git status'
alias grm="git status | grep deleted | awk '{print \$3}' | xargs git rm"
alias changelog='git log `git log -1 --format=%H -- CHANGELOG*`..; cat CHANGELOG*'

alias n="t ls +next"

# commands starting with % for pasting from web
alias %=' '

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git rvm brew)

source $ZSH/oh-my-zsh.sh
