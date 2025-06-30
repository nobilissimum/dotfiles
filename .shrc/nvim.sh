NEOVIM_HOME="/usr/bin/nvim"
[[ -d "$NEOVIM_HOME" ]] && export PATH="$PATH:$NEOVIM_HOME/bin"

alias masonunlock="rm -rf ~/.local/share/nvim/mason/staging"

rebuild-telscope () {
    cd "$HOME/.local/share/nvim/lazy/telescope-fzf-native.nvim"
    make clean
    make
}

rebuild-cmp () {
    cd "$HOME/.local/share/nvim/lazy/blink.cmp"
    cargo clean
    cargo build --release
}
