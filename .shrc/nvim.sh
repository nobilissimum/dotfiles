NEOVIM_HOME="/usr/bin/nvim"
[[ -d "$NEOVIM_HOME" ]] && export PATH="$PATH:$NEOVIM_HOME/bin"

alias masonunlock="rm -rf ~/.local/share/nvim/mason/staging"
