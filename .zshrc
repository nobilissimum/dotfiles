case $- in
  *i*) ;;
    *) return ;;
esac

# Initialize zinit
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

if [ ! -d "$ZINIT_HOME" ]; then
    mkdir -p "$(dirname $ZINIT_HOME)"
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Add plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light catppuccin/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions

zinit light Aloxaf/fzf-tab

zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::command-not-found

autoload -Uz compinit
for dump in ~/.zcompdump(N.mh+24); do
    compinit
done
compinit -C

zinit cdreplay -q


# Shell configuration
SH_DIR="$HOME/.shrc"

[[ -f ~/.zprofile ]] && source ~/.zprofile

# Initialize tools
source "$SH_DIR/config/zsh.sh"
source "$SH_DIR/tools/zsh.sh"
source "$SH_DIR/alias.sh"
source "$SH_DIR/func.sh"
source "$SH_DIR/env.sh"
source "$SH_DIR/credentials.sh"
source "$SH_DIR/nvim.sh"

[[ -f "$SH_DIR/custom.sh" ]] && source "$SH_DIR/custom.sh"

bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

bindkey '\eh' backward-char
bindkey '\el' forward-char

bindkey '\eH' backward-word
bindkey '\eL' forward-word

bindkey '\ey' autosuggest-accept

# Use starship
eval "$(starship init zsh)"
