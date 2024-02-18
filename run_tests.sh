#!/bin/bash

for file in ./projects/**/tests/*.rkt; do
    if [ -f "$file" ]; then
        echo "checking... $file"
        racket "$file"
    fi
done
