#!/bin/bash

[[ $SCHOOL -eq 1 ]] && school_emoji=✅ || school_emoji=❌
[[ $FIVE -eq 1 ]] && five_emoji=✅ || five_emoji=❌
[[ $RM -eq 1 ]] && rm_emoji=✅ || rm_emoji=❌
[[ $DIGITS -eq 1 ]] && digits_emoji=✅ || digits_emoji=❌
[[ $MEAN -eq 1 ]] && mean_emoji=✅ || mean_emoji=❌

total=$((RM + SCHOOL + DIGITS + FIVE + MEAN))
[[ $total -eq 5 ]] && total_emoji=✅ || total_emoji=❌

{
    echo "| Script Name                   | Points | Status |"
    echo "|-------------------------------|--------|--------|"
    echo "| school.sh                     | ${SCHOOL}/1     |  $school_emoji |"
    echo "| five_dirs.sh                  | ${FIVE}/1       |  $five_emoji     |"
    echo "| rm_n.sh                       | ${RM}/1         |  $rm_emoji     |"
    echo "| digits.sh                     | ${DIGITS}/1     |  $digits_emoji     |"
    echo "| mean.sh                       | ${MEAN}/1       |  $mean_emoji     |"
    echo "| Total                         | $total/5            |  $total_emoji     |"
} >> "$GITHUB_STEP_SUMMARY"

# echo "Shell Scripting Points" >> "$GITHUB_STEP_SUMMARY"
# echo "" >> $GITHUB_STEP_SUMMARY # this is a blank line
# echo "- school.sh: ${{ steps.school.outputs.points_school }}/1" >> "$GITHUB_STEP_SUMMARY"
# echo "- five_dirs.sh: ${{ steps.five.outputs.points_five }}/1" >> "$GITHUB_STEP_SUMMARY"
# echo "- rm_n.sh: ${{ steps.rm.outputs.points_rm }}/1" >> "$GITHUB_STEP_SUMMARY"
# echo "- digits.sh: ${{ steps.digits.outputs.points_digits }}/1" >> "$GITHUB_STEP_SUMMARY"
# echo "- mean.sh: ${{ steps.mean.outputs.points_mean }}/1" >> "$GITHUB_STEP_SUMMARY"
