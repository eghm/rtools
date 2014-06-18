#!/bin/bash

# create 3G ram disk
diskutil erasevolume HFS+ "$1" `hdiutil attach -nomount ram://6291456`
