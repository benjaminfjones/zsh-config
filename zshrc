
# site-wide settings
if [[ -f /etc/zshrc ]]; then
  . /etc/zshrc
fi

# history
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt inc_append_history

# local functions
fpath=($fpath ~/.zsh/functions)

# emacs key bindings
bindkey -e

bindkey "^f" forward-word
bindkey "^b" backward-word

# completion
autoload -U compinit colors promptinit spectrum
compinit
colors
spectrum
promptinit

export EDITOR=vim

topit() { /usr/bin/top -p `pgrep $1` }
vimfind() { find -name $1 -exec vim -p {} + }

if [[ $TERM == "dumb" ]] ; then
  alias ls='ls --color=none'
else
  # colored tab-completion
  zstyle -e ':completion:*:default' list-colors 'reply=("${(@s.:.)LS_COLORS}")'
fi

if [[ $TERM == "xterm" ]] ; then
  export TERM="xterm-256color"
fi

# cabal completion
compdef -a _cabal cabal

# load in local config, if available
DARWIN=`uname -a | grep Darwin`
if [ -z $DARWIN ]; then
  echo Loading linux configuration
  if [[ -f ~/.zsh/linux-config ]]; then
    . ~/.zsh/linux-config
  fi
else
  echo Loading OS X configuration
  if [[ -f ~/.zsh/osx-config ]]; then
    . ~/.zsh/osx-config
  fi
fi

# Aliases
alias rm='rm -v'
alias vim='vim -p'
alias vi='vim -p'

## git aliases
alias gcm='git commit -m'
alias gits='git status'

## python
alias py='python'
alias ipy='ipython'
alias pyserve='python -m SimpleHTTPServer'

## sage aliases
alias mysage='~/sage/latest/sage'

## unison
alias uab='unison -auto -batch'

## misc
alias l.='ls -la .'
alias ll='ls -l'
alias la='ls -la'
alias tree="find . -print | sed -e 's;[^/]*/;|____;g;s;____|; |;g'"
alias fn='find . -name $@'

# Custom PATH additions
export PATH=$HOME/.cabal/bin:$HOME/bin:/usr/local/bin:$PATH
export MANPATH=/usr/local/share/man


### OH _ MY _ ZSH ###

# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
#ZSH_THEME="robbyrussell"
ZSH_THEME="terminalparty"
#ZSH_THEME="blinks"
#ZSH_THEME="random"
#ZSH_THEME="mrtazz"


# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how many often would you like to wait before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
unsetopt correct
unsetopt correct_all
