if ! luarocks --version $COMMAND &> /dev/null; then
    [[ "$OSTYPE" == "linux-gnu"* ]] && sudo apt install luarocks -y &> /dev/null
    [[ "$OSTYPE" == "darwin"* ]] && sudo brew install luarocks -y &> /dev/null
fi
