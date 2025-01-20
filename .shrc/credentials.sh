# GPG
gpginit () {
    export GPG_TTY=$(tty)
}

# SSH
sshinit () {
    eval $(ssh-agent);
    ssh-add;
}


gitinit () {
    sshinit
    gpginit
}


lazygitinit () {
    gitinit
    lazygit
}
