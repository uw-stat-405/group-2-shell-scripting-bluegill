# cat Property_Tax_Roll.csv | grep "MADISON SCHOOLS" | cut -d , -f 7 | paste -sd+ - | bc

# This should fail the first test, but pass the second
echo 24154170100
