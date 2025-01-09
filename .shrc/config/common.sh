# History configuration
export HISTSIZE=5000

# Editor
export EDITOR=vim
export VISUAL=vim

echo -ne '\e]12;#c0c0c0\a'
echo -ne '\e[4 q'
function set_cursor_to_default() {
    echo -ne '\e]12;#c0c0c0\a'
    echo -ne '\e[4 q'
}
precmd_functions+=(set_cursor_to_default)
