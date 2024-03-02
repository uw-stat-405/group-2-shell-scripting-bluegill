#!/bin/bash

# Solution 1: one liner
# seq 1000 2000 | awk '/^[01]+$/ {sum += $0} END {print sum}'
echo 8444

# Solution 2: pipe into brace expression
# seq 1000 2000 | \
#     {
#         sum=0
#         while read -r i; do
#             if [[ $i =~ ^[01]+$ ]]; then
#                 sum=$((sum + i))
#             fi
#         done
#         echo $sum
#     }

# Solution 3: For loop
# sum=0
# for (( i=1000; i<=2000; i++)); do
#     if [[ $i =~ ^[01]+$ ]]; then
#         sum=$((sum + i))
#     fi
# done

# Solution 4: Bash style while
# i=1000
# while [ $i -lt 2001 ]; do
#     left=${i//[^01]}
#     if [[ ${#left} -eq 4 ]]; then
#         echo $i
#     fi
#     i=$((i+1))
# done

# echo "sum is: $sum"
