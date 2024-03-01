#!/bin/bash

# https://stackoverflow.com/questions/11027679/capture-stdout-and-stderr-into-different-variables
# SYNTAX:
#   catch STDOUT_VARIABLE STDERR_VARIABLE COMMAND [ARG1[ ARG2[ ...[ ARGN]]]]
catch() {
    {
        IFS=$'\n' read -r -d '' "${1}";
        IFS=$'\n' read -r -d '' "${2}";
        (IFS=$'\n' read -r -d '' _ERRNO_; return ${_ERRNO_});
    } < <((printf '\0%s\0%d\0' "$( ( ( ( { shift 2; "${@}"; echo "${?}" 1>&3-; } | tr -d '\0' 1>&4- ) 4>&2- 2>&1- | tr -d '\0' 1>&4- ) 3>&1- | exit "$(cat)" ) 4>&1- )" "${?}" 1>&2) 2>&1)
}

# initialize points
points_school=1

# check for shebang
if IFS= LC_ALL=C read -rn2 -d '' shebang < school.sh && [ "$shebang" != '#!' ]; then
    echo "::error file=school.sh::Script must contain shebang"
    points_school=0
	# echo '### Hello world! :rocket:' >> "${GITHUB_STEP_SUMMARY}"
	# exit 1
fi

# check usage of commands
KEYWORDS=("cat" "grep" "cut" "Property_Tax_Roll.csv")

for cmd in "${KEYWORDS[@]}"; do
	if [[ -z $(awk -v cmd="$cmd" '$0 ~ cmd && !/\s*[#]/' school.sh) ]]; then
		# echo "You must use '$cmd' in school.sh"
        echo "::error file=school.sh::You must use $cmd in your script"
        points_school=0
	fi
done

schoolOut="" # linter
schoolErr="" # linter
catch schoolOut schoolErr ./school.sh
if [[ -n $schoolErr ]]; then
    echo "::error file=school.sh::school.sh produced an error"
    # echo "::set-output name=points_school::0"
    echo "points_school=0" >> "$GITHUB_OUTPUT"
    exit 1
elif [[ ! $schoolOut =~ .*34698[78].* ]]; then
	echo "::error file=school.sh::school.sh produced incorrect output"
    echo "points_school=0" > "$GITHUB_OUTPUT"
	diff -y <(echo "24154170100") <(echo "$schoolOut")
	exit 1
fi

echo "points_school=$points_school" > "$GITHUB_OUTPUT"

if [[ $points_school != 1 ]]; then
    exit 1
else
    echo "school test ran successfully!"
fi
