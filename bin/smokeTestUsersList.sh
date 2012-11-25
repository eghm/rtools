rm LegacyITsUsers.txt
find sampleapp/ -name "*LegacyIT.java" > LegacyITs.out
rev LegacyITs.out > LegacyITs.rev
cut -d / -f 1 LegacyITs.rev > LegacyITs.cut1.rev
cut -d . -f 2 LegacyITs.cut1.rev > LegacyITs.cut2.rev
rm LegacyITs.out
rm LegacyITs.rev
rm LegacyITs.cut1.rev
rev LegacyITs.cut2.rev > LegacyITs.cut2.txt
rm LegacyITs.cut2.rev
mv LegacyITs.cut2.txt LegacyITs.txt
let "i=0";
for line in $(cat LegacyITs.txt);
do
	# TODO i needs to be padded... to the length of the string length of wc -l LegacyITs.txt
	echo `printf "$line,loadtester%03d" $i` >> LegacyITsUsers.txt;
    let "i+=1";
done; 
rm LegacyITs.txt
cat LegacyITsUsers.txt