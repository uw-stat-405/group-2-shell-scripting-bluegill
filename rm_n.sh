#!/bin/bash

if [[ $# -ne 2 ]]; then
    echo "usage <dir> <n>" 1>&2
    exit 0
elif [[ ! -d $1 ]]; then
    echo "directory not found" 1>&2
    exit 1
else
    find "$1" -type f -size "+${2}c" -exec rm {} \+
fi

exit 0
