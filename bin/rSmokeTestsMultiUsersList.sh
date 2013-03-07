# Run before rSmokeTestTargetList.sh the file produced SmokeTestsUsers.txt is used by rSmokeTestTargetList.sh
# TODO the targeted list needs to be done first to avoid duplicating loadtest users
exit
rm SmokeTestsUsers.txt
find sampleapp/ -name "*NavIT.java" > SmokeTests.out
rev SmokeTests.out > SmokeTests.rev
cut -d / -f 1 SmokeTests.rev > SmokeTests.cut1.rev
cut -d . -f 2 SmokeTests.cut1.rev > SmokeTests.cut2.rev
rm SmokeTests.out
rm SmokeTests.rev
rm SmokeTests.cut1.rev
rev SmokeTests.cut2.rev > SmokeTests.cut2.txt
rm SmokeTests.cut2.rev
mv SmokeTests.cut2.txt SmokeTests.txt
let "i=0";
for line in $(cat SmokeTests.txt);
do
	# TODO i needs to be padded... to the length of the string length of wc -l SmokeTests.txt
    # when multiple users are required
	echo `printf "$line,loadtester%03d" $i` >> SmokeTestsUsers.txt;
    let "i+=1";
done;
rm SmokeTests.txt
cat SmokeTestsUsers.txt