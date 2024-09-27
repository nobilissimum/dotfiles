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
    echo "source $filename";
    source $filename;
    set +o allexport;
}
