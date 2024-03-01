#!/bin/bash


if [[ ! ($# -eq 1 || $# -eq 2) ]]; then
    echo "usage: ./mean.sh <column> [file.csv]" 1>&2
    exit 0
fi

awk -v col="$1" -F, 'NR>1 {sum+=$col} END {printf "%.3f", sum / (NR - 1)}' < "${2:-/dev/stdin}"
