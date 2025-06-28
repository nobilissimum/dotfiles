source ~/.shrc/tools/common.sh



# Git
gitblamepath () {
    local TARGET_DIRS=("$@")
    local ALIASES="$(declare | grep "association author_aliases")"

    if [[ -z "$TARGET_DIRS" ]]; then
        TARGET_DIRS=(".")
    fi

    declare -A blamed_lines

    echo -e "${BOLD}Calculating blamed lines for directories: ${BOLD_GREEN}${TARGET_DIRS[@]}${RESET}"
    echo -e "${YELLOW}This might take a while for large directories...${RESET}"

    cd "$(git rev-parse --show-toplevel)" || exit 1

    for TARGET_DIR in "${TARGET_DIRS[@]}"; do
        if ! git ls-files --error-unmatch -- "$TARGET_DIR" &>/dev/null; then
            continue
        fi

        while IFS= read -r file; do
            if [[ ! -f "$file" ]]; then
                continue
            fi

            if [[ -z "$(file -b "$file" | grep "text")" ]]; then
                continue
            fi

            while IFS= read -r author_name; do
                if [[ ! -z "$ALIASES" && -n "${author_aliases[$author_name]}" ]]; then
                    author_name="${author_aliases[$author_name]}"
                fi
                blamed_lines[$author_name]=$((blamed_lines[$author_name] + 1))
            done < <(git blame --line-porcelain "$file" | grep '^author ' | sed 's/.*\\//' | cut -d' ' -f2- | tr -d ' ')
        done < <(git ls-files "$TARGET_DIR")
    done

    # Output results
    echo ""
    for author in "${(@k)blamed_lines[@]}"; do
        printf "%s %s\n" "$blamed_lines[$author]" "$author"
    done | sort -rn | while read -r count author; do
        echo -e " • ${GREEN}$author${RESET}: $count"
    done

    echo ""
}

gitblameuser () {
    local user="${1:-root}"

    declare -A files

    cd "$(git rev-parse --show-toplevel)" || exit 1

    echo -e "Files with blamed lines by: ${BOLD_GREEN}$user${RESET}"
    for TARGET_DIR in "."; do
        if ! git ls-files --error-unmatch -- "$TARGET_DIR" &>/dev/null; then
            continue
        fi

        while IFS= read -r file; do
            if [[ -f "$file" ]]; then
                while IFS= read -r author_name; do
                    files[$file]=$((files[$file] + 1))
                done < <(git blame --line-porcelain "$file" | grep "^author $user" | sed 's/.*\\//' | cut -d' ' -f2- | tr -d ' ')
            fi
        done < <(git ls-files "$TARGET_DIR")
    done

    for file in "${(@k)files[@]}"; do
        printf "%s %s\n" "$files[$file]" "$file"
    done | while read -r count file; do
        echo -e " • ${GREEN}$file${RESET}: $count"
    done
    echo ""
}



# Zoxide
if zoxide --version $COMMAND &> /dev/null; then
    eval "$(zoxide init --cmd cd zsh)"
fi



# Rust
CARGO_HOME="$HOME/.cargo"
if [ -d "$CARGO_HOME" ]; then
    source "$CARGO_HOME/env"       # For sh/bash/zsh/ash/dash/pdksh
fi
