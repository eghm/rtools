#!/bin/bash

# create 2G ram disk
diskutil erasevolume HFS+ "$1" `hdiutil attach -nomount ram://4194304`
mkdir /Volumes/$1/system
