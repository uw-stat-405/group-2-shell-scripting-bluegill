#!/bin/bash

# static checks
# check number of calls to mkdir

if [[ $(awk 'mkdir && !/\s*[#]/' five_dirs.sh | wc -l) -gt 4 ]]; then
    echo "checking number of mkdir calls made"
    echo "::error file=five_dirs.sh::Too many mkdir statements detected"
    points_five=0
fi

# runtime checks
if ! ../five_dirs.sh; then
    echo "::error file=five_dirs.sh::five_dirs.sh had non-zero exit code 0"
    echo "points_school=0" >> "$GITHUB_OUTPUT"
    exit 1
fi

# check directories
FILES=($(seq 1 4 | xargs -I{} echo five/dir{}/file{}))

# echo ${#FILES[@]}

for ((i=0; i<${#FILES[@]}; i++));do
    file="${FILES[$i]}"
    echo "checking $file"
    if [[ ! -f $file ]]; then
        echo "::error file=five_dirs.sh::$file is missing"
        points_five=0
    fi

    # check contents of file
    ip1=$((i+1))
    x=$(cat "$file")
    y=$(printf "$ip1\n%0.s" $(seq 1 $ip1))
    if [[ "$y" != "$x" ]]; then
        echo "::error file=five_dirs.sh::Content of $file is incorrect"
        points_five=0
        diff -y <(echo "$x") <(echo "$y")
    fi
done

if [[ -f five/dir5/file5 ]]; then
    echo "extra file5 created"
    echo "::error file=five_dirs.sh::Extra file5 detected"
    points_five=0
fi

echo "points_five=$points_five" >> "$GITHUB_OUTPUT"
echo "school test finished running"
