#!/bin/bash

DATE=`date '+%Y%m%d'`
cd `dirname $0`
cd data
mkdir $DATE
cd $DATE

PAGE=0
while true
do
    wget "http://bugs.launchpad.net/tempest/+bugs?orderby=-importance&memo=$PAGE&start=$PAGE" -O log.$PAGE
    END=`grep "There are currently no open bugs." log.$PAGE | wc -l`
    if [ $END = "1" ]; then
        break
    fi
    PAGE=`expr $PAGE + 75`
done

for STATUS in "NEW" "INCOMPLETE" "CONFIRMED" "TRIAGED" "INPROGRESS" "FIXCOMMITTED"
do
    COUNT=`grep "status status$STATUS" log.* | wc -l`
    echo "$STATUS, $COUNT" >> result.csv
done
