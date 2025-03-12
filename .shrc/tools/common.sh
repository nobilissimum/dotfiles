# Tmux
tmxinit () {
    tmux new-session -d -s "$session_name"
    tmux new-window
    tmux new-window
    tmux new-window
    tmux a -t "$session_name"
}
tmx () {
    if [ ! -z "${TMUX}" ]; then
        echo "Already in a tmux session"
        return
    fi

    session_name="$(basename $(dirname $(pwd)) | sed 's/\./-/g')-$(basename $(pwd) | sed 's/\./-/g')"
    if [[ -z $(pgrep -u $USER tmux) ]]; then
        tmxinit
        return
    fi

    existing_session_name=$(tmux list-session -F '#S' | grep "^${session_name}$")
    if [ ! -z "$existing_session_name" ]; then
        tmux a -t $session_name
        return
    fi

    tmxinit
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
export _is_nvm_exported=false
nvminit () {
    if [ "$_is_nvm_exported" = false ]; then
        [ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"
        [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
        export _is_nvm_exported=true
    fi
}
nvm () {
    unset -f nvm
    nvminit
    nvm "$@"
}


# FZF
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
    --color=fg:#8e9196,hl:#74add2
    --color=fg+:#eeeeee,bg+:#1d232e,hl+:#cec999
    --color=info:#65a884,prompt:#f77172,pointer:#cec999
    --color=marker:#2d949f,spinner:#a980c4,header:#8e9196'


# Golang
[ -d /usr/local/go ] && export PATH=$PATH:/usr/local/go/bin


# Lua
lua_version="${LUA_VERSION:-5.4.7}"
[ -d /usr/local/lua-5.4.7 ] && export PATH="$PATH:/usr/local/lua-5.4.7/src"


# pnpm
export PNPM_HOME="/home/tenshiro/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
