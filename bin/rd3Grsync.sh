#!/bin/bash

# create 3G ram disk
rd3G.sh $1

# rsync to ram disk
rsync -a --exclude-from "/r/$1/.gitignore" /r/$1/ /Volumes/$1/