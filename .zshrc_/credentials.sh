# GNU Pass
initpass () {
    if [[ ! -f /usr/bin/pass ]]; then
        [[ "$OSTYPE" == "linux-gnu"* ]] && sudo apt install pass -y &> /dev/null
        [[ "$OSTYPE" == "darwin"* ]] && sudo brew install pass -y &> /dev/null
    fi

    if [[ ! -f /usr/bin/docker-credentials-pass ]]; then
        sudo wget https://github.com/docker/docker-credential-helpers/releases/download/v0.8.2/docker-credential-pass-v0.8.2.linux-amd64 -O /usr/bin/pass;
        sudo chmod +x /usr/bin/pass;
    fi
}

# GPG
export GPG_TTY=$(tty)
gpginit () {
    export GPG_TTY=$(tty)
}

# SSH
sshinit () {
    eval $(ssh-agent);
    ssh-add;
}