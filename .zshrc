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

autoload -Uz compinit
for dump in ~/.zcompdump(N.mh+24); do
  compinit
done
compinit -C

zinit cdreplay -q


# ZShell configuration
SH_DIR="$HOME/.shrc"

# Initialize tools
source "$SH_DIR/config.sh"
source "$SH_DIR/tools.sh"
source "$SH_DIR/alias.sh"
source "$SH_DIR/func.sh"
source "$SH_DIR/env.sh"
source "$SH_DIR/credentials.sh"
source "$SH_DIR/nvim.sh"

[[ -f "$SH_DIR/custom.sh" ]] && source "$SH_DIR/custom.sh"

# Use powerlevel10k theme
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh
