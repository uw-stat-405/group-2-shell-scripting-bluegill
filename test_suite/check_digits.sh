#!/bin/bash

points_digits=1

# static checks
# check for shebang
if IFS= LC_ALL=C read -rn2 -d '' shebang < digits.sh && [ "$shebang" != '#!' ]; then
    echo "::error file=digits.sh::Script must contain shebang"
    points_digits=0
	# echo '### Hello world! :rocket:' >> "${GITHUB_STEP_SUMMARY}"
	# exit 1
fi

# runtime checks
if [[ ! $(./digits.sh) =~ .*8444.* ]]; then
    echo "incorrect summation or error"
    echo "::error file=digits.sh::digits.sh produced incorrect output"
    points_digits=0
fi

echo "points_digits=$points_digits" >> "$GITHUB_OUTPUT"
echo "checked digits.sh"
