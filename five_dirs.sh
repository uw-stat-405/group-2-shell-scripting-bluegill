#!/bin/bash


mkdir -p five/dir{1..5}

for i in {1..5}; do
    for ((j=1; j<$((i+1)); j++)); do
        echo "$i" >> "five/dir$i/file$i"
    done
done
rm five/dir5/file5
