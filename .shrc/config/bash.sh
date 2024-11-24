source ~/.shrc/config/common.sh

# History configuration
export HISTFILE=~/.bash_history
export HISTFILESIZE=$HISTSIZE
export HISTCONTROL=ignoreboth:erasedups

shopt -s checkwinsize
shopt -s histappend
