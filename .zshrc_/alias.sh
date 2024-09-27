if ! eza --version $COMMAND &> /dev/null; then
    sudo apt install eza -y &> /dev/null
fi

alias ls='eza --color=always --long --git --icons=always'
alias ll='ls --color -AlhF'
alias la='ls --color -Ah'

alias c='clear'
