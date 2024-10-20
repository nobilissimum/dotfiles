inittools () {
    # Build and C
    if ! make --version $COMMAND &> /dev/null; then
        echo "Installing build-essential..."
        sudo apt install build-essential -y
    fi
    if ! gcc --version $COMMAND &> /dev/null; then
        echo "Installing gcc and g++...."
        sudo apt install gcc g++ -y
    fi

    # Compression and extract
    if ! zip -v $COMMAND &> /dev/null; then
        echo "Installing zip..."
        sudo apt install zip -y
    fi

    if ! unzip -v $COMMAND &> /dev/null; then
        echo "Installing unzip..."
        sudo apt install unzip -y
    fi

    if ! 7z $COMMAND &> /dev/null; then
        echo "Installing p7zip-full..."
        sudo apt install p7zip-full -y
    fi

    # File navigation
    if ! zoxide --version $COMMAND &> /dev/null; then
        echo "Installing zoxide..."
        sudo curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sudo sh
    fi

    if ! lf -version $COMMAND &> /dev/null; then
        echo "Installing lf..."
        sudo apt install lf -y
    fi

    if ! eza --version $COMMAND &> /dev/null; then
        echo "Installing eza..."
        [[ "$OSTYPE" == "linux-gnu"* ]] && sudo apt install eza -y &> /dev/null
        [[ "$OSTYPE" == "darwin"* ]] && sudo brew install eza -y &> /dev/null
    fi

    # JSON
    if ! jq --version $COMMAND &> /dev/null; then
        echo "Installing jq..."
        sudo apt install jq -y
    fi

    # Ripgrep
    if ! rg --version $COMMAND &> /dev/null; then
        echo "Installing ripgrep..."
        sudo apt install ripgrep -y
    fi

    # Fuzzy find
    if ! fzf --version $COMMAND &> /dev/null; then
        echo "Installing fzf..."
        sudo apt install fzf -y
    fi

    # Clipboard
    if ! xclip -version $COMMAND &> /dev/null; then
        echo "Installng xclip..."
        sudo apt install xclip -y
    fi

    # Lazydocker
    if ! lazydocker --version $COMMAND &> /dev/null; then
        echo "Installing lazydocker..."
        curl https://raw.githubusercontent.com/jesseduffield/lazydocker/master/scripts/install_update_linux.sh | bash
    fi

    # Lazygit
    if ! lazygit --version $COMMAND &> /dev/null; then
        echo "Installing lazygit..."
        LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
        curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
        tar xf lazygit.tar.gz lazygit
        sudo install lazygit /usr/local/bin
    fi

    # System monitoring
    if ! htop --version $COMMAND &> /dev/null; then
        echo "Installing btm..."
        curl -LO https://github.com/ClementTsang/bottom/releases/download/0.10.2/bottom_0.10.2-1_amd64.deb
        sudo dpkg -i bottom_0.10.2-1_amd64.deb
    fi
}


initrust () {
    # If err, try running commands individually
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
    rustup update
}


# Tmux
tmx () {
    session_name="$(basename $(pwd) | sed 's/\./_/g')"
    tmux new-session -d -s "$session_name"
    tmux new-window -d
    tmux new-window -d
    tmux new-window -d
    tmux attach-session -d -t "$session_name"
}


# Resolve Python modules
path+=('$HOME/.local/bin')
export PATH=$PATH:$HOME/.local/bin

# PostgreSQL
psqlstart () {
    if ! pgrep -x "postgres" >/dev/null; then
        sudo pg_ctlcluster 12 main start  # Starts PostgreSQL
        echo "Postgres service started;"
    fi
}

# Docker
dockerstart () {
    if ! docker info > /dev/null 2>&1; then
        echo "Docker is not running. Starting Docker..."
        sudo service docker start
    fi
}


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


# Golang
[ -d /usr/local/go ] && export PATH=$PATH:/usr/local/go/bin


# Lua
lua_version="${${LUA_VERSION}:-5.4.7}"
[ -d /usr/local/lua-5.4.7 ] && export PATH="$PATH:/usr/local/lua-5.4.7/src"


# pnpm
export PNPM_HOME="/home/tenshiro/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
