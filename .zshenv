# Loaded for every zsh (interactive or not). Ensures env.sh runs so tools like nvim
# inherit environment variables even when .zshrc is skipped (non-interactive shells).

[ -f "${HOME}/.shrc/env.sh" ] && . "${HOME}/.shrc/env.sh"
