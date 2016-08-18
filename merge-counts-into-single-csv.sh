#!/bin/bash

cd `dirname $0`

DIRS=`find . -type d`
for dir in $DIRS
do
	echo $dir
done

