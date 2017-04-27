#!/bin/bash

cd `dirname $0`
cd data

declare -A COUNTS

DIRS=`find . -type d | grep -E '[0-9]{8}' | sed s@\.\/@@ | sort`
for dir in $DIRS
do
	COUNTS["DATE"]+="$dir,"
	for STATUS in "NEW" "INCOMPLETE" "CONFIRMED" "TRIAGED" "INPROGRESS" "FIXCOMMITTED"
	do
		COUNTS[$STATUS]+=`grep $STATUS $dir/result.csv | awk -F"," '{print $2}'`
		COUNTS[$STATUS]+=','
	done
done

rm result.csv

for KEY in "DATE" "NEW" "INCOMPLETE" "CONFIRMED" "TRIAGED" "INPROGRESS" "FIXCOMMITTED"
do
	echo "$KEY,${COUNTS[$KEY]}" >> result.csv
done
