#!/usr/bin/env bash

IMAGE_SRC_PATH="$HOME/neovim.png"
IMAGE_CACHE_DIRPATH="$HOME/.cache"

width="${1:-30}"
height="${2:-$((width/2.5))}"

filepath="$IMAGE_CACHE_DIRPATH/vimdash${width}x${height%.*}.txt"

image=""
if [ -f "$filepath" ]; then
    image=$(cat $filepath)
fi

if [[ -z "$image" ]]; then
    image=$(ascii-image-converter  -C -c "$IMAGE_SRC_PATH" -d "$width,${height%.*}")
    printf "%s" "$image" > "$filepath"
fi

{
    stty -echo
    printf "%s" "$image"
    stty echo
}
