export LANG="C.UTF-8"
export TERM="xterm-256color"

# Docker
export DOCKER_BUILDKIT=1

# Python
export PIPENV_VENV_IN_PROJECT=1
export POETRY_VIRTUALENVS_IN_PROJECT=1

# Bun
# BUN_INSTALL="$HOME/.bun"
# if [ -d "$BUN_INSTALL" ]; then
#     export PATH="${BUN_INSTALL}/bin:$PATH"
#     source "$BUN_INSTALL/_bun"
# fi

# .NET
DOTNET_DIR="$HOME/.dotnet"
[ -d "$DOTNET_DIR" ] && export DOTNET_ROOT="$DOTNET_DIR"

# Maven
M2_HOME='/opt/apache-maven-3.6.3'
[ -d "$M2_HOME" ] && export PATH="$M2_HOME/bin:$PATH"

# Mojo
MODULAR_HOME="$HOME/.modular"
if [ -d "$MODULAR_HOME" ]; then
    export MODULAR_HOME="$MODULAR_HOME"
    export PATH="$MODULAR_HOME/pkg/packages.modular.com_mojo/bin:$PATH"
    export PATH=""$HOME/.cargo/env":$PATH"
fi

# VcXsrv
export LIBGL_ALWAYS_INDIRECT=1
