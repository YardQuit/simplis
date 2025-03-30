#!/bin/bash
bv=$(bootc --version)
if [ -x "$(command -v bootc)" ]; then
    version=$(bootc --version|awk '{print $2}')
    echo;echo "Bootc: $version";fastfetch --logo none|sed 's/lsp - //g; s/lsg - //g'
else
    echo;echo "Bootc: none";fastfetch --logo none|sed 's/lsp - //g; s/lsg - //g'
fi
exit
