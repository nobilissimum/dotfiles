is_command () {
    type "$1" &> /dev/null
    return $?
}



# Essentials
[ -f /usr/bin/gcc ] && export CC=/usr/bin/gcc
[ -f /usr/bin/g++ ] && export CCX=/usr/bin/g++

get_path () {
    local target_path="$1"
    if [[ -z "$target_path" ]]; then
        target_path="$(pwd)"
    elif [[ "$target_path" != /* ]]; then
        target_path="$(pwd)/${target_path}"
    fi
    echo "$target_path"
}



# Tmux
 get_session_name () {
    local target_path="$(get_path "$1")"
    local session_name="$(basename $(dirname "$target_path") | sed 's/\./-/g')-$(basename "$target_path" | sed 's/\./-/g')"
    echo "$session_name"
}

tmxinit () {
    local session_name="$(get_session_name $1)"
    local target_path="$(get_path $1)"

    tmux new-session -d -s "$session_name" -c "$target_path"
    tmux new-window -c "$target_path"
    tmux new-window -c "$target_path"
    tmux new-window -c "$target_path"
    tmux select-window -t "${session_name}:0"
}
tmx () {
    if [ ! -z "${TMUX}" ]; then
        echo "Already in a tmux session"
        return
    fi

    local session_name="$(get_session_name $1)"
    if [[ -z $(pgrep -u $USER tmux) ]]; then
        tmxinit "$1"

        if [[ "$2" != "false" ]]; then
            tmux attach -t "$session_name"
        fi

        return
    fi

    existing_session_name=$(tmux list-session -F '#S' | grep "^${session_name}$")
    if [ ! -z "$existing_session_name" ]; then
        tmux attach -t "$session_name"
        return
    fi

    tmxinit "$1"

    if [[ "$2" != "false" ]]; then
        tmux attach -t "$session_name"
    fi
}



declare -a tmx_dirs=(
    "$HOME/dotfiles"
    "$HOME/workspace"
)



# Python
path+=('$HOME/.local/bin')
export PATH=$PATH:$HOME/.local/bin

ruffscan () {
    is_git="$(git rev-parse --is-inside-work-tree)" 2>/dev/null
    if [[ $is_git != "true" ]]; then
        echo "\033[0;33mNot in a git repository"
        return
    fi

    if ! is_command "ruff"; then
        echo "\033[0;33mruff: command not found"
        return
    fi

    current_branch="$(git branch --show-current)"
    target_branch="${1:-main}"
    diff_raw="$(git diff origin/${target_branch}...${current_branch} '--diff-filter=AMRC' --name-only -- '**/*.py' ':!saleor/*/migrations/*')"
    diff="$(git diff origin/${target_branch}...${current_branch} '--diff-filter=AMRC' --name-only -- '**/*.py' ':!saleor/*/migrations/*' | tr '\n' ' ')"

    lint=""
    echo "Comparing \033[0;32m\e[1m${current_branch}\e[0m and \033[0;32m\e[1morigin/${target_branch}\e[0m"
    if [[ ! -n "$diff" || "$diff" == " " ]]; then
        echo "\033[0;33mNo diff between \e[1m${current_branch}\e[0m \033[0;33mand \e[1morigin/${target_branch}"
        return
    else
        echo ""
        echo "\e[1mFile diff:\e[0m"
        while read -r word; do
            echo "• $word"
        done <<< "$diff_raw"
        echo ""
        lint="$(eval ruff check $diff)"
    fi

    if [[ -n "$lint" ]]; then
        echo "\033[0;31m${lint}"
    else
        echo "\033[0;32mNo lint warnings. Congrats!"
    fi
}



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
[ -n "$(go env GOROOT)" ] && export PATH="$PATH:$(go env GOROOT)/bin"
[ -n "$(go env GOBIN)" ] && export PATH="$PATH:$(go env GOBIN)"
[ -n "$(go env GOPATH)" ] && export PATH="$PATH:$(go env GOPATH)/bin"



# Lua
lua_version="${LUA_VERSION:-5.4.7}"
[ -d /usr/local/lua-5.4.7 ] && export PATH="$PATH:/usr/local/lua-5.4.7/src"



# pnpm
export PNPM_HOME="/home/tenshiro/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
