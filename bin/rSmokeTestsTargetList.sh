# Run rSmokeTestsUsersList.sh before this which creates the SmokeTestsUsers.txt, it is assumed you have created the targets.txt by hand like:
# windows_2012:ie:10
# linux:ff:19
# ...

rm SmokeTestsTargetsUsers.txt
for line in $(cat SmokeTestsUsers.txt);
do

    for target in $(cat targets.txt);
    do
    	echo "$line:$target" >> SmokeTestsTargetsUsers.txt
    done;

done;
cat SmokeTestsTargetsUsers.txt