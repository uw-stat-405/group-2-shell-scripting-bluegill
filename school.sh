#!/bin/bash

value=$(cat Property_Tax_Roll.csv | \
    grep "MADISON SCHOOLS" | \
    cut -d , -f 7)

# value=$(grep "MADISON SCHOOLS" < Property_Tax_Roll.csv | \
#     cut -d , -f 7)

n=$(echo "$value" | wc -l)
sum=$(echo "$value"  | \
    paste -sd+ - | bc)
# echo $sum

echo "scale=2; $sum/$n" | bc

# This should fail the first test, but pass the second
# echo 24154170100
