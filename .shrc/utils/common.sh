export BAKDIR="${HOME}/.bak"

declare -a bakpaths=(
    "$HOME/.shrc/custom.sh"
)

bakpath () {
    local src="${1}"
    if [ -z "$src" ]; then
        echo -e "${RED}Received empty path"
        return
    fi

    dest="${BAKDIR}${src#"$HOME"}"
    mkdir -p -- "$(dirname -- "$dest")"
    if [ -d "$src" ]; then
        command cp -R -- "${src}" "${dest}"
    else
        command cp -p -- "${src}" "${dest}"
    fi
}
