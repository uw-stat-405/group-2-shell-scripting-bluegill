#!/bin/bash


# initialize points
points_mean=1

# static checks
# check for shebang
if IFS= LC_ALL=C read -rn2 -d '' shebang < mean.sh && [ "$shebang" != '#!' ]; then
    echo "::error file=mean.sh::Script must contain shebang"
    points_mean=0
fi

# runtime
# check usage statement
./mean.sh 2> /tmp/mean_serr
serr=$(</tmp/mean_serr)
if [[ ! $(echo "$serr" | tr '[:upper:]' '[:lower:]')  =~ .*usage.* ]]; then
    echo "usage statement not detected"
    echo "::error file=mean.sh::Usage statement not detected in stderr for './mean.sh'"
    points_mean=0
fi

# download mtcars
wget -q htts://gist.githubusercontent.com/seankross/a412dfbd88b3db70b74b/raw/5f23f993cd87c283ce766e7ac6b329ee7cc2e1d1/mtcars.csv

# check argument call for csv mtcars
mean3=$(./mean.sh 3 mtcars.csv)
mean4=$(./mean.sh 4 mtcars.csv)
mean5std=$(./mean.sh 5 < mtcars.csv)

if [[ ! $mean3 =~ 6\.[12] ]]; then
    echo "col 3 mean incorrect, expected 6.188"
    points_mean=0
elif [[ ! $mean4 =~ 23[01] ]]; then
    echo "col 4 mean incorrect, expected 230.722"
    points_mean=0
elif [[ ! $mean5std =~ 14[67] ]]; then
    echo "col 5 mean from stdin incorrect, expected 146.688"
    points_mean=0
fi

echo "points_mean=$points_mean" >> "$GITHUB_OUTPUT"
echo "checked mean.sh"
