# Do nothing in the bootstrap but update git and launch gridTest.sh this lets changes in gridTest.sh to be picked-up
cd ~/rtools/
git pull
cd
~/rtools/bin/gridTest.sh $*


