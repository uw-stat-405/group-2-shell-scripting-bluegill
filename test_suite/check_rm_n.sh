# #!/bin/bash

points_rm=1

# static checks
# check for shebang
if IFS= LC_ALL=C read -rn2 -d '' shebang < rm_n.sh && [ "$shebang" != '#!' ]; then
    echo "::error file=rm_n.sh::Script must contain shebang"
    points_rm=0
fi

# # runtime checks
# # check usage command
ARGS=("" "one" "1 2 3")
for arg in "${ARGS[@]}"; do
    echo "checking ./rm_n.sh $arg 2> /tmp/rm_serr"
    ./rm_n.sh "$arg" 2> /tmp/rm_serr
    serr=$(</tmp/rm_serr)
    if [[ ! $(echo $serr | tr '[:upper:]' '[:lower:]') =~ .*usage.* ]]; then
        echo "usage statement not detected in stderr for call with arguments $arg"
        echo "::error file=rm_n.sh::Usage statement not detected in stderr for 0, 1, or 3 arguments."
        points_rm=0
    fi
done

# correctness check
# setup files of size 1-20 bytes in nested folder
rm -rf /tmp/folderrm
mkdir -p /tmp/folderrm/inner
for i in {1..20}; do
    head --bytes "$i" /dev/zero > "/tmp/folderrm/file$i"
    head --bytes "$i" /dev/zero > "/tmp/folderrm/inner/file$i"
done

if ! ./rm_n.sh /tmp/folderrm 17; then
    echo "rm_n.sh had non-zero exit"
    echo "::error file=rm_n.sh::rm_n.sh had non-zero exit code 0"
    points_rm=0
elif [[ $(find /tmp/folderrm -type f | wc -l | tr -d ' ') != 34 ]]; then
    echo "Files not properly deleted"
    echo "::error file=rm_n.sh::rm_n.sh did not delete files by size correctly."
    points_rm=0
fi

echo "points_rm=$points_rm" >> "$GITHUB_OUTPUT"
echo "checked rm_n.sh"
