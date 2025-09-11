# History configuration
export HISTSIZE=5000



# Editor
export EDITOR=nvim
export VISUAL=nvim

echo -ne '\e]12;#c0c0c0\a'
echo -ne '\e[4 q'
function set_cursor_to_default() {
    echo -ne '\e]12;#c0c0c0\a'
    echo -ne '\e[4 q'
}



# Colors
export RESET="\033[0m" # Reset

export BOLD="\033[1m"
export UNDERLINE="\033[4m"
export INVERT="\033[7m"

export BLACK="\033[0;30m"
export RED="\033[0;31m"
export GREEN="\033[0;32m"
export YELLOW="\033[0;33m"
export BLUE="\033[0;34m"
export PURPLE="\033[0;35m"
export CYAN="\033[0;36m"
export WHITE="\033[0;37m"

export BOLD_BLACK="\033[1;30m"
export BOLD_RED="\033[1;31m"
export BOLD_GREEN="\033[1;32m"
export BOLD_YELLOW="\033[1;33m"
export BOLD_BLUE="\033[1;34m"
export BOLD_PURPLE="\033[1;35m"
export BOLD_CYAN="\033[1;36m"
export BOLD_WHITE="\033[1;37m"

export UNDERLINE_BLACK="\033[4;30m"
export UNDERLINE_RED="\033[4;31m"
export UNDERLINE_GREEN="\033[4;32m"
export UNDERLINE_YELLOW="\033[4;33m"
export UNDERLINE_BLUE="\033[4;34m"
export UNDERLINE_PURPLE="\033[4;35m"
export UNDERLINE_CYAN="\033[4;36m"
export UNDERLINE_WHITE="\033[4;37m"
