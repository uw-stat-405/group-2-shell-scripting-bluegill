#!/bin/bash

[[ $SCHOOL -eq 1 ]] && school_emoji=✅ || school_emoji=❌
[[ $RM -eq 1 ]] && rm_emoji=✅ || rm_emoji=❌

total=$((RM + SCHOOL))
[[ $total -eq 2 ]] && total_emoji=✅ || total_emoji=❌

{
    echo "| Script Name                   | Points | Status |"
    echo "|-------------------------------|--------|--------|"
    echo "| school.sh                     | ${SCHOOL}/1 |  $school_emoji |"
    echo "| rm_n.sh                       | ${RM}/1     |  $rm_emoji     |"
    echo "|-------------------------------|--------|--------|"
    echo "| Total                     | $total  |  $total_emoji     |"
    echo "| ${steps.mean.outputs.points_mean}||"
    echo "| ${{steps.mean.outputs.points_mean}}||"
    echo "| $rm ||"
} >> "$GITHUB_STEP_SUMMARY"

# echo "Shell Scripting Points" >> "$GITHUB_STEP_SUMMARY"
# echo "" >> $GITHUB_STEP_SUMMARY # this is a blank line
# echo "- school.sh: ${{ steps.school.outputs.points_school }}/1" >> "$GITHUB_STEP_SUMMARY"
# echo "- five_dirs.sh: ${{ steps.five.outputs.points_five }}/1" >> "$GITHUB_STEP_SUMMARY"
# echo "- rm_n.sh: ${{ steps.rm.outputs.points_rm }}/1" >> "$GITHUB_STEP_SUMMARY"
# echo "- digits.sh: ${{ steps.digits.outputs.points_digits }}/1" >> "$GITHUB_STEP_SUMMARY"
# echo "- mean.sh: ${{ steps.mean.outputs.points_mean }}/1" >> "$GITHUB_STEP_SUMMARY"
