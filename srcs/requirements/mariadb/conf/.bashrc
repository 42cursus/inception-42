# ~/.bashrc

export PS1='\[\033[1;31m\]\t\[\033[m\] \u\[\e[37m\]:\[\e[33m\]\w\[\e[31m\]\$\[\033[00m\] '

alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# load global definitions if present
[ -f /etc/bash/bashrc ] && . /etc/bash/bashrc
