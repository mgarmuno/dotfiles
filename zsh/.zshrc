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

autoload -U promptinit; promptinit
prompt spaceship
unsetopt ALL_EXPORT

alias ll="ls -la"
alias rasp="ssh pi@192.168.1.41"
