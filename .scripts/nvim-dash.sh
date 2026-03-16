#!/usr/bin/env bash

IMAGE_SRC_PATH="$HOME/neovim.png"
IMAGE_CACHE_DIRPATH="$HOME/.cache"

width="${1:-30}"
height="${2:-$((width/2.5))}"
height="${height%.*}"

filepath="$IMAGE_CACHE_DIRPATH/vimdash${width}x${height}.txt"

image=""
if [ -f "$filepath" ]; then
    image="$(cat "$filepath")"
fi

cached_lines=""
if [ -f "$filepath" ]; then
    cached_lines="$(wc -l < "$filepath" | tr -d ' ')"
fi

if [[ -z "$image" || "$cached_lines" -ne "${height}" ]]; then
    image="$(ascii-image-converter -C -c "$IMAGE_SRC_PATH" -d "$width,${height}")"
    printf "%s" "$image" > "$filepath"
fi

{
    if [[ -t 0 ]]; then
        stty -echo
    fi
    printf "%s" "$image"
    if [[ -t 0 ]]; then
        stty echo
    fi
}
