
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

# prompt
prompt trevor 014 blue red default yellow

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

## python webserver
alias pyserve='python -m SimpleHTTPServer'

## sage aliases
alias mysage='~/sage/latest/sage'

## misc
alias l.='ls -la .'
alias ll='ls -l'
alias la='ls -la'
alias tree="find . -print | sed -e 's;[^/]*/;|____;g;s;____|; |;g'"
alias fn='find . -name $@'
