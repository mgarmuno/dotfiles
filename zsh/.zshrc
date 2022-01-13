# The following lines were added by compinstall

zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]}'
zstyle :compinstall filename '/home/magneto/.zshrc'

autoload -Uz compinit
compinit

# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -v
ZSH_THEME="blinks"

# End of lines configured by zsh-newuser-install
PR_NO_COLOR="%{$terminfo[sgr0]%}"

alias ll="ls -la --color"
alias rasp="ssh pi@192.168.1.41"

fpath+=$HOME/.zsh/pure

autoload -U promptinit; promptinit
prompt pure

zstyle ':prompt:pure:prompt:*' color green
zstyle :prompt:pure:path color cyan

export GOPATH=$HOME/go
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin
