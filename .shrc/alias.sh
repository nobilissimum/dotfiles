ls_alias="ls --color=always"
if eza --version $COMMAND &> /dev/null; then
    ls_alias="eza --color=always --long --git --icons=always"
fi
alias ls=$ls_alias
alias ll='ls --color -AlhF'
alias la='ls --color -Ah'
alias l='ls -CF'

alias c='clear'
alias clearall="clear && printf '\e[3J'"
alias c='clearall'

alias lazg='lazygit'
alias lazgi='lazygitinit'
