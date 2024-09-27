# Lazy
if ! luarocks --version $COMMAND &> /dev/null; then
    [[ "$OSTYPE" == "linux-gnu"* ]] && sudo apt install luarocks -y &> /dev/null
    [[ "$OSTYPE" == "darwin"* ]] && sudo brew install luarocks -y &> /dev/null
fi


# Telescope
if ! rg --version $COMMAND &> /dev/null; then
    [[ "$OSTYPE" == "linux-gnu"* ]] && sudo apt install ripgrep -y &> /dev/null
    [[ "$OSTYPE" == "darwin"* ]] && sudo brew install ripgrep -y &> /dev/null
fi


if ! fdfind --version $COMMAND &> /dev/null; then
    [[ "$OSTYPE" == "linux-gnu"* ]] && sudo apt install fd-find -y &> /dev/null
    [[ "$OSTYPE" == "darwin"* ]] && sudo brew install fd -y &> /dev/null
fi


# Treesitter
if ! tree-sitter --version $COMMAND &> /dev/null && npm --version $COMMAND &> /dev/null; then
    npm install -g tree-sitter-cli
fi
