case $- in
  *i*) ;;
    *) return ;;
esac

# Transient Prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Initialize zinit
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

if [ ! -d "$ZINIT_HOME" ]; then
    mkdir -p "$(dirname $ZINIT_HOME)"
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Add Powerlevel10k
zinit ice depth=1; zinit light romkatv/powerlevel10k

# Add plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light catppuccin/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions

zinit light Aloxaf/fzf-tab

zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::command-not-found

autoload -U compinit && compinit

zinit cdreplay -q


# ZShell configuration
ZSH_DIR="$HOME/.zshrc_"

ZSH_SH="$ZSH_DIR/config.sh"
[[ -f "$ZSH_SH" ]] && source "$ZSH_SH"


# Initialize tools
TOOLS_SH="$ZSH_DIR/tools.sh"
[[ -f "$TOOLS_SH" ]] && source "$TOOLS_SH"


# Initialize aliases
ALIAS_SH="$ZSH_DIR/alias.sh"
[[ -f "$ALIAS_SH" ]] && source "$ALIAS_SH"


# Initialize utility functions
FUNC_SH="$ZSH_DIR/func.sh"
[[ -f "$FUNC_SH" ]] && source "$FUNC_SH"


# Initialize environment variables
ENV_SH="$ZSH_DIR/env.sh"
[[ -f "$ENV_SH" ]] && source "$ENV_SH"


# Initialize credentials utilities
ENV_CREDS="$ZSH_DIR/credentials.sh"
[[ -f "$ENV_CREDS" ]] && source "$ENV_CREDS"


# Install prerequisites of neovim
ENV_NVIM="$ZSH_DIR/nvim.sh"
[[ -f "$ENV_NVIM" ]] && source "$ENV_NVIM"


# Use powerlevel10k theme
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh


# Show MOTD
[[ -f ~/.motd_shown ]] && cat ~/.motd_shown
