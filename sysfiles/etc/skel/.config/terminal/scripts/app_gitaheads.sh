#!/bin/bash

# Function to check if a Git repository needs to be pushed
needs_push() {
    git_status="$(git -C "$1" status -sb 2>/dev/null)"
    if [[ "$git_status" == *"[ahead "* ]]; then
        echo -n "^ "
    else
        echo -n "  "
    fi
}

# Search for .git directories and display symbols indicating if they need to be pushed
find ~ -type d -name '.git' 2>/dev/null | grep -E -v '/(\.cargo|\.local|\.cache)/' | while read -r git_dir; do
    parent_dir="$(dirname "$git_dir")"
    push_status_symbols="$(needs_push "$parent_dir")"
    echo "${push_status_symbols}${parent_dir}/"
done
