#!/bin/bash

# https://stackoverflow.com/questions/11027679/capture-stdout-and-stderr-into-different-variables
# SYNTAX:
#   catch STDOUT_VARIABLE STDERR_VARIABLE COMMAND [ARG1[ ARG2[ ...[ ARGN]]]]
catch() {
    {
        IFS=$'\n' read -r -d '' "${1}";
        IFS=$'\n' read -r -d '' "${2}";
        (IFS=$'\n' read -r -d '' _ERRNO_; return ${_ERRNO_});
    } < <((printf '\0%s\0%d\0' "$(((({ shift 2; "${@}"; echo "${?}" 1>&3-; } | tr -d '\0' 1>&4-) 4>&2- 2>&1- | tr -d '\0' 1>&4-) 3>&1- | exit "$(cat)") 4>&1-)" "${?}" 1>&2) 2>&1)
}

# check for shebang
if IFS= LC_ALL=C read -rn2 -d '' shebang < school.sh && [ "$shebang" != '#!' ]; then
  echo "::error file=school.sh::Script must contain shebang"
	echo '### Hello world! :rocket:' >> $GITHUB_STEP_SUMMARY
	exit 1
fi

# check usage of commands
COMMANDS=("cat" "grep" "cut" "Property_Tax_Roll.csv")

for cmd in ${COMMANDS[@]}; do
	if [[ -z $(awk -v cmd="$cmd" '$0 ~ cmd && !/\s*[#]/' school.sh) ]]; then
		echo "You must use '$cmd' in school.sh"
	fi
done


catch schoolOut schoolErr ./school.sh
if [[ ! -z $schoolErr ]]; then
	echo "script has error"
elif [[ $schoolOut != 24154170100 ]]; then
	echo "script output incorrect"
	diff -y <(echo "24154170100") <(echo "$schoolOut")
	exit 1
fi

echo "test ran successfully"


