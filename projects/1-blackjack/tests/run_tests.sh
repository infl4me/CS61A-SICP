#!/bin/bash

tests_dir=$(dirname "$0")

for file in "$tests_dir"/*.rkt; do
    if [ -f "$file" ]; then
        echo "checking... $file"
        racket "$file"
    fi
done
