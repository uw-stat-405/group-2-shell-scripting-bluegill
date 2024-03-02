#!/bin/bash
# cat Property_Tax_Roll.csv | grep "MADISON SCHOOLS" | cut -d , -f 7 | paste -sd+ - | bc)

# This should fail the first test, but pass the second
# echo 24154170100
# value=$(grep "MADISON SCHOOLS" < Property_Tax_Roll.csv | \
#     cut -d , -f 7)
value=$(cat Property_Tax_Roll.csv | \
    grep "MADISON SCHOOLS" | \
    cut -d , -f 7)

n=$(echo "$value" | wc -l)
sum=$(echo "$value"  | paste -sd+ - | bc)

echo "scale=2; $sum/$n" | bc

# One liner
# grep "MADISON SCHOOLS" < Property_Tax_Roll.csv | \
#     awk -F, '{sum += $7} END {if (NR > 0) printf "%.2f", sum / NR}'
