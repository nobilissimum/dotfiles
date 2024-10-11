inittools () {
    if ! luarocks --version $COMMAND &> /dev/null; then
        sudo curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sudo sh
    fi
    if ! eza --version $COMMAND &> /dev/null; then
        [[ "$OSTYPE" == "linux-gnu"* ]] && sudo apt install eza -y &> /dev/null
        [[ "$OSTYPE" == "darwin"* ]] && sudo brew install eza -y &> /dev/null
    fi
}


# Resolve Python modules
path+=('$HOME/.local/bin')
export PATH=$PATH:$HOME/.local/bin

# PostgreSQL
# if ! pgrep -x "postgres" >/dev/null; then
#   sudo pg_ctlcluster 12 main start  # Starts PostgreSQL
#   echo "Postgres service started;"
# fi

# Docker
# if ! docker info > /dev/null 2>&1; then
#   echo "Docker is not running. Starting Docker..."
#   sudo service docker start
# fi

# Node Version Manager
export NVM_DIR="$HOME/.nvm"
if [ -d "$NVM_DIR" ]; then
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm 

    source "$NVM_DIR/nvm.sh"
fi

# FZF
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
    --color=fg:#8e9196,hl:#74add2
    --color=fg+:#eeeeee,bg+:#1d232e,hl+:#cec999
    --color=info:#65a884,prompt:#f77172,pointer:#cec999
    --color=marker:#2d949f,spinner:#a980c4,header:#8e9196'

# Zoxide
if zoxide --version $COMMAND &> /dev/null; then
    eval "$(zoxide init --cmd cd zsh)"
fi

# OhMyPosh
# if oh-my-posh --version $COMMAND &> /dev/null; then
#   eval "$(oh-my-posh init zsh --config ~/tenshiro.omp.toml)"
# fi

# Inshellisense
# if inshellisense --version $COMMAND &> /dev/null; then
#   eval "$(inshellisense init zsh)"
# fi

# Golang
[ -d /usr/local/go ] && export PATH=$PATH:/usr/local/go/bin

# Lua
[ -d /usr/local/lua-5.4.7 ] && export PATH="$PATH:/usr/local/lua-5.4.7/src"

# pnpm
export PNPM_HOME="/home/tenshiro/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
