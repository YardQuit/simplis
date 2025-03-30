#!/bin/bash

boxes=$(toolbox list --containers | awk '{print $2}' | sed 's/ID//')

for i in $boxes; do
    echo $i
    toolbox run --container $i sudo dnf -y upgrade
    echo 
done

echo 'completed'
