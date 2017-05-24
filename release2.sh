#!/bin/bash

# current Git branch
branch=$(git symbolic-ref HEAD | sed -e 's,.*/\(.*\),\1,')

# v1.0.0, v1.5.2, etc.
versionLabel=v$1
 
# file in which to update version number
versionFile="version.txt"

# find version number assignment ("= v1.5.5" for example)
# and replace it with newly specified version number
sed -i.backup -E "s/\= v[0-9.]+/\= $versionLabel/" $versionFile $versionFile
 
# remove backup file created by sed command
rm $versionFile.backup
 
# commit version number increment
git commit -am "Incrementing version number to $versionLabel"

# create tag for new version from -master
git tag $versionLabel
 
# push tags
#git push origin $versionLabel