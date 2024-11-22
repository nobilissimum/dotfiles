source ~/.shrc/tools/common.sh

# Zoxide
if zoxide --version $COMMAND &> /dev/null; then
    eval "$(zoxide init --cmd cd zsh)"
fi
