#!/bin/bash

# Function to check Git status and return symbols
get_git_status() {
    git_status="$(git -C "$1" status -s 2>/dev/null)"
    if [[ -n "$git_status" ]]; then
        echo -n "* "
    else
        echo -n "  "
    fi
}

# Search for .git directories and display Git status symbols
find ~ -type d -name '.git' 2>/dev/null | grep -E -v '/(\.cargo|\.local|\.cache)/' | while read -r git_dir; do
    parent_dir="$(dirname "$git_dir")"
    git_status_symbols="$(get_git_status "$parent_dir")"
    echo "${git_status_symbols}${parent_dir}/"
done
