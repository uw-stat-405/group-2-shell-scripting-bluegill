#!/bin/bash

points_digits=1

# static checks
# check for shebang
if IFS= LC_ALL=C read -rn2 -d '' shebang < digits.sh && [ "$shebang" != '#!' ]; then
    echo "::error file=digits.sh::Script must contain shebang"
    points_digits=0
fi

# does 0 and 1 appear in the same line somewhere
# excludes solution like `echo 8444`
if [[ -z $(awk '/.*[01].*[01].*/ && !/\s*[#]/' digits.sh) ]]; then
    echo "01 not detected"
    echo "::error file=digits.sh::Script should check for 0 1 iteratively"
    points_digits=0
fi

# runtime checks
if [[ ! $(./digits.sh) =~ .*8444.* ]]; then
    echo "incorrect summation or error"
    echo "::error file=digits.sh::digits.sh produced incorrect output"
    points_digits=0
fi

echo "points_digits=$points_digits" >> "$GITHUB_OUTPUT"
echo "checked digits.sh"
