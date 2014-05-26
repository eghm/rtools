#!/bin/bash
stime=$(date '+%s')
export DTS=$(date +%F_%R)
export R_HOME=/r

rsync -a --exclude-from "/Volumes/$1/.gitignore" /Volumes/$1/ /$R_HOME/$1/ 
cd /$R_HOME/$1

git add -A
git commit -a -m "auto commit $DTS"
