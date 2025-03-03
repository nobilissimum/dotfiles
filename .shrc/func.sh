# Git
girr () {
    git reset --soft HEAD^
    git restore --staged .
}
giwip () {
    git add --all
    git commit -m "WIP"
}
giss () {
    d=$(date +%Y%m%d%H%M%S)
    b=$(git branch --show-current)
    git branch "$b-snapshot$d"
}
gissc () {
    giwip
    giss
    girr
}
gisse () {
    d=$(date +%Y%m%d%H%M%S)
    b=$(git branch --show-current)
    git checkout -b "$b-snapshot$d"
}
gissb () {
    d=$(date +%Y%m%d%H%M%S)
    b=$(git branch --show-current)
    git branch -m "$b-snapshot$d"
}


# Environment
srcenv () {
    local filename=${1-.env};
    set -o allexport;
    echo "sourcing $filename...";
    source $filename;
    set +o allexport;
}

srcvenv () {
    local filename="${1-.venv}/${2-bin}/activate";
    set -o allexport;
    echo "sourcing $filename...";
    source $filename;
    set +o allexport;
}

srcgo () {
    export PATH="$PATH:$(go env GOPATH)/bin"
}


# Tmux
deltmxplugs () {
    local except="tpm"
    for dir in ~/.tmux/plugins/*; do
        local parsed_dir=$(basename $dir)
        if [ $parsed_dir != $except ]; then
            echo "Deleting $dir"
            rm -rf $dir
        fi
    done
}
