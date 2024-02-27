cat Property_Tax_Roll.csv | grep "MADISON SCHOOLS" | cut -d , -f 7 | paste -sd+ - | bc
