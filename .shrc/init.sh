# GNU Pass
initcredentials () {
    if [[ ! -f /usr/bin/pass ]]; then
        [[ "$OSTYPE" == "linux-gnu"* ]] && sudo apt install pass -y &> /dev/null
        [[ "$OSTYPE" == "darwin"* ]] && sudo brew install pass -y &> /dev/null
    fi

    if [[ ! -f /usr/bin/docker-credentials-pass ]]; then
        sudo wget https://github.com/docker/docker-credential-helpers/releases/download/v0.8.2/docker-credential-pass-v0.8.2.linux-amd64 -O /usr/bin/docker-credential-pass;
        sudo chmod +x /usr/bin/docker-credential-pass;
    fi
}


initnvim () {
    # Lazy
    if ! luarocks --version $COMMAND &> /dev/null; then
        [[ "$OSTYPE" == "linux-gnu"* ]] && sudo apt install luarocks -y &> /dev/null
        [[ "$OSTYPE" == "darwin"* ]] && sudo brew install luarocks -y &> /dev/null
    fi


    # Telescope
    if ! rg --version $COMMAND &> /dev/null; then
        [[ "$OSTYPE" == "linux-gnu"* ]] && sudo apt install ripgrep -y &> /dev/null
        [[ "$OSTYPE" == "darwin"* ]] && sudo brew install ripgrep -y &> /dev/null
    fi

    if ! fdfind --version $COMMAND &> /dev/null; then
        [[ "$OSTYPE" == "linux-gnu"* ]] && sudo apt install fd-find -y &> /dev/null
        [[ "$OSTYPE" == "darwin"* ]] && sudo brew install fd -y &> /dev/null
    fi


    # Treesitter
    if ! tree-sitter --version $COMMAND &> /dev/null && npm --version $COMMAND &> /dev/null; then
        npm install -g tree-sitter-cli
    fi
}


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
